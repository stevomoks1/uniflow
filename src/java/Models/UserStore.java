package Models;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

public class UserStore {
    private static final Map<String, User> USERS = Collections.synchronizedMap(new HashMap<>());

    static {
        String defaultAdminEmail = "admin@uniflow.local";
        String defaultAdminPassword = "Admin@123";
        if (!USERS.containsKey(defaultAdminEmail)) {
            USERS.put(defaultAdminEmail.toLowerCase(),
                    new User(defaultAdminEmail, hashPassword(defaultAdminPassword), "System", "Admin", "System Admin"));
        }
    }

    public static boolean registerUser(String email, String password, String firstName, String lastName, String role) {
        String normalizedEmail = normalizeEmail(email);
        if (USERS.containsKey(normalizedEmail)) {
            return false;
        }
        String passwordHash = hashPassword(password);
        USERS.put(normalizedEmail, new User(normalizedEmail, passwordHash, firstName, lastName, role));
        return true;
    }

    public static User authenticate(String email, String password) {
        if (email == null || password == null) {
            return null;
        }
        String normalizedEmail = normalizeEmail(email);
        User user = USERS.get(normalizedEmail);
        if (user == null) {
            return null;
        }
        String passwordHash = hashPassword(password);
        return passwordHash.equals(user.getPasswordHash()) ? user : null;
    }

    public static User findByEmail(String email) {
        if (email == null) {
            return null;
        }
        return USERS.get(normalizeEmail(email));
    }

    private static String normalizeEmail(String email) {
        return email == null ? null : email.trim().toLowerCase();
    }

    private static String hashPassword(String password) {
        if (password == null) {
            return null;
        }
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hashed = digest.digest(password.getBytes(StandardCharsets.UTF_8));
            return Base64.getEncoder().encodeToString(hashed);
        } catch (NoSuchAlgorithmException ex) {
            throw new RuntimeException("SHA-256 algorithm unavailable", ex);
        }
    }
}


