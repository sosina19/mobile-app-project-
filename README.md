# QR-Based Attendance Management System

## Overview

The QR-Based Attendance Management System is a mobile application developed to simplify and automate classroom attendance management. The system eliminates manual attendance sheets by allowing students to check in using personalized QR codes while enabling teachers to monitor attendance records in real time.

The application provides separate interfaces for Administrators, Teachers, and Students, ensuring that each user has access only to the features relevant to their role.

---

## Objectives

* Automate student attendance tracking.
* Reduce time spent taking attendance manually.
* Improve attendance accuracy.
* Provide attendance history.
* Enable teachers to monitor frequently absent students.

---

## System Users

### Administrator

The Administrator manages the overall system and add new teacher are controlled by admin.

#### Administrator Features

* Create student accounts.
* Create teacher accounts.
* Manage user information.

#### Default Administrator Account

Email: admin@gmail.com

Password: 12345678

---

### Teacher

Teachers are responsible for managing attendance and monitoring student participation.

#### Teacher Features

* Login securely.
* Create and manage courses.
* Generate attendance sessions.
* Scan student QR codes.
* Mark attendance automatically.
* View attendance history by course and date.
* Display complete attendance history.
* Identify students with more than three absences.

#### Default Teacher Account

Email: fiker@gmail.com

Password:345678123

---

### Student

Students can access their attendance information and generate their personal QR code.

#### Student Features

* Login securely.
* Generate unique QR code.
* Present QR code for attendance registration.
* View attendance status.
* Monitor attendance history.

#### Default Student Account

Email: sosina@gmail.com

Password: 123456789

---

## Technology Stack

### Frontend

* Flutter
* Dart

### Backend

* Nest js

### Database

* PostgreSQL

### Authentication

* JWT (JSON Web Token)

### API Communication

* RESTful APIs
* HTTP Requests

---

## System Workflow

1. Administrator creates Teacher accounts.
2. Student logs in and accesses their QR code.
3. Teacher selects a course and scans student QR codes.
4. Attendance records are stored in the database.
5. Teachers can view attendance history and absentee reports.
8. Students can see their attendance status through the mobile application.

---

## Installation and Setup

### Clone Repository

```bash
git clone https://github.com/sosina 19mobile-app-project-.git
```

### Install Dependencies

```bash
flutter pub get
```

### Run Application

```bash
flutter run
```

---

## Key Features

✓ QR Code Based Attendance

✓ Role-Based Authentication

✓ Course Management

✓ Attendance History Tracking

✓ Frequent Absentee Monitoring

✓ Student QR Generation

✓ JWT Authentication

✓ Mobile Friendly Interface

✓ Real-Time Attendance Recording

---

## Developed By

Software Engineering Final Year Project

Dire Dawa University
