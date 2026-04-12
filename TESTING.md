# UniFlow - Testing & Account Management Guide

## Database Schema
The database schema is located at: `db/schema.sql`

All tables are automatically created on first connection by the application:
- `users` - User accounts with roles
- `requirement_cycles` - Academic year/semester cycles
- `course_requirements` - Course requirement submissions
- `draft_timetables` - Draft timetable versions
- `requirement_issues` - Issues reported by class reps
- `det_adjustments` - Timetabling admin adjustments
- `final_requirements` - Final approved requirements

## Testing Registration & Login Flow

### Step 1: Test Registration (Fresh Account)
1. Open browser: `http://localhost:8080/uniflow/register.jsp`
2. Fill in form:
   - **First Name:** John
   - **Last Name:** Doe
   - **Email:** john.doe@university.local
   - **Password:** TestPass12345 (must be 8+ chars)
   - **Role:** Class Representative
3. Click "Create account"
4. You should be redirected to login page with success message

### Step 2: Test Login (Just Registered)
1. On login page: `http://localhost:8080/uniflow/login.jsp`
2. Enter credentials:
   - **Email:** john.doe@university.local
   - **Password:** TestPass12345 (must match exactly)
3. Click "Sign in"
4. You should see Class Representative Dashboard

### Step 3: Test Role-Based Dashboards
After successful login, try these test accounts:

**System Admin Account:**
- Open MySQL and insert:
```sql
INSERT INTO users (email, password_hash, first_name, last_name, role) 
VALUES (
  'admin@uniflow.local',
  '3a5a6a2b8e8c7f9d2a4b6c8e0f1a3b5c7d9e1f3a5b7c9d1e3f5a7b9d1f3a5b',
  'System',
  'Admin',
  'System Admin'
);
```
- Password: `Admin@123456` (pre-hashed SHA-256)

**Timetabling Admin:**
```sql
INSERT INTO users (email, password_hash, first_name, last_name, role) 
VALUES (
  'timetable@uniflow.local',
  '5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c',
  'Time',
  'Admin',
  'Timetabling Admin'
);
```
- Password: `TimePass1234` (register through UI instead)

**COD Account:**
- Register through UI with role "COD"

## Troubleshooting

### Error: "An account with that email already exists"
**Cause:** Email is already registered in the database

**Solution:**
1. Delete the existing user:
```sql
DELETE FROM users WHERE email = 'john.doe@university.local';
```
2. Try registering again with same email and desired password

### Error: "Invalid email or password" on Login
**Cause:** 
- Email doesn't exist, OR
- Password doesn't match the one used during registration

**Solution:**
1. **Check email is correct** - copy/paste email to avoid typos
2. **Check password is correct** - passwords are case-sensitive
3. **If account was created manually in database:**
   - Delete it and register through UI:
   ```sql
   DELETE FROM users WHERE email = 'your.email@domain.local';
   ```
   - Then use registration page to create account with hashed password

### Account Created But Can't Login
**Cause:** Password hash mismatch (usually from manual database insert)

**Solution:** Only create accounts through the registration page at `/register.jsp`
- App automatically hashes passwords with SHA-256
- Manual inserts must use pre-hashed values

## Password Reset Instructions

### To Reset a User's Password:
1. Delete the user account:
```sql
DELETE FROM users WHERE email = 'user@example.local';
```
2. User goes to `http://localhost:8080/uniflow/register.jsp`
3. User registers with same email and new password
4. User can now login with new credentials

## Dashboard Navigation

After login, users are automatically routed to their role dashboard:

- **System Admin** → `/admin/dashboard.jsp`
  - Manage Users
  - System Logs
  - Audit Trail
  
- **Timetabling Admin** → `/timetableadmin/dashboard.jsp`
  - Allocate Venue
  - Manage Schedule
  - View Issues
  - Draft Requirements
  - Final Requirements
  
- **COD** → `/cod/dashboard.jsp`
  - Submit Requirements
  - Edit Requirements
  - Manage Requests
  
- **Class Representative** → `/classrep/dashboard.jsp`
  - Report Issue
  - Track Issue

## Database Connection Settings

Default connection in `source/java/Models/MySQLUserDAO.java`:
- **URL:** `jdbc:mysql://localhost:3306/uniflowdb`
- **User:** `root`
- **Password:** `Winnerbonnie@24`
- **Driver:** `com.mysql.cj.jdbc.Driver`

To change, set environment variables or system properties:
- `UNIFLOW_JDBC_URL`
- `UNIFLOW_JDBC_USER`
- `UNIFLOW_JDBC_PASSWORD`
- `UNIFLOW_JDBC_DRIVER`

## Logout & Session

- Click "Logout" button in any dashboard
- Redirects to login page
- Session timeout: 30 minutes of inactivity
- Last login info saved in cookies (last name + role)
