# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

This project uses FVM (Flutter Version Manager) locked to Flutter 3.35.1 (see `.fvmrc`).

```sh
fvm flutter pub get       # Install dependencies
fvm flutter run           # Run the app
fvm flutter test          # Run all tests
fvm flutter test test/widget_test.dart  # Run a single test file
fvm flutter analyze       # Static analysis
fvm flutter build apk     # Android release build
fvm flutter build ios     # iOS release build
```

If FVM is not installed, replace `fvm flutter` with `flutter` (ensure version 3.35.1 is active).

## Architecture

### State Management

The app uses the **Provider** package with a `ChangeNotifier` pattern split into two layers:

- **`lib/providers/main_provider.dart`** — global singleton managing cross-screen state: authenticated user info (`UserInfoModel`), cart contents with price calculations, and wishlist
- **Screen-level providers** (`HomeProvider`, `StoreProvider`, `CheckoutProvider`, `ProfileProvider`) — local state scoped to individual screens, accessed via `MultiProvider` in the widget tree

### Service Layer

`*Service` classes in each screen folder handle all data access. They are pure data-fetching classes (no ChangeNotifier) called by providers:
- Firebase Firestore queries (products, categories, orders)
- Firebase Authentication (login, signup, password reset via `http` to Google Identity Toolkit API)
- SQLite via `lib/db/` (wishlist and brand data for offline persistence)

### Navigation

- `CustomNavigator` (`lib/helpers/custom_navigator.dart`) wraps `Navigator.push/pushReplacement` — use it for all navigation
- Each screen declares a `static const routeName` string used as the route identifier
- `ScreenWrapper` + `AppNavigation` manage the bottom nav bar (4 tabs: Home, Store, Wishlist, Profile); active tab is detected by matching `ModalRoute.of(context).settings.name`

### Data Flow

```
UI widget → calls Provider method → Provider calls Service → Service hits Firebase/SQLite
                                  ← Provider calls notifyListeners() ← data returned
```

### Provider Rules

- **`notifyListeners()` belongs in the provider, never in widgets.** `notifyListeners()` is `@protected` and must only be called from inside a `ChangeNotifier` method. When a screen needs to trigger a UI refresh after an async operation, it must call a provider setter method (e.g. `mainProvider.setEmail(value)`) that mutates state and calls `notifyListeners()` internally — never call `someProvider.notifyListeners()` directly from a widget.

- **Providers must not receive other provider instances as parameters.** Never pass a provider instance into another provider's constructor or method. Each provider resolves its own dependencies (services, models) independently. Cross-provider coordination belongs in the widget tree, where both providers are accessible via `Provider.of` or `Consumer`.

- **Use `Consumer` or `Selector` for reactive UI, not `Provider.of` with `listen: true`.** Any widget that needs to rebuild when provider state changes must use `Consumer<T>` (rebuilds on any `notifyListeners`) or `Selector<T, R>` (rebuilds only when the selected value changes). `Provider.of<T>(context, listen: false)` is only for one-shot reads inside callbacks and `initState`-equivalent calls — never use it where a rebuild is needed.

### Widget Reuse Rules

- **Where a shared widget lives depends on where it is used:**
  - Used in multiple places **within the same screen or section** → place it in that section's local `widgets/` folder (e.g. `lib/screens/app/profile/profile_widgets/`).
  - Used across **different sections or screens** → place it in the global widgets folder (`lib/widgets/`).
  - Never copy-paste a widget inline when it appears in more than one place.

- **Shared widgets must be designed to cover all their call sites.** When extracting a reusable widget, identify every place it is used and expose the parameters needed to satisfy all variants. No caller should need to wrap or workaround the widget because a case was missed.

### Storage

- **Firestore** — product catalog (`Products` collection), categories (`Categories`), user orders
- **Firebase Auth** — email/password authentication; Firebase App Check for security
- **Cloud Storage** — product images (loaded via `cached_network_image`)
- **SQLite** (`lib/db/`) — local persistence for wishlist and brand cache, enabling offline access

### Key Files

| File | Purpose |
|------|---------|
| `lib/main.dart` | App entry point, Provider setup, Firebase init |
| `lib/providers/main_provider.dart` | Global cart/wishlist/user state |
| `lib/constants/` | Theme colors, icon paths, asset URLs, global constants |
| `lib/helpers/auth_enum.dart` | `AuthStatus` and `OrderStatus` enums used app-wide |
| `lib/firebase_options.dart` | Auto-generated FlutterFire config (do not edit manually) |
| `lib/db/db_helper.dart` | SQLite schema and CRUD for local data |

### Firebase Project

Project ID: `e-commerce-14198` (EU region). Re-generate `firebase_options.dart` with `flutterfire configure` if Firebase config changes.

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
