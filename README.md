# Flutter Shopping App + Firebase

A Flutter shopping app with English/Arabic localization, a responsive shopping screen, Firebase email/password authentication, and Cloud Firestore user records.

## Features

- Firebase Authentication: sign up, login, and sign out using email and password.
- Existing shopping UI with product cards, offers, cart counter, and English/Arabic localization.
- Firestore form for Name, Age, and Favourite Hobby.
- Live list of the signed-in user's saved records.
- Each record is associated with the authenticated user's UID.
- Separate screen and service files for maintainability.

## Requirements

- Flutter SDK and Dart
- Node.js/npm
- A Google account and Firebase project
- Android Studio or VS Code with Android SDK

## 1. Install Firebase CLI and FlutterFire CLI

Run in PowerShell:

```powershell
npm install -g firebase-tools
firebase login
dart pub global activate flutterfire_cli
```

If `flutterfire` is not recognized, add Dart's global executable folder to PATH and restart the terminal. On Windows this is commonly `%LOCALAPPDATA%\Pub\Cache\bin`.

## 2. Configure your own Firebase project

1. Create a project in the [Firebase Console](https://console.firebase.google.com/).
2. In the project root, run:

   ```powershell
   flutter pub get
   flutterfire configure
   ```

3. Select your Firebase project and Android platform. The command generates `lib/firebase_options.dart`; this file is specific to your Firebase project and is intentionally not included in this starter archive.
4. In Firebase Console → Authentication → Sign-in method, enable **Email/Password**.
5. In Firebase Console → Firestore Database, create a database.
6. Publish the rules from `firestore.rules` in the Firestore Rules tab. Do not leave the database open to everyone.

The Android application ID currently is `com.example.flutter_shoping_app`. If you change it, run `flutterfire configure` again and register the matching Android app in Firebase.

## 3. Android Gradle property

The required setting is already included in `android/gradle.properties`:

```properties
kotlin.incremental=false
```

## 4. Run and format

From the project root:

```powershell
dart format .
flutter analyze
flutter run
```

If Android build tooling is stale after Firebase setup, try `flutter clean`, then `flutter pub get`, and run again.

## App flow

1. App opens at Login.
2. New users can open Sign Up. Firebase creates their account and signs them in.
3. Successful login/sign-up opens the existing Shopping screen.
4. Use the person/record icon in the shopping app bar to open the Name/Age/Favourite Hobby form.
5. Save a record, then choose View saved records. The list updates from Firestore in real time.
6. Use the logout icon to return to Login.

## GitHub submission

Do not commit passwords, service-account private keys, or local machine files. Firebase's generated client configuration is required by the app; it is not a service-account secret. Review your repository visibility and Firebase security rules before publishing.

```powershell
git init
git add .
git commit -m "Integrate Firebase authentication and Firestore"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPOSITORY.git
git push -u origin main
```

If you already cloned or initialized the repository, do not run `git init` or add a second remote; use your existing Git setup instead.

## Required screenshots

Create a `screenshots/` folder and capture:

1. Login screen.
2. Shopping home screen after successful authentication.
3. User information form.
4. Saved records screen showing Firestore data.
