import javax.swing.SwingUtilities;

/**
 * Application Entry Point.
 * Bootstraps the Model, View, and Controller on Swing's Event Dispatch Thread.
 */
public class Main {
    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            CalculatorModel model = new CalculatorModel();
            CalculatorView view = new CalculatorView();
            new CalculatorController(view, model);
            view.setVisible(true);
        });
    }
}
