package com.quickkart.swing.view;

import com.quickkart.common.model.Category;
import com.quickkart.common.model.Order;
import com.quickkart.common.model.Product;
import com.quickkart.common.model.User;
import com.quickkart.dao.CategoryDAO;
import com.quickkart.dao.OrderDAO;
import com.quickkart.dao.ProductDAO;
import com.quickkart.swing.model.ProductTableModel;

import javax.swing.*;
import javax.swing.border.EmptyBorder;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableRowSorter;
import java.awt.*;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.io.File;
import java.net.URI;
import java.util.List;

/**
 * Swing View & Controller: Admin Dashboard Management Window with modern FlatLaf UI.
 */
public class AdminDashboardFrame extends JFrame {
    private final User adminUser;
    private final ProductDAO productDAO = new ProductDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final OrderDAO orderDAO = new OrderDAO();

    private final ProductTableModel productTableModel = new ProductTableModel();
    private final JTable productTable = new JTable(productTableModel);
    private TableRowSorter<ProductTableModel> productSorter;

    private final DefaultTableModel orderTableModel = new DefaultTableModel(
            new String[]{"Order ID", "Customer", "Amount", "Payment", "Status", "Date & Time"}, 0) {
        @Override
        public boolean isCellEditable(int row, int column) {
            return false;
        }
    };
    private final JTable orderTable = new JTable(orderTableModel);

    private final JLabel kpiRevenue = new JLabel("₹0.00");
    private final JLabel kpiOrders = new JLabel("0");
    private final JLabel kpiProducts = new JLabel("0");
    private final JLabel kpiLowStock = new JLabel("0");

    public AdminDashboardFrame(User adminUser) {
        this.adminUser = adminUser;
        initUI();
        refreshAllData();
    }

    private void initUI() {
        setTitle("QuickKart Desktop Administration - [" + adminUser.getName() + "]");
        setSize(1100, 750);
        setMinimumSize(new Dimension(950, 650));
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);

        // App Icon
        setAppIcon();

        // Top Modern Header
        add(createTopHeaderPanel(), BorderLayout.NORTH);

        // Main Tabbed Pane
        JTabbedPane tabbedPane = new JTabbedPane();
        tabbedPane.setFont(new Font("Segoe UI", Font.BOLD, 13));
        tabbedPane.addTab("  Products Inventory  ", createProductsPanel());
        tabbedPane.addTab("  Customer Orders  ", createOrdersPanel());
        tabbedPane.addTab("  System KPI & Architecture  ", createMetricsPanel());

        add(tabbedPane, BorderLayout.CENTER);
    }

    private JPanel createTopHeaderPanel() {
        JPanel header = new JPanel(new BorderLayout());
        header.setBackground(new Color(248, 250, 252));
        header.setBorder(BorderFactory.createCompoundBorder(
                BorderFactory.createMatteBorder(0, 0, 1, 0, new Color(226, 232, 240)),
                BorderFactory.createEmptyBorder(12, 20, 12, 20)
        ));

        // Brand + User greeting
        JPanel left = new JPanel(new FlowLayout(FlowLayout.LEFT, 12, 0));
        left.setOpaque(false);

        JLabel logoLbl = createLogoIcon(32);
        left.add(logoLbl);

        JPanel titleBox = new JPanel();
        titleBox.setLayout(new BoxLayout(titleBox, BoxLayout.Y_AXIS));
        titleBox.setOpaque(false);

        JLabel brandTitle = new JLabel("QuickKart Desktop Administration");
        brandTitle.setFont(new Font("Segoe UI", Font.BOLD, 16));
        brandTitle.setForeground(new Color(15, 23, 42));

        JLabel userSub = new JLabel("Logged in: " + adminUser.getName() + " (" + adminUser.getEmail() + ")");
        userSub.setFont(new Font("Segoe UI", Font.PLAIN, 12));
        userSub.setForeground(new Color(100, 116, 139));

        titleBox.add(brandTitle);
        titleBox.add(userSub);
        left.add(titleBox);

        // Right actions
        JPanel right = new JPanel(new FlowLayout(FlowLayout.RIGHT, 10, 0));
        right.setOpaque(false);

        JLabel dbStatus = new JLabel("● H2 Cluster Online");
        dbStatus.setFont(new Font("Segoe UI", Font.BOLD, 12));
        dbStatus.setForeground(new Color(16, 185, 129));
        right.add(dbStatus);

        JButton webBtn = new JButton("Open Storefront");
        webBtn.putClientProperty("JButton.buttonType", "roundRect");
        webBtn.addActionListener(e -> openWebBrowser("http://localhost:8080/"));
        right.add(webBtn);

        JButton refreshBtn = new JButton("Refresh All");
        refreshBtn.putClientProperty("JButton.buttonType", "roundRect");
        refreshBtn.addActionListener(e -> refreshAllData());
        right.add(refreshBtn);

        JButton logoutBtn = new JButton("Sign Out");
        logoutBtn.putClientProperty("JButton.buttonType", "roundRect");
        logoutBtn.setForeground(new Color(225, 29, 72));
        logoutBtn.addActionListener(e -> {
            dispose();
            SwingUtilities.invokeLater(() -> new LoginFrame().setVisible(true));
        });
        right.add(logoutBtn);

        header.add(left, BorderLayout.WEST);
        header.add(right, BorderLayout.EAST);
        return header;
    }

    private JPanel createProductsPanel() {
        JPanel panel = new JPanel(new BorderLayout(10, 10));
        panel.setBackground(Color.WHITE);
        panel.setBorder(new EmptyBorder(14, 16, 14, 16));

        // Toolbar with search
        JPanel toolBarPanel = new JPanel(new BorderLayout(10, 0));
        toolBarPanel.setOpaque(false);

        JPanel actionButtons = new JPanel(new FlowLayout(FlowLayout.LEFT, 8, 0));
        actionButtons.setOpaque(false);

        JButton addBtn = new JButton("+ Add Product");
        addBtn.setBackground(new Color(79, 70, 229));
        addBtn.setForeground(Color.WHITE);
        addBtn.setFont(new Font("Segoe UI", Font.BOLD, 12));
        addBtn.putClientProperty("JButton.buttonType", "roundRect");
        addBtn.addActionListener(e -> onAddProduct());

        JButton editBtn = new JButton("Edit Selected");
        editBtn.putClientProperty("JButton.buttonType", "roundRect");
        editBtn.addActionListener(e -> onEditProduct());

        JButton deleteBtn = new JButton("Delete");
        deleteBtn.putClientProperty("JButton.buttonType", "roundRect");
        deleteBtn.setForeground(new Color(225, 29, 72));
        deleteBtn.addActionListener(e -> onDeleteProduct());

        JButton refreshBtn = new JButton("Refresh");
        refreshBtn.putClientProperty("JButton.buttonType", "roundRect");
        refreshBtn.addActionListener(e -> refreshProducts());

        actionButtons.add(addBtn);
        actionButtons.add(editBtn);
        actionButtons.add(deleteBtn);
        actionButtons.add(refreshBtn);

        // Search Filter on right
        JPanel searchBox = new JPanel(new FlowLayout(FlowLayout.RIGHT, 8, 0));
        searchBox.setOpaque(false);
        JLabel searchLbl = new JLabel("Filter Products:");
        searchLbl.setFont(new Font("Segoe UI", Font.BOLD, 12));
        searchLbl.setForeground(new Color(71, 85, 105));

        JTextField searchField = new JTextField(18);
        searchField.putClientProperty("JTextField.placeholderText", "Search by name, brand...");

        productSorter = new TableRowSorter<>(productTableModel);
        productTable.setRowSorter(productSorter);

        searchField.getDocument().addDocumentListener(new DocumentListener() {
            @Override
            public void insertUpdate(DocumentEvent e) { filter(); }
            @Override
            public void removeUpdate(DocumentEvent e) { filter(); }
            @Override
            public void changedUpdate(DocumentEvent e) { filter(); }

            private void filter() {
                String text = searchField.getText().trim();
                if (text.isEmpty()) {
                    productSorter.setRowFilter(null);
                } else {
                    productSorter.setRowFilter(RowFilter.regexFilter("(?i)" + text));
                }
            }
        });

        searchBox.add(searchLbl);
        searchBox.add(searchField);

        toolBarPanel.add(actionButtons, BorderLayout.WEST);
        toolBarPanel.add(searchBox, BorderLayout.EAST);

        panel.add(toolBarPanel, BorderLayout.NORTH);

        // Configure Product Table
        styleProductTable();
        JScrollPane scrollPane = new JScrollPane(productTable);
        scrollPane.setBorder(BorderFactory.createLineBorder(new Color(226, 232, 240)));
        panel.add(scrollPane, BorderLayout.CENTER);

        return panel;
    }

    private void styleProductTable() {
        productTable.setRowHeight(34);
        productTable.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
        productTable.setShowGrid(true);
        productTable.setGridColor(new Color(241, 245, 249));

        // Column widths
        if (productTable.getColumnModel().getColumnCount() >= 8) {
            productTable.getColumnModel().getColumn(0).setPreferredWidth(55);  // ID
            productTable.getColumnModel().getColumn(1).setPreferredWidth(270); // Name
            productTable.getColumnModel().getColumn(2).setPreferredWidth(120); // Brand
            productTable.getColumnModel().getColumn(3).setPreferredWidth(160); // Category
            productTable.getColumnModel().getColumn(4).setPreferredWidth(110); // Price
            productTable.getColumnModel().getColumn(5).setPreferredWidth(95);  // Discount
            productTable.getColumnModel().getColumn(6).setPreferredWidth(85);  // Stock
            productTable.getColumnModel().getColumn(7).setPreferredWidth(90);  // Status
        }

        // Custom Cell Renderers
        DefaultTableCellRenderer centerRenderer = new DefaultTableCellRenderer();
        centerRenderer.setHorizontalAlignment(SwingConstants.CENTER);
        productTable.getColumnModel().getColumn(0).setCellRenderer(centerRenderer);
        productTable.getColumnModel().getColumn(5).setCellRenderer(centerRenderer);

        DefaultTableCellRenderer priceRenderer = new DefaultTableCellRenderer();
        priceRenderer.setHorizontalAlignment(SwingConstants.RIGHT);
        priceRenderer.setFont(new Font("Segoe UI", Font.BOLD, 12));
        priceRenderer.setForeground(new Color(79, 70, 229));
        productTable.getColumnModel().getColumn(4).setCellRenderer(priceRenderer);

        productTable.getColumnModel().getColumn(6).setCellRenderer(new DefaultTableCellRenderer() {
            @Override
            public Component getTableCellRendererComponent(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int column) {
                JLabel l = (JLabel) super.getTableCellRendererComponent(table, value, isSelected, hasFocus, row, column);
                l.setHorizontalAlignment(SwingConstants.CENTER);
                try {
                    int stock = Integer.parseInt(value.toString());
                    if (stock <= 10) {
                        l.setForeground(new Color(225, 29, 72)); // Red
                        l.setFont(l.getFont().deriveFont(Font.BOLD));
                    } else if (stock <= 25) {
                        l.setForeground(new Color(217, 119, 6)); // Amber
                    } else {
                        l.setForeground(new Color(16, 185, 129)); // Green
                    }
                } catch (Exception ignored) {}
                return l;
            }
        });

        productTable.getColumnModel().getColumn(7).setCellRenderer(new DefaultTableCellRenderer() {
            @Override
            public Component getTableCellRendererComponent(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int column) {
                JLabel l = (JLabel) super.getTableCellRendererComponent(table, value, isSelected, hasFocus, row, column);
                l.setHorizontalAlignment(SwingConstants.CENTER);
                String status = String.valueOf(value);
                if ("Active".equalsIgnoreCase(status)) {
                    l.setForeground(new Color(16, 185, 129));
                    l.setText("● Active");
                } else {
                    l.setForeground(Color.GRAY);
                    l.setText("○ Disabled");
                }
                return l;
            }
        });

        // Double click to edit
        productTable.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                if (e.getClickCount() == 2 && productTable.getSelectedRow() >= 0) {
                    onEditProduct();
                }
            }
        });
    }

    private JPanel createOrdersPanel() {
        JPanel panel = new JPanel(new BorderLayout(10, 10));
        panel.setBackground(Color.WHITE);
        panel.setBorder(new EmptyBorder(14, 16, 14, 16));

        JPanel toolBar = new JPanel(new FlowLayout(FlowLayout.LEFT, 10, 0));
        toolBar.setOpaque(false);

        JButton refreshBtn = new JButton("Refresh Orders");
        refreshBtn.putClientProperty("JButton.buttonType", "roundRect");
        refreshBtn.addActionListener(e -> refreshOrders());
        toolBar.add(refreshBtn);

        panel.add(toolBar, BorderLayout.NORTH);

        // Style Order Table
        orderTable.setRowHeight(34);
        orderTable.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
        orderTable.setShowGrid(true);
        orderTable.setGridColor(new Color(241, 245, 249));

        if (orderTable.getColumnModel().getColumnCount() >= 6) {
            orderTable.getColumnModel().getColumn(0).setPreferredWidth(100);
            orderTable.getColumnModel().getColumn(1).setPreferredWidth(180);
            orderTable.getColumnModel().getColumn(2).setPreferredWidth(120);
            orderTable.getColumnModel().getColumn(3).setPreferredWidth(130);
            orderTable.getColumnModel().getColumn(4).setPreferredWidth(120);
            orderTable.getColumnModel().getColumn(5).setPreferredWidth(170);
        }

        DefaultTableCellRenderer orderIdRenderer = new DefaultTableCellRenderer();
        orderIdRenderer.setHorizontalAlignment(SwingConstants.CENTER);
        orderIdRenderer.setFont(new Font("Segoe UI", Font.BOLD, 12));
        orderTable.getColumnModel().getColumn(0).setCellRenderer(orderIdRenderer);

        DefaultTableCellRenderer amountRenderer = new DefaultTableCellRenderer();
        amountRenderer.setHorizontalAlignment(SwingConstants.RIGHT);
        amountRenderer.setFont(new Font("Segoe UI", Font.BOLD, 12));
        amountRenderer.setForeground(new Color(79, 70, 229));
        orderTable.getColumnModel().getColumn(2).setCellRenderer(amountRenderer);

        orderTable.getColumnModel().getColumn(4).setCellRenderer(new DefaultTableCellRenderer() {
            @Override
            public Component getTableCellRendererComponent(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int column) {
                JLabel l = (JLabel) super.getTableCellRendererComponent(table, value, isSelected, hasFocus, row, column);
                l.setHorizontalAlignment(SwingConstants.CENTER);
                String st = String.valueOf(value);
                if ("DELIVERED".equalsIgnoreCase(st)) {
                    l.setForeground(new Color(16, 185, 129));
                } else if ("CONFIRMED".equalsIgnoreCase(st) || "SHIPPED".equalsIgnoreCase(st)) {
                    l.setForeground(new Color(14, 165, 233));
                } else if ("CANCELLED".equalsIgnoreCase(st)) {
                    l.setForeground(new Color(225, 29, 72));
                } else {
                    l.setForeground(new Color(217, 119, 6));
                }
                return l;
            }
        });

        JScrollPane scrollPane = new JScrollPane(orderTable);
        scrollPane.setBorder(BorderFactory.createLineBorder(new Color(226, 232, 240)));
        panel.add(scrollPane, BorderLayout.CENTER);
        return panel;
    }

    private JPanel createMetricsPanel() {
        JPanel panel = new JPanel(new BorderLayout(20, 20));
        panel.setBackground(new Color(248, 250, 252));
        panel.setBorder(new EmptyBorder(24, 24, 24, 24));

        // 4 Cards Grid
        JPanel cardsGrid = new JPanel(new GridLayout(1, 4, 16, 16));
        cardsGrid.setOpaque(false);

        cardsGrid.add(createCard("Total Revenue", kpiRevenue, new Color(79, 70, 229), "Gross settled sales"));
        cardsGrid.add(createCard("Total Orders", kpiOrders, new Color(16, 185, 129), "Placed customer orders"));
        cardsGrid.add(createCard("Catalog Items", kpiProducts, new Color(14, 165, 233), "Active store products"));
        cardsGrid.add(createCard("Low Stock Alert", kpiLowStock, new Color(244, 63, 94), "Stock under 20 units"));

        panel.add(cardsGrid, BorderLayout.NORTH);

        // Architecture & System Status Card
        JPanel infoCard = new JPanel(new BorderLayout(16, 16));
        infoCard.setBackground(Color.WHITE);
        infoCard.setBorder(BorderFactory.createCompoundBorder(
                BorderFactory.createLineBorder(new Color(226, 232, 240), 1, true),
                BorderFactory.createEmptyBorder(20, 24, 20, 24)
        ));

        JLabel infoTitle = new JLabel("System Environment & Health Status");
        infoTitle.setFont(new Font("Segoe UI", Font.BOLD, 15));
        infoTitle.setForeground(new Color(30, 41, 59));
        infoCard.add(infoTitle, BorderLayout.NORTH);

        JPanel details = new JPanel(new GridLayout(6, 2, 12, 10));
        details.setOpaque(false);

        addDetailRow(details, "Application Version:", "QuickKart Enterprise Platform v1.0.0");
        addDetailRow(details, "Runtime Environment:", "Java 21 (Temurin JDK 21.0.12.1+1)");
        addDetailRow(details, "Database Driver:", "H2 Database 2.2.224 Clustered AutoServer");
        addDetailRow(details, "Database Storage:", "~/.quickkart/h2_quickkart.mv.db");
        addDetailRow(details, "Connection Pool:", "HikariCP 5.1.0 (QuickKart-H2-EmbeddedPool)");
        addDetailRow(details, "Web Application URL:", "http://localhost:8080/ (Apache Tomcat 10.1)");

        infoCard.add(details, BorderLayout.CENTER);

        JPanel actionRow = new JPanel(new FlowLayout(FlowLayout.LEFT, 12, 0));
        actionRow.setOpaque(false);

        JButton launchWebBtn = new JButton("Launch Storefront in Browser");
        launchWebBtn.setBackground(new Color(79, 70, 229));
        launchWebBtn.setForeground(Color.WHITE);
        launchWebBtn.setFont(new Font("Segoe UI", Font.BOLD, 12));
        launchWebBtn.putClientProperty("JButton.buttonType", "roundRect");
        launchWebBtn.addActionListener(e -> openWebBrowser("http://localhost:8080/"));

        JButton syncBtn = new JButton("Refresh KPI Metrics");
        syncBtn.putClientProperty("JButton.buttonType", "roundRect");
        syncBtn.addActionListener(e -> refreshMetrics());

        actionRow.add(launchWebBtn);
        actionRow.add(syncBtn);
        infoCard.add(actionRow, BorderLayout.SOUTH);

        panel.add(infoCard, BorderLayout.CENTER);
        return panel;
    }

    private void addDetailRow(JPanel p, String label, String value) {
        JLabel l = new JLabel(label);
        l.setFont(new Font("Segoe UI", Font.BOLD, 12));
        l.setForeground(new Color(100, 116, 139));

        JLabel v = new JLabel(value);
        v.setFont(new Font("Segoe UI", Font.PLAIN, 12));
        v.setForeground(new Color(30, 41, 59));

        p.add(l);
        p.add(v);
    }

    private JPanel createCard(String title, JLabel valueLabel, Color accentColor, String subtitle) {
        JPanel card = new JPanel(new BorderLayout(8, 8));
        card.setBorder(BorderFactory.createCompoundBorder(
                BorderFactory.createLineBorder(new Color(226, 232, 240), 1, true),
                BorderFactory.createEmptyBorder(16, 18, 16, 18)
        ));
        card.setBackground(Color.WHITE);

        JPanel top = new JPanel(new BorderLayout());
        top.setOpaque(false);
        JLabel titleLabel = new JLabel(title);
        titleLabel.setFont(new Font("Segoe UI", Font.BOLD, 13));
        titleLabel.setForeground(new Color(100, 116, 139));
        top.add(titleLabel, BorderLayout.WEST);

        valueLabel.setFont(new Font("Segoe UI", Font.BOLD, 22));
        valueLabel.setForeground(accentColor);

        JLabel subLabel = new JLabel(subtitle);
        subLabel.setFont(new Font("Segoe UI", Font.PLAIN, 11));
        subLabel.setForeground(new Color(148, 163, 184));

        card.add(top, BorderLayout.NORTH);
        card.add(valueLabel, BorderLayout.CENTER);
        card.add(subLabel, BorderLayout.SOUTH);
        return card;
    }

    private void onAddProduct() {
        List<Category> categories = categoryDAO.findAll();
        ProductDialog dialog = new ProductDialog(this, "Add New Product", null, categories);
        dialog.setVisible(true);

        if (dialog.isSaved()) {
            productDAO.create(dialog.getProduct());
            refreshProducts();
            refreshMetrics();
        }
    }

    private void onEditProduct() {
        int viewRow = productTable.getSelectedRow();
        if (viewRow < 0) {
            JOptionPane.showMessageDialog(this, "Please select a product to edit.", "Selection Required", JOptionPane.WARNING_MESSAGE);
            return;
        }

        int modelRow = productTable.convertRowIndexToModel(viewRow);
        Product selected = productTableModel.getProductAt(modelRow);
        if (selected != null) {
            List<Category> categories = categoryDAO.findAll();
            ProductDialog dialog = new ProductDialog(this, "Edit Product", selected, categories);
            dialog.setVisible(true);

            if (dialog.isSaved()) {
                productDAO.update(dialog.getProduct());
                refreshProducts();
                refreshMetrics();
            }
        }
    }

    private void onDeleteProduct() {
        int viewRow = productTable.getSelectedRow();
        if (viewRow < 0) {
            JOptionPane.showMessageDialog(this, "Please select a product to delete.", "Selection Required", JOptionPane.WARNING_MESSAGE);
            return;
        }

        int modelRow = productTable.convertRowIndexToModel(viewRow);
        Product selected = productTableModel.getProductAt(modelRow);
        if (selected != null) {
            int confirm = JOptionPane.showConfirmDialog(this,
                    "Are you sure you want to permanently delete '" + selected.getName() + "'?",
                    "Confirm Deletion", JOptionPane.YES_NO_OPTION);

            if (confirm == JOptionPane.YES_OPTION) {
                productDAO.delete(selected.getProductId());
                refreshProducts();
                refreshMetrics();
            }
        }
    }

    private void refreshAllData() {
        refreshProducts();
        refreshOrders();
        refreshMetrics();
    }

    private void refreshProducts() {
        List<Product> list = productDAO.findAll(false);
        productTableModel.setProducts(list);
    }

    private void refreshOrders() {
        orderTableModel.setRowCount(0);
        List<Order> orders = orderDAO.findAll();
        for (Order o : orders) {
            orderTableModel.addRow(new Object[]{
                    "#QK-" + o.getOrderId(),
                    o.getUserName(),
                    String.format("₹%,.2f", o.getFinalAmount()),
                    o.getPaymentMethod() + " (" + o.getPaymentStatus() + ")",
                    o.getOrderStatus(),
                    o.getCreatedAt() != null ? o.getCreatedAt().toString() : ""
            });
        }
    }

    private void refreshMetrics() {
        kpiRevenue.setText(String.format("₹%,.2f", orderDAO.getTotalRevenue()));
        kpiOrders.setText(String.valueOf(orderDAO.countOrders()));
        kpiProducts.setText(String.valueOf(productDAO.countProducts()));

        List<Product> all = productDAO.findAll(false);
        long lowStockCount = all.stream().filter(p -> p.getStock() <= 20).count();
        kpiLowStock.setText(String.valueOf(lowStockCount));
    }

    private void setAppIcon() {
        String[] iconPaths = {
                "/home/devops-user/Downloads/quickkart-icon.png",
                "/home/devops-user/Downloads/java-project/quickkart-web/src/main/webapp/assets/img/quickkart-icon.png"
        };
        for (String path : iconPaths) {
            File f = new File(path);
            if (f.exists()) {
                ImageIcon icon = new ImageIcon(path);
                setIconImage(icon.getImage());
                break;
            }
        }
    }

    private JLabel createLogoIcon(int size) {
        String iconPath = "/home/devops-user/Downloads/quickkart-icon.png";
        File f = new File(iconPath);
        if (f.exists()) {
            ImageIcon orig = new ImageIcon(iconPath);
            Image scaled = orig.getImage().getScaledInstance(size, size, Image.SCALE_SMOOTH);
            return new JLabel(new ImageIcon(scaled));
        }
        JLabel fallback = new JLabel("QK");
        fallback.setFont(new Font("Segoe UI", Font.BOLD, 18));
        fallback.setForeground(new Color(79, 70, 229));
        return fallback;
    }

    private void openWebBrowser(String url) {
        try {
            if (Desktop.isDesktopSupported() && Desktop.getDesktop().isSupported(Desktop.Action.BROWSE)) {
                Desktop.getDesktop().browse(new URI(url));
            } else {
                new ProcessBuilder("xdg-open", url).start();
            }
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(this, "Could not open browser: " + ex.getMessage());
        }
    }
}
