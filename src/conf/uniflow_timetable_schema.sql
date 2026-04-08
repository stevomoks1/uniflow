CREATE TABLE IF NOT EXISTS requirement_cycles (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    academic_year VARCHAR(20) NOT NULL,
    semester VARCHAR(20) NOT NULL,
    status VARCHAR(40) NOT NULL DEFAULT 'COLLECTING',
    workflow_week INT NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uk_cycle (academic_year, semester)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS course_requirements (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    cycle_id BIGINT NOT NULL,
    course_code VARCHAR(30) NOT NULL,
    student_count INT NOT NULL,
    lecturer_name VARCHAR(120) NOT NULL,
    special_needs TEXT,
    submitted_by VARCHAR(255) NOT NULL,
    submitted_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_course_requirements_cycle (cycle_id),
    CONSTRAINT fk_course_requirements_cycle
        FOREIGN KEY (cycle_id) REFERENCES requirement_cycles(id)
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS draft_timetables (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    cycle_id BIGINT NOT NULL,
    version_no INT NOT NULL,
    notes TEXT,
    released_by VARCHAR(255) NOT NULL,
    released_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_draft_timetables_cycle (cycle_id),
    CONSTRAINT fk_draft_timetables_cycle
        FOREIGN KEY (cycle_id) REFERENCES requirement_cycles(id)
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS requirement_issues (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    cycle_id BIGINT NOT NULL,
    requirement_id BIGINT NULL,
    reported_by VARCHAR(255) NOT NULL,
    issue_type VARCHAR(80) NOT NULL,
    priority VARCHAR(20) NOT NULL DEFAULT 'NORMAL',
    description TEXT NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'OPEN',
    reported_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    resolved_at TIMESTAMP NULL,
    INDEX idx_requirement_issues_cycle (cycle_id),
    CONSTRAINT fk_requirement_issues_cycle
        FOREIGN KEY (cycle_id) REFERENCES requirement_cycles(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_requirement_issues_requirement
        FOREIGN KEY (requirement_id) REFERENCES course_requirements(id)
        ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS det_adjustments (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    cycle_id BIGINT NOT NULL,
    issue_id BIGINT NULL,
    action_taken TEXT NOT NULL,
    adjusted_by VARCHAR(255) NOT NULL,
    adjusted_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_det_adjustments_cycle (cycle_id),
    CONSTRAINT fk_det_adjustments_cycle
        FOREIGN KEY (cycle_id) REFERENCES requirement_cycles(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_det_adjustments_issue
        FOREIGN KEY (issue_id) REFERENCES requirement_issues(id)
        ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS final_requirements (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    cycle_id BIGINT NOT NULL,
    generated_by VARCHAR(255) NOT NULL,
    approval_notes TEXT,
    generated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uk_final_cycle (cycle_id),
    CONSTRAINT fk_final_requirements_cycle
        FOREIGN KEY (cycle_id) REFERENCES requirement_cycles(id)
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
