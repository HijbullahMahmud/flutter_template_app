# Flutter Clean Architecture Starter

A ready-to-extend Flutter application template using feature-first clean
architecture, GoRouter, Riverpod, explicit dependency injection, Material 3,
and automatic device theme selection.

## Included

- Feature-first clean architecture (`data`, `domain`, `presentation`)
- Centralized named routes and a 404 page with GoRouter
- Generated Riverpod providers/notifiers and async state
- Dio CRUD networking with bearer auth, cache interceptor, and typed failures
- Dartz `Either<Failure, T>` repository and network results
- Freezed and JSON-serializable data models
- Persisted Material 3 theme selection; `ThemeMode.system` is the default
- Color, typography, spacing, radius, and responsive layout tokens
- Shared page and error widgets
- Comprehensive transport, HTTP, cache, serialization, and unknown failures
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
│   ├── network/                  # Dio client, CRUD service, cache, error mapper
│   ├── theme/                    # Colors, typography, ThemeData, controller
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

The domain layer remains independent of Flutter and infrastructure packages.
Its repository contracts use Dartz `Either`; implementations live in `data`.

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

## Networking

`NetworkService` is the shared entry point for remote data sources. It supports
GET, POST, PUT, PATCH, and DELETE and always returns
`Future<Either<Failure, T>>`.

```dart
final result = await ref.read(networkServiceProvider).get<UserModel>(
  '/users/42',
  decoder: (data) => UserModel.fromJson(data! as Map<String, dynamic>),
);

return result.fold(
  (failure) => throw failure,
  (user) => user,
);
```

GET requests use the cache interceptor by default. Use
`RequestCachePolicy.refresh` for pull-to-refresh or
`RequestCachePolicy.noCache` for always-online reads. Mutating requests are not
cached. The default cache is a bounded in-memory LRU store and can be replaced
by overriding `cacheOptionsProvider`.

`authTokenSourceProvider` currently returns an empty token source. Override it
with an `AccessTokenProvider` backed by secure storage when authentication is
implemented. Request and response bodies are not logged in release builds.

The error mapper covers Dio timeouts, transformation timeouts, certificate
errors, cancellation, connection failures, every HTTP 4xx/5xx response,
serialization failures, cache failures, and unexpected errors. Server-provided
validation messages are retained when available.

## Generated code

Use Freezed for every data model and Riverpod annotations for providers and
notifiers. After changing an annotated file, regenerate code:

```sh
dart run build_runner build
```

During development, use watch mode:

```sh
dart run build_runner watch
```

## Environment configuration

Compile-time configuration files are stored in `config/`:

```text
config/
├── dev.json
└── prod.json
```

Run the development configuration:

```sh
flutter run --dart-define-from-file=config/dev.json
```

Build a production Android App Bundle:

```sh
flutter build appbundle --release \
  --dart-define-from-file=config/prod.json
```

Build a production APK:

```sh
flutter build apk --release \
  --dart-define-from-file=config/prod.json
```

Read values through `AppConfig`. The committed files should contain public
build-time configuration only. Do not put secrets in these files: values
compiled into an application binary can be extracted.

## Theme and fonts

The app starts with `ThemeMode.system`, automatically matching the device when
no preference has been saved. A light, dark, or system selection made in
Settings is restored on future launches. Brand colors are in `app_colors.dart`,
typography is in `app_typography.dart`, and component styles are in
`app_theme.dart`.

The template deliberately uses each platform's native font. To use a brand font,
add local font files to `assets/fonts`, register them under `flutter.fonts` in
`pubspec.yaml`, and set `AppTypography.fontFamily`.

## Quality checks

```sh
dart format .
flutter analyze
flutter test
```
