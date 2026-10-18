package com.quickkart.swing;

import com.formdev.flatlaf.FlatLightLaf;
import com.quickkart.swing.view.LoginFrame;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.swing.*;
import java.awt.*;

/**
 * Entry point for the QuickKart Swing Desktop Administration module.
 * Sets the modern FlatLaf Pluggable Look and Feel and initiates the Swing event dispatch thread.
 */
public class MainSwingAdmin {
    private static final Logger logger = LoggerFactory.getLogger(MainSwingAdmin.class);

    public static void main(String[] args) {
        // High-DPI and Anti-Aliasing text rendering
        System.setProperty("awt.useSystemAAFontSettings", "on");
        System.setProperty("swing.aatext", "true");

        try {
            FlatLightLaf.setup();

            // Modern theme customizations
            UIManager.put("Button.arc", 10);
            UIManager.put("Component.arc", 8);
            UIManager.put("ProgressBar.arc", 8);
            UIManager.put("TextComponent.arc", 8);
            UIManager.put("ScrollBar.thumbArc", 999);
            UIManager.put("ScrollBar.thumbInsets", new Insets(2, 2, 2, 2));
            UIManager.put("Table.rowHeight", 34);
            UIManager.put("TableHeader.height", 36);
            UIManager.put("TabbedPane.showTabSeparators", true);
            UIManager.put("TabbedPane.tabHeight", 36);
            UIManager.put("TabbedPane.selectedBackground", Color.WHITE);
            UIManager.put("Component.focusWidth", 1);
            UIManager.put("Component.innerFocusWidth", 0);

            Font defaultFont = new Font("Segoe UI", Font.PLAIN, 13);
            if (defaultFont.getFamily().equals("Dialog")) {
                defaultFont = new Font("SansSerif", Font.PLAIN, 13);
            }
            UIManager.put("defaultFont", defaultFont);
        } catch (Exception e) {
            logger.warn("Could not set FlatLaf look and feel, falling back to system: {}", e.getMessage());
            try {
                UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
            } catch (Exception ignored) {}
        }

        SwingUtilities.invokeLater(() -> {
            LoginFrame frame = new LoginFrame();
            frame.setVisible(true);
        });
    }
}
