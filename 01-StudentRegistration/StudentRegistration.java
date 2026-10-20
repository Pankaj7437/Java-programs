import javax.swing.*;
import java.awt.event.*;
public class StudentRegistration extends JFrame implements ActionListener {
    // Labels    
    JLabel lblName, lblRoll, lblGender, lblBranch;

    // Text Fields
    JTextField txtName, txtRoll, txtBranch;

    // Radio Buttons   
    JRadioButton male, female;    
    ButtonGroup genderGroup;

    // Check Box    
    JCheckBox terms;

    // Buttons   
    JButton submit, reset;

    public StudentRegistration() {
        setTitle("Student Registration Form");
        setSize(400, 400);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(null);

        // Labels
        lblName = new JLabel("Student Name");
        lblName.setBounds(50, 50, 100, 30);
        add(lblName);

        txtName = new JTextField();
        txtName.setBounds(150, 50, 150, 30);
        add(txtName);

        lblRoll = new JLabel("Roll Number");
        lblRoll.setBounds(50, 90, 100, 30);
        add(lblRoll);

        txtRoll = new JTextField();
        txtRoll.setBounds(150, 90, 150, 30);
        add(txtRoll);

        lblGender = new JLabel("Gender");
        lblGender.setBounds(50, 130, 100, 30);
        add(lblGender);

        male = new JRadioButton("Male");
        male.setBounds(150, 130, 60, 30);
        add(male);

        female = new JRadioButton("Female");
        female.setBounds(210, 130, 60, 30);
        add(female);

        genderGroup = new ButtonGroup();
        genderGroup.add(male);
        genderGroup.add(female);

        lblBranch = new JLabel("Branch");
        lblBranch.setBounds(50, 170, 100, 30);
        add(lblBranch);

        txtBranch = new JTextField();
        txtBranch.setBounds(150, 170, 150, 30);
        add(txtBranch);

        terms = new JCheckBox("I agree to terms and conditions");
        terms.setBounds(50, 210, 250, 30);
        add(terms);

        submit = new JButton("Submit");
        submit.setBounds(50, 250, 100, 30);
        submit.addActionListener(this);
        add(submit);

        reset = new JButton("Reset");
        reset.setBounds(200, 250, 100, 30);
        reset.addActionListener(this);
        add(reset);

        setVisible(true);

    }

    @Override
    public void actionPerformed(ActionEvent e) {
        // Reset button
        if (e.getSource() == reset) {
            txtName.setText("");
            txtRoll.setText("");
            txtBranch.setText("");
            genderGroup.clearSelection();
            terms.setSelected(false);
            return;
        } 

        // Submit button
        if (txtName.getText().trim().isEmpty()) {
            JOptionPane.showMessageDialog(this, "Please enter student name", "Error", JOptionPane.ERROR_MESSAGE);
            return;
        }

        if (txtRoll.getText().trim().isEmpty()) {
            JOptionPane.showMessageDialog(this, "Please enter roll number", "Error", JOptionPane.ERROR_MESSAGE);
            return;
        }

        if (!male.isSelected() && !female.isSelected()) {
            JOptionPane.showMessageDialog(this, "Please select gender", "Error", JOptionPane.ERROR_MESSAGE);
            return;
        }

        if (txtBranch.getText().trim().isEmpty()) {
            JOptionPane.showMessageDialog(this, "Please enter branch", "Error", JOptionPane.ERROR_MESSAGE);
            return;
        }

        if (!terms.isSelected()) {
            JOptionPane.showMessageDialog(this, "Please agree to terms and conditions", "Error", JOptionPane.ERROR_MESSAGE);
            return;
        }

        String gender = male.isSelected() ? "Male" : "Female";

        JOptionPane.showMessageDialog(this,
            "Registration Successful!\n\n" 
                + "Student Name: " + txtName.getText()
                + "\nRoll Number: " + txtRoll.getText()
                + "\nGender: " + gender
                + "\nBranch: " + txtBranch.getText());
    }

    public static void main(String[] args) {
        new StudentRegistration();
    }
}