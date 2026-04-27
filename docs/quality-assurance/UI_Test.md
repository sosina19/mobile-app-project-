# SMART ATTENDANCE SYSTEM

## UI/UX Testing Documentation

## Purpose

This document records the execution results of defined test scenarios for the Smart Attendance System. It provides a structured way to monitor system behavior during testing and to determine whether implemented features meet expected outcomes.

## Scope

UI/UX testing covers all user-facing screens of the mobile application, including:

Student Interfaces:

- Dashboard
- My QR Code Screen
- Attendance History
- Profile Screen

Instructor Interfaces:

- Dashboard
- QR Code Scanning Screen
- Attendance History
- Course Creation Screen
- Profile Screen

## Execution Status Definition

| Status  | Meaning                                     |
| ------- | ------------------------------------------- |
| Pass    | Functionality works as expected             |
| Fail    | Functionality does not meet expected result |
| Pending | Test not yet executed                       |

## Test Execution Table

### Authentication Testing

| Test ID | Scenario                            | Expected outcome             | Status  | Remarks |
| ------- | ----------------------------------- | ---------------------------- | ------- | ------- |
| TC01    | Register student with valid data    | Account created successfully | Pending |         |
| TC02    | Register instructor with valid data | Account created successfully | Pending |         |
| TC03    | Submit empty registration form      | Validation error displayed   | Pending |         |
| TC04    | Login with correct credentials      | User logged in               | Pending |         |
| TC05    | Login with incorrect password       | Error message displayed      | Pending |         |
| TC06    | Login with unregisterd user         | Access denied                | Pending |         |

### Student Interface Testing

| Test ID | Scenario               | Expected outcome                 | Status  | Remarks |
| ------- | ---------------------- | -------------------------------- | ------- | ------- |
| TC07    | View student dashboard | Name, ID, and attendance visible | Pending |         |
| TC08    | Navigate between tabs  | Correct screen displayed         | Pending |         |
| TC09    | View enrolled courses  | Course list shown                | Pending |         |

### QR Code Functionality

| Test ID | Scenario              | Expected outcome          | Status  | Remarks |
| ------- | --------------------- | ------------------------- | ------- | ------- |
| TC10    | Display QR code       | Unique QR shown           | Pending |         |
| TC11    | QR ready for scanning | QR screen loads correctly | Pending |         |

### Instructor Scanning Process

| Test ID | Scenario           | Expected outcome        | Status  | Remarks |
| ------- | ------------------ | ----------------------- | ------- | ------- |
| TC12    | Scan valid QR code | Student marked present  | Pending |         |
| TC13    | Scan same QR twice | Duplicate prevented     | Pending |         |
| TC14    | Scan invalid QR    | Error message displayed | Pending |         |
| TC15    | View recent scans  | List updates correctly  | Pending |         |

### Course Management

| Test ID | Scenario                       | Expected outcome       | Status  | Remarks |
| ------- | ------------------------------ | ---------------------- | ------- | ------- |
| TC16    | Created course with valid data | Course created         | Pending |         |
| TC17    | Submit incomplete course data  | Validation error shown | Pending |         |

### Attendance Records

Student View:

| Test ID | Scenario                 | Expected outcome     | Status  | Remarks |
| ------- | ------------------------ | -------------------- | ------- | ------- |
| TC18    | Open attendance history  | Records displayed    | Pending |         |
| TC19    | Verify sttendance status | Correct status shown | Pending |         |

Instructor View:

| Test ID | Scenario                | Expected outcome       | Status  | Remarks |
| ------- | ----------------------- | ---------------------- | ------- | ------- |
| TC20    | View course attendance  | Student list displayed | Pending |         |
| TC21    | Mixed attendance status | Present/Absent visible | Pending |         |

### Interface Behavior Validation

| Test ID | Scenario                | Expected outcome          | Status  | Remarks |
| ------- | ----------------------- | ------------------------- | ------- | ------- |
| TC22    | Check theme consistency | Color match design        | Pending |         |
| TC23    | Verify layout alignment | UI properly aligned       | Pending |         |
| TC24    | Test navigation flow    | Smooth transitions        | Pending |         |
| TC25    | Validate button actions | Buttons perform correctly | Pending |         |
| TC26    | Check layout stability  | No overlap or overflow    | Pending |         |

## UI/UX Validation Criteria

The QA team will evaluate the application based on the following criteria:

## 5.1 Visual Consistency

- Colors match the defined theme
- Fonts and text sizes are consistent
- Icons and UI elements follow design guidelines

### 5.2 Layout and Alignment

- Proper spacing between elements
- Consistent margins and padding
- No overlapping components

### 5.3 Readability

- Text is clear and legible
- Proper contrast between text and background

### 5.4 Navigation

- Smooth transition between screens
- Correct screen loads on user interaction

### 5.5 Button and Interaction

- Buttons are visible and accessible
- All buttons respond correctly to user input

### 5.6 Layout Stability

- No UI breaking on different screen sizes
- No overflow or clipping issues