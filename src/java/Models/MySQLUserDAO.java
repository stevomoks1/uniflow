package Models;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class MySQLUserDAO {
    private static final String JDBC_URL = readSetting(
            "uniflow.jdbc.url",
            "UNIFLOW_JDBC_URL",
            "jdbc:mysql://localhost:3306/uniflowdb?createDatabaseIfNotExist=true&useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC");
    private static final String JDBC_USER = readSetting("uniflow.jdbc.user", "UNIFLOW_JDBC_USER", "root");
    private static final String JDBC_PASSWORD = readSetting("uniflow.jdbc.password", "UNIFLOW_JDBC_PASSWORD", "Winnerbonnie@24");
    private static final String JDBC_DRIVER = readSetting("uniflow.jdbc.driver", "UNIFLOW_JDBC_DRIVER", "com.mysql.cj.jdbc.Driver");

    static {
        try {
            Class.forName(JDBC_DRIVER);
        } catch (ClassNotFoundException ex) {
            throw new IllegalStateException("MySQL JDBC driver not found: " + JDBC_DRIVER, ex);
        }
    }

    private static Connection getConnection() throws SQLException {
        Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
        createSchema(conn);
        return conn;
    }

    private static void createSchema(Connection connection) {
        String createUsers = "CREATE TABLE IF NOT EXISTS users ("
                + "email VARCHAR(255) PRIMARY KEY, "
                + "password_hash VARCHAR(255), "
                + "first_name VARCHAR(100), "
                + "last_name VARCHAR(100), "
                + "role VARCHAR(100)"
                + ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4";
        try (Statement statement = connection.createStatement()) {
            statement.executeUpdate(createUsers);
        } catch (SQLException e) {
            // Log but don't fail, assume table might exist or will fail on actual write/read
            System.err.println("Could not create schema: " + e.getMessage());
        }
    }

    public static boolean save(User user) {
        if (user == null) {
            return false;
        }
        String sql = "INSERT INTO users(email, password_hash, first_name, last_name, role) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, normalizeEmail(user.getEmail()));
            ps.setString(2, user.getPasswordHash());
            ps.setString(3, user.getFirstName());
            ps.setString(4, user.getLastName());
            ps.setString(5, user.getRole());
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            String sqlState = ex.getSQLState();
            if (sqlState != null && (sqlState.equals("23000") || sqlState.equals("23505"))) {
                return false;
            }
            throw new RuntimeException("Unable to save user", ex);
        }
    }

    public static User findByEmail(String email) {
        if (email == null) {
            return null;
        }
        String normalizedEmail = normalizeEmail(email);
        String sql = "SELECT email, password_hash, first_name, last_name, role FROM users WHERE email = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, normalizedEmail);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User(
                            rs.getString("email"),
                            rs.getString("password_hash"),
                            rs.getString("first_name"),
                            rs.getString("last_name"),
                            rs.getString("role")
                    );
                }
            }
        } catch (SQLException ex) {
            throw new RuntimeException("Unable to query user by email", ex);
        }
        return null;
    }

    public static User authenticate(String email, String password) {
        User user = findByEmail(email);
        if (user == null || password == null) {
            return null;
        }
        return user.getPasswordHash() != null && user.getPasswordHash().equals(hashPassword(password)) ? user : null;
    }

    public static int countUsers() {
        String sql = "SELECT COUNT(*) AS total FROM users";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("total");
            }
            return 0;
        } catch (SQLException ex) {
            throw new RuntimeException("Unable to count users", ex);
        }
    }

    public static String hashPassword(String password) {
        if (password == null) {
            return null;
        }
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = digest.digest(password.getBytes(StandardCharsets.UTF_8));
            return bytesToHex(hashedBytes);
        } catch (NoSuchAlgorithmException ex) {
            throw new IllegalStateException("SHA-256 algorithm not available", ex);
        }
    }

    private static String bytesToHex(byte[] bytes) {
        char[] hexChars = new char[bytes.length * 2];
        final char[] HEX_ARRAY = "0123456789abcdef".toCharArray();
        for (int i = 0; i < bytes.length; i++) {
            int v = bytes[i] & 0xFF;
            hexChars[i * 2] = HEX_ARRAY[v >>> 4];
            hexChars[i * 2 + 1] = HEX_ARRAY[v & 0x0F];
        }
        return new String(hexChars);
    }

    private static String normalizeEmail(String email) {
        return email == null ? null : email.trim().toLowerCase();
    }

    private static String readSetting(String propertyName, String envName, String defaultValue) {
        String fromProperty = System.getProperty(propertyName);
        if (fromProperty != null && !fromProperty.trim().isEmpty()) {
            return fromProperty.trim();
        }
        String fromEnv = System.getenv(envName);
        if (fromEnv != null && !fromEnv.trim().isEmpty()) {
            return fromEnv.trim();
        }
        return defaultValue;
    }
}


