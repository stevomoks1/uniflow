import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Utility to generate SHA-256 password hashes for UniFlow users.
 * 
 * Usage: java PasswordHashGenerator <password>
 * 
 * Example:
 *   java PasswordHashGenerator MyPassword123
 *   Output: a1b2c3d4e5f6...
 * 
 * Then use this hash in SQL INSERT:
 *   INSERT INTO users (email, password_hash, first_name, last_name, role)
 *   VALUES ('test@uniflow.local', 'a1b2c3d4e5f6...', 'Test', 'User', 'COD');
 */
public class PasswordHashGenerator {
    
    public static void main(String[] args) {
        if (args.length == 0) {
            System.out.println("Usage: java PasswordHashGenerator <password>");
            System.out.println("Example: java PasswordHashGenerator MyPass123");
            System.out.println("\nThis will output the SHA-256 hash of your password.");
            System.out.println("Copy the hash and use it in SQL INSERT statements.");
            System.exit(1);
        }
        
        String password = args[0];
        String hash = hashPassword(password);
        
        System.out.println("Password: " + password);
        System.out.println("SHA-256 Hash: " + hash);
        System.out.println("\nSQL Example:");
        System.out.println("INSERT INTO users (email, password_hash, first_name, last_name, role)");
        System.out.println("VALUES ('user@uniflow.local', '" + hash + "', 'First', 'Last', 'COD');");
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
}
