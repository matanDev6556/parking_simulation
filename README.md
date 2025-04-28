# Parking App Simulation

## Overview

This project is a simulation of a parking app built with Flutter, designed specifically to demonstrate key mobile development concepts including clean architecture, state management, user tracking, location services, and notifications. While it's a small application, it focuses on showcasing important Flutter and mobile development principles that are essential in professional applications.

## Learning Objectives

This project was created to demonstrate proficiency in:

- **Clean Architecture**: Implementing a three-layer architecture (data, domain, presentation) for separation of concerns
- **State Management**: Using BLoC and Cubit patterns for efficient state management
- **Firebase Integration**: Authentication and Firestore database for user management
- **Location Services**: Requesting and handling location permissions and tracking user location
- **Notifications**: Setting up local notifications that work even when the app is in the background
- **App Lifecycle Management**: Tracking when users enter and exit the application to update their online status in real-time
- **Platform-Specific Configuration**: Handling iOS and Android platform-specific files and permissions

## Features

1. **User Authentication**:

   - Registration with validation
   - Firebase Authentication
   - Persistence of authentication state

2. **Location Services**:

   - Permission handling for location access
   - Real-time location display
   - Platform-specific configuration for iOS and Android

3. **Notifications**:

   - Permission handling for sending notifications
   - Background notifications when parking time expires
   - Local notification configuration

4. **User Lifecycle Tracking**:

   - Monitoring when users are online/offline
   - Updating last active timestamp in Firebase
   - Real-time user status updates

5. **Parking Simulation**:
   - Timer for parking duration
   - Notification when parking time expires
   - Seamless experience across app states (foreground/background)

## Technical Implementation

### Architecture

The project follows Clean Architecture principles with three main layers:

- **Data Layer**: Repositories implementation, data sources, models
- **Domain Layer**: Repositories interfaces, use cases, business logic
- **Presentation Layer**: BLoCs/Cubits, UI views, widgets

### State Management

- **BLoC/Cubit**: Used for managing different aspects of the application state
  - AuthBloc: Handles authentication state
  - LifecycleCubit: Manages application lifecycle events
  - LocationCubit: Manages location permissions and updates
  - NotificationBloc: Handles notification permissions and delivery

### Dependencies

Key libraries used:

- flutter_bloc: For state management
- firebase_auth & cloud_firestore: For authentication and database
- geolocator & location: For location services
- flutter_local_notifications: For local notifications
- permission_handler: For managing various permissions
- get_it: For dependency injection

## Getting Started

1. **Clone the repository**:

   ```
   git clone https://github.com/matanDev6556/parking_simulation.git
   ```

2. **Install dependencies**:

   ```
   flutter pub get
   ```

3. **Firebase setup**:

   - Create a Firebase project
   - Add Android and iOS apps to your Firebase project
   - Download and place the configuration files (google-services.json and GoogleService-Info.plist)
   - Enable Authentication and Firestore in Firebase console

4. **Run the application**:
   ```
   flutter run
   ```

## Platform-Specific Configuration

The project includes necessary configuration for both iOS and Android platforms:

- **iOS**: Properly configured Info.plist with permission descriptions for location and notifications
- **Android**: Updated AndroidManifest.xml with required permissions and metadata
