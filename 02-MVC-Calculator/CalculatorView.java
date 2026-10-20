import javax.swing.*;
import java.awt.*;

/**
 * View component of the MVC Calculator.
 * Constructs and lays out all graphical user interface elements.
 * Maintains no business calculation logic.
 */
public class CalculatorView extends JFrame {

    private JTextField txtNum1;
    private JTextField txtNum2;
    private JTextField txtResult;

    private JButton btnAdd;
    private JButton btnSub;
    private JButton btnMul;
    private JButton btnDiv;
    private JButton btnClear;

    public CalculatorView() {
        setTitle("MVC Calculator Application");
        setSize(420, 360);
        setLocationRelativeTo(null);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(null);
        setResizable(false);

        Font labelFont = new Font("SansSerif", Font.BOLD, 14);
        Font fieldFont = new Font("SansSerif", Font.PLAIN, 14);
        Font buttonFont = new Font("SansSerif", Font.BOLD, 16);

        // First Number Label & Field
        JLabel lblNum1 = new JLabel("First Number:");
        lblNum1.setFont(labelFont);
        lblNum1.setBounds(40, 30, 130, 30);
        add(lblNum1);

        txtNum1 = new JTextField();
        txtNum1.setFont(fieldFont);
        txtNum1.setBounds(180, 30, 180, 30);
        add(txtNum1);

        // Second Number Label & Field
        JLabel lblNum2 = new JLabel("Second Number:");
        lblNum2.setFont(labelFont);
        lblNum2.setBounds(40, 75, 130, 30);
        add(lblNum2);

        txtNum2 = new JTextField();
        txtNum2.setFont(fieldFont);
        txtNum2.setBounds(180, 75, 180, 30);
        add(txtNum2);

        // Operator Buttons
        btnAdd = new JButton("+");
        btnAdd.setFont(buttonFont);
        btnAdd.setBounds(40, 130, 70, 35);
        add(btnAdd);

        btnSub = new JButton("-");
        btnSub.setFont(buttonFont);
        btnSub.setBounds(125, 130, 70, 35);
        add(btnSub);

        btnMul = new JButton("×");
        btnMul.setFont(buttonFont);
        btnMul.setBounds(210, 130, 70, 35);
        add(btnMul);

        btnDiv = new JButton("÷");
        btnDiv.setFont(buttonFont);
        btnDiv.setBounds(290, 130, 70, 35);
        add(btnDiv);

        // Result Label & Field
        JLabel lblResult = new JLabel("Result:");
        lblResult.setFont(labelFont);
        lblResult.setBounds(40, 190, 130, 30);
        add(lblResult);

        txtResult = new JTextField();
        txtResult.setFont(new Font("SansSerif", Font.BOLD, 14));
        txtResult.setBounds(180, 190, 180, 30);
        txtResult.setEditable(false);
        txtResult.setBackground(new Color(245, 245, 245));
        add(txtResult);

        // Clear Button
        btnClear = new JButton("Clear / Reset");
        btnClear.setFont(labelFont);
        btnClear.setBounds(120, 245, 160, 35);
        add(btnClear);
    }

    // Accessor methods for Controller bindings
    public String getFirstNumberText() {
        return txtNum1.getText().trim();
    }

    public String getSecondNumberText() {
        return txtNum2.getText().trim();
    }

    public void setResultText(String result) {
        txtResult.setText(result);
    }

    public void clearFields() {
        txtNum1.setText("");
        txtNum2.setText("");
        txtResult.setText("");
        txtNum1.requestFocus();
    }

    public JButton getBtnAdd() {
        return btnAdd;
    }

    public JButton getBtnSub() {
        return btnSub;
    }

    public JButton getBtnMul() {
        return btnMul;
    }

    public JButton getBtnDiv() {
        return btnDiv;
    }

    public JButton getBtnClear() {
        return btnClear;
    }

    public void showError(String message) {
        JOptionPane.showMessageDialog(this, message, "Input Error", JOptionPane.ERROR_MESSAGE);
    }
}
