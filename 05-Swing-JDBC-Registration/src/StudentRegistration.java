import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * Database-Driven GUI Application.
 * Combines Java Swing desktop interface with MySQL persistence via JDBC.
 *
 * @author Pankaj Sharma
 */
public class StudentRegistration extends JFrame implements ActionListener {

    // Database connection details (environment overrides supported)
    private static final String DEFAULT_URL = "jdbc:mysql://localhost:3306/college_db";
    private static final String DEFAULT_USER = "root";
    private static final String DEFAULT_PASSWORD = "password";

    private final String dbUrl;
    private final String dbUser;
    private final String dbPassword;

    // UI Components
    private JLabel lblName, lblRoll, lblGender, lblBranch;
    private JTextField txtName, txtRoll, txtBranch;
    private JRadioButton male, female;
    private ButtonGroup genderGroup;
    private JCheckBox terms;
    private JButton submit, reset;

    public StudentRegistration() {
        this.dbUrl = System.getenv("DB_URL") != null ? System.getenv("DB_URL") : DEFAULT_URL;
        this.dbUser = System.getenv("DB_USER") != null ? System.getenv("DB_USER") : DEFAULT_USER;
        this.dbPassword = System.getenv("DB_PASSWORD") != null ? System.getenv("DB_PASSWORD") : DEFAULT_PASSWORD;

        initializeUI();
    }

    private void initializeUI() {
        setTitle("Database-Integrated Student Registration (Swing + JDBC)");
        setSize(700, 560);
        setLocationRelativeTo(null);
        setLayout(null);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setResizable(false);

        Font titleFont = new Font("SansSerif", Font.BOLD, 20);
        Font labelFont = new Font("SansSerif", Font.BOLD, 15);
        Font fieldFont = new Font("SansSerif", Font.PLAIN, 15);
        Font buttonFont = new Font("SansSerif", Font.BOLD, 15);

        // Header Banner
        JLabel lblTitle = new JLabel("Student Registration & MySQL Persistence", SwingConstants.CENTER);
        lblTitle.setFont(titleFont);
        lblTitle.setBounds(50, 20, 600, 35);
        add(lblTitle);

        // Student Name
        lblName = new JLabel("Student Name:");
        lblName.setFont(labelFont);
        lblName.setBounds(70, 80, 160, 30);
        add(lblName);

        txtName = new JTextField();
        txtName.setFont(fieldFont);
        txtName.setBounds(240, 80, 380, 32);
        add(txtName);

        // Roll Number
        lblRoll = new JLabel("Roll Number:");
        lblRoll.setFont(labelFont);
        lblRoll.setBounds(70, 135, 160, 30);
        add(lblRoll);

        txtRoll = new JTextField();
        txtRoll.setFont(fieldFont);
        txtRoll.setBounds(240, 135, 380, 32);
        add(txtRoll);

        // Gender
        lblGender = new JLabel("Gender:");
        lblGender.setFont(labelFont);
        lblGender.setBounds(70, 190, 160, 30);
        add(lblGender);

        male = new JRadioButton("Male");
        male.setFont(fieldFont);
        male.setBounds(240, 190, 90, 30);
        add(male);

        female = new JRadioButton("Female");
        female.setFont(fieldFont);
        female.setBounds(340, 190, 110, 30);
        add(female);

        genderGroup = new ButtonGroup();
        genderGroup.add(male);
        genderGroup.add(female);

        // Branch
        lblBranch = new JLabel("Branch / Dept:");
        lblBranch.setFont(labelFont);
        lblBranch.setBounds(70, 245, 160, 30);
        add(lblBranch);

        txtBranch = new JTextField();
        txtBranch.setFont(fieldFont);
        txtBranch.setBounds(240, 245, 380, 32);
        add(txtBranch);

        // Terms & Conditions
        terms = new JCheckBox("I accept Terms & Conditions and certify the information is accurate");
        terms.setFont(new Font("SansSerif", Font.PLAIN, 13));
        terms.setBounds(70, 305, 550, 30);
        add(terms);

        // Submit Button
        submit = new JButton("Submit & Save to DB");
        submit.setFont(buttonFont);
        submit.setBounds(150, 370, 200, 42);
        submit.addActionListener(this);
        add(submit);

        // Reset Button
        reset = new JButton("Reset Form");
        reset.setFont(buttonFont);
        reset.setBounds(370, 370, 160, 42);
        reset.addActionListener(this);
        add(reset);

        // Status Footer
        JLabel lblStatus = new JLabel("Connected DB: " + dbUrl, SwingConstants.CENTER);
        lblStatus.setFont(new Font("SansSerif", Font.ITALIC, 12));
        lblStatus.setForeground(Color.GRAY);
        lblStatus.setBounds(50, 470, 600, 25);
        add(lblStatus);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == reset) {
            resetForm();
            return;
        }

        // Validation Checks
        String name = txtName.getText().trim();
        String roll = txtRoll.getText().trim();
        String branch = txtBranch.getText().trim();

        if (name.isEmpty()) {
            JOptionPane.showMessageDialog(this, "Please enter Student Name", "Validation Error", JOptionPane.WARNING_MESSAGE);
            txtName.requestFocus();
            return;
        }
        if (roll.isEmpty()) {
            JOptionPane.showMessageDialog(this, "Please enter Roll Number", "Validation Error", JOptionPane.WARNING_MESSAGE);
            txtRoll.requestFocus();
            return;
        }
        if (!male.isSelected() && !female.isSelected()) {
            JOptionPane.showMessageDialog(this, "Please select Gender", "Validation Error", JOptionPane.WARNING_MESSAGE);
            return;
        }
        if (branch.isEmpty()) {
            JOptionPane.showMessageDialog(this, "Please enter Branch", "Validation Error", JOptionPane.WARNING_MESSAGE);
            txtBranch.requestFocus();
            return;
        }
        if (!terms.isSelected()) {
            JOptionPane.showMessageDialog(this, "Please accept the Terms & Conditions", "Validation Error", JOptionPane.WARNING_MESSAGE);
            return;
        }

        String gender = male.isSelected() ? "Male" : "Female";

        // Persist to MySQL via JDBC
        if (saveRegistrationToDatabase(name, roll, gender, branch)) {
            JOptionPane.showMessageDialog(this,
                    "Registration saved successfully into MySQL Database!\n\n"
                            + "Student Name: " + name + "\n"
                            + "Roll Number:  " + roll + "\n"
                            + "Gender:       " + gender + "\n"
                            + "Branch:       " + branch + "\n"
                            + "Status:       Active Record Persisted",
                    "Success", JOptionPane.INFORMATION_MESSAGE);
            resetForm();
        }
    }

    private boolean saveRegistrationToDatabase(String name, String roll, String gender, String branch) {
        String insertSql = "INSERT INTO streg (name, roll, gender, branch) VALUES (?, ?, ?, ?)";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            JOptionPane.showMessageDialog(this,
                    "MySQL Driver not found in classpath!\n" + ex.getMessage(),
                    "Driver Error", JOptionPane.ERROR_MESSAGE);
            return false;
        }

        try (Connection connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
             PreparedStatement statement = connection.prepareStatement(insertSql)) {

            statement.setString(1, name);
            statement.setString(2, roll);
            statement.setString(3, gender);
            statement.setString(4, branch);

            int rows = statement.executeUpdate();
            return rows > 0;

        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(this,
                    "Database Insertion Error:\n" + ex.getMessage()
                            + "\n\nPlease ensure MySQL server is active and table 'streg' exists.",
                    "Database Error", JOptionPane.ERROR_MESSAGE);
            ex.printStackTrace();
            return false;
        }
    }

    private void resetForm() {
        txtName.setText("");
        txtRoll.setText("");
        txtBranch.setText("");
        genderGroup.clearSelection();
        terms.setSelected(false);
        txtName.requestFocus();
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            StudentRegistration app = new StudentRegistration();
            app.setVisible(true);
        });
    }
}
