package Models;

import java.sql.Timestamp;

public class CourseRequirement {
    private final long id;
    private final long cycleId;
    private final String courseCode;
    private final int studentCount;
    private final String lecturerName;
    private final String specialNeeds;
    private final String submittedBy;
    private final Timestamp submittedAt;

    public CourseRequirement(long id, long cycleId, String courseCode, int studentCount,
            String lecturerName, String specialNeeds, String submittedBy, Timestamp submittedAt) {
        this.id = id;
        this.cycleId = cycleId;
        this.courseCode = courseCode;
        this.studentCount = studentCount;
        this.lecturerName = lecturerName;
        this.specialNeeds = specialNeeds;
        this.submittedBy = submittedBy;
        this.submittedAt = submittedAt;
    }

    public long getId() {
        return id;
    }

    public long getCycleId() {
        return cycleId;
    }

    public String getCourseCode() {
        return courseCode;
    }

    public int getStudentCount() {
        return studentCount;
    }

    public String getLecturerName() {
        return lecturerName;
    }

    public String getSpecialNeeds() {
        return specialNeeds;
    }

    public String getSubmittedBy() {
        return submittedBy;
    }

    public Timestamp getSubmittedAt() {
        return submittedAt;
    }
}
