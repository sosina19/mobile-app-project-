# Smart Student Attendance Application

## 1\. Quality Assurance Plan

### 1.1 Purpose

The purpose of this Quality Assurance (QA) Plan is to define the procedures and activities required to ensure that the Smart Attendance application satisfies its specified functional and non-functional requirements. The QA process aims to verify that the application operates correctly, reliably, and efficiently while maintaining a high level of usability for both students and instructors.

Through systematic testing and validation, the QA team will identify defects, verify system functionality, and ensure that the application provides accurate attendance management.

### 1.2 Scope of Quality Assurance

The QA process will focus on testing all major functional components of the Smart Attendance Application, including:

- User registration and authentication using **username and password**
- QR code generation for students
- QR code scanning for attendance recording
- Course creation and course management
- Attendance recording and monitoring
- Attendance history viewing
- User interface consistency and usability

The QA activities will ensure that all components of the system interact correctly and produce accurate outputs.

### 1.3 QA Objectives

The main objectives of the QA activities are:

- To ensure that the application meets all **functional requirements**
- To verify that attendance records are **accurately stored and retrieved**
- To confirm that **QR code scanning functionality operates correctly**
- To validate that user authentication using **username and password** functions securely
- To ensure the application provides a **consistent and user-friendly interface**
- To detect and report defects during early development stages

## 2\. Test Strategy

### 2.1 Testing Approach

The Smart Attendance Application will follow a structured testing approach that includes multiple levels of testing to ensure system reliability and functionality.

Testing will be conducted progressively as system components are developed and integrated.

### 2.2 Types of Testing

Functional Testing:

Functional testing verifies that each feature of the application operates according to the specified requirements. This includes testing the registration process, login functionality, QR code scanning, and attendance recording.

Integration Testing:

Integration testing ensures that different components of the system work together correctly. For example, the interaction between the mobile application and the backend database will be tested to verify proper data communication.

User Interface Testing:

User interface testing evaluates the usability, consistency, and layout of the application screens to ensure a clear and intuitive user experience.

Database Testing:

Database testing verifies that user information, course data, and attendance records are stored and retrieved accurately within the database system.

Authentication Testing:

Authentication testing ensures that only authorized users can access the system through valid **username and password credentials**.

Regression Testing

Regression testing is conducted after system updates or modifications to ensure that previously functioning features continue to operate correctly

## Initial Test Cases

### Registration Testing

| Test ID | Test Description                     | Test Steps                                 | Expected Result                       |
| ------- | ------------------------------------ | ------------------------------------------ | ------------------------------------- |
| TC01    | Student registration with valid data | Enter valid student information and submit | Student account created successfully  |
| TC02    | Teacher registration with valid data | Enter valid teacher information and submit | Teacher account created successfully  |
| TC03    | Registration with missing fields     | Submit registration form with empty fields | Application displays validation error |

### 3.2 Login Testing

| Test ID | Test Description                         | Test Steps                                | Expected Result                        |
| ------- | ---------------------------------------- | ----------------------------------------- | -------------------------------------- |
| TC04    | Login with correct username and password | Enter valid credentials and submit        | User successfully logs into the system |
| TC05    | Login with incorrect password            | Enter correct username but wrong password | System displays authentication error   |
| TC06    | Login with non-existent user             | Enter username not registered in system   | Access denied and error displayed      |

### 3.3 QR Code Attendance Testing

| Test ID | Test Description        | Test Steps                                       | Expected Result                      |
| ------- | ----------------------- | ------------------------------------------------ | ------------------------------------ |
| TC07    | Scan student QR code    | Teacher scans student QR code                    | Student marked as Present            |
| TC08    | Scan same QR code twice | Teacher scans the same student twice             | System prevents duplicate attendance |
| TC09    | Student not scanned     | Attendance session ends without scanning student | Student marked as Absent             |

### 3.4 Course Management Testing

| Test ID | Test Description  | Test Steps                        | Expected Result               |
| ------- | ----------------- | --------------------------------- | ----------------------------- |
| TC10    | Create new course | Enter course name, code, semester | Course successfully added     |
| TC11    | View course list  | Navigate to course list page      | All created courses displayed |

### 3.5 Attendance History Testing

| Test ID | Test Description           | Test Steps                            | Expected Result                      |
| ------- | -------------------------- | ------------------------------------- | ------------------------------------ |
| TC12    | Student attendance history | Student opens attendance history page | Correct attendance records displayed |
| TC13    | Teacher attendance report  | Teacher views course attendance list  | Table displays students and status   |

## 4\. Quality Assurance Workflow

The Quality Assurance process for the Smart Attendance Application follows a structured workflow to ensure that all functionalities are thoroughly tested and validated throughout the development life-cycle.

Phase 1: Test Planning

During this phase, the QA team prepares the Quality Assurance documentation, including the QA Plan, Test Strategy, and initial test cases. The objective of this phase is to define the scope of testing, testing methods, and responsibilities of team members.

Phase 2: Test Case Development

In this phase, the QA team develops detailed test cases for each system functionality. These test cases describe the testing procedures, input conditions, and expected outcomes required to validate system behavior.

Phase 3: Test Execution

Test execution involves running the prepared test cases on the application to evaluate whether the system performs according to the expected results. Any deviations or unexpected behavior observed during testing are documented for further analysis.

Phase 4: Defect Identification and Reporting

When inconsistencies or failures are detected during testing, the QA team documents these issues and communicates them to the development team for correction.

Phase 5 - Retesting

After developers address the identified issues, the QA team performs retesting to confirm that the defects have been successfully resolved.

Phase 6 - Regression Testing

Regression testing is conducted after system modifications to ensure that previously functioning components remain unaffected by recent changes.

Phase 7 - Quality Validation

Once all critical functionalities pass the testing procedures, the QA team confirms that the system satisfies the defined quality standards and functional requirements.
