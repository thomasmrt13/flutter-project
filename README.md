# E-Commerce Flutter App

Welcome to our E-Commerce Flutter App! This app is designed to provide a seamless shopping experience for users interested in purchasing iPhones, iPads, and Macs.

## Table of Contents
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Usage](#usage)
- [Dependencies](#dependencies)

## Features

1. User side:

- Browse and search for apple products
- View detailed product information, including specifications and prices
- Add products to the shopping cart
- Proceed to checkout and complete the purchase
- See all commands passed
- Access settings to change personals informations
- User authentication and account management

2. Admin side:

- Add products to the store
- View and adit detailed product informations
- Delete products
- See all the comands passed on the app
- Access settings to change personals informations

## Prerequisites

Before you begin, ensure you have met the following requirements:

- Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)
- Dart SDK: [Installation Guide](https://dart.dev/get-dart)
- Git: [Installation Guide](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

## Getting Started

1. Clone the repository:

    ```bash
    git clone https://github.com/thomasmrt13/flutter-project.git
    ```

2. Navigate to the project directory:

    ```bash
    cd tekhub
    ```

3. Install dependencies:

    ```bash
    flutter pub get
    ```

## Usage

To run the app locally on your machine, use the following command:

```bash
flutter run
```
## Dependencies

```bash
dependencies:
  buttons_tabbar: ^1.3.8  # A customizable tab bar with a variety of button styles.
  carousel_slider: ^4.2.1  # An image carousel slider widget.
  cloud_firestore: ^4.13.2  # A Flutter plugin to use Cloud Firestore, a NoSQL database.
  cupertino_icons: ^1.0.0  # Default icons for Flutter applications.
  firebase_auth: ^4.14.1  # Firebase Authentication for Flutter.
  firebase_core: ^2.23.0  # Flutter plugin for Firebase Core, enabling connecting to multiple Firebase apps.
  firebase_crashlytics: ^3.4.8  # Flutter plugin for Firebase Crashlytics, a lightweight, realtime crash reporter.
  firebase_storage: ^11.5.3  # A Flutter plugin to use Firebase Cloud Storage.
  flip_card: ^0.7.0  # A flip card animation widget.
  flutter: sdk: flutter
  flutter_staggered_grid_view: ^0.7.0  # A Flutter staggered grid view widget.
  geocoding: ^2.1.1  # A Flutter plugin to geocode and reverse geocode coordinates.
  location: ^5.0.3  # A Flutter plugin for handling location updates.
  patterns_canvas: ^0.4.0  # A Flutter widget for drawing patterns.
  permission_handler: ^11.1.0  # A permissions plugin for Flutter.
  provider: ^5.0.0  # A state management library for Flutter applications.
  sidebarx: ^0.16.3  # A responsive sidebar package for Flutter web.

```

## Architecture

The project follows a structured architecture, organized into the following key components:

- **Firebase:**
  - Manages Firebase-related services, including authentication, cloud storage, and Firestore for database operations. The configuration and options are defined in `firebase_options.dart`.

- **Provider:**
  - Implements state management using the Provider package. Each provider is responsible for managing the state related to a specific feature or data entity.

- **Routes:**
  - Defines the navigation routes for the app.

- **Screens:**
  - Contains the main user interface screens of the app. Screens are organized based on different features such as home, product details, cart, and checkout.

- **Widgets:**
  - Houses reusable UI components or widgets that are used across multiple screens. This promotes code reusability and maintainability.

- **firebase_options.dart:**
  - Centralized configuration file for Firebase, containing options and settings required for Firebase services.

- **main.dart:**
  - The entry point of the Flutter application where the app is initialized. It includes the main function, Flutter app configuration, and the root widget (commonly a MaterialApp or CupertinoApp).

The chosen architecture promotes a clear separation of concerns, making the codebase modular and easier to maintain. It also follows best practices for Flutter app development, ensuring scalability and flexibility as the project evolves.

## Authors

- **Antoine Horeau**
- **Paul Mondon**
- **Thomas Martin**
