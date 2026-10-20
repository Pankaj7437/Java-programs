import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;

/**
 * TCP Echo Server implementation.
 * Listens on a designated port, accepts incoming client connections,
 * reads messages across a network socket, and echoes responses.
 */
public class Server {

    public static final int PORT = 5000;

    public static void main(String[] args) {
        System.out.println("==================================================");
        System.out.println("        TCP SOCKET ECHO SERVER INITIALIZING       ");
        System.out.println("==================================================");
        System.out.println("[INFO] Server starting on port " + PORT + "...");

        try (ServerSocket serverSocket = new ServerSocket(PORT)) {
            System.out.println("[INFO] Server listening. Waiting for client to connect...");

            while (true) {
                try (Socket clientSocket = serverSocket.accept();
                     BufferedReader reader = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
                     PrintWriter writer = new PrintWriter(clientSocket.getOutputStream(), true)) {

                    System.out.println("\n[CONNECTED] Client connected from: " + clientSocket.getRemoteSocketAddress());
                    writer.println("Connection established to TCP Server. Type messages or 'bye' to quit.");

                    String clientMessage;
                    while ((clientMessage = reader.readLine()) != null) {
                        System.out.println("[CLIENT MESSAGE] " + clientMessage);

                        if ("bye".equalsIgnoreCase(clientMessage.trim())) {
                            writer.println("Goodbye! Disconnecting from server...");
                            System.out.println("[DISCONNECT] Client requested session termination.");
                            break;
                        }

                        // Echo response back to client
                        writer.println("[Server Echo]: " + clientMessage.toUpperCase());
                    }

                    System.out.println("[CLOSED] Session finished with " + clientSocket.getRemoteSocketAddress());
                    System.out.println("[INFO] Waiting for next client connection (Press Ctrl+C to terminate server)...\n");
                }
            }
        } catch (IOException e) {
            System.err.println("[ERROR] Server encounter exception: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
