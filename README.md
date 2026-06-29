# Electro Pi Task Manager

A modern Task Manager application built with Flutter using **Clean Architecture**, **BLoC**, and **Firebase**. The app enables users to authenticate securely, manage projects, organize tasks, and track progress with a clean and responsive user interface.

## ✨ Features

### 🔐 Authentication

* Login with email & password
* User registration
* Persistent authentication
* Auto-login on app launch
* Secure logout

### 📁 Project Management

* View all projects
* Create new projects
* Edit project information
* Delete projects
* Pull-to-refresh
* Empty state support

### ✅ Task Management

* View project tasks
* Add new tasks
* Edit existing tasks
* Delete tasks
* Mark tasks as completed
* Task priorities (Low, Medium, High)
* Task statuses (Pending, In Progress, Done)

### 👤 Profile

* Display current user information
* Dark/Light mode support
* Logout functionality

## 🏗 Architecture

The project follows **Clean Architecture** with clear separation between:

```
lib/
├── core/
├── features/
│   ├── auth/
│   ├── home/
│   └── profile/
├── shared/
└── main.dart
```

Each feature contains:

* Data Layer

  * Models
  * Repositories
  * Data Sources
* Domain Layer
* Presentation Layer

  * Screens
  * Cubits
  * Widgets

## 🛠 Tech Stack

* Flutter
* Dart
* BLoC (flutter_bloc)
* Firebase Authentication
* Cloud Firestore
* GetIt (Dependency Injection)
* SharedPreferences
* Flutter SVG

## 🎯 Implemented Requirements

* ✅ Clean Architecture
* ✅ Dependency Injection
* ✅ Firebase Authentication
* ✅ Cloud Firestore Database
* ✅ CRUD Operations
* ✅ State Management with BLoC
* ✅ Responsive UI
* ✅ Dark Mode
* ✅ Bottom Sheets
* ✅ Loading States
* ✅ Error Handling
* ✅ Success SnackBars
* ✅ Pull-to-Refresh
* ✅ Named Navigation

## 📱 Screens

* Welcome Screen
* Login
* Register
* Projects
* Project Details
* Add/Edit Project
* Add/Edit Task
* Profile
* Settings

## 🚀 Getting Started

1. Clone the repository.
2. Run:

```bash
flutter pub get
```

3. Configure Firebase:

* Android (`google-services.json`)
* iOS (`GoogleService-Info.plist`)

4. Run:

```bash
flutter run
```

## 📌 Notes

This project was developed as part of the **Electro Pi Flutter Mobile Developer Technical Assessment**. The implementation emphasizes clean code practices, reusable components, scalable architecture, and a smooth user experience while leveraging Firebase for backend services.
