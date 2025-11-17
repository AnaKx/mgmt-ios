# mngmt iOS - User Management Application

A native iOS application built with SwiftUI, featuring secure authentication, role-based access control, and modern user management capabilities.

## 🎯 Learning Goals

This project was developed to demonstrate proficiency in:

- **User Management**: Complete authentication flows with persistent sessions
- **iOS Security**: Keychain integration and secure token storage
- **Server-Client Communication**: RESTful API integration with async/await
- **SwiftUI Best Practices**: State management, Model-VIew patterns, and component reusability
- **UX Design**: Intuitive flows, input validation, and error handling
- **Industry Standards**: Professional code organization and architecture patterns

## 🛠️ Tech Stack

- **Language**: Swift
- **Framework**: SwiftUI
- **Architecture**: Model-View with service layers
- **Networking**: URLSession with async/await
- **Security**: Keychain Services, UserDefaults
- **Backend**: [mngmt-api](https://github.com/anakx/mngmt-api)

## ✨ Features

### Authentication
- ✅ User registration with validation
- ✅ Secure login with JWT tokens
- ✅ Persistent sessions (stays logged in)
- ✅ Secure logout with data clearing
- ✅ Password visibility toggle
- ✅ Real-time input validation

### User Management (Admin)
- ✅ View all registered users
- ✅ Revoke user access
- ✅ Restore user access
- ✅ User detail modal sheets

### Security Features
- ✅ JWT token storage in Keychain
- ✅ User data persistence in UserDefaults
- ✅ Automatic session restoration
- ✅ Role-based access control (Admin/User views)
- ✅ Input validation and sanitization
- ✅ HTTPS encrypted connections

## 🏗️ Architecture

### Service Layer Architecture
```
┌─────────────────┐
│   SwiftUI Views │
└────────┬────────┘
         │
    ┌────▼────────────────┐
    │   APIService        │  ← Handles all API calls
    │   - signup()        │
    │   - login()         │
    │   - getAllUsers()   │
    │   - revokeAccess()  │
    └────────┬────────────┘
             │
    ┌────────▼──────────────────┐
    │  KeychainService          │  ← Secure token storage
    │  UserDefaultsService      │  ← User data storage
    └───────────────────────────┘
```

### Authentication Flow
```
1. User enters credentials
        ↓
2. APIService.login() sends request
        ↓
3. Backend validates & returns JWT + user data
        ↓
4. KeychainService stores token securely
        ↓
5. UserDefaultsService stores user metadata
        ↓
6. RootView updates → Shows appropriate view
```

### State Management
```swift
RootView (Source of Truth)
    ├── @State isLoggedIn: Bool
    ├── @State isAdmin: Bool
    └── @State hasAccess: Bool
         ↓ (Passed as @Binding)
    ┌────────────┬──────────────┐
SignUpView   LoginView     AdminView
```

## 🎨 UI/UX Highlights

- **Floating Labels**: Input fields with animated floating labels
- **Real-time Validation**: Immediate feedback on invalid inputs
- **Password Toggle**: Show/hide password functionality
- **Loading States**: Progress indicators during API calls
- **Error Handling**: Clear, actionable error messages
- **Modal Sheets**: Bottom sheets for user details
- **Consistent Design**: Reusable components for uniform styling

## 📚 Key Learnings

### SwiftUI Patterns
- `@State` vs `@Binding` for state management
- `async/await` for modern concurrency
- `Task` for handling asynchronous operations
- `.sheet()` modifiers for modal presentations
- Custom view modifiers for reusable styling

### iOS Security
- Keychain vs UserDefaults (when to use each)
- Never storing passwords locally
- Secure token transmission with HTTPS
- Input sanitization and validation

### Networking
- URLSession with async/await
- JSON encoding/decoding with Codable
- Error handling and user feedback
- Bearer token authentication

### Architecture Decisions
- Service layer separation
- Reusable validation logic
- Component-based UI design
- Defensive programming practices

## 🐛 Known Issues / Future Improvements

- [ ] Implement password reset functionality
- [ ] Add user profile editing
- [ ] Implement search/filter in admin view
- [ ] Implement biometric authentication
- [ ] Add dark mode optimization
- [ ] Add Sign in with Apple

## 🔗 Related Projects

- [mngmt-api](https://github.com/anakx/mngmt-api) - Backend REST API
