# Task Flow 📋

A Flutter task management app designed to help users create, organize, and manage their daily tasks with a simple and user-friendly interface.

## ✨ Features

* Create new tasks
* Edit tasks
* Delete tasks
* Mark tasks as completed
* View and manage daily tasks
* Simple and user-friendly interface

## 🛠️ Technologies Used

* Flutter
* Dart
* Material Design

## 📋 Requirements

Before running this project, make sure you have:

* Flutter SDK installed
* Dart SDK
* Android Studio or VS Code
* Android SDK
* Android device or emulator

## 🔢 Flutter Version

This project was developed using:

```text
Flutter 3.41.6
```

Check your Flutter version with:

```bash
flutter --version
```

## 📦 Packages Used

The project uses the packages listed in `pubspec.yaml`.

Install all dependencies using:

```bash
flutter pub get
```

Main package used:

* `shared_preferences` – used for storing task data locally on the device.

## 🚀 Setup & Installation

### 1. Clone the repository

```bash
git clone YOUR_GITHUB_REPOSITORY_URL
```

### 2. Open the project

```bash
cd task_flow
```

### 3. Install dependencies

```bash
flutter pub get
```

### 4. Run the application

Connect an Android device or start an Android emulator and run:

```bash
flutter run
```

## 📱 Build APK

To create an installable Android APK:

```bash
flutter build apk --release
```

The generated APK can be found at:

```text
build/app/outputs/flutter-apk/app-release.apk
```

## ⚠️ Known Limitations

* The application currently focuses on basic task management.
* Task data is stored locally on the device.
* Tasks are not synchronized between multiple devices.
* There is currently no cloud-based account synchronization.
* The application is primarily designed and tested for Android.

## 👩‍💻 Developer

Developed using Flutter and Dart.
