package com.quickkart.swing.model;

import com.quickkart.common.model.Product;

import javax.swing.table.AbstractTableModel;
import java.util.ArrayList;
import java.util.List;

/**
 * Swing MVC Model: Custom AbstractTableModel representing catalog products for JTable.
 */
public class ProductTableModel extends AbstractTableModel {
    private final String[] columns = {"ID", "Product Name", "Brand", "Category", "Retail Price", "Discount", "Stock Units", "Status"};
    private List<Product> products = new ArrayList<>();

    public void setProducts(List<Product> products) {
        this.products = (products != null) ? products : new ArrayList<>();
        fireTableDataChanged();
    }

    public Product getProductAt(int rowIndex) {
        if (rowIndex >= 0 && rowIndex < products.size()) {
            return products.get(rowIndex);
        }
        return null;
    }

    @Override
    public int getRowCount() {
        return products.size();
    }

    @Override
    public int getColumnCount() {
        return columns.length;
    }

    @Override
    public String getColumnName(int column) {
        return columns[column];
    }

    @Override
    public Object getValueAt(int rowIndex, int columnIndex) {
        Product p = products.get(rowIndex);
        switch (columnIndex) {
            case 0: return p.getProductId();
            case 1: return p.getName();
            case 2: return p.getBrand();
            case 3: return p.getCategoryName() != null ? p.getCategoryName() : String.valueOf(p.getCategoryId());
            case 4: return String.format("₹%,.2f", p.getPrice());
            case 5: return p.getDiscount() > 0 ? String.format("%.0f%% OFF", p.getDiscount()) : "None";
            case 6: return p.getStock();
            case 7: return p.isStatus() ? "Active" : "Disabled";
            default: return "";
        }
    }
}
