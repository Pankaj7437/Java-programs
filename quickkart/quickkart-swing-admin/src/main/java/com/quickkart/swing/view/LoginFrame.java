package com.quickkart.swing.view;

import com.quickkart.common.model.User;
import com.quickkart.service.AuthService;

import javax.swing.*;
import java.awt.*;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.io.File;

/**
 * Swing View: Desktop Administrator Authentication Window with modern UI styling.
 */
public class LoginFrame extends JFrame {
    private final JTextField emailField = new JTextField(22);
    private final JPasswordField passwordField = new JPasswordField(22);
    private final JLabel statusLabel = new JLabel(" ", SwingConstants.CENTER);
    private final AuthService authService = new AuthService();

    public LoginFrame() {
        initUI();
    }

    private void initUI() {
        setTitle("QuickKart Desktop Admin - Sign In");
        setSize(440, 500);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);
        setResizable(false);

        // Set application icon
        setAppIcon();

        // Root container
        JPanel rootPanel = new JPanel(new BorderLayout());
        rootPanel.setBackground(new Color(248, 250, 252));
        rootPanel.setBorder(BorderFactory.createEmptyBorder(24, 28, 24, 28));

        // Center Card
        JPanel cardPanel = new JPanel();
        cardPanel.setLayout(new BoxLayout(cardPanel, BoxLayout.Y_AXIS));
        cardPanel.setBackground(Color.WHITE);
        cardPanel.setBorder(BorderFactory.createCompoundBorder(
                BorderFactory.createLineBorder(new Color(226, 232, 240), 1, true),
                BorderFactory.createEmptyBorder(28, 28, 28, 28)
        ));

        // Brand Icon / Header
        JLabel iconLabel = createLogoLabel();
        iconLabel.setAlignmentX(Component.CENTER_ALIGNMENT);
        cardPanel.add(iconLabel);
        cardPanel.add(Box.createVerticalStrut(12));

        JLabel titleLabel = new JLabel("QuickKart Admin");
        titleLabel.setFont(new Font("Segoe UI", Font.BOLD, 22));
        titleLabel.setForeground(new Color(30, 41, 59));
        titleLabel.setAlignmentX(Component.CENTER_ALIGNMENT);
        cardPanel.add(titleLabel);

        JLabel subtitleLabel = new JLabel("Desktop Administration Console");
        subtitleLabel.setFont(new Font("Segoe UI", Font.PLAIN, 12));
        subtitleLabel.setForeground(new Color(100, 116, 139));
        subtitleLabel.setAlignmentX(Component.CENTER_ALIGNMENT);
        cardPanel.add(subtitleLabel);
        cardPanel.add(Box.createVerticalStrut(24));

        // Form fields with proper labels
        JLabel emailLbl = new JLabel("Administrator Email");
        emailLbl.setFont(new Font("Segoe UI", Font.BOLD, 12));
        emailLbl.setForeground(new Color(71, 85, 105));
        emailLbl.setAlignmentX(Component.LEFT_ALIGNMENT);
        cardPanel.add(emailLbl);
        cardPanel.add(Box.createVerticalStrut(6));

        emailField.setPreferredSize(new Dimension(320, 38));
        emailField.setMaximumSize(new Dimension(Short.MAX_VALUE, 38));
        emailField.setAlignmentX(Component.LEFT_ALIGNMENT);
        emailField.putClientProperty("JTextField.placeholderText", "Enter admin email");
        cardPanel.add(emailField);
        cardPanel.add(Box.createVerticalStrut(16));

        JLabel passLbl = new JLabel("Password");
        passLbl.setFont(new Font("Segoe UI", Font.BOLD, 12));
        passLbl.setForeground(new Color(71, 85, 105));
        passLbl.setAlignmentX(Component.LEFT_ALIGNMENT);
        cardPanel.add(passLbl);
        cardPanel.add(Box.createVerticalStrut(6));

        passwordField.setPreferredSize(new Dimension(320, 38));
        passwordField.setMaximumSize(new Dimension(Short.MAX_VALUE, 38));
        passwordField.setAlignmentX(Component.LEFT_ALIGNMENT);
        passwordField.putClientProperty("JTextField.placeholderText", "Enter password");
        cardPanel.add(passwordField);
        cardPanel.add(Box.createVerticalStrut(12));

        // Status message
        statusLabel.setForeground(new Color(225, 29, 72));
        statusLabel.setFont(new Font("Segoe UI", Font.PLAIN, 12));
        statusLabel.setAlignmentX(Component.CENTER_ALIGNMENT);
        cardPanel.add(statusLabel);
        cardPanel.add(Box.createVerticalStrut(12));

        // Submit Button
        JButton loginBtn = new JButton("Sign In to Admin Console");
        loginBtn.setPreferredSize(new Dimension(320, 42));
        loginBtn.setMaximumSize(new Dimension(Short.MAX_VALUE, 42));
        loginBtn.setBackground(new Color(79, 70, 229));
        loginBtn.setForeground(Color.WHITE);
        loginBtn.setFont(new Font("Segoe UI", Font.BOLD, 13));
        loginBtn.setFocusPainted(false);
        loginBtn.setCursor(new Cursor(Cursor.HAND_CURSOR));
        loginBtn.setAlignmentX(Component.CENTER_ALIGNMENT);
        loginBtn.putClientProperty("JButton.buttonType", "roundRect");
        loginBtn.addActionListener(e -> onLogin());

        // Enable ENTER key submission
        KeyAdapter enterListener = new KeyAdapter() {
            @Override
            public void keyPressed(KeyEvent e) {
                if (e.getKeyCode() == KeyEvent.VK_ENTER) {
                    onLogin();
                }
            }
        };
        emailField.addKeyListener(enterListener);
        passwordField.addKeyListener(enterListener);

        cardPanel.add(loginBtn);
        rootPanel.add(cardPanel, BorderLayout.CENTER);
        add(rootPanel);
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

    private JLabel createLogoLabel() {
        String iconPath = "/home/devops-user/Downloads/quickkart-icon.png";
        File f = new File(iconPath);
        if (f.exists()) {
            ImageIcon orig = new ImageIcon(iconPath);
            Image scaled = orig.getImage().getScaledInstance(54, 54, Image.SCALE_SMOOTH);
            return new JLabel(new ImageIcon(scaled));
        }
        JLabel fallback = new JLabel("QK");
        fallback.setFont(new Font("Segoe UI", Font.BOLD, 28));
        fallback.setForeground(new Color(79, 70, 229));
        return fallback;
    }

    private void onLogin() {
        String email = emailField.getText().trim();
        String password = new String(passwordField.getPassword()).trim();

        if (email.isEmpty() || password.isEmpty()) {
            statusLabel.setText("Please enter both email and password.");
            return;
        }

        statusLabel.setForeground(new Color(79, 70, 229));
        statusLabel.setText("Authenticating credentials...");

        // Perform authentication
        SwingWorker<User, Void> worker = new SwingWorker<>() {
            @Override
            protected User doInBackground() {
                return authService.authenticate(email, password);
            }

            @Override
            protected void done() {
                try {
                    User user = get();
                    if (user != null) {
                        if (user.isAdmin()) {
                            dispose();
                            SwingUtilities.invokeLater(() -> new AdminDashboardFrame(user).setVisible(true));
                        } else {
                            statusLabel.setForeground(new Color(225, 29, 72));
                            statusLabel.setText("Access Denied: Administrator role required.");
                        }
                    } else {
                        statusLabel.setForeground(new Color(225, 29, 72));
                        statusLabel.setText("Invalid email or password.");
                    }
                } catch (Exception ex) {
                    statusLabel.setForeground(new Color(225, 29, 72));
                    statusLabel.setText("Authentication error: " + ex.getMessage());
                }
            }
        };
        worker.execute();
    }
}
