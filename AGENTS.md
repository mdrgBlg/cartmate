# Project: CartMate

## Purpose

These instructions apply to coding agents working on the CartMate Flutter project.

Prioritize correct, minimal, and focused changes. Avoid unnecessary project-wide exploration, builds, tests, analysis, or other long-running commands unless they are justified by the task.

---

## Stack

- Flutter 3.41.4
- Dart 3.11.1
- State management: Provider (`ChangeNotifier`)
- Backend: Custom REST API
- HTTP client: `DfApiClient` from the custom `df_http` package
- Routing: `Navigator`
- Local storage: `shared_preferences`
- Flutter SDK managed through FVM

---

## Architecture

Follow the existing project architecture.

### Data

- `Services`
- `Repositories`
- `Models`

### Presentation

- `Widgets`: Reusable UI components
- `Screens`: Screens and views
- `Providers`: Feature state and presentation logic
- `Utils`: Utility functions and helpers

Do not introduce new architectural patterns or dependencies unless explicitly requested.

When modifying an existing feature, follow the patterns already used by neighboring files.

---

## General Working Rules

### Keep changes focused

- Make the smallest change necessary to complete the requested task.
- Do not refactor unrelated code.
- Do not rename or reorganize unrelated files.
- Do not modify dependencies unless required.
- Do not update package versions unless explicitly requested.
- Do not modify generated files unless the task requires it.
- Do not fix unrelated warnings or existing issues.
- Preserve existing behavior outside the requested change.

### Keep exploration focused

Do not scan or read large parts of the repository by default.

Start with files directly related to the request and expand only when necessary.

Prefer:

1. Locate the relevant feature/file.
2. Inspect its immediate dependencies if necessary.
3. Make the change.
4. Perform proportional validation.
5. Stop.

Do not investigate unrelated modules merely to gain additional context.

---

## Storage

- **Firestore** — product catalog (`Products` collection), categories (`Categories`), user orders
- **Firebase Auth** — email/password authentication; Firebase App Check for security
- **Cloud Storage** — product images (loaded via `cached_network_image`)
- **SQLite** (`lib/db/`) — local persistence for wishlist and brand cache, enabling offline access

## Firebase Project

Project ID: `e-commerce-14198` (EU region). Re-generate `firebase_options.dart` with `flutterfire configure` if Firebase config changes.

---

## Localization

Never hardcode user-facing UI strings.

All user-facing strings must use the project's localization system (`l10n` / ARB files).

When adding a new user-facing string:

- Add it to the appropriate ARB file.
- Use the generated localization API in Dart.
- Follow the naming conventions already present in existing ARB files.

Do not replace localized strings with raw string literals.

---

## Provider Conventions

Use `ChangeNotifier`-based Provider state management.

- One `ChangeNotifier` per feature domain, e.g. `EmailLoginProvider`.
- Register app-wide providers in `main.dart` through `MultiProvider`. Feature-local
  providers may be created close to the screen that owns them.
- Expose state through immutable/public getters.
- Mutate state only through provider methods.
- Call `notifyListeners()` when observable state changes.
- Use `context.watch<T>()` when UI should rebuild from changes.
- Use `context.read<T>()` for one-off actions and callbacks.
- Use `Selector` or `Consumer` when rebuild scope should be limited.
- Never call `notifyListeners()` synchronously during `build`.
- Keep business logic out of widgets.

Do not introduce another state-management solution unless explicitly requested.

---

## REST API Conventions

All API communication must go through the existing service layer and its configured client.

- There is no Base URL configuration in here because firebase is used for API-s.
- Authentication tokens are handled by firebase
- UI code must never call firebase APIs directly.
- API communication belongs in service classes.
- Preserve the existing Service → Repository → Provider architecture, or the
  feature-specific flow used by neighboring code.
- API operations return either a `Success` model or a `Failure` model.
- Providers expose loading/error/success state to the presentation layer.

Do not introduce another HTTP client unless explicitly requested.

---

## Error Handling

Follow the existing error-handling architecture.

Services return:

```dart
Failure(Exception(e))
```

for unsuccessful operations according to the project's existing patterns.

Providers should:

- Determine whether the response is `Success` or `Failure`.
- Update the appropriate state.
- Set/clear the `error` field as appropriate.
- Call `notifyListeners()` when observable state changes.

Screens should render errors based on provider state.

Never expose raw exceptions directly in UI widgets.

---

## Dart and Flutter Conventions

- Follow `analysis_options.yaml`.
- Prefer `const` constructors whenever possible.
- Prefix private widgets/classes with `_`.
- Avoid multiple unrelated classes/widgets in one file.
- Screens may contain small private supporting widgets when appropriate.
- Models should remain immutable.
- Use `copyWith` for model updates when the existing model follows that pattern.
- Keep business logic out of widgets.
- Follow existing naming and file-organization conventions.
- Prefer existing project components over introducing duplicate widgets/helpers.
- Avoid unnecessary abstractions for small changes.

---

## Commands

The project uses FVM.

Common commands include:

```bash
fvm flutter run
fvm flutter test
fvm flutter analyze
```

When `build_runner` is required:

```bash
fvm dart run build_runner build --delete-conflicting-outputs
```

These commands are available but **must not automatically be run after every task**.

---

## Validation Strategy

Use **fast, proportional, and targeted validation**.

The amount of validation should correspond to the risk and scope of the change.

### Small Changes

Examples:

- Padding/margin changes
- Colors
- Text styles
- Widget sizing
- Simple layout adjustments
- Adding/removing a small UI element
- Small localization changes
- Straightforward property changes
- Minor isolated Dart changes

For these tasks:

- Do NOT run the full test suite.
- Do NOT run a full project-wide `fvm flutter analyze`.
- Do NOT build the application.
- Do NOT start an emulator or simulator.
- Do NOT run the application.
- Inspect the changed code for obvious issues.
- Format modified Dart files only when necessary.

Do not perform expensive validation merely to mark a small task complete.

### Medium Changes

Examples:

- Provider state changes
- Form validation
- Navigation changes
- API integration changes
- New service/repository methods
- Changes affecting multiple related files

Use targeted validation.

Run only the narrowest useful checks when they provide meaningful confidence.

Prefer targeted analysis such as:

```bash
fvm flutter analyze path/to/changed_file.dart
```

or the smallest relevant set of files.

Run relevant tests only when tests exist for the changed behavior and running them provides useful validation.

Do not automatically run the entire test suite.

### Large or High-Risk Changes

Examples:

- Authentication flows
- Significant Provider refactors
- Core architecture changes
- Shared infrastructure
- Changes affecting many features
- Complex API/data-layer changes
- Large refactors

For these tasks, broader validation may be appropriate.

`fvm flutter analyze` and relevant tests may be run when justified by the scope of the change.

Still prefer targeted tests before running the complete test suite.

---

## Naming Conventions

### Files
- `snake_case.dart` for all Dart files (e.g., `home_provider.dart`, `user_info_model.dart`, `custom_colors.dart`)

### Classes & Types
- `UpperCamelCase` for classes, enums, typedefs, and widgets (e.g., `UserInfoModel`, `HomeProvider`, `AuthStatus`, `CustomCurvedEdges`)

### Enums
- Enum type: `UpperCamelCase`
- Enum values: `camelCase` (e.g., `AuthStatus.successful`, `AuthStatus.wrongPassword`)

### Variables & Fields
- Public instance fields: `camelCase` (e.g., `firstName`, `phoneNumber`, `productModel`)
- Private fields: `_camelCase` with underscore prefix (e.g., `_cartItems`, `_isLoading`)
- Local variables: `camelCase` (e.g., `mainProvider`, `elementExists`, `cartIds`)

### Methods & Functions
- `camelCase` for all methods and functions (e.g., `fetchUserInfo()`, `addProductToCart()`, `focusChange()`)
- Method parameters: `camelCase` (e.g., `String firstName`, `String categoryId`)

### Constants
- Static class constants: `camelCase` without prefix (e.g., `CustomColors.text`, `CustomColors.primary`)
- Route names: `static const routeName` on each screen class

### Notes
- The codebase uses `whishlist` (double-h) consistently as a typo — match this spelling when touching existing wishlist identifiers to avoid renames

## Git Workflow

Every piece of work — bug fix, feature, refactor — must follow this flow without exception:

1. **Sync master first:** `git checkout master && git pull origin master`
2. **Create a branch** named for the work before touching any files:
   - Features: `feat/<short-description>` (e.g. `feat/cart-quantity-field`)
   - Fixes: `fix/<short-description>` (e.g. `fix/null-product-model`)
   - Refactors: `refactor/<short-description>`
3. **Before every commit, show the diff first:** Run `git diff --staged` (or `git diff HEAD` if nothing is staged yet) and present the output to the user so they can review what will be committed. Do not proceed with the commit until the user has seen the diff.
4. **Commit locally** after every meaningful change with a descriptive message. Never batch unrelated changes into one commit. Do not push yet.
5. **Push only when the entire feature is complete.** All commits for a feature travel together as one branch: `git push origin <branch-name>`
6. **Never push directly to master** — all changes go through branches and PRs.
7. **If the user says "work on this branch" or "don't make a new branch/PR"** — skip steps 1–2 and continue committing on the current branch.

Do not wait to be reminded. Apply this workflow automatically at the start of every task.
