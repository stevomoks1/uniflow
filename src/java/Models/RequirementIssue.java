package Models;

import java.sql.Timestamp;

public class RequirementIssue {
    private final long id;
    private final long cycleId;
    private final Long requirementId;
    private final String reportedBy;
    private final String issueType;
    private final String priority;
    private final String description;
    private final String status;
    private final Timestamp reportedAt;

    public RequirementIssue(long id, long cycleId, Long requirementId, String reportedBy, String issueType,
            String priority, String description, String status, Timestamp reportedAt) {
        this.id = id;
        this.cycleId = cycleId;
        this.requirementId = requirementId;
        this.reportedBy = reportedBy;
        this.issueType = issueType;
        this.priority = priority;
        this.description = description;
        this.status = status;
        this.reportedAt = reportedAt;
    }

    public long getId() {
        return id;
    }

    public long getCycleId() {
        return cycleId;
    }

    public Long getRequirementId() {
        return requirementId;
    }

    public String getReportedBy() {
        return reportedBy;
    }

    public String getIssueType() {
        return issueType;
    }

    public String getPriority() {
        return priority;
    }

    public String getDescription() {
        return description;
    }

    public String getStatus() {
        return status;
    }

    public Timestamp getReportedAt() {
        return reportedAt;
    }
}
