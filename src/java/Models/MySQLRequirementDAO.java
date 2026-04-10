package Models;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class MySQLRequirementDAO {
    private static final String JDBC_URL = System.getProperty("uniflow.jdbc.url",
            "jdbc:mysql://localhost:3306/uniflowdb?createDatabaseIfNotExist=true&useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC");
    private static final String JDBC_USER = System.getProperty("uniflow.jdbc.user", "root");
    private static final String JDBC_PASSWORD = System.getProperty("uniflow.jdbc.password", "");
    private static final String JDBC_DRIVER = System.getProperty("uniflow.jdbc.driver", "com.mysql.cj.jdbc.Driver");

    static {
        try {
            Class.forName(JDBC_DRIVER);
            createSchema();
        } catch (ClassNotFoundException ex) {
            throw new IllegalStateException("MySQL JDBC driver not found: " + JDBC_DRIVER, ex);
        } catch (SQLException ex) {
            throw new IllegalStateException("Unable to initialize requirement schema", ex);
        }
    }

    private static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
    }

    private static void createSchema() throws SQLException {
        String createCycleTable = "CREATE TABLE IF NOT EXISTS requirement_cycles ("
                + "id BIGINT AUTO_INCREMENT PRIMARY KEY, "
                + "academic_year VARCHAR(20) NOT NULL, "
                + "semester VARCHAR(20) NOT NULL, "
                + "status VARCHAR(40) NOT NULL DEFAULT 'COLLECTING', "
                + "workflow_week INT NOT NULL DEFAULT 1, "
                + "created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, "
                + "updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, "
                + "UNIQUE KEY uk_cycle(academic_year, semester)"
                + ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4";

        String createRequirementTable = "CREATE TABLE IF NOT EXISTS course_requirements ("
                + "id BIGINT AUTO_INCREMENT PRIMARY KEY, "
                + "cycle_id BIGINT NOT NULL, "
                + "course_code VARCHAR(30) NOT NULL, "
                + "student_count INT NOT NULL, "
                + "lecturer_name VARCHAR(120) NOT NULL, "
                + "special_needs TEXT, "
                + "submitted_by VARCHAR(255) NOT NULL, "
                + "submitted_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, "
                + "INDEX idx_course_requirements_cycle(cycle_id), "
                + "CONSTRAINT fk_course_requirements_cycle FOREIGN KEY(cycle_id) REFERENCES requirement_cycles(id) "
                + "ON DELETE CASCADE"
                + ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4";

        String createDraftTable = "CREATE TABLE IF NOT EXISTS draft_timetables ("
                + "id BIGINT AUTO_INCREMENT PRIMARY KEY, "
                + "cycle_id BIGINT NOT NULL, "
                + "version_no INT NOT NULL, "
                + "notes TEXT, "
                + "released_by VARCHAR(255) NOT NULL, "
                + "released_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, "
                + "INDEX idx_draft_timetables_cycle(cycle_id), "
                + "CONSTRAINT fk_draft_timetables_cycle FOREIGN KEY(cycle_id) REFERENCES requirement_cycles(id) "
                + "ON DELETE CASCADE"
                + ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4";

        String createIssueTable = "CREATE TABLE IF NOT EXISTS requirement_issues ("
                + "id BIGINT AUTO_INCREMENT PRIMARY KEY, "
                + "cycle_id BIGINT NOT NULL, "
                + "requirement_id BIGINT NULL, "
                + "reported_by VARCHAR(255) NOT NULL, "
                + "issue_type VARCHAR(80) NOT NULL, "
                + "priority VARCHAR(20) NOT NULL DEFAULT 'NORMAL', "
                + "description TEXT NOT NULL, "
                + "status VARCHAR(20) NOT NULL DEFAULT 'OPEN', "
                + "reported_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, "
                + "resolved_at TIMESTAMP NULL, "
                + "INDEX idx_requirement_issues_cycle(cycle_id), "
                + "CONSTRAINT fk_requirement_issues_cycle FOREIGN KEY(cycle_id) REFERENCES requirement_cycles(id) "
                + "ON DELETE CASCADE, "
                + "CONSTRAINT fk_requirement_issues_requirement FOREIGN KEY(requirement_id) REFERENCES course_requirements(id) "
                + "ON DELETE SET NULL"
                + ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4";

        String createAdjustmentTable = "CREATE TABLE IF NOT EXISTS det_adjustments ("
                + "id BIGINT AUTO_INCREMENT PRIMARY KEY, "
                + "cycle_id BIGINT NOT NULL, "
                + "issue_id BIGINT NULL, "
                + "action_taken TEXT NOT NULL, "
                + "adjusted_by VARCHAR(255) NOT NULL, "
                + "adjusted_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, "
                + "INDEX idx_det_adjustments_cycle(cycle_id), "
                + "CONSTRAINT fk_det_adjustments_cycle FOREIGN KEY(cycle_id) REFERENCES requirement_cycles(id) "
                + "ON DELETE CASCADE, "
                + "CONSTRAINT fk_det_adjustments_issue FOREIGN KEY(issue_id) REFERENCES requirement_issues(id) "
                + "ON DELETE SET NULL"
                + ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4";

        String createFinalTable = "CREATE TABLE IF NOT EXISTS final_requirements ("
                + "id BIGINT AUTO_INCREMENT PRIMARY KEY, "
                + "cycle_id BIGINT NOT NULL, "
                + "generated_by VARCHAR(255) NOT NULL, "
                + "approval_notes TEXT, "
                + "generated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, "
                + "UNIQUE KEY uk_final_cycle(cycle_id), "
                + "CONSTRAINT fk_final_requirements_cycle FOREIGN KEY(cycle_id) REFERENCES requirement_cycles(id) "
                + "ON DELETE CASCADE"
                + ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4";

        try (Connection connection = getConnection(); Statement statement = connection.createStatement()) {
            statement.executeUpdate(createCycleTable);
            statement.executeUpdate(createRequirementTable);
            statement.executeUpdate(createDraftTable);
            statement.executeUpdate(createIssueTable);
            statement.executeUpdate(createAdjustmentTable);
            statement.executeUpdate(createFinalTable);
        }
    }

    public static long createCycle(String academicYear, String semester) {
        String sql = "INSERT INTO requirement_cycles(academic_year, semester) VALUES(?, ?)";
        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, academicYear);
            ps.setString(2, semester);
            ps.executeUpdate();
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) {
                    return keys.getLong(1);
                }
            }
            throw new SQLException("No generated key returned for cycle");
        } catch (SQLException ex) {
            throw new RuntimeException("Unable to create requirement cycle", ex);
        }
    }

    public static long getOrCreateCycle(String academicYear, String semester) {
        String findSql = "SELECT id FROM requirement_cycles WHERE academic_year = ? AND semester = ?";
        String insertSql = "INSERT INTO requirement_cycles(academic_year, semester) VALUES(?, ?)";

        try (Connection conn = getConnection()) {
            try (PreparedStatement findPs = conn.prepareStatement(findSql)) {
                findPs.setString(1, academicYear);
                findPs.setString(2, semester);
                try (ResultSet rs = findPs.executeQuery()) {
                    if (rs.next()) {
                        return rs.getLong("id");
                    }
                }
            }

            try (PreparedStatement insertPs = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {
                insertPs.setString(1, academicYear);
                insertPs.setString(2, semester);
                insertPs.executeUpdate();
                try (ResultSet keys = insertPs.getGeneratedKeys()) {
                    if (keys.next()) {
                        return keys.getLong(1);
                    }
                }
            } catch (SQLException duplicateEx) {
                // Another request may have inserted the same cycle concurrently.
                try (PreparedStatement findPs = conn.prepareStatement(findSql)) {
                    findPs.setString(1, academicYear);
                    findPs.setString(2, semester);
                    try (ResultSet rs = findPs.executeQuery()) {
                        if (rs.next()) {
                            return rs.getLong("id");
                        }
                    }
                }
                throw duplicateEx;
            }

            throw new SQLException("Unable to resolve requirement cycle id");
        } catch (SQLException ex) {
            throw new RuntimeException("Unable to fetch or create requirement cycle", ex);
        }
    }

    public static boolean addCourseRequirement(long cycleId, String courseCode, int studentCount,
            String lecturerName, String specialNeeds, String submittedBy) {
        String sql = "INSERT INTO course_requirements(cycle_id, course_code, student_count, lecturer_name, special_needs, submitted_by) "
                + "VALUES(?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, cycleId);
            ps.setString(2, courseCode);
            ps.setInt(3, studentCount);
            ps.setString(4, lecturerName);
            ps.setString(5, specialNeeds);
            ps.setString(6, submittedBy);
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            throw new RuntimeException("Unable to save course requirement", ex);
        }
    }

    public static boolean releaseDraftTimetable(long cycleId, int versionNo, String notes, String releasedBy) {
        String sql = "INSERT INTO draft_timetables(cycle_id, version_no, notes, released_by) VALUES(?, ?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, cycleId);
            ps.setInt(2, versionNo);
            ps.setString(3, notes);
            ps.setString(4, releasedBy);
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            throw new RuntimeException("Unable to release draft timetable", ex);
        }
    }

    public static boolean reportIssue(long cycleId, Long requirementId, String reportedBy, String issueType,
            String priority, String description) {
        String sql = "INSERT INTO requirement_issues(cycle_id, requirement_id, reported_by, issue_type, priority, description) "
                + "VALUES(?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, cycleId);
            if (requirementId == null) {
                ps.setNull(2, java.sql.Types.BIGINT);
            } else {
                ps.setLong(2, requirementId);
            }
            ps.setString(3, reportedBy);
            ps.setString(4, issueType);
            ps.setString(5, priority);
            ps.setString(6, description);
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            throw new RuntimeException("Unable to store requirement issue", ex);
        }
    }

    public static boolean addDetAdjustment(long cycleId, Long issueId, String actionTaken, String adjustedBy) {
        String sql = "INSERT INTO det_adjustments(cycle_id, issue_id, action_taken, adjusted_by) VALUES(?, ?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, cycleId);
            if (issueId == null) {
                ps.setNull(2, java.sql.Types.BIGINT);
            } else {
                ps.setLong(2, issueId);
            }
            ps.setString(3, actionTaken);
            ps.setString(4, adjustedBy);
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            throw new RuntimeException("Unable to save DET adjustment", ex);
        }
    }

    public static boolean finalizeRequirements(long cycleId, String generatedBy, String approvalNotes) {
        String sql = "INSERT INTO final_requirements(cycle_id, generated_by, approval_notes) VALUES(?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, cycleId);
            ps.setString(2, generatedBy);
            ps.setString(3, approvalNotes);
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            throw new RuntimeException("Unable to create final requirement output", ex);
        }
    }

    public static List<RequirementIssue> getOpenIssues(long cycleId) {
        String sql = "SELECT id, cycle_id, requirement_id, reported_by, issue_type, priority, description, status, reported_at "
                + "FROM requirement_issues WHERE cycle_id = ? AND status <> 'RESOLVED' ORDER BY reported_at DESC";
        List<RequirementIssue> issues = new ArrayList<>();
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, cycleId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Long requirementId = rs.getObject("requirement_id") == null
                            ? null : rs.getLong("requirement_id");
                    issues.add(new RequirementIssue(
                            rs.getLong("id"),
                            rs.getLong("cycle_id"),
                            requirementId,
                            rs.getString("reported_by"),
                            rs.getString("issue_type"),
                            rs.getString("priority"),
                            rs.getString("description"),
                            rs.getString("status"),
                            rs.getTimestamp("reported_at")));
                }
            }
            return issues;
        } catch (SQLException ex) {
            throw new RuntimeException("Unable to load requirement issues", ex);
        }
    }
}
