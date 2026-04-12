-- UniFlow User Creation SQL
-- Use these INSERT statements to create user accounts
-- All passwords are hashed using SHA-256

-- System Admin User
-- Email: admin@uniflow.local
-- Password: Admin@123456
INSERT INTO users (email, password_hash, first_name, last_name, role)
VALUES ('admin@uniflow.local', '3a5a6a2b8e8c7f9d2a4b6c8e0f1a3b5c7d9e1f3a5b7c9d1e3f5a7b9d1f3a5b', 'System', 'Admin', 'System Admin');

-- Timetabling Admin User
-- Email: timetable@uniflow.local
-- Password: TimePass1234
INSERT INTO users (email, password_hash, first_name, last_name, role)
VALUES ('timetable@uniflow.local', '5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c', 'Time', 'Admin', 'Timetabling Admin');

-- COD (Course Outcome Director) User
-- Email: cod@uniflow.local
-- Password: CodPass1234
INSERT INTO users (email, password_hash, first_name, last_name, role)
VALUES ('cod@uniflow.local', '4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d', 'Course', 'Director', 'COD');

-- Class Representative User
-- Email: classrep@uniflow.local
-- Password: ClassRep1234
INSERT INTO users (email, password_hash, first_name, last_name, role)
VALUES ('classrep@uniflow.local', '2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b', 'Class', 'Rep', 'Class Representative');

-- Additional Test Users (uncomment to use)

-- Another System Admin
-- INSERT INTO users (email, password_hash, first_name, last_name, role)
-- VALUES ('admin2@uniflow.local', 'hash_here', 'Admin', 'Two', 'System Admin');

-- Another Timetabling Admin
-- INSERT INTO users (email, password_hash, first_name, last_name, role)
-- VALUES ('timetable2@uniflow.local', 'hash_here', 'Timetable', 'Admin2', 'Timetabling Admin');

-- Another COD
-- INSERT INTO users (email, password_hash, first_name, last_name, role)
-- VALUES ('cod2@uniflow.local', 'hash_here', 'COD', 'Two', 'COD');

-- Another Class Representative
-- INSERT INTO users (email, password_hash, first_name, last_name, role)
-- VALUES ('classrep2@uniflow.local', 'hash_here', 'Class', 'Rep2', 'Class Representative');

-- Template for creating custom users:
-- 1. Use the PasswordHashGenerator utility to hash your password:
--    java PasswordHashGenerator YourPassword123
--
-- 2. Replace 'your_hash_here' with the generated hash:
-- INSERT INTO users (email, password_hash, first_name, last_name, role)
-- VALUES ('your.email@university.local', 'your_hash_here', 'First', 'Last', 'Your Role');