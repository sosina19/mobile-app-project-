[3/16/2026 10:06 PM] Yon: Smart Attendance System
Product Management Documentation

1. Product Overview
   1.1 Product Description
   The Smart Attendance System is a mobile-based application designed to digitize the traditional attendance process used in higher education institutions. The system utilizes QR code technology to enable instructors to efficiently record student attendance while allowing students to monitor their attendance history through a mobile interface.
   The primary objective of the system is to reduce reliance on paper-based attendance methods and improve the accuracy, efficiency, and transparency of attendance management within educational institutions.
   1.2 Product Vision
   The vision of the Smart Attendance System is to create a simple and reliable digital platform that enables educational institutions to manage student attendance efficiently through mobile technology.
   The system aims to streamline attendance processes, minimize administrative workload, and enhance accessibility for both students and instructors.
   1.3 Product Objectives
   The major objectives of the product include:
   To replace manual attendance recording systems with a digital solution
   To provide a fast and reliable QR code-based attendance mechanism
   To allow instructors to easily manage courses and attendance sessions
   To enable students to track their attendance records in real time
   To improve overall transparency and data accuracy in attendance management
2. Target Users
   The Smart Attendance System is designed for two primary categories of users.
   2.1 Students
   Students interact with the system to:
   Register an account
   Generate and display their personal QR code
   View attendance history
   Access course-related information
   2.2 Instructors (Teachers)
   Instructors utilize the system to:
   Create and manage courses
   Conduct attendance sessions
   Scan student QR codes
   Monitor student attendance records
   Generate attendance reports
3. Product Features
   3.1 User Registration
   The system allows both students and instructors to create accounts by providing basic information such as name, institutional identification number, department, and password.
   The system verifies user roles during the registration process to ensure that each user receives the appropriate permissions.
   3.2 User Authentication
   The system provides secure login functionality through a username and password authentication mechanism.
   Only registered users are able to access system features. Authentication ensures that students and instructors access only the functionalities relevant to their roles.
   3.3 Student QR Code Generation
   Each student is assigned a unique QR code that represents their identity within the system.
   This QR code is generated automatically after registration and can be displayed within the student's mobile application interface.
   The QR code is used by instructors to record attendance.
   3.4 QR Code Attendance Scanning
   During an attendance session, instructors use the mobile application to scan student QR codes.
   The system automatically records the attendance status of the scanned student and stores the record in the database.
   The system prevents duplicate attendance entries for the same session.
   3.5 Course Management
   Instructors can create and manage courses within the system.
   Each course includes information such as:
   Course name
   Course code
   Academic year
   Semester
   Students enrolled in a particular course are associated with that course's attendance records.
   3.6 Attendance Session Management
   Instructors initiate attendance sessions for a specific course.
   During the session:
   Student QR codes are scanned
   Attendance is recorded automatically
   Unscanned students are marked as absent when the session closes
   3.7 Attendance History
   Students can access their personal attendance history through the mobile application.
   The attendance history displays:Course name
   [3/16/2026 10:06 PM] Yon: Date of attendance session
   Attendance status (Present or Absent)
   3.8 Attendance Reports
   Instructors can view detailed attendance reports for each course.
   The report includes:
   Student name
   Student ID
   Date of session
   Attendance status
   This allows instructors to track participation and identify absent students.Functional Requirements
   FR1 – User Registration
   The system shall allow users to create an account by entering their name, ID number, username, password, and role (student or instructor).
   FR2 – User Login
   The system shall allow registered users to log in using their username and password.
   FR3 – Student QR Code Generation
   The system shall generate a unique QR code for each registered student.
   FR4 – QR Code Attendance Scanning
   The system shall allow instructors to scan student QR codes to record attendance for a course session.
   FR5 – Duplicate Attendance Prevention
   The system shall prevent a student from being marked present more than once during the same attendance session.
   FR6 – Course Creation
   The system shall allow instructors to create courses by entering course name, course code, academic year, and semester.
   FR7 – Attendance Session Management
   The system shall allow instructors to start and end an attendance session for a specific course.
   FR8 – Student Attendance History
   The system shall allow students to view their attendance history for all courses.
   FR9 – Attendance Report
   The system shall allow instructors to view a list of students marked present or absent for each attendance session.
   Non-Functional Requirements
   NFR1 – Performance
   The system shall record attendance within two seconds after scanning a QR code.
   NFR2 – Usability
   The system interface shall allow users to register and log in without external assistance.
   NFR3 – Security
   The system shall require users to log in using a valid username and password before accessing the application.
   NFR4 – Data Storage
   The system shall store user information, course information, and attendance records in the database.
   NFR5 – Data Accuracy
   Each attendance record shall include student ID, course ID, date, and attendance status.Product Development Workflow
   The product development process for the Smart Attendance System follows a structured workflow to ensure efficient coordination between team members.
   Phase 1 – Requirement Analysis
   During this phase, the team identifies the functional and non-functional requirements of the system and defines the scope of the application.
   Phase 2 – System Design
   The UI/UX designer and developers design the user interface and system architecture required to support the application's functionality.
   Phase 3 – Development
   Developers implement the system features using Flutter for the mobile application and appropriate backend technologies for data management.
   Phase 4 – Testing and Quality Assurance
   The QA team executes testing procedures to verify that the system meets the specified requirements and performs correctly.
   Phase 5 – Deployment and Evaluation
   Once testing is completed, the system is deployed and evaluated to ensure that it satisfies user needs and project objectives.
   [3/16/2026 10:07 PM] Yon: Smart Attendance System
   Product Management Documentation
4. Product Overview
   1.1 Product Description
   The Smart Attendance System is a mobile-based application designed to digitize the traditional attendance process used in higher education institutions. The system utilizes QR code technology to enable instructors to efficiently record student attendance while allowing students to monitor their attendance history through a mobile interface.
   The primary objective of the system is to reduce reliance on paper-based attendance methods and improve the accuracy, efficiency, and transparency of attendance management within educational institutions.
   1.2 Product Vision
   The vision of the Smart Attendance System is to create a simple and reliable digital platform that enables educational institutions to manage student attendance efficiently through mobile technology.
   The system aims to streamline attendance processes, minimize administrative workload, and enhance accessibility for both students and instructors.
   1.3 Product Objectives
   The major objectives of the product include:
   To replace manual attendance recording systems with a digital solution
   To provide a fast and reliable QR code-based attendance mechanism
   To allow instructors to easily manage courses and attendance sessions
   To enable students to track their attendance records in real time
   To improve overall transparency and data accuracy in attendance management
5. Target Users
   The Smart Attendance System is designed for two primary categories of users.
   2.1 Students
   Students interact with the system to:
   Register an account
   Generate and display their personal QR code
   View attendance history
   Access course-related information
   2.2 Instructors (Teachers)
   Instructors utilize the system to:
   Create and manage courses
   Conduct attendance sessions
   Scan student QR codes
   Monitor student attendance records
   Generate attendance reports
6. Product Features
   3.1 User Registration
   The system allows both students and instructors to create accounts by providing basic information such as name, institutional identification number, department, and password.
   The system verifies user roles during the registration process to ensure that each user receives the appropriate permissions.
   3.2 User Authentication
   The system provides secure login functionality through a username and password authentication mechanism.
   Only registered users are able to access system features. Authentication ensures that students and instructors access only the functionalities relevant to their roles.
   3.3 Student QR Code Generation
   Each student is assigned a unique QR code that represents their identity within the system.
   This QR code is generated automatically after registration and can be displayed within the student's mobile application interface.
   The QR code is used by instructors to record attendance.
   3.4 QR Code Attendance Scanning
   During an attendance session, instructors use the mobile application to scan student QR codes.
   The system automatically records the attendance status of the scanned student and stores the record in the database.
   The system prevents duplicate attendance entries for the same session.
   3.5 Course Management
   Instructors can create and manage courses within the system.
   Each course includes information such as:
   Course name
   Course code
   Academic year
   Semester
   Students enrolled in a particular course are associated with that course's attendance records.
   3.6 Attendance Session Management
   Instructors initiate attendance sessions for a specific course.
   During the session:
   Student QR codes are scanned
   Attendance is recorded automatically
   Unscanned students are marked as absent when the session closes
   3.7 Attendance History
   Students can access their personal attendance history through the mobile application.
   The attendance history displays:Course name
   [3/16/2026 10:07 PM] Yon: Date of attendance session
   Attendance status (Present or Absent)
   3.8 Attendance Reports
   Instructors can view detailed attendance reports for each course.
   The report includes:
   Student name
   Student ID
   Date of session
   Attendance status
   This allows instructors to track participation and identify absent students.
   [3/16/2026 10:07 PM] Yon: Functional Requirements
   FR1 – User Registration
   The system shall allow users to create an account by entering their name, ID number, username, password, and role (student or instructor).
   FR2 – User Login
   The system shall allow registered users to log in using their username and password.
   FR3 – Student QR Code Generation
   The system shall generate a unique QR code for each registered student.
   FR4 – QR Code Attendance Scanning
   The system shall allow instructors to scan student QR codes to record attendance for a course session.
   FR5 – Duplicate Attendance Prevention
   The system shall prevent a student from being marked present more than once during the same attendance session.
   FR6 – Course Creation
   The system shall allow instructors to create courses by entering course name, course code, academic year, and semester.
   FR7 – Attendance Session Management
   The system shall allow instructors to start and end an attendance session for a specific course.
   FR8 – Student Attendance History
   The system shall allow students to view their attendance history for all courses.
   FR9 – Attendance Report
   The system shall allow instructors to view a list of students marked present or absent for each attendance session.
   Non-Functional Requirements
   NFR1 – Performance
   The system shall record attendance within two seconds after scanning a QR code.
   NFR2 – Usability
   The system interface shall allow users to register and log in without external assistance.
   NFR3 – Security
   The system shall require users to log in using a valid username and password before accessing the application.
   NFR4 – Data Storage
   The system shall store user information, course information, and attendance records in the database.
   NFR5 – Data Accuracy
   Each attendance record shall include student ID, course ID, date, and attendance status.
   [3/16/2026 10:07 PM] Yon: Product Development Workflow
   The product development process for the Smart Attendance System follows a structured workflow to ensure efficient coordination between team members.
   Phase 1 – Requirement Analysis
   During this phase, the team identifies the functional and non-functional requirements of the system and defines the scope of the application.
   Phase 2 – System Design
   The UI/UX designer and developers design the user interface and system architecture required to support the application's functionality.
   Phase 3 – Development
   Developers implement the system features using Flutter for the mobile application and appropriate backend technologies for data management.
   Phase 4 – Testing and Quality Assurance
   The QA team executes testing procedures to verify that the system meets the specified requirements and performs correctly.
   Phase 5 – Deployment and Evaluation
   Once testing is completed, the system is deployed and evaluated to ensure that it satisfies user needs and project objectives.
