# Wasteagram

A simple clone of "Instagram", Wastegram allows users to post food that is going to waste so it can be redirected to a good use. Utilizies built-in system functions for the camera, gallery, and location, as well as integrates with Google Firebase and Cloud Firestore for persistence across devices and platforms. Crash reporting and usage data provided by Sentry and Firebase Analytics.

## Getting Started

### Prerequisites
- Dart
- Flutter SDK
- Device emulator or physical device

### Installing
1. Clone the repository
2. Setup your physical device or emulator
3. Run main.dart with flutter

## Tests
- flutter test
  - Tests that the firebase and firestore database exists, and that a entry can be properly made, saved, and retrieved
- flutter test integration_test
  - Runs an end to end test launching the virtual device, building the widget tree, and adding a new entry to firebase.
  
## Running the app

![alt-text](https://media.giphy.com/media/RwwTKMnkUF11mEqdr1/giphy.gif)

## Built With
- Dart
- Flutter
- image_picker
- cloud_firestore
- firebase_storage
- intl
- test
- location
- sentry_flutter
- firebase_analytics

## Authors
Kyle Brogdon

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
