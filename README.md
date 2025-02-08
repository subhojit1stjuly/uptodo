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

- Task Management
- Categories Organization
- Clean and Intuitive UI
- Multi-language Support
- Dark/Light Theme
- Local Data Persistence
- Task reminder notification

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
│   │   ├── app_colors.dart     # Color definitions
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

# 1: Core Layer:

- Contains all the core functionality and configurations
- Handles cross-cutting concerns like networking, storage, and theming
- Houses all constants and utilities used across the app

# 2: Feature Layer:

- Follows Clean Architecture principles
- Each feature is self-contained with its own data, domain,
  and presentation layers
- Promotes separation of concerns and maintainability

# 3: Shared Layer:

- Contains reusable widgets and mixins
- Promotes code reuse across features
- Reduces duplication

# 4: Testing Structure:

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

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (Version X.X.X)
- Dart SDK (Version X.X.X)
- Android Studio / VS Code

### Installation

1. Clone the repository

```bash
git clone https://github.com/subhojit1stjuly/uptodo.git
```

### 📲 Download

### 🌍 Localization

Currently supported languages:

- English (en)
- Bengali (bn)
- Kannada (kn)
- Hindi (hi)

## Firebase Configuration

### Setup

1. Download configuration files from Firebase Console
2. Place them in the following locations:
    - Android:
        - Development: `android/app/src/debug/google-services.json`
        - Production: `android/app/src/release/google-services.json`
    - iOS:
        - Development: `ios/config/development/GoogleService-Info.plist`
        - Production: `ios/config/production/GoogleService-Info.plist`

### Environment Files

Copy `.env.example` to create your environment files:

```bash
cp .env.example .env.development
cp .env.example .env.production
```