package Models;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class WorkflowDAO {
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
            createSchema();
        } catch (ClassNotFoundException ex) {
            throw new IllegalStateException("MySQL JDBC driver not found: " + JDBC_DRIVER, ex);
        } catch (SQLException ex) {
            throw new IllegalStateException("Unable to initialize UniFlow workflow schema", ex);
        }
    }

    private static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
    }

    private static void createSchema() throws SQLException {
        String createRequirements = "CREATE TABLE IF NOT EXISTS requirements ("
                + "id BIGINT PRIMARY KEY AUTO_INCREMENT, "
                + "course_code VARCHAR(100) NOT NULL, "
                + "lecturer_name VARCHAR(255) NOT NULL, "
                + "student_count INT NOT NULL, "
                + "special_needs TEXT, "
                + "submitted_by_email VARCHAR(255) NOT NULL, "
                + "status VARCHAR(40) NOT NULL DEFAULT 'SUBMITTED', "
                + "venue VARCHAR(255), "
                + "day_of_week VARCHAR(30), "
                + "time_slot VARCHAR(60), "
                + "adjustment_note TEXT, "
                + "final_note TEXT, "
                + "created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, "
                + "updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"
                + ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4";

        String createIssues = "CREATE TABLE IF NOT EXISTS feedback_issues ("
                + "id BIGINT PRIMARY KEY AUTO_INCREMENT, "
                + "requirement_id BIGINT NULL, "
                + "issue_title VARCHAR(255) NOT NULL, "
                + "category VARCHAR(100) NOT NULL, "
                + "priority VARCHAR(30) NOT NULL, "
                + "description TEXT NOT NULL, "
                + "reported_by_email VARCHAR(255) NOT NULL, "
                + "status VARCHAR(40) NOT NULL DEFAULT 'OPEN', "
                + "timetable_response TEXT, "
                + "created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, "
                + "updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, "
                + "CONSTRAINT fk_feedback_requirement FOREIGN KEY (requirement_id) REFERENCES requirements(id) "
                + "ON DELETE SET NULL ON UPDATE CASCADE"
                + ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4";

        try (Connection connection = getConnection(); Statement statement = connection.createStatement()) {
            statement.executeUpdate(createRequirements);
            statement.executeUpdate(createIssues);
        }
    }

    public static boolean submitRequirement(String courseCode, String lecturerName, int studentCount, String specialNeeds, String submittedByEmail) {
        String sql = "INSERT INTO requirements(course_code, lecturer_name, student_count, special_needs, submitted_by_email, status) "
                + "VALUES (?, ?, ?, ?, ?, 'SUBMITTED')";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, safeTrim(courseCode));
            ps.setString(2, safeTrim(lecturerName));
            ps.setInt(3, studentCount);
            ps.setString(4, safeTrim(specialNeeds));
            ps.setString(5, safeTrim(submittedByEmail));
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            throw new RuntimeException("Unable to submit requirement", ex);
        }
    }

    public static boolean releaseDraft(long requirementId, String venue, String dayOfWeek, String timeSlot) {
        String sql = "UPDATE requirements SET venue = ?, day_of_week = ?, time_slot = ?, status = 'DRAFT_RELEASED' WHERE id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, safeTrim(venue));
            ps.setString(2, safeTrim(dayOfWeek));
            ps.setString(3, safeTrim(timeSlot));
            ps.setLong(4, requirementId);
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            throw new RuntimeException("Unable to release draft timetable", ex);
        }
    }

    public static boolean markAdjusted(long requirementId, String adjustmentNote) {
        String sql = "UPDATE requirements SET status = 'ADJUSTED', adjustment_note = ? WHERE id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, safeTrim(adjustmentNote));
            ps.setLong(2, requirementId);
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            throw new RuntimeException("Unable to mark requirement as adjusted", ex);
        }
    }

    public static boolean finalizeRequirement(long requirementId, String finalNote) {
        String sql = "UPDATE requirements SET status = 'FINALIZED', final_note = ? WHERE id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, safeTrim(finalNote));
            ps.setLong(2, requirementId);
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            throw new RuntimeException("Unable to finalize requirement", ex);
        }
    }

    public static int batchFinalizeRequirements(String finalNote) {
        String sql = "UPDATE requirements SET status = 'FINALIZED', final_note = ? WHERE status IN ('SUBMITTED', 'DRAFT_RELEASED', 'ADJUSTED')";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, safeTrim(finalNote));
            return ps.executeUpdate();
        } catch (SQLException ex) {
            throw new RuntimeException("Unable to batch finalize requirements", ex);
        }
    }

    public static boolean reportIssue(Long requirementId, String issueTitle, String category, String priority, String description, String reportedByEmail) {
        String sql = "INSERT INTO feedback_issues(requirement_id, issue_title, category, priority, description, reported_by_email, status) "
                + "VALUES (?, ?, ?, ?, ?, ?, 'OPEN')";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            if (requirementId == null || requirementId <= 0) {
                ps.setNull(1, java.sql.Types.BIGINT);
            } else {
                ps.setLong(1, requirementId);
            }
            ps.setString(2, safeTrim(issueTitle));
            ps.setString(3, safeTrim(category));
            ps.setString(4, safeTrim(priority));
            ps.setString(5, safeTrim(description));
            ps.setString(6, safeTrim(reportedByEmail));
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            throw new RuntimeException("Unable to report issue", ex);
        }
    }

    public static boolean updateIssueStatus(long issueId, String status, String response) {
        String sql = "UPDATE feedback_issues SET status = ?, timetable_response = ? WHERE id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, safeTrim(status));
            ps.setString(2, safeTrim(response));
            ps.setLong(3, issueId);
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            throw new RuntimeException("Unable to update issue status", ex);
        }
    }

    public static List<RequirementRecord> listRequirements() {
        String sql = "SELECT id, course_code, lecturer_name, student_count, special_needs, submitted_by_email, status, "
                + "venue, day_of_week, time_slot, adjustment_note, final_note, created_at, updated_at "
                + "FROM requirements ORDER BY created_at DESC";
        List<RequirementRecord> records = new ArrayList<>();
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                records.add(new RequirementRecord(
                        rs.getLong("id"),
                        rs.getString("course_code"),
                        rs.getString("lecturer_name"),
                        rs.getInt("student_count"),
                        rs.getString("special_needs"),
                        rs.getString("submitted_by_email"),
                        rs.getString("status"),
                        rs.getString("venue"),
                        rs.getString("day_of_week"),
                        rs.getString("time_slot"),
                        rs.getString("adjustment_note"),
                        rs.getString("final_note"),
                        rs.getString("created_at"),
                        rs.getString("updated_at")
                ));
            }
        } catch (SQLException ex) {
            throw new RuntimeException("Unable to list requirements", ex);
        }
        return records;
    }

    public static List<IssueRecord> listIssues() {
        String sql = "SELECT id, requirement_id, issue_title, category, priority, description, reported_by_email, status, timetable_response, created_at, updated_at "
                + "FROM feedback_issues ORDER BY created_at DESC";
        List<IssueRecord> records = new ArrayList<>();
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                long requirementId = rs.getLong("requirement_id");
                records.add(new IssueRecord(
                        rs.getLong("id"),
                        rs.wasNull() ? null : requirementId,
                        rs.getString("issue_title"),
                        rs.getString("category"),
                        rs.getString("priority"),
                        rs.getString("description"),
                        rs.getString("reported_by_email"),
                        rs.getString("status"),
                        rs.getString("timetable_response"),
                        rs.getString("created_at"),
                        rs.getString("updated_at")
                ));
            }
        } catch (SQLException ex) {
            throw new RuntimeException("Unable to list issues", ex);
        }
        return records;
    }

    public static List<IssueRecord> listIssuesByReporter(String reporterEmail) {
        String sql = "SELECT id, requirement_id, issue_title, category, priority, description, reported_by_email, status, timetable_response, created_at, updated_at "
                + "FROM feedback_issues WHERE reported_by_email = ? ORDER BY created_at DESC";
        List<IssueRecord> records = new ArrayList<>();
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, safeTrim(reporterEmail));
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    long requirementId = rs.getLong("requirement_id");
                    records.add(new IssueRecord(
                            rs.getLong("id"),
                            rs.wasNull() ? null : requirementId,
                            rs.getString("issue_title"),
                            rs.getString("category"),
                            rs.getString("priority"),
                            rs.getString("description"),
                            rs.getString("reported_by_email"),
                            rs.getString("status"),
                            rs.getString("timetable_response"),
                            rs.getString("created_at"),
                            rs.getString("updated_at")
                    ));
                }
            }
        } catch (SQLException ex) {
            throw new RuntimeException("Unable to list reporter issues", ex);
        }
        return records;
    }

    private static String safeTrim(String value) {
        return value == null ? null : value.trim();
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

    public static class RequirementRecord {
        public final long id;
        public final String courseCode;
        public final String lecturerName;
        public final int studentCount;
        public final String specialNeeds;
        public final String submittedByEmail;
        public final String status;
        public final String venue;
        public final String dayOfWeek;
        public final String timeSlot;
        public final String adjustmentNote;
        public final String finalNote;
        public final String createdAt;
        public final String updatedAt;

        public RequirementRecord(long id, String courseCode, String lecturerName, int studentCount, String specialNeeds,
                                 String submittedByEmail, String status, String venue, String dayOfWeek, String timeSlot,
                                 String adjustmentNote, String finalNote, String createdAt, String updatedAt) {
            this.id = id;
            this.courseCode = courseCode;
            this.lecturerName = lecturerName;
            this.studentCount = studentCount;
            this.specialNeeds = specialNeeds;
            this.submittedByEmail = submittedByEmail;
            this.status = status;
            this.venue = venue;
            this.dayOfWeek = dayOfWeek;
            this.timeSlot = timeSlot;
            this.adjustmentNote = adjustmentNote;
            this.finalNote = finalNote;
            this.createdAt = createdAt;
            this.updatedAt = updatedAt;
        }
    }

    public static class IssueRecord {
        public final long id;
        public final Long requirementId;
        public final String issueTitle;
        public final String category;
        public final String priority;
        public final String description;
        public final String reportedByEmail;
        public final String status;
        public final String timetableResponse;
        public final String createdAt;
        public final String updatedAt;

        public IssueRecord(long id, Long requirementId, String issueTitle, String category, String priority,
                           String description, String reportedByEmail, String status, String timetableResponse,
                           String createdAt, String updatedAt) {
            this.id = id;
            this.requirementId = requirementId;
            this.issueTitle = issueTitle;
            this.category = category;
            this.priority = priority;
            this.description = description;
            this.reportedByEmail = reportedByEmail;
            this.status = status;
            this.timetableResponse = timetableResponse;
            this.createdAt = createdAt;
            this.updatedAt = updatedAt;
        }
    }
}

