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
- Profile Screen

## Execution Status Definition

| Status  | Meaning                                     |
| ------- | ------------------------------------------- |
| Pass    | Functionality works as expected             |
| Fail    | Functionality does not meet expected result |
| Pending | Test not yet executed                       |

## Test Execution Table

### Authentication Testing

| Test ID | Scenario                            | Expected outcome             | Status  |
| ------- | ----------------------------------- | ---------------------------- | ------- | 
| TC01    | Register student with valid data    | Account created successfully | Pass    |         
| TC02    | Register instructor with valid data | Account created successfully | Pass    |         
| TC03    | Submit empty registration form      | Validation error displayed   | Pass    |         
| TC04    | Login with correct credentials      | User logged in               | Pass    |         
| TC05    | Login with incorrect password       | Error message displayed      | Pass    |         
| TC06    | Login with unregisterd user         | Access denied                | Pass    |         

### Student Interface Testing

| Test ID | Scenario               | Expected outcome                 | Status  | 
| ------- | ---------------------- | -------------------------------- | ------- | 
| TC07    | View student dashboard | Name, ID, and attendance visible | Pass    |         
| TC08    | Navigate between tabs  | Correct screen displayed         | Pass    |         


### QR Code Functionality

| Test ID | Scenario              | Expected outcome          | Status  | 
| ------- | --------------------- | ------------------------- | ------- | 
| TC9     | Display QR code       | Unique QR shown           | Pass    |        
| TC10    | QR ready for scanning | QR screen loads correctly | Pass    |        

### Instructor Scanning Process

| Test ID | Scenario           | Expected outcome        | Status  | 
| ------- | ------------------ | ----------------------- | ------- | 
| TC11    | Scan valid QR code | Student marked present  | Pass    |         
| TC12    | Scan same QR twice | Duplicate prevented     | Pass    |         
| TC13    | Scan invalid QR    | Error message displayed | Pass    |         
| TC14    | View recent scans  | List updates correctly  | Pass    |         


### Attendance Records

Student View:

| Test ID | Scenario                 | Expected outcome     | Status  | 
| ------- | ------------------------ | -------------------- | ------- | 
| TC15    | Open attendance history  | Records displayed    | Pass    |         
| TC16    | Verify sttendance status | Correct status shown | Pass    |         

Instructor View:

| Test ID | Scenario                | Expected outcome       | Status  |
| ------- | ----------------------- | ---------------------- | ------- |        
| TC17    | Mixed attendance status | Present/Absent visible | Pass    |         

### Interface Behavior Validation

| Test ID | Scenario                | Expected outcome          | Status  | 
| ------- | ----------------------- | ------------------------- | ------- | 
| TC18    | Check theme consistency | Color match design        | Pass    |         
| TC19    | Verify layout alignment | UI properly aligned       | Pass    |         
| TC20    | Test navigation flow    | Smooth transitions        | Pass    |         
| TC21    | Validate button actions | Buttons perform correctly | Pass    |         
| TC22    | Check layout stability  | No overlap or overflow    | Pass    |         

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