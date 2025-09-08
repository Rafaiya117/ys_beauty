# Event Management App

A comprehensive Flutter application for event management with smooth animations, MVVM architecture, and professional UI design.

## 🏗️ Project Structure

```
lib/
├── core/
│   └── router.dart                 # Centralized navigation service with 20+ routes
├── features/
│   ├── splash/                     # Splash screen with logo animation
│   │   ├── model/splash_model.dart
│   │   ├── repository/splash_repository.dart
│   │   ├── view/splash_page.dart
│   │   └── viewmodel/splash_viewmodel.dart
│   ├── animation/                  # 22-image sequential animation
│   │   ├── model/animation_model.dart
│   │   ├── repository/animation_repository.dart
│   │   ├── view/animation_page.dart
│   │   └── viewmodel/animation_viewmodel.dart
│   ├── auth/                       # Complete authentication system
│   │   ├── model/
│   │   │   ├── auth_model.dart
│   │   │   ├── login_model.dart
│   │   │   ├── signup_model.dart
│   │   │   ├── forgot_password_model.dart
│   │   │   ├── otp_model.dart
│   │   │   └── reset_password_model.dart
│   │   ├── repository/
│   │   │   ├── auth_repository.dart
│   │   │   ├── forgot_password_repository.dart
│   │   │   ├── otp_repository.dart
│   │   │   └── reset_password_repository.dart
│   │   ├── view/
│   │   │   ├── auth_page.dart
│   │   │   ├── login_page.dart
│   │   │   ├── signup_page.dart
│   │   │   ├── forgot_password_page.dart
│   │   │   ├── otp_page.dart
│   │   │   └── reset_password_page.dart
│   │   └── viewmodel/
│   │       ├── auth_viewmodel.dart
│   │       ├── login_viewmodel.dart
│   │       ├── signup_viewmodel.dart
│   │       ├── forgot_password_viewmodel.dart
│   │       ├── otp_viewmodel.dart
│   │       └── reset_password_viewmodel.dart
│   ├── navigation/                 # Bottom navigation system
│   │   ├── model/navigation_model.dart
│   │   ├── view/main_navigation_page.dart
│   │   └── viewmodel/navigation_viewmodel.dart
│   ├── home/                       # Main dashboard
│   │   ├── model/home_model.dart
│   │   ├── repository/home_repository.dart
│   │   ├── view/home_page.dart
│   │   └── viewmodel/home_viewmodel.dart
│   ├── events/                     # Event management system
│   │   ├── model/
│   │   │   ├── events_model.dart
│   │   │   ├── create_event_model.dart
│   │   │   ├── event_details_model.dart
│   │   │   └── edit_event_model.dart
│   │   ├── repository/
│   │   │   ├── events_repository.dart
│   │   │   ├── create_event_repository.dart
│   │   │   ├── event_details_repository.dart
│   │   │   └── edit_event_repository.dart
│   │   ├── view/
│   │   │   ├── events_page.dart
│   │   │   ├── create_event_page.dart
│   │   │   ├── event_details_page.dart
│   │   │   └── edit_event_page.dart
│   │   └── viewmodel/
│   │       ├── events_viewmodel.dart
│   │       ├── create_event_viewmodel.dart
│   │       ├── event_details_viewmodel.dart
│   │       └── edit_event_viewmodel.dart
│   ├── finances/                   # Financial management
│   │   ├── view/finances_page.dart
│   │   └── viewmodel/finances_viewmodel.dart
│   ├── finance_history/            # Financial history tracking
│   │   ├── model/finance_history_model.dart
│   │   ├── repository/finance_history_repository.dart
│   │   ├── view/finance_history_page.dart
│   │   └── viewmodel/finance_history_viewmodel.dart
│   ├── finances_view/              # Detailed financial view
│   │   ├── model/finances_view_model.dart
│   │   ├── repository/finances_view_repository.dart
│   │   ├── view/finances_view_page.dart
│   │   └── viewmodel/finances_view_viewmodel.dart
│   ├── edit_financial_details/     # Financial data editing
│   │   ├── model/edit_financial_details_model.dart
│   │   ├── repository/edit_financial_details_repository.dart
│   │   ├── view/edit_financial_details_page.dart
│   │   └── viewmodel/edit_financial_details_viewmodel.dart
│   ├── search/                     # Global search functionality
│   │   ├── model/search_model.dart
│   │   ├── repository/search_repository.dart
│   │   ├── view/search_page.dart
│   │   └── viewmodel/search_viewmodel.dart
│   ├── reminders/                  # Reminders & notifications
│   │   ├── model/reminders_model.dart
│   │   ├── repository/reminders_repository.dart
│   │   ├── view/reminders_page.dart
│   │   └── viewmodel/reminders_viewmodel.dart
│   ├── settings/                   # App settings
│   │   ├── model/settings_model.dart
│   │   ├── view/settings_page.dart
│   │   └── viewmodel/settings_viewmodel.dart
│   ├── account/                    # User account management
│   │   ├── model/
│   │   │   ├── account_model.dart
│   │   │   ├── edit_information_model.dart
│   │   │   └── edit_password_model.dart
│   │   ├── repository/
│   │   │   ├── account_repository.dart
│   │   │   └── edit_information_repository.dart
│   │   ├── view/
│   │   │   ├── account_information_page.dart
│   │   │   ├── edit_information_page.dart
│   │   │   └── edit_password_page.dart
│   │   └── viewmodel/
│   │       ├── account_viewmodel.dart
│   │       ├── edit_information_viewmodel.dart
│   │       └── edit_password_viewmodel.dart
│   ├── help/                       # Help & support
│   │   ├── model/help_support_model.dart
│   │   ├── view/help_support_page.dart
│   │   └── viewmodel/help_support_viewmodel.dart
│   ├── terms/                      # Terms & conditions
│   │   ├── model/terms_condition_model.dart
│   │   ├── view/terms_condition_page.dart
│   │   └── viewmodel/terms_condition_viewmodel.dart
│   ├── privacy/                    # Privacy policy
│   │   ├── model/privacy_policy_model.dart
│   │   ├── view/privacy_policy_page.dart
│   │   └── viewmodel/privacy_policy_viewmodel.dart
│   └── feedback/                   # User feedback system
│       ├── model/feedback_model.dart
│       ├── repository/feedback_repository.dart
│       ├── view/feedback_page.dart
│       └── viewmodel/feedback_viewmodel.dart
├── shared/
│   ├── constants/
│   │   ├── app_colors.dart         # App-wide color definitions
│   │   └── app_constants.dart      # App-wide constants & asset paths
│   ├── utils/
│   │   └── greeting_utils.dart     # Dynamic greeting utility
│   └── widgets/
│       ├── custom_progress_bar.dart # Reusable progress bar
│       └── global_drawer.dart      # Global navigation drawer
├── app.dart                        # Main app configuration
└── main.dart                       # App entry point
```

## 🎯 Core Features

### 🚀 **Authentication System**
- **Login/Signup**: Complete user registration and authentication
- **Forgot Password**: Password recovery with OTP verification
- **OTP Verification**: Secure one-time password system
- **Reset Password**: Secure password reset functionality
- **Google Sign-in**: Social authentication integration

### 🏠 **Dashboard & Navigation**
- **Home Page**: Dynamic greeting, search bar, booking calendar, event cards
- **Bottom Navigation**: 4-tab navigation (Home, Events, Finances, Settings)
- **Global Drawer**: Unified navigation menu across all screens
- **Smooth Transitions**: Professional fade transitions between screens

### 📅 **Event Management**
- **Create Events**: Comprehensive event creation with all details
- **Event Details**: Detailed event information with status badges
- **Edit Events**: Full event editing capabilities
- **Event Calendar**: Interactive calendar with event indicators
- **Event Search**: Global search functionality across all events
- **Event Categories**: Organized event categorization

### 💰 **Financial Management**
- **Financial Dashboard**: Overview with summary cards and charts
- **Booth Fees**: Track and manage booth rental fees
- **Sales Tracking**: Record and monitor event sales
- **Expense Management**: Track event-related expenses
- **Financial History**: Complete transaction history
- **Financial Reports**: Detailed financial views with charts
- **Interactive Charts**: FL Chart integration for data visualization

### 🔍 **Search & Discovery**
- **Global Search**: Search across events, locations, and dates
- **Dedicated Search Page**: Full-screen search experience
- **Real-time Results**: Live search with instant results
- **Search Filters**: Advanced filtering options

### 🔔 **Notifications & Reminders**
- **Reminders System**: Event reminders and notifications
- **Notification Center**: Centralized notification management

### ⚙️ **Settings & Account**
- **User Settings**: Comprehensive app settings
- **Account Information**: User profile management
- **Edit Profile**: Update user information
- **Change Password**: Secure password management
- **Help & Support**: Support request system with file upload
- **Terms & Conditions**: Legal terms display
- **Privacy Policy**: Privacy policy information
- **Feedback System**: User feedback collection

### 🎨 **UI/UX Features**
- **Responsive Design**: Flutter ScreenUtil for pixel-perfect UI
- **Custom Fonts**: Google Fonts integration (Playfair, Great Vibes)
- **Dynamic Greetings**: Time-based greeting messages
- **Background Images**: Full-screen background images
- **Card Designs**: Professional card layouts
- **Smooth Animations**: 22-image sequential animation
- **Professional Icons**: Material Design icons throughout

## 📦 Dependencies & Packages

### **Core Dependencies**
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
```

### **State Management**
```yaml
provider: ^6.1.1                    # MVVM architecture & state management
```

### **UI & Design**
```yaml
flutter_screenutil: ^5.9.3          # Responsive design & pixel-perfect UI
google_fonts: ^6.2.1                # Custom typography (Playfair, Great Vibes)
```

### **Functionality**
```yaml
image_picker: ^1.0.4                # File upload for help & support
table_calendar: ^3.1.2              # Interactive calendar widget
fl_chart: ^0.68.0                   # Financial charts & data visualization
```

### **Development**
```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0             # Code quality & linting
```

## 🛠️ Technical Architecture

### **MVVM Pattern**
- **Model**: Data structures and business logic
- **View**: UI components and user interactions
- **ViewModel**: State management and business logic coordination
- **Repository**: Data access layer with mock data

### **Navigation System**
- **Centralized Router**: 20+ named routes in `AppRouter`
- **Smooth Transitions**: Custom page transitions with fade effects
- **Parameter Passing**: Secure argument passing between screens
- **Deep Linking**: Support for deep navigation

### **State Management**
- **Provider Pattern**: Reactive state management
- **ChangeNotifier**: Efficient UI updates
- **Consumer Widgets**: Optimized rebuilds
- **Disposal**: Proper memory management

## 🎨 Design System

### **Color Palette**
- **Primary Orange**: `#FF8A00` - Main brand color
- **Background**: Full-screen background images
- **Cards**: White with subtle shadows
- **Text**: Dark gray (`#424242`) for readability
- **Borders**: Black borders for search bars

### **Typography**
- **Playfair Display**: Dynamic greeting text (bold)
- **Great Vibes**: User names and titles (italic)
- **System Fonts**: Body text and UI elements

### **Spacing & Layout**
- **Responsive Units**: `.w`, `.h`, `.sp`, `.r` from ScreenUtil
- **Consistent Padding**: 24.w horizontal, 16.h vertical
- **Card Spacing**: 12.h between cards
- **Icon Sizes**: 20.sp for small, 24.sp for medium

## 📱 App Flow

### **1. Launch Sequence**
```
Splash Screen (2s) → Animation (22 images) → Auth/Home
```

### **2. Authentication Flow**
```
Auth Page → Login/Signup → OTP (if needed) → Main App
```

### **3. Main App Navigation**
```
Bottom Navigation: Home ↔ Events ↔ Finances ↔ Settings
Global Drawer: Access to all features
```

### **4. Event Management Flow**
```
Home → Create Event → Event Details → Edit Event
Events → Search → Event Details → Edit Event
```

### **5. Financial Flow**
```
Finances → Financial History → Financial View → Edit Details
```

## 🚀 Getting Started

### **Prerequisites**
- Flutter SDK ^3.8.1
- Dart SDK
- Android Studio / VS Code
- Git

### **Installation**
```bash
# Clone the repository
git clone <repository-url>
cd animation

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### **Build Commands**
```bash
# Debug build
flutter build apk --debug

# Release build
flutter build apk --release

# iOS build
flutter build ios --release
```

## 📊 Project Statistics

### **Code Structure**
- **Total Features**: 15 major features
- **Total Screens**: 25+ screens
- **Total Routes**: 20+ navigation routes
- **Architecture**: MVVM with Provider
- **Code Organization**: Feature-based structure

### **Assets**
- **Animation Images**: 22 sequential images
- **Background Images**: Full-screen backgrounds
- **Icons**: Material Design icons
- **Logos**: App logo and Google logo
- **Card Backgrounds**: Professional card designs

### **API Requirements** (Estimated)
Based on the current mock data structure, the app would need approximately **15-20 API endpoints**:

#### **Authentication APIs (5 endpoints)**
- `POST /auth/login` - User login
- `POST /auth/register` - User registration
- `POST /auth/forgot-password` - Password reset request
- `POST /auth/verify-otp` - OTP verification
- `POST /auth/reset-password` - Password reset

#### **Event Management APIs (6 endpoints)**
- `GET /events` - Get all events
- `POST /events` - Create new event
- `GET /events/{id}` - Get event details
- `PUT /events/{id}` - Update event
- `DELETE /events/{id}` - Delete event
- `GET /events/search` - Search events

#### **Financial APIs (4 endpoints)**
- `GET /finances` - Get financial overview
- `GET /finances/history` - Get financial history
- `GET /finances/{id}` - Get financial details
- `PUT /finances/{id}` - Update financial details

#### **User Management APIs (3 endpoints)**
- `GET /user/profile` - Get user profile
- `PUT /user/profile` - Update user profile
- `PUT /user/password` - Change password

#### **Support APIs (2 endpoints)**
- `POST /support/request` - Submit support request
- `POST /feedback` - Submit user feedback

## 🔧 Development Guidelines

### **Code Standards**
- **MVVM Architecture**: Strict adherence to Model-View-ViewModel pattern
- **Feature Organization**: Each feature in its own directory
- **Consistent Naming**: snake_case for files, camelCase for variables
- **Documentation**: Comprehensive code comments
- **Error Handling**: Graceful error handling throughout

### **Performance Optimizations**
- **Lazy Loading**: Efficient list rendering
- **Memory Management**: Proper disposal of controllers
- **Image Optimization**: Optimized asset loading
- **State Management**: Minimal rebuilds with Provider

### **Testing Strategy**
- **Unit Tests**: ViewModel and Repository testing
- **Widget Tests**: UI component testing
- **Integration Tests**: End-to-end user flows
- **Mock Data**: Comprehensive mock data for development

## 🎯 Future Enhancements

### **Phase 2 Features**
- [ ] Real-time notifications
- [ ] Offline data synchronization
- [ ] Advanced analytics dashboard
- [ ] Multi-language support
- [ ] Dark mode theme
- [ ] Export functionality (PDF, Excel)
- [ ] Advanced search filters
- [ ] Event templates
- [ ] Recurring events
- [ ] Team collaboration features

### **Technical Improvements**
- [ ] API integration
- [ ] Database implementation
- [ ] Caching strategy
- [ ] Performance monitoring
- [ ] Crash reporting
- [ ] Automated testing
- [ ] CI/CD pipeline

## 📄 License

This project is open source and available under the MIT License.

---

## 👨‍💻 Developer
**Mir Md Mosarof Hossan Showrav**  
📧 showravofficial@gmail.com

---

**Built with  using Flutter & MVVM Architecture**