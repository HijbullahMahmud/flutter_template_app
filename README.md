# Flutter Clean Architecture Starter

A ready-to-extend Flutter application template using feature-first clean
architecture, GoRouter, Riverpod, explicit dependency injection, Material 3,
and automatic device theme selection.

## Included

- Feature-first clean architecture (`data`, `domain`, `presentation`)
- Centralized named routes and a 404 page with GoRouter
- Riverpod state management, async state, and dependency composition
- Light and dark Material 3 themes; `ThemeMode.system` is the default
- Color, typography, spacing, radius, and responsive layout tokens
- Shared page and error widgets
- Typed `Result<T>` and `Failure` primitives
- Compile-time environment configuration
- Stricter analyzer rules and starter unit/widget tests

## Project structure

```text
lib/
├── app/
│   ├── bootstrap.dart            # Framework startup and root error boundary
│   ├── router/                   # Route paths, names, and GoRouter config
│   └── template_app.dart         # MaterialApp composition
├── core/
│   ├── config/                   # Compile-time application config
│   ├── constants/                # Shared design/layout tokens
│   ├── di/                       # Application dependency composition
│   ├── error/                    # Typed failures
│   ├── extensions/               # Shared Dart/Flutter extensions
│   ├── theme/                    # Colors, typography, ThemeData, controller
│   ├── types/                    # Shared result types
│   └── widgets/                  # App-wide reusable widgets
└── features/
    └── feature_name/
        ├── data/                 # Data sources, DTOs, repository impls
        ├── domain/               # Entities, repository contracts, use cases
        └── presentation/         # Pages, widgets, Riverpod notifiers
```

Dependencies point inward:

```text
presentation → domain ← data
```

The domain layer should remain independent of Flutter and external packages.
Repository interfaces live in `domain`; implementations live in `data`.

## Start developing

```sh
flutter pub get
flutter run
```

Add a feature by copying the `features/home` layer structure, then:

1. Define entities, repository contracts, and use cases in `domain`.
2. Implement data sources and repositories in `data`.
3. Add controllers and UI in `presentation`.
4. Register dependencies in `lib/core/di/app_providers.dart`.
5. Register pages in `lib/app/router/app_router.dart`.

Avoid placing feature-specific code in `core`; `core` is only for code shared
by multiple features.

## Environment configuration

Configuration uses `--dart-define`, so secrets are not committed:

```sh
flutter run \
  --dart-define=APP_ENV=development \
  --dart-define=API_BASE_URL=https://dev-api.example.com
```

Read values through `AppConfig`. Do not store real secrets in a client app;
anything shipped in an application binary can be extracted.

## Theme and fonts

The app starts with `ThemeMode.system`, automatically matching the device.
Users can preview light and dark overrides from Settings. Brand colors are in
`app_colors.dart`, typography is in `app_typography.dart`, and component styles
are in `app_theme.dart`.

The template deliberately uses each platform's native font. To use a brand font,
add local font files to `assets/fonts`, register them under `flutter.fonts` in
`pubspec.yaml`, and set `AppTypography.fontFamily`.

## Quality checks

```sh
dart format .
flutter analyze
flutter test
```
