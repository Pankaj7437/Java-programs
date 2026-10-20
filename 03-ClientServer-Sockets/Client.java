import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

/**
 * TCP Socket Client implementation.
 * Connects to the Server on localhost:5000, transmits messages
 * entered via keyboard, and reads incoming server echoes.
 */
public class Client {

    public static final String SERVER_HOST = "localhost";
    public static final int SERVER_PORT = 5000;

    public static void main(String[] args) {
        System.out.println("==================================================");
        System.out.println("           TCP SOCKET CLIENT STARTING             ");
        System.out.println("==================================================");
        System.out.println("[INFO] Attempting connection to " + SERVER_HOST + ":" + SERVER_PORT + "...");

        try (Socket socket = new Socket(SERVER_HOST, SERVER_PORT);
             BufferedReader serverIn = new BufferedReader(new InputStreamReader(socket.getInputStream()));
             PrintWriter serverOut = new PrintWriter(socket.getOutputStream(), true);
             BufferedReader userConsole = new BufferedReader(new InputStreamReader(System.in))) {

            System.out.println("[SUCCESS] Connected to server successfully!");

            // Read welcome greeting from server
            String welcomeMessage = serverIn.readLine();
            System.out.println("[SERVER] " + welcomeMessage);
            System.out.println("--------------------------------------------------");
            System.out.println("Enter text to transmit (Type 'bye' to exit):");

            String userInput;
            while (true) {
                System.out.print("> ");
                userInput = userConsole.readLine();

                if (userInput == null || userInput.trim().isEmpty()) {
                    continue;
                }

                // Send message to server
                serverOut.println(userInput);

                // Receive response from server
                String serverResponse = serverIn.readLine();
                System.out.println(serverResponse);

                if ("bye".equalsIgnoreCase(userInput.trim())) {
                    System.out.println("\n[INFO] Session terminated. Closing client connection.");
                    break;
                }
            }
        } catch (IOException e) {
            System.err.println("[ERROR] Unable to connect or I/O failure: " + e.getMessage());
            System.err.println("[TIP] Ensure Server.java is running first on port " + SERVER_PORT);
        }
    }
}
