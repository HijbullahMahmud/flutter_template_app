# Flutter Clean Architecture Starter

A ready-to-extend Flutter template with feature-first clean architecture,
generated Riverpod state and dependency injection, GoRouter, Dio networking,
Freezed models, generated localization, environment configuration, and
persisted Material 3 themes.

## Included

- Feature-first `data`, `domain`, and `presentation` layers
- Generated Riverpod providers and async notifiers
- Named GoRouter routes, nested navigation, and a 404 page
- Dio GET, POST, PUT, PATCH, and DELETE support
- Dio cache interceptor with configurable request policies
- Bearer-token interceptor ready for secure token storage
- Dartz `Either<Failure, T>` results
- Typed transport, HTTP, cache, serialization, and unknown failures
- Freezed immutable models with generated JSON serialization
- Development and production `dart-define` files
- English, Bangla, and Arabic localization with automatic RTL layout
- Persisted language selection with English as the default
- Persisted light, dark, and system theme selection
- Material 3 colors, typography, spacing, radii, and component themes
- Responsive small-phone, phone, tablet, and expanded layouts
- Adaptive spacing, typography, content widths, grids, and narrow controls
- Shared page and error widgets
- Strict analyzer rules plus unit and widget tests

## Main packages

| Area | Packages |
| --- | --- |
| State and DI | `flutter_riverpod`, `riverpod_annotation`, `riverpod_generator` |
| Navigation | `go_router` |
| Networking | `dio`, `dio_cache_interceptor` |
| Functional results | `dartz` |
| Models | `freezed_annotation`, `freezed`, `json_annotation`, `json_serializable` |
| Persistence | `shared_preferences` |
| Localization | `flutter_localizations`, `intl`, Flutter `gen-l10n` |
| Generation | `build_runner` |

## Project structure

```text
.
├── config/
│   ├── dev.json
│   └── prod.json
├── l10n.yaml                     # Flutter gen-l10n configuration
├── lib/
│   ├── app/
│   │   ├── bootstrap.dart
│   │   ├── router/
│   │   └── template_app.dart
│   ├── core/
│   │   ├── config/               # Compile-time environment values
│   │   ├── constants/            # Shared spacing and layout tokens
│   │   ├── di/                   # Generated application providers
│   │   ├── error/                # Failure types
│   │   ├── extensions/           # Shared extensions
│   │   ├── localization/         # Supported locales, persistence, notifier
│   │   ├── network/              # Dio, CRUD, cache, auth, error mapping
│   │   ├── responsive/           # Breakpoints, metrics, values, layout widgets
│   │   ├── theme/                # ThemeData, tokens, persistence, notifier
│   │   └── widgets/              # App-wide widgets
│   ├── l10n/                     # ARB resources and generated localizations
│   ├── features/
│   │   └── home/
│   │       ├── data/
│   │       │   ├── datasources/
│   │       │   ├── models/
│   │       │   └── repositories/
│   │       ├── domain/
│   │       │   ├── entities/
│   │       │   ├── repositories/
│   │       │   └── usecases/
│   │       └── presentation/
│   │           ├── pages/
│   │           ├── providers/
│   │           └── widgets/
│   └── main.dart
└── test/
```

Dependencies point toward the domain:

```text
presentation → domain ← data
```

- `domain` contains business entities, repository contracts, and use cases.
- `data` contains Freezed models, data sources, mapping, and repository
  implementations.
- `presentation` contains generated Riverpod notifiers, pages, and widgets.
- `core` contains infrastructure shared by multiple features.

Keep feature-specific code out of `core`.

## Responsive layout

Responsive decisions use available logical width instead of platform or device
names:

| Window class | Width | Typical use |
| --- | ---: | --- |
| Small phone | `< 360` | Compact spacing and stacked controls |
| Phone | `360–599` | Standard mobile layout |
| Tablet | `600–839` | Wider content and multiple columns |
| Expanded | `≥ 840` | Tablet landscape and larger windows |

Shared implementation lives in `lib/core/responsive/`:

- `AppBreakpoints` maps a logical width to an `AppWindowSize`.
- `ResponsiveValue<T>` keeps breakpoint-specific values declarative.
- `AppResponsiveMetrics` provides page padding, card padding, and layout gaps.
- `ResponsiveBuilder` exposes those metrics from current constraints.
- `ResponsiveGrid` calculates columns from a minimum card width.
- `ResponsiveConstrainedBox` keeps content centered and readable.

Example:

```dart
ResponsiveBuilder(
  builder: (context, metrics) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: metrics.horizontalPadding,
        vertical: metrics.verticalPadding,
      ),
      child: ResponsiveGrid(
        minimumItemWidth: AppSizes.cardMinWidth,
        spacing: metrics.gridGap,
        children: cards,
      ),
    );
  },
)
```

`AppPage` constrains general content to `1100` logical pixels. Settings and
other forms should use `AppSizes.formMaxWidth`; long text should use
`AppSizes.readableTextMaxWidth`. Cards remain content-driven instead of using
fixed heights. Tablet typography increases modestly, while Flutter's
`MediaQuery` text scaling remains active for accessibility.

When implementing a Figma screen:

1. Map Figma color and text styles to theme tokens rather than copying raw
   values into a page.
2. Treat 320, 390, 768, and 1024-pixel frames as reference states, not separate
   screens.
3. Translate Auto Layout behavior into `Row`, `Column`, `Flexible`, `Wrap`, and
   `ResponsiveGrid`.
4. Prefer start/end alignment so Arabic mirrors automatically.
5. Test content-driven height with long Bangla and Arabic copy.
6. Replace wide controls with a stacked or dropdown variant when their labels
   cannot fit; the Settings theme selector demonstrates this pattern.

Do not globally scale a Figma frame or use `FittedBox` for body text. Select
layout, spacing, and component variants from constraints and let text wrap.

Responsive widget coverage includes a 320×568 small phone at 2× text scale,
Bangla compact settings, and a 1024×768 Arabic RTL tablet layout:

```sh
flutter test test/core/responsive test/widget_test.dart
```

## Getting started

```sh
flutter pub get
flutter gen-l10n
dart run build_runner build
flutter run --dart-define-from-file=config/dev.json
```

Generated localization, `.g.dart`, and `.freezed.dart` files are part of the
source tree. Do not edit generated files manually.

## Localization

The template currently supports:

| Language | Locale | Direction |
| --- | --- | --- |
| English | `en` | LTR |
| Bangla | `bn` | LTR |
| Arabic | `ar` | RTL |

English is the explicit first-run default, even when the device uses another
language. Selecting a language in Settings updates the application immediately
and persists the choice with `SharedPreferencesAsync`. The saved locale is
restored during bootstrap before the first frame. Missing, unsupported, invalid,
or unreadable values fall back to English.

Use localized strings in presentation and shared widgets through the
`BuildContext` extension:

```dart
Text(context.locale.settingsTitle)
```

For several messages in one build method, keep a local reference:

```dart
final l10n = context.locale;

return Column(
  children: <Widget>[
    Text(l10n.settingsTitle),
    Text(l10n.languageDescription),
  ],
);
```

Keep user-facing presentation text in ARB resources. Domain entities and data
models should not depend on `AppLocalizations`; translate display text at the
presentation boundary.

### Localization files

Editable translation resources:

```text
lib/l10n/
├── app_en.arb
├── app_bn.arb
└── app_ar.arb
```

Generated files:

```text
lib/l10n/
├── app_localizations.dart
├── app_localizations_en.dart
├── app_localizations_bn.dart
└── app_localizations_ar.dart
```

`app_en.arb` is the template configured in `l10n.yaml`. Add a message there,
provide the same key in Bangla and Arabic, and then regenerate:

```sh
flutter gen-l10n
```

Example message with a placeholder:

```json
{
  "welcomeUser": "Welcome, {name}",
  "@welcomeUser": {
    "description": "Greeting shown after login",
    "placeholders": {
      "name": {
        "type": "String"
      }
    }
  }
}
```

Presentation usage:

```dart
Text(context.locale.welcomeUser(user.name))
```

### Locale state and persistence

Localization infrastructure is split by responsibility:

- `app_locales.dart`: supported locales and English fallback.
- `locale_preferences.dart`: `SharedPreferencesAsync` persistence.
- `locale_controller.dart`: generated Riverpod state and save behavior.
- `build_context_extensions.dart`: the `context.locale` presentation helper.
- `bootstrap.dart`: restores the saved locale before `runApp`.
- `template_app.dart`: delegates, supported locales, and current locale.

Change the language from presentation code:

```dart
await ref
    .read(localeControllerProvider.notifier)
    .setLocale(AppLocales.bangla);
```

Only locales in `AppLocales.supported` are accepted. Selecting the active locale
again does not perform another storage write.

### Adding another language

1. Create its ARB file, such as `lib/l10n/app_es.arb`.
2. Translate every message defined by `app_en.arb`.
3. Add its `Locale` constant and list entry in `AppLocales`.
4. Add its localized display-name message to every ARB file.
5. Add it to the Settings language selector.
6. Add the locale code to `CFBundleLocalizations` in
   `ios/Runner/Info.plist`.
7. Run `flutter gen-l10n`.
8. Add fallback, persistence, rendering, and directionality tests as
   appropriate.

Flutter includes the generated localization delegate plus global Material,
Cupertino, and Widgets delegates. Because the selected locale is passed to
`MaterialApp`, Arabic automatically renders with right-to-left directionality.
No manual `Directionality` widget is required.

Localization tests cover the English fallback, supported-locale validation,
single-write persistence, Bangla rendering, and Arabic RTL directionality:

```sh
flutter test test/core/localization test/widget_test.dart
```

## Environment configuration

The application reads compile-time values through `AppConfig`.

`config/dev.json`:

```json
{
  "APP_ENV": "development",
  "API_BASE_URL": "https://dev-api.example.com"
}
```

`config/prod.json`:

```json
{
  "APP_ENV": "production",
  "API_BASE_URL": "https://api.example.com"
}
```

Replace the placeholder URLs with the appropriate API hosts.

Run development:

```sh
flutter run --dart-define-from-file=config/dev.json
```

Build a production App Bundle:

```sh
flutter build appbundle --release \
  --dart-define-from-file=config/prod.json
```

Build a production APK:

```sh
flutter build apk --release \
  --dart-define-from-file=config/prod.json
```

These files must contain public build-time configuration only. Values compiled
into a client application can be extracted, so never place secrets in them.

## Networking

Remote data sources should receive `NetworkService` through constructor
injection. Do not create separate Dio instances inside features.

```dart
class UserRemoteDataSource {
  const UserRemoteDataSource(this._networkService);

  final NetworkService _networkService;

  Future<Either<Failure, UserModel>> getUser(int id) {
    return _networkService.get<UserModel>(
      '/users/$id',
      decoder: (data) {
        return UserModel.fromJson(data! as Map<String, dynamic>);
      },
    );
  }

  Future<Either<Failure, UserModel>> createUser(
    Map<String, dynamic> body,
  ) {
    return _networkService.post<UserModel>(
      '/users',
      data: body,
      decoder: (data) {
        return UserModel.fromJson(data! as Map<String, dynamic>);
      },
    );
  }
}
```

Register the data source with a generated provider:

```dart
part 'user_providers.g.dart';

@riverpod
UserRemoteDataSource userRemoteDataSource(Ref ref) {
  return UserRemoteDataSource(ref.watch(networkServiceProvider));
}
```

### CRUD API

Every method requires a typed decoder and returns
`Future<Either<Failure, T>>`.

| Method | Body | Query parameters | Cache policy |
| --- | --- | --- | --- |
| `get<T>` | No | Yes | Yes |
| `post<T>` | Yes | Yes | No |
| `put<T>` | Yes | Yes | No |
| `patch<T>` | Yes | Yes | No |
| `delete<T>` | Optional | Yes | No |

All methods also accept Dio `Options` and a `CancelToken`.

Decode a list response:

```dart
final result = await networkService.get<List<UserModel>>(
  '/users',
  queryParameters: <String, dynamic>{'page': 1},
  decoder: (data) {
    final items = data! as List<dynamic>;
    return items
        .map(
          (item) => UserModel.fromJson(item! as Map<String, dynamic>),
        )
        .toList(growable: false);
  },
);
```

Consume a result without exceptions:

```dart
return result.fold(
  (failure) {
    // Convert to feature state or return the failure from the repository.
    return Left(failure);
  },
  (users) {
    return Right(users.map((model) => model.toEntity()).toList());
  },
);
```

### Cache behavior

GET requests default to `RequestCachePolicy.useCache`.

```dart
await networkService.get<UserModel>(
  '/users/42',
  cachePolicy: RequestCachePolicy.refresh,
  decoder: (data) {
    return UserModel.fromJson(data! as Map<String, dynamic>);
  },
);
```

Available policies:

- `useCache`: respect server cache directives and use a cached response when
  appropriate.
- `refresh`: fetch from the server and refresh the cached entry.
- `noCache`: bypass the cache for that request.

The default store is a bounded in-memory LRU cache:

- Maximum total size: 10 MB
- Maximum entry size: 1 MB
- Maximum stale duration: 7 days
- Cached fallback on connection failure
- Cached fallback for HTTP 500, 502, 503, and 504
- POST caching disabled; other mutations are not cached

Override `cacheOptionsProvider` if the product requires a persistent or
encrypted cache.

### Authentication

`AuthInterceptor` reads a token from `AccessTokenProvider` and adds:

```text
Authorization: Bearer <token>
```

The template uses `EmptyAccessTokenProvider`, so unauthenticated requests work
without additional setup. When authentication is implemented, provide a secure
storage-backed implementation by overriding `authTokenSourceProvider`.

Do not store access or refresh tokens in `SharedPreferences`.

### Timeouts and logging

The Dio client has 30-second connection, send, and receive timeouts. A
`LogInterceptor` is enabled only in debug mode. Request bodies are available in
debug logs; response bodies are disabled, and no Dio logger is installed in
release builds.

## Error handling

Network and repository operations return `Either<Failure, T>`. Inspect
`failure.type` to produce feature-specific behavior.

| Failure type | Source |
| --- | --- |
| `connectionTimeout` | Connection could not be established in time |
| `sendTimeout` | Request upload timed out |
| `receiveTimeout` | Response or HTTP 408 timed out |
| `transformTimeout` | Dio response transformation timed out |
| `badCertificate` | TLS certificate validation failed |
| `cancelled` | Request was cancelled |
| `noConnection` | DNS, socket, or connectivity failure |
| `badRequest` | HTTP 400 or another unclassified 4xx response |
| `unauthorized` | HTTP 401 |
| `forbidden` | HTTP 403 |
| `notFound` | HTTP 404 |
| `conflict` | HTTP 409 |
| `validation` | HTTP 422 |
| `rateLimited` | HTTP 429 |
| `server` | HTTP 5xx |
| `cache` | Local data/cache operation failed |
| `serialization` | A response decoder rejected the payload |
| `unknown` | Any unexpected error |

The mapper retains server messages from `message`, `error`, `detail`, or
`title`. It also flattens common field-validation payloads under `errors`.

## Freezed models

Use Freezed for every data model/DTO. Keep domain entities independent of JSON
and infrastructure concerns.

```dart
part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required int id,
    required String name,
  }) = _UserModel;

  const UserModel._();

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return _$UserModelFromJson(json);
  }

  User toEntity() => User(id: id, name: name);
}
```

After adding or changing a model, regenerate its implementation.

## Riverpod annotations

Use `@riverpod` or `@Riverpod(keepAlive: true)` for every provider and notifier.
Do not manually construct `Provider`, `NotifierProvider`, or
`AsyncNotifierProvider`.

Function provider:

```dart
@riverpod
UserRepository userRepository(Ref ref) {
  return UserRepositoryImpl(ref.watch(userRemoteDataSourceProvider));
}
```

Async notifier:

```dart
@riverpod
class UsersController extends _$UsersController {
  @override
  Future<List<User>> build() async {
    final result = await ref.watch(getUsersProvider)();
    return result.fold(
      (failure) => throw StateError(failure.message),
      (users) => users,
    );
  }
}
```

Providers are auto-disposed by default. Use `keepAlive: true` only for
application-level dependencies that should live for the entire provider scope.

## Code generation

Generate once:

```sh
dart run build_runner build
```

Watch during development:

```sh
dart run build_runner watch
```

If stale generated files conflict, stop the watcher, remove only the affected
generated file, and run the build command again.

## Routing

Route paths and names live in `lib/app/router/app_routes.dart`. GoRouter
composition lives in `lib/app/router/app_router.dart`.

When adding a page:

1. Add its path and route name.
2. Register its `GoRoute`.
3. Navigate with `goNamed`, `pushNamed`, or typed path parameters.

Unknown routes render the shared 404 page.

## Theme and fonts

The default theme mode is `ThemeMode.system`. A user selection of system, light,
or dark is persisted with `SharedPreferencesAsync` and restored before the
first application frame. Missing, invalid, or unreadable values fall back to
system mode.

- Colors: `lib/core/theme/app_colors.dart`
- Typography: `lib/core/theme/app_typography.dart`
- Component themes: `lib/core/theme/app_theme.dart`
- Persistence: `lib/core/theme/theme_preferences.dart`
- Riverpod state: `lib/core/theme/theme_controller.dart`

The template uses the platform font. To add a brand font:

1. Add the font files under `assets/fonts/`.
2. Register them in `pubspec.yaml`.
3. Set `AppTypography.fontFamily`.

## Adding a feature

1. Create `data`, `domain`, and `presentation` folders.
2. Define domain entities and repository contracts.
3. Create Freezed data models and mapping methods.
4. Implement remote/local data sources using shared infrastructure.
5. Implement the repository and return `Either<Failure, T>`.
6. Add use cases.
7. Add annotated Riverpod providers/notifiers.
8. Register routes.
9. Run code generation.
10. Add unit and widget tests.

## Quality checks

```sh
dart format .
flutter gen-l10n
dart run build_runner build
flutter analyze
flutter test
```

Build verification:

```sh
flutter build apk --release \
  --dart-define-from-file=config/prod.json
```

## Release signing

The starter Android project currently uses the debug signing configuration for
release builds. Configure a private production keystore before publishing an
APK or App Bundle to Google Play.
