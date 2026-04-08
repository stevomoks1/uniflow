package Models;

public class User {
    private String email;
    private String passwordHash;
    private String firstName;
    private String lastName;
    private String role;

    public User(String email, String passwordHash, String firstName, String lastName, String role) {
        this.email = email;
        this.passwordHash = passwordHash;
        this.firstName = firstName;
        this.lastName = lastName;
        this.role = role;
    }

    public String getEmail() {
        return email;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getRole() {
        return role;
    }

    public String getFullName() {
        return firstName + " " + lastName;
    }
}
