# Contributing Guide

This guide outlines the development workflow, code standards, and contribution process for the Studex project. All contributors should follow these guidelines to maintain code quality and consistency.

---

## Table of Contents

1. [Getting Started](#getting-started)
2. [Development Workflow](#development-workflow)
3. [Branch Naming Convention](#branch-naming-convention)
4. [Commit Message Convention](#commit-message-convention)
5. [Code Standards](#code-standards)
6. [Testing Requirements](#testing-requirements)
7. [Pull Request Workflow](#pull-request-workflow)
8. [Code Review Process](#code-review-process)
9. [Common Development Tasks](#common-development-tasks)

---

## Getting Started

### Prerequisites

Before you start contributing, ensure you have:

- ✅ Flutter SDK 3.9.2+
- ✅ Dart SDK 3.9.2+
- ✅ Android Studio or VS Code with Flutter extension
- ✅ Git installed and configured
- ✅ Firebase account access (for testing)

### Initial Setup

1. **Clone the Repository**

```bash
git clone https://github.com/AbdulrhmanBadwy/studex_app.git
cd studex_app/studex_graduation_project
```

2. **Install Dependencies**

```bash
flutter pub get
```

3. **Verify Setup**

```bash
flutter doctor
flutter analyze
```

4. **Create Feature Branch**

```bash
git checkout -b feature/your-feature-name
```

---

## Development Workflow

### Phase-Based Development

The project is organized into phases:

- **Phase 0** — Foundation (complete) ✅
- **Phase 1** — Core Features (in progress)
- **Phase 2** — Advanced Features (planned)

When implementing features:

1. Check the [project plan](project-plan.md) for your phase
2. Understand dependencies between tasks
3. Follow the task checklist
4. Complete Definition of Done before submitting PR

### Local Development Steps

1. **Create feature branch** (see [Branch Naming Convention](#branch-naming-convention))

```bash
git checkout -b feature/feature-name
```

2. **Make changes** following [Code Standards](#code-standards)

3. **Run tests locally**

```bash
flutter test
flutter analyze
```

4. **Format code**

```bash
dart format lib/ test/
```

5. **Commit changes** (see [Commit Message Convention](#commit-message-convention))

6. **Push to remote**

```bash
git push origin feature/feature-name
```

7. **Create Pull Request** (see [Pull Request Workflow](#pull-request-workflow))

---

## Branch Naming Convention

Use the following format: `<type>/<short-description>`

### Types

| Type | Purpose | Example |
|------|---------|---------|
| `feature` | New feature or enhancement | `feature/user-profile-page` |
| `bugfix` | Bug fix | `bugfix/auth-token-expiry` |
| `refactor` | Code refactoring without feature changes | `refactor/bloc-state-management` |
| `docs` | Documentation updates | `docs/setup-guide` |
| `test` | Test additions or improvements | `test/firestore-security-rules` |

### Naming Rules

- Use lowercase
- Use hyphens to separate words (not underscores or camelCase)
- Keep description short (2–4 words max)
- Be specific and descriptive

### Examples

✅ **Good**
- `feature/auth-email-verification`
- `bugfix/firestore-timestamp-parsing`
- `refactor/user-repository-cleanup`
- `docs/firebase-setup`

❌ **Bad**
- `my-feature` (too vague)
- `feature_auth_fixes` (underscores and vague)
- `feature/this-is-a-very-long-description-that-is-too-verbose` (too long)
- `Feature/AuthFix` (mixed case)

---

## Commit Message Convention

Follow **Conventional Commits** format: `<type>(<scope>): <subject>`

### Commit Types

| Type | Purpose | Example |
|------|---------|---------|
| `feat` | New feature | `feat(auth): add email verification` |
| `fix` | Bug fix | `fix(firestore): handle timestamp parsing` |
| `refactor` | Code refactoring | `refactor(bloc): simplify auth state logic` |
| `test` | Test additions | `test(security): add firestore rule tests` |
| `docs` | Documentation | `docs: update README setup instructions` |
| `chore` | Dependency updates, tooling | `chore: upgrade flutter_bloc to 8.1.4` |

### Commit Scope

The scope identifies the component:

- `auth` — Authentication system
- `user` — User management and profiles
- `firestore` — Firestore integration
- `bloc` — State management
- `models` — Domain models
- `repo` — Repositories and data layer
- `ui` — UI components and screens
- `router` — Navigation and routing
- `config` — Configuration files

### Subject Rules

- Use imperative mood ("add" not "added")
- Don't capitalize first letter
- No period at the end
- Keep under 50 characters
- Be specific and concise

### Commit Body (for complex changes)

For non-trivial commits, include a body explaining:

- **What**: What changed and why
- **How**: How the change works
- **Impact**: Side effects or breaking changes

Format:

```
feat(auth): add email verification flow

- Implemented email verification after signup
- Added VerificationBloc to manage verification state
- Updated AuthRepository.signup() to send verification email
- Added verification timeout after 10 minutes
- Updated navigation to include verification screen

Closes #42
```

### Trailers

Include these trailers at the end:

- `Closes #<issue-number>` — Link to closed issue
- `Co-authored-by: Name <email>` — Multiple authors
- `Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>` — Copilot assists

### Examples

✅ **Good**
```
feat(auth): add password reset flow

fix(firestore): parse timestamp correctly for quiz attempts

refactor(bloc): extract event handling to separate methods

test(security): validate user profile access rules

docs(readme): add firebase emulator setup instructions
```

❌ **Bad**
```
Added auth stuff
Fixed bugs
Updated code
WIP
random changes
```

---

## Code Standards

### Dart Style Guide

Follow the [Effective Dart Style Guide](https://dart.dev/guides/language/effective-dart/style):

- Use 2 spaces for indentation (not tabs)
- Prefer `const` for constant values
- Use `late` keyword for lazy initialization
- Follow naming conventions:
  - Classes: `PascalCase` (e.g., `UserModel`, `AuthBloc`)
  - Variables/functions: `camelCase` (e.g., `userName`, `fetchUser()`)
  - Constants: `lowerCamelCase` (e.g., `maxRetries`, `defaultTimeout`)
  - Private members: prefix with `_` (e.g., `_privateField`)

### Code Organization

#### File Structure

```dart
// 1. Library documentation (if applicable)
/// {@template user_model}
/// Represents a user profile in Firestore
/// {@endtemplate}

// 2. Imports (organize in groups: dart, flutter, packages, project)
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

// 3. Class/Type definitions
class UserRepository {
  // 3a. Fields (static first, then instance)
  static const String _collectionPath = 'users';
  final FirebaseFirestore _firestore;

  // 3b. Constructor
  UserRepository(this._firestore);

  // 3c. Methods (public first, then private)
  Future<UserModel?> fetchUser(String uid) async {
    // implementation
  }

  // 3d. Private methods
  Future<DocumentSnapshot> _getUserDocument(String uid) async {
    // implementation
  }
}
```

#### Class Order

1. Static fields and constants
2. Instance fields
3. Constructor
4. Getters
5. Public methods
6. Private methods
7. `@override` methods

### Code Quality

#### Comments

- **Use comments sparingly** — prefer self-documenting code
- Document **why**, not **what** — code shows what, comments explain why
- Use `///` for public documentation (generates dartdoc)
- Use `//` for internal comments

```dart
// Bad: comment explains what code does
// Increment counter by 1
counter++;

// Good: only comment non-obvious logic
// Subtract 1 to convert from 1-indexed to 0-indexed
final listIndex = position - 1;

/// Fetches user profile from Firestore
/// 
/// Returns the user with the given [uid], or null if not found.
/// Throws [FirebaseException] if the operation fails.
Future<UserModel?> fetchUser(String uid) async {
  // implementation
}
```

#### Error Handling

Always handle errors explicitly:

```dart
// Bad: silent failure
try {
  await firestore.collection('users').doc(uid).get();
} catch (_) {}

// Good: log and rethrow
try {
  final doc = await firestore.collection('users').doc(uid).get();
  return UserModel.fromJson(doc.data());
} catch (e) {
  logger.error('Failed to fetch user $uid: $e');
  rethrow;
}
```

#### Type Safety

Always use types explicitly:

```dart
// Bad: dynamic is unsafe
var user = getUserFromJson(data);

// Good: explicit type
UserModel user = getUserFromJson(data);

// Also good: inferred from context
final user = _buildUserFromJson(data); // type inferred
```

### Firestore Collection Names

Use centralized constants:

```dart
// ✅ Correct
import 'package:studex_app/core/constants/firestore_collections.dart';

final collection = firestore.collection(FirestoreCollections.users);

// ❌ Incorrect (hardcoded)
final collection = firestore.collection('users');
```

### State Management (Bloc)

#### Event Naming

Use past tense for events (user action):

```dart
abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();

  @override
  List<Object> get props => [];
}
```

#### State Naming

Use adjective/status for states (result):

```dart
abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthSuccess extends AuthState {
  final UserModel user;

  const AuthSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object> get props => [message];
}
```

### Testing Requirements

#### Unit Tests

- Test domain models (serialization, equality)
- Test repositories (Firebase integration)
- Test Bloc logic (event → state transitions)

```dart
void main() {
  group('UserModel', () {
    test('fromJson() deserializes correctly', () {
      final json = {
        'uid': 'user-123',
        'email': 'user@example.com',
        'role': 'student',
      };

      final user = UserModel.fromJson(json);

      expect(user.uid, 'user-123');
      expect(user.email, 'user@example.com');
      expect(user.role, 'student');
    });

    test('copyWith() creates new instance with updated fields', () {
      final original = UserModel(
        uid: 'user-123',
        email: 'user@example.com',
        role: 'student',
      );

      final updated = original.copyWith(role: 'teacher');

      expect(updated.role, 'teacher');
      expect(original.role, 'student'); // original unchanged
    });
  });
}
```

#### Widget Tests

- Test UI interactions
- Test navigation
- Test error states

#### Integration Tests

- Test full user flows
- Test Firebase integration
- Test Bloc state transitions

---

## Testing Requirements

### Before Submitting PR

1. ✅ **All existing tests pass**

```bash
flutter test
```

2. ✅ **New tests added for new features**

   - Unit tests for models and repositories
   - Bloc tests for state management
   - Widget tests for UI changes

3. ✅ **Code analysis passes**

```bash
flutter analyze
```

4. ✅ **Code is formatted**

```bash
dart format lib/ test/
```

5. ✅ **Manual testing completed**

   - Test on both Android and iOS
   - Test all user flows affected by your changes
   - Verify no regressions

### Test Coverage

Aim for:
- ✅ 80%+ coverage for domain models
- ✅ 80%+ coverage for repositories
- ✅ 60%+ coverage for Bloc logic
- ✅ 50%+ coverage for UI (widget/integration tests)

Run coverage report:

```bash
flutter test --coverage
```

---

## Pull Request Workflow

### Before Creating PR

1. ✅ Verify branch is up-to-date with `main`

```bash
git fetch origin
git rebase origin/main
```

2. ✅ All tests pass locally

```bash
flutter test
flutter analyze
```

3. ✅ Code is formatted

```bash
dart format lib/ test/
```

### PR Title Format

Use same format as commit messages: `<type>(<scope>): <subject>`

**Examples:**
- `feat(auth): add email verification flow`
- `fix(firestore): handle timestamp parsing correctly`
- `docs: update contributing guide`

### PR Description Template

```markdown
## Description
Brief description of what this PR does and why.

## Related Issue
Closes #<issue-number>

## Type of Change
- [ ] New feature
- [ ] Bug fix
- [ ] Documentation update
- [ ] Refactoring
- [ ] Dependency update

## Changes Made
- Change 1
- Change 2
- Change 3

## Testing
- [ ] Unit tests added/updated
- [ ] Tests pass locally
- [ ] Tested on Android
- [ ] Tested on iOS

## Checklist
- [ ] Code follows style guidelines
- [ ] Code is formatted (`dart format`)
- [ ] No linting errors (`flutter analyze`)
- [ ] Updated documentation (if needed)
- [ ] No breaking changes (or documented)
- [ ] All tests passing
```

### PR Requirements

Before merge, PR must satisfy:

- ✅ Title follows convention
- ✅ Description explains changes
- ✅ All tests passing
- ✅ No merge conflicts
- ✅ Approved by at least 1 reviewer
- ✅ Code review comments resolved

---

## Code Review Process

### For PR Authors

1. **Request Review**
   - Request review from team members
   - Link related issues/PRs

2. **Respond to Feedback**
   - Address all comments
   - Push new commits for changes
   - Don't force-push after review starts

3. **Communicate**
   - Explain design decisions
   - Discuss alternatives if feedback suggests changes
   - Mark conversations as resolved when addressed

### For Reviewers

1. **Review Checklist**
   - [ ] Code follows style guidelines
   - [ ] Logic is correct and efficient
   - [ ] Tests cover new functionality
   - [ ] No breaking changes
   - [ ] Documentation is clear
   - [ ] Error handling is appropriate

2. **Comment Guidelines**
   - Be respectful and constructive
   - Explain **why**, not just point out issues
   - Suggest improvements, don't demand
   - Mark minor/nitpick comments as such

3. **Approval**
   - Approve when satisfied with changes
   - Leave comments for non-blocking suggestions

### Review Priorities

Review in this order:
1. **Correctness** — Does it work? Are there bugs?
2. **Design** — Does it fit architecture? Is it testable?
3. **Readability** — Is code clear and maintainable?
4. **Efficiency** — Can it be optimized? Any performance issues?
5. **Style** — Does it follow conventions? (lowest priority)

---

## Common Development Tasks

### Adding a New Feature

1. **Create feature branch**

```bash
git checkout -b feature/feature-name
```

2. **Plan implementation**
   - Check project plan for requirements
   - Review related domain models
   - Plan state management (Bloc)

3. **Implement model**

```dart
// lib/models/new_model.dart
class NewModel extends Equatable {
  final String id;
  final String name;

  const NewModel({required this.id, required this.name});

  // Add toJson, fromJson, copyWith, equality, hashCode
  // See UserModel for template
}
```

4. **Implement repository**

```dart
// lib/repositories/new_repository.dart
class NewRepository {
  Future<NewModel> fetch(String id) async {
    // Firebase logic
  }
}
```

5. **Implement Bloc** (if state management needed)

```dart
// lib/blocs/new/new_event.dart, new_state.dart, new_bloc.dart
// See auth_bloc.dart for template
```

6. **Create UI**

```dart
// lib/features/new/new_screen.dart
// Use BlocConsumer/BlocListener to connect state
```

7. **Add tests**

```bash
flutter test test/models/new_model_test.dart
flutter test test/blocs/new/new_bloc_test.dart
```

8. **Create PR**

### Fixing a Bug

1. **Create bugfix branch**

```bash
git checkout -b bugfix/bug-description
```

2. **Write failing test** (TDD approach)

```dart
test('should handle edge case', () {
  // Test that demonstrates the bug
});
```

3. **Fix the bug**

4. **Verify test passes**

```bash
flutter test
```

5. **Check no regressions**

```bash
flutter test
flutter analyze
```

6. **Create PR** with `fix(scope): description`

### Updating Documentation

1. **Create docs branch**

```bash
git checkout -b docs/documentation-title
```

2. **Update or create documentation file**

3. **Verify formatting and links**

4. **Create PR** with `docs: description`

### Adding Dependencies

1. **Update pubspec.yaml**

```yaml
dependencies:
  new_package: ^1.0.0
```

2. **Run `flutter pub get`**

```bash
flutter pub get
```

3. **Commit changes**

```bash
git commit -m "chore: add new_package dependency"
```

4. **Create PR**

---

## Troubleshooting

### Conflicts During Rebase

```bash
# If conflicts occur during rebase
git rebase --abort  # Cancel rebase and try again

# Or resolve conflicts manually
git add <resolved-files>
git rebase --continue
```

### Need to Update PR from Main

```bash
git fetch origin
git rebase origin/main
git push -f origin feature/feature-name  # Force push only on personal branches
```

### Accidentally Committed to Main

```bash
# Create feature branch from current main
git checkout -b feature/feature-name

# Reset main to before your commits
git checkout main
git reset --hard origin/main
```

---

## Contact & Questions

- **Slack/Chat**: Reach out to team leads
- **Issues**: Create GitHub issue for bugs/features
- **PR Comments**: Ask in PR discussion

---

## Code of Conduct

- Be respectful to all contributors
- Provide constructive feedback
- Respect different opinions and approaches
- Celebrate contributions and successes

Thank you for contributing to Studex! 🎓
