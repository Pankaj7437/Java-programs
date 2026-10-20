import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

/**
 * Controller component of the MVC Calculator.
 * Listens for UI events on the View, validates user inputs,
 * delegates calculations to the Model, and updates the View.
 */
public class CalculatorController implements ActionListener {

    private final CalculatorView view;
    private final CalculatorModel model;

    public CalculatorController(CalculatorView view, CalculatorModel model) {
        this.view = view;
        this.model = model;

        // Register action listeners on View buttons
        this.view.getBtnAdd().addActionListener(this);
        this.view.getBtnSub().addActionListener(this);
        this.view.getBtnMul().addActionListener(this);
        this.view.getBtnDiv().addActionListener(this);
        this.view.getBtnClear().addActionListener(this);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        Object source = e.getSource();

        // Handle Clear button
        if (source == view.getBtnClear()) {
            view.clearFields();
            return;
        }

        // Validate and parse numerical inputs
        double num1;
        double num2;
        try {
            String str1 = view.getFirstNumberText();
            String str2 = view.getSecondNumberText();

            if (str1.isEmpty() || str2.isEmpty()) {
                view.showError("Please enter both first and second numbers.");
                return;
            }

            num1 = Double.parseDouble(str1);
            num2 = Double.parseDouble(str2);
        } catch (NumberFormatException ex) {
            view.showError("Invalid input: Please enter valid numerical values.");
            return;
        }

        // Delegate computation to Model based on triggered button
        try {
            double result = 0.0;
            if (source == view.getBtnAdd()) {
                result = model.add(num1, num2);
            } else if (source == view.getBtnSub()) {
                result = model.subtract(num1, num2);
            } else if (source == view.getBtnMul()) {
                result = model.multiply(num1, num2);
            } else if (source == view.getBtnDiv()) {
                result = model.divide(num1, num2);
            }

            // Display formatted result
            if (result == (long) result) {
                view.setResultText(String.format("%d", (long) result));
            } else {
                view.setResultText(String.format("%.4f", result).replaceAll("0+$", "").replaceAll("\\.$", ""));
            }
        } catch (ArithmeticException ex) {
            view.showError(ex.getMessage());
        }
    }
}
