# UpTodo - Task Management App

UpTodo is a feature-rich task management application built with Flutter, following Clean
Architecture principles and modern development practices.

## 📱 Screenshots

[Add your app screenshots here in a grid format]

## 🎨 Design

This project is based on
the [UpTodo App Design](https://www.figma.com/design/NT2TkQ2BSUZCojTguVHBCV/UpTodo---Todo-list-app-UI-Kit-(Community))
from the Figma Community.

### Design Credits

- **Designer**: Amir Baghestani
- **Source
  **: [Figma Community](https://www.figma.com/design/NT2TkQ2BSUZCojTguVHBCV/UpTodo---Todo-list-app-UI-Kit-(Community))
- **License**: Free to use (Community Resource)

## 🌟 Features

- **Task Management**: Create, edit, delete, and mark tasks as complete
- **Categories Organization**: Group tasks by custom categories with color coding
- **Priority Levels**: Assign priority levels to tasks
- **Due Dates & Reminders**: Set due dates and receive notifications
- **Clean and Intuitive UI**: User-friendly interface designed for productivity
- **Multi-language Support**: Available in English, Bengali, Kannada, and Hindi
- **Dark/Light Theme**: Choose your preferred visual mode
- **Local Data Persistence**: All your tasks are stored locally
- **Task Search & Filtering**: Easily find tasks with powerful search and filtering options
- **Task Statistics**: Visual representation of your productivity

# Project Structure

```
lib/
├── core/                         # Core functionality and utilities
│   ├── config/                   # Application configuration
│   │   ├── app_config.dart      # App-wide configuration
│   │   ├── env_config.dart      # Environment-specific configuration
│   │   └── theme_config.dart    # Theme configuration
│   │
│   ├── constants/               # Application constants
│   │   ├── api_constants.dart   # API endpoints and related constants
│   │   ├── app_constants.dart   # App-wide constants
│   │   ├── asset_constants.dart # Asset path constants
│   │   └── storage_constants.dart# Storage related constants
│   │
│   ├── di/                      # Dependency injection
│   │   ├── injection_container.dart    # DI setup
│   │   └── register_module.dart        # Module registration
│   │
│   ├── errors/                  # Error handling
│   │   ├── exceptions.dart      # Custom exceptions
│   │   └── failures.dart        # Failure classes
│   │
│   ├── network/                 # Network related code
│   │   ├── dio/                # Dio HTTP client setup
│   │   │   └── interceptors/   # Custom interceptors
│   │   └── network_info.dart   # Network utility
│   │
│   ├── storage/                 # Local storage
│   │   ├── database/           # SQLite database
│   │   ├── objectbox/          # ObjectBox database
│   │   └── secure_storage/     # Secure storage implementation
│   │
│   ├── theme/                  # Theming
│   ���   ├── app_colors.dart     # Color definitions
│   │   ├── app_text_styles.dart# Text style definitions
│   │   └── app_theme.dart      # Theme data
│   │
│   └── utils/                  # Utility classes
│       ├── date_utils.dart     # Date handling utilities
│       ├── string_utils.dart   # String manipulation utilities
│       └── validation_utils.dart # Input validation utilities
│
├── features/                    # Feature modules
│   └── feature_name/           # Individual feature
│       ├── data/              # Data layer
│       │   ├── datasources/   # Data sources
│       │   ├── models/        # Data models
│       │   └── repositories/  # Repository implementations
│       │
│       ├── domain/           # Domain layer
│       │   ├── entities/     # Business entities
│       │   ├── repositories/ # Repository interfaces
│       │   └── usecases/     # Use cases
│       │
│       └── presentation/               # Presentation layer
│           ├── bloc/                   # BLoC state management
│           ├── pages/                  # Feature pages
│           └── widgets/                # Feature-specific widgets
│
├── shared/                             # Shared components
│   ├── widgets/                        # Common widgets
│   │   ├── app_button.dart             # Custom button widget
│   │   ├── app_text_field.dart         # Custom text field widget
│   │   └── error_widget.dart           # Error display widget
│   └── mixins/                         # Shared mixins
│       └── validation_mixin.dart       # Input validation mixin
│
└── main.dart                           # Application entry point
```

## Key Points:

### 1: Core Layer:

- Contains all the core functionality and configurations
- Handles cross-cutting concerns like networking, storage, and theming
- Houses all constants and utilities used across the app

### 2: Feature Layer:

- Follows Clean Architecture principles
- Each feature is self-contained with its own data, domain,
  and presentation layers
- Promotes separation of concerns and maintainability

### 3: Shared Layer:

- Contains reusable widgets and mixins
- Promotes code reuse across features
- Reduces duplication

### 4: Testing Structure:

```
 test/
├── core/                     # Core layer tests
│   ├── network/             # Network tests
│   └── storage/             # Storage tests
│
├── features/                # Feature tests
│   └── feature_name/       # Individual feature tests
│       ├── data/          # Data layer tests
│       ├── domain/        # Domain layer tests
│       └── presentation/  # Presentation layer tests
│
└── fixtures/               # Test fixtures
    └── feature_response.json # Mock responses
```

## 🏗️ Architecture

This project follows Clean Architecture principles with three main layers:

1. **Presentation Layer**
    - Widgets
    - BLoC (Business Logic Component)
    - Pages

2. **Domain Layer**
    - Entities
    - Repositories (Interface)
    - Use Cases

3. **Data Layer**
    - Models
    - Repositories (Implementation)
    - Data Sources

## 🛠️ Technical Stack

- **State Management**: flutter_bloc
- **Dependency Injection**: get_it + injectable
- **Routing**: go_router
- **Local Storage**:
    - ObjectBox
    - Drift (SQLite)
- **API Client**: Dio
- **Localization**: flutter_localizations
- **Code Generation**: build_runner
- **Testing**: flutter_test, mocktail, bloc_test

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (Version 3.10.0 or higher)
- Dart SDK (Version 3.0.0 or higher)
- Android Studio / VS Code
- Git

### Installation

1. Clone the repository

```bash
git clone https://github.com/subhojit1stjuly/uptodo.git
cd uptodo
```

2. Install dependencies

```bash
flutter pub get
```

3. Run code generation

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Running the App

#### Development Environment

```bash
flutter run --flavor development --target lib/main_development.dart
```

#### Production Environment

```bash
flutter run --flavor production --target lib/main_production.dart
```

### Building the App

#### Android

```bash
flutter build apk --flavor production --target lib/main_production.dart
```

#### iOS

```bash
flutter build ios --flavor production --target lib/main_production.dart
```

## 🌍 Localization

Currently supported languages:

- English (en)
- Bengali (bn)
- Kannada (kn)
- Hindi (hi)

To add a new language:

1. Create a new ARB file in `lib/l10n/` named `app_<language_code>.arb`
2. Add the language to the supported locales in `lib/core/config/app_config.dart`

## 📱 Download

[App download links will be added here]

## Firebase Configuration

### Setup

1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Add Android and iOS apps to your Firebase project
3. Download configuration files:
    - Android: `google-services.json`
    - iOS: `GoogleService-Info.plist`

4. Place them in the following locations:
    - Android:
        - Development: `android/app/src/debug/google-services.json`
        - Production: `android/app/src/release/google-services.json`
    - iOS:
        - Development: `ios/config/development/GoogleService-Info.plist`
        - Production: `ios/config/production/GoogleService-Info.plist`

### Environment Configuration

1. Copy `.env.example` to create your environment files:

```bash
cp .env.example .env.development
cp .env.example .env.production
```

2. Update the environment files with your API keys and configuration values

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.
