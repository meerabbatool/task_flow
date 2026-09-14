# Task Flow 📋

Task Flow is a Flutter-based task management application designed to help users create, organize, and manage their daily tasks through a simple and user-friendly interface.

## ✨ Features

* Create and add tasks
* Edit existing tasks
* Delete tasks
* Mark tasks as completed
* Organize and manage daily tasks
* Store task data locally
* Simple and user-friendly interface

## 🛠️ Technologies Used

* **Flutter**
* **Dart**
* **Material Design**
* **Shared Preferences** for local data storage

## 📋 Requirements

Before running the project, make sure you have:

* Flutter SDK installed
* Dart SDK
* Android Studio or VS Code
* Android SDK
* Android device or emulator

## 🔢 Flutter & Dart Version

### Flutter

```text
Flutter 3.41.6
```

### Dart

```text
Dart 3.11.4
```

## 📦 Packages Used

The following packages are used in this project:

### Dependencies

**Cupertino Icons**

```text
cupertino_icons: ^1.0.8
```

Provides iOS-style icons for the Flutter application.

**Shared Preferences**

```text
shared_preferences: ^2.3.0
```

Used to store task data locally on the user's device.

### Development Dependency

**Flutter Lints**

```text
flutter_lints: ^6.0.0
```

Used to apply recommended Flutter and Dart coding practices.

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

Run:

```bash
flutter pub get
```

### 4. Run the application

Connect an Android device or start an Android emulator, then run:

```bash
flutter run
```

## 📱 Build Installable APK

To create a release APK, run:

```bash
flutter build apk --release
```

The generated APK will be available at:

```text
build/app/outputs/flutter-apk/app-release.apk
```

## 📁 Project Structure

```text
task_flow/
├── android/
├── assets/
│   └── images/
│       └── logo.png
├── lib/
├── test/
├── pubspec.yaml
└── README.md
```

## ⚠️ Known Limitations

* Task data is stored locally on the device.
* Tasks are not synchronized across multiple devices.
* The application does not currently include cloud-based data synchronization.
* The current version is primarily designed and tested for Android.
* Data stored locally may be lost if the application's local data is cleared or the application is uninstalled.

## 📄 License

This project is not published to pub.dev and is intended for educational and project purposes.

## 👩‍💻 Developer

Developed using Flutter and Dart.
