import java.rmi.Naming;
import java.rmi.registry.LocateRegistry;

/**
 * RMI Server Host.
 * Instantiates the remote service object and binds it to the RMI Registry.
 * Automatically initializes an in-process RMI registry on port 1099 if not already present.
 */
public class RmiServer {

    public static final int RMI_PORT = 1099;
    public static final String SERVICE_NAME = "CalculatorService";

    public static void main(String[] args) {
        System.out.println("==================================================");
        System.out.println("            JAVA RMI SERVER INITIALIZING          ");
        System.out.println("==================================================");

        try {
            // Step 1: Start or locate in-process RMI Registry
            try {
                LocateRegistry.createRegistry(RMI_PORT);
                System.out.println("[INFO] Embedded RMI Registry started on port " + RMI_PORT);
            } catch (Exception e) {
                System.out.println("[INFO] RMI Registry already active on port " + RMI_PORT);
            }

            // Step 2: Create remote servant object
            CalculatorService service = new CalculatorServiceImpl();

            // Step 3: Bind remote servant stub to registry
            String rmiUrl = "rmi://localhost:" + RMI_PORT + "/" + SERVICE_NAME;
            Naming.rebind(rmiUrl, service);

            System.out.println("[SUCCESS] Service bound successfully: " + rmiUrl);
            System.out.println("[INFO] RMI Server is ready and listening for remote method calls.");
            System.out.println("[INFO] Press Ctrl+C in this terminal to stop the server.\n");

        } catch (Exception e) {
            System.err.println("[ERROR] Failed to start RMI Server: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
