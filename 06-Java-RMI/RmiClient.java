import java.rmi.Naming;

/**
 * RMI Client application.
 * Performs lookup of the remote object in the RMI registry and invokes
 * remote methods as if they were local procedure calls.
 */
public class RmiClient {

    public static final String RMI_URL = "rmi://localhost:1099/CalculatorService";

    public static void main(String[] args) {
        System.out.println("==================================================");
        System.out.println("            JAVA RMI CLIENT CONNECTING            ");
        System.out.println("==================================================");
        System.out.println("[INFO] Looking up remote service at: " + RMI_URL);

        try {
            // Step 1: Perform RMI Registry lookup to retrieve remote Stub
            CalculatorService calc = (CalculatorService) Naming.lookup(RMI_URL);
            System.out.println("[SUCCESS] Remote Stub obtained successfully!\n");

            // Step 2: Invoke remote operations across JVM boundaries
            int a = 48;
            int b = 12;

            System.out.println("Invoking Remote Methods with inputs (a = " + a + ", b = " + b + "):");
            System.out.println("--------------------------------------------------");

            int sum = calc.add(a, b);
            System.out.println("[REMOTE CALL] add(" + a + ", " + b + ")      = " + sum);

            int diff = calc.subtract(a, b);
            System.out.println("[REMOTE CALL] subtract(" + a + ", " + b + ") = " + diff);

            int prod = calc.multiply(a, b);
            System.out.println("[REMOTE CALL] multiply(" + a + ", " + b + ") = " + prod);

            double quotient = calc.divide(a, b);
            System.out.println("[REMOTE CALL] divide(" + a + ", " + b + ")   = " + quotient);

            System.out.println("--------------------------------------------------");
            System.out.println("[SUCCESS] All remote procedure invocations completed successfully.");

        } catch (Exception e) {
            System.err.println("[ERROR] RMI Client failure: " + e.getMessage());
            System.err.println("[TIP] Make sure RmiServer is running before starting RmiClient.");
            e.printStackTrace();
        }
    }
}
