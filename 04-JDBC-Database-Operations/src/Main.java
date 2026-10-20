import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * JDBC Database Connectivity & CRUD Operations Demonstration.
 * Connects to MySQL using JDBC Type-4 Driver, executes parameterized
 * INSERT operations using PreparedStatement, and reads records via ResultSet.
 *
 * @author Pankaj Sharma
 */
public class Main {

    // Database connection credentials (configurable via Environment Variables)
    private static final String DEFAULT_URL = "jdbc:mysql://localhost:3306/college_db";
    private static final String DEFAULT_USER = "root";
    private static final String DEFAULT_PASS = "password";

    public static void main(String[] args) {
        String dbUrl = System.getenv("DB_URL") != null ? System.getenv("DB_URL") : DEFAULT_URL;
        String dbUser = System.getenv("DB_USER") != null ? System.getenv("DB_USER") : DEFAULT_USER;
        String dbPass = System.getenv("DB_PASSWORD") != null ? System.getenv("DB_PASSWORD") : DEFAULT_PASS;

        System.out.println("==============================================================");
        System.out.println("         JAVA DATABASE CONNECTIVITY (JDBC) CRUD SYSTEM        ");
        System.out.println("==============================================================");
        System.out.println("[INFO] Target Database: " + dbUrl);
        System.out.println("[INFO] Database User:   " + dbUser);

        // Step 1: Register MySQL JDBC Driver
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("[SUCCESS] MySQL JDBC Driver registered successfully.");
        } catch (ClassNotFoundException e) {
            System.err.println("[ERROR] MySQL JDBC Driver not found in classpath: " + e.getMessage());
            System.err.println("[TIP] Include mysql-connector-j in your -cp argument.");
            return;
        }

        // Step 2 & 3: Establish Connection and Execute SQL Queries
        try (Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPass)) {
            System.out.println("[SUCCESS] Database connection established successfully!\n");

            // --- INSERTION DEMO VIA PREPAREDSTATEMENT ---
            String insertQuery = "INSERT INTO student (id, name, branch) VALUES (?, ?, ?) "
                               + "ON DUPLICATE KEY UPDATE name=VALUES(name), branch=VALUES(branch)";

            try (PreparedStatement pstmt = conn.prepareStatement(insertQuery)) {
                pstmt.setInt(1, 101);
                pstmt.setString(2, "Pankaj Sharma");
                pstmt.setString(3, "Computer Science & Engineering");

                int rowsAffected = pstmt.executeUpdate();
                System.out.println("[INSERT] PreparedStatement executed successfully (" + rowsAffected + " row(s) updated).");
            }

            // Insert another sample record
            try (PreparedStatement pstmt = conn.prepareStatement(insertQuery)) {
                pstmt.setInt(1, 102);
                pstmt.setString(2, "Priyanka Verma");
                pstmt.setString(3, "Information Technology");
                pstmt.executeUpdate();
            }

            // --- RETRIEVAL DEMO VIA STATEMENT & RESULTSET ---
            System.out.println("\n--------------------------------------------------------------");
            System.out.println("                   STUDENT RECORDS TABLE                      ");
            System.out.println("--------------------------------------------------------------");
            System.out.printf("%-8s | %-28s | %-30s%n", "ID", "STUDENT NAME", "BRANCH / DEPARTMENT");
            System.out.println("--------------------------------------------------------------");

            String selectQuery = "SELECT id, name, branch FROM student ORDER BY id ASC";
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(selectQuery)) {

                int count = 0;
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    String branch = rs.getString("branch");

                    System.out.printf("%-8d | %-28s | %-30s%n", id, name, branch);
                    count++;
                }

                System.out.println("--------------------------------------------------------------");
                System.out.println("[INFO] Total student records retrieved: " + count);
            }

        } catch (SQLException e) {
            System.err.println("[DATABASE ERROR] " + e.getMessage());
            System.err.println("\n[TROUBLESHOOTING GUIDE]:");
            System.err.println("1. Verify MySQL server is running (e.g. 'mysql -u root -p').");
            System.err.println("2. Create database using schema.sql: mysql -u root -p < schema.sql");
            System.err.println("3. Ensure database credentials match (default root / password).");
        }
    }
}
