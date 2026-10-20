/**
 * Model component of the MVC Calculator.
 * Encapsulates the arithmetic business logic and mathematical rules.
 */
public class CalculatorModel {

    /**
     * Performs addition of two numbers.
     */
    public double add(double a, double b) {
        return a + b;
    }

    /**
     * Performs subtraction of two numbers.
     */
    public double subtract(double a, double b) {
        return a - b;
    }

    /**
     * Performs multiplication of two numbers.
     */
    public double multiply(double a, double b) {
        return a * b;
    }

    /**
     * Performs division of two numbers with divide-by-zero protection.
     * @throws ArithmeticException when divisor is zero
     */
    public double divide(double a, double b) {
        if (b == 0.0) {
            throw new ArithmeticException("Division by zero is undefined.");
        }
        return a / b;
    }
}
