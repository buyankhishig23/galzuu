# Galzuu App

A Flutter-based mobile application for interactive games and questions.

## 🚀 Deployment Ready

This app has been configured and verified for production deployment with:
- ✅ All linting issues resolved
- ✅ Production package name: `mn.careerx.galzuu`
- ✅ Android configuration optimized
- ✅ Release build tested and verified

## 📱 Features

- **Interactive Games**: Multiple game modes with different categories
- **Question System**: Dynamic question loading with image support
- **Modern UI**: Dark/Light theme support with smooth animations
- **API Integration**: Backend connectivity via CareerX API

## 🛠️ Build Instructions

### Prerequisites
- Flutter SDK 3.7.2 or higher
- Android SDK with API level 21+
- Dart SDK

### Development Build
```bash
flutter pub get
flutter run
```

### Production Build
```bash
# Build release APK
flutter build apk --release

# Output location: build/app/outputs/flutter-apk/app-release.apk
```

### Verify Code Quality
```bash
flutter analyze
```

## 📦 Project Structure

```
lib/
├── main.dart                 # App entry point
├── modules/
│   ├── components/          # Reusable UI components
│   ├── init/                # App initialization (theme, dio)
│   ├── model/               # Data models (games, questions)
│   ├── screens/             # App screens
│   ├── services/            # API services
│   └── widgets/             # Custom widgets
```

## 🔧 Configuration

### API Endpoint
The app connects to: `https://api.careerx.mn`

To change the API endpoint, edit:
```dart
// lib/modules/init/dio_manager.dart
final String _privateUrl = 'https://api.careerx.mn';
```

### Package Name
- **Production**: `mn.careerx.galzuu`
- **Namespace**: `mn.careerx.galzuu`

### SDK Versions
- **minSdk**: 21 (Android 5.0 Lollipop)
- **targetSdk**: 34 (Android 14)

## 📝 Release Notes

### Version 1.0.0+1

#### Fixed
- Renamed model files to follow Dart naming conventions (`games.dart`, `question.dart`)
- Fixed deprecated `AlwaysStoppedAnimation` API usage
- Fixed deprecated `withOpacity` API usage
- Updated all import statements

#### Configured
- Added INTERNET permission for API calls
- Set production application ID: `mn.careerx.galzuu`
- Configured proper app label: "Galzuu"
- Optimized SDK versions for modern Android devices

## 🎨 Assets

The app includes:
- Logo: `assets/logo/logo.png`
- Game images: `assets/images/` (1.png through 5.png, ad.png, right-arrow.png)

## 📄 License

All rights reserved.
