package com.quickkart.swing.view;

import com.quickkart.common.model.Category;
import com.quickkart.common.model.Product;

import javax.swing.*;
import java.awt.*;
import java.util.List;

/**
 * Swing View: Product Dialog for adding and editing catalog items.
 */
public class ProductDialog extends JDialog {
    private final JTextField nameField = new JTextField(20);
    private final JTextField brandField = new JTextField(20);
    private final JComboBox<CategoryItem> categoryBox = new JComboBox<>();
    private final JTextField priceField = new JTextField(10);
    private final JTextField discountField = new JTextField(10);
    private final JTextField stockField = new JTextField(10);
    private final JTextField imageField = new JTextField(20);
    private final JTextArea descArea = new JTextArea(4, 20);
    private final JCheckBox statusCheck = new JCheckBox("Active / Visible", true);

    private boolean saved = false;
    private final Product product;

    public static class CategoryItem {
        public final int id;
        public final String name;
        public CategoryItem(int id, String name) { this.id = id; this.name = name; }
        @Override public String toString() { return name; }
    }

    public ProductDialog(Frame parent, String title, Product product, List<Category> categories) {
        super(parent, title, true);
        this.product = (product != null) ? product : new Product();

        // Populate Categories combo
        for (Category c : categories) {
            categoryBox.addItem(new CategoryItem(c.getCategoryId(), c.getName()));
        }

        initUI();
        if (product != null && product.getProductId() > 0) {
            populateFields();
        }
    }

    private void initUI() {
        setLayout(new BorderLayout());
        setMinimumSize(new Dimension(520, 640));
        setSize(520, 640);
        setResizable(false);

        // Header Panel
        JPanel headerPanel = new JPanel(new BorderLayout());
        headerPanel.setBackground(new Color(241, 245, 249));
        headerPanel.setBorder(BorderFactory.createCompoundBorder(
                BorderFactory.createMatteBorder(0, 0, 1, 0, new Color(226, 232, 240)),
                BorderFactory.createEmptyBorder(16, 20, 16, 20)
        ));

        JLabel titleLbl = new JLabel(getTitle());
        titleLbl.setFont(new Font("Segoe UI", Font.BOLD, 16));
        titleLbl.setForeground(new Color(30, 41, 59));
        headerPanel.add(titleLbl, BorderLayout.WEST);

        add(headerPanel, BorderLayout.NORTH);

        // Main form
        JPanel form = new JPanel(new GridBagLayout());
        form.setBackground(Color.WHITE);
        form.setBorder(BorderFactory.createEmptyBorder(20, 24, 20, 24));
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.insets = new Insets(6, 6, 6, 6);
        gbc.fill = GridBagConstraints.HORIZONTAL;

        int row = 0;
        addRow(form, gbc, row++, "Product Name:", nameField);
        addRow(form, gbc, row++, "Brand:", brandField);
        addRow(form, gbc, row++, "Category:", categoryBox);
        addRow(form, gbc, row++, "Retail Price (₹):", priceField);
        addRow(form, gbc, row++, "Discount (%):", discountField);
        addRow(form, gbc, row++, "Stock Units:", stockField);
        addRow(form, gbc, row++, "Image URL:", imageField);

        gbc.gridx = 0; gbc.gridy = row; gbc.anchor = GridBagConstraints.NORTHWEST;
        JLabel descLabel = new JLabel("Description:");
        descLabel.setFont(new Font("Segoe UI", Font.BOLD, 12));
        form.add(descLabel, gbc);
        gbc.gridx = 1;
        descArea.setLineWrap(true);
        descArea.setWrapStyleWord(true);
        form.add(new JScrollPane(descArea), gbc);
        row++;

        gbc.gridx = 1; gbc.gridy = row;
        statusCheck.setBackground(Color.WHITE);
        form.add(statusCheck, gbc);

        add(new JScrollPane(form), BorderLayout.CENTER);

        // Footer Buttons
        JPanel buttonPanel = new JPanel(new FlowLayout(FlowLayout.RIGHT, 12, 14));
        buttonPanel.setBackground(new Color(248, 250, 252));
        buttonPanel.setBorder(BorderFactory.createMatteBorder(1, 0, 0, 0, new Color(226, 232, 240)));

        JButton cancelBtn = new JButton("Cancel");
        cancelBtn.setPreferredSize(new Dimension(90, 34));
        cancelBtn.addActionListener(e -> dispose());

        JButton saveBtn = new JButton("Save Product");
        saveBtn.setPreferredSize(new Dimension(130, 34));
        saveBtn.setBackground(new Color(79, 70, 229));
        saveBtn.setForeground(Color.WHITE);
        saveBtn.setFont(new Font("Segoe UI", Font.BOLD, 12));
        saveBtn.putClientProperty("JButton.buttonType", "roundRect");

        saveBtn.addActionListener(e -> {
            if (validateAndExtract()) {
                saved = true;
                dispose();
            }
        });

        buttonPanel.add(cancelBtn);
        buttonPanel.add(saveBtn);
        add(buttonPanel, BorderLayout.SOUTH);

        setLocationRelativeTo(getParent());
    }

    private void addRow(JPanel panel, GridBagConstraints gbc, int row, String label, Component comp) {
        gbc.gridx = 0; gbc.gridy = row;
        gbc.anchor = GridBagConstraints.EAST;
        JLabel lbl = new JLabel(label);
        lbl.setFont(new Font("Segoe UI", Font.BOLD, 12));
        lbl.setForeground(new Color(51, 65, 85));
        panel.add(lbl, gbc);
        gbc.gridx = 1;
        gbc.anchor = GridBagConstraints.WEST;
        panel.add(comp, gbc);
    }

    private void populateFields() {
        nameField.setText(product.getName());
        brandField.setText(product.getBrand());
        priceField.setText(String.valueOf(product.getPrice()));
        discountField.setText(String.valueOf(product.getDiscount()));
        stockField.setText(String.valueOf(product.getStock()));
        imageField.setText(product.getImageUrl());
        descArea.setText(product.getDescription());
        statusCheck.setSelected(product.isStatus());

        for (int i = 0; i < categoryBox.getItemCount(); i++) {
            if (categoryBox.getItemAt(i).id == product.getCategoryId()) {
                categoryBox.setSelectedIndex(i);
                break;
            }
        }
    }

    private boolean validateAndExtract() {
        String name = nameField.getText().trim();
        if (name.isEmpty()) {
            JOptionPane.showMessageDialog(this, "Product name cannot be empty", "Validation Error", JOptionPane.ERROR_MESSAGE);
            return false;
        }

        try {
            double price = Double.parseDouble(priceField.getText().trim());
            double discount = discountField.getText().trim().isEmpty() ? 0.0 : Double.parseDouble(discountField.getText().trim());
            int stock = Integer.parseInt(stockField.getText().trim());

            product.setName(name);
            product.setBrand(brandField.getText().trim());
            CategoryItem item = (CategoryItem) categoryBox.getSelectedItem();
            if (item != null) {
                product.setCategoryId(item.id);
                product.setCategoryName(item.name);
            }
            product.setPrice(price);
            product.setDiscount(discount);
            product.setStock(stock);
            product.setImageUrl(imageField.getText().trim());
            product.setDescription(descArea.getText().trim());
            product.setStatus(statusCheck.isSelected());
            return true;
        } catch (NumberFormatException e) {
            JOptionPane.showMessageDialog(this, "Please enter valid numeric values for price, discount, and stock.", "Validation Error", JOptionPane.ERROR_MESSAGE);
            return false;
        }
    }

    public boolean isSaved() { return saved; }
    public Product getProduct() { return product; }
}
