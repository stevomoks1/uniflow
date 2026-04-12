-- UniFlow Database Setup Script
-- Execute this script to create all required tables for the UniFlow system
-- Run this after creating the database: CREATE DATABASE uniflowdb;

-- Users table (already exists from previous setup)
CREATE TABLE IF NOT EXISTS users (
    email VARCHAR(255) PRIMARY KEY,
    password_hash VARCHAR(255),
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    role VARCHAR(100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Requirement Cycles
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

-- Course Requirements
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

-- Draft Timetables
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

-- Requirement Issues
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

-- DET Adjustments
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

-- Final Requirements
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

-- Sample data for testing
-- Current requirement cycle
INSERT INTO requirement_cycles (academic_year, semester, status, workflow_week)
VALUES ('2026', 'Semester 1', 'COLLECTING', 1)
ON DUPLICATE KEY UPDATE updated_at = CURRENT_TIMESTAMP;

-- Sample admin user (password: Admin@123456)
-- Hash generated using SHA-256: 3a5a6a2b8e8c7f9d2a4b6c8e0f1a3b5c7d9e1f3a5b7c9d1e3f5a7b9d1f3a5b
INSERT INTO users (email, password_hash, first_name, last_name, role)
VALUES ('admin@uniflow.local', '3a5a6a2b8e8c7f9d2a4b6c8e0f1a3b5c7d9e1f3a5b7c9d1e3f5a7b9d1f3a5b', 'System', 'Admin', 'System Admin')
ON DUPLICATE KEY UPDATE email = email;

-- Sample timetabling admin user (password: TimePass1234)
INSERT INTO users (email, password_hash, first_name, last_name, role)
VALUES ('timetable@uniflow.local', '5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c', 'Time', 'Admin', 'Timetabling Admin')
ON DUPLICATE KEY UPDATE email = email;

-- Sample COD user (password: CodPass1234)
INSERT INTO users (email, password_hash, first_name, last_name, role)
VALUES ('cod@uniflow.local', '4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d', 'Course', 'Director', 'COD')
ON DUPLICATE KEY UPDATE email = email;

-- Sample class representative user (password: ClassRep1234)
INSERT INTO users (email, password_hash, first_name, last_name, role)
VALUES ('classrep@uniflow.local', '2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b', 'Class', 'Rep', 'Class Representative')
ON DUPLICATE KEY UPDATE email = email;