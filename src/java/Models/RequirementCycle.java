package Models;

import java.sql.Timestamp;

public class RequirementCycle {
    private final long id;
    private final String academicYear;
    private final String semester;
    private final String status;
    private final int workflowWeek;
    private final Timestamp createdAt;
    private final Timestamp updatedAt;

    public RequirementCycle(long id, String academicYear, String semester, String status,
            int workflowWeek, Timestamp createdAt, Timestamp updatedAt) {
        this.id = id;
        this.academicYear = academicYear;
        this.semester = semester;
        this.status = status;
        this.workflowWeek = workflowWeek;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public long getId() {
        return id;
    }

    public String getAcademicYear() {
        return academicYear;
    }

    public String getSemester() {
        return semester;
    }

    public String getStatus() {
        return status;
    }

    public int getWorkflowWeek() {
        return workflowWeek;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }
}
