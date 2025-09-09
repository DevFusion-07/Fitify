# Fitify - Fitness Tracking App

A comprehensive Flutter fitness tracking application with workout, meal, and sleep tracking features. Built with modern UI/UX design principles and a clean, intuitive interface.

## ✨ Features

### 🏠 Home Dashboard
- **Personalized Welcome**: Dynamic user name display from authentication
- **BMI Tracking**: Visual progress indicators with color-coded categories
- **Daily Activity Status**: Heart Rate, Water Intake, Sleep, and Calories tracking
- **Workout Progress Charts**: Interactive charts showing fitness journey
- **Latest Workout Summaries**: Quick access to recent workout sessions
- **Today's Target Overview**: Daily goals and progress tracking
- **Navigation Integration**: Direct access to Fullbody, Lowerbody, and Ab workout screens

### 🔐 Authentication System
- **Local Authentication**: Secure user registration and login
- **Profile Management**: Complete user profile with personal data
- **Data Persistence**: Local storage using SharedPreferences
- **Session Management**: Automatic login state handling
- **Profile Image Support**: Camera and gallery integration for profile pictures

### 🏋️ Workout Tracker
- **Workout Categories**: Fullbody, Lowerbody, and Ab workout screens
- **Exercise Library**: Detailed exercise instructions with images
- **Progress Tracking**: Comprehensive workout analytics
- **Custom Workout Creation**: Personalized workout plans
- **Workout Completion**: Session tracking and completion rewards
- **Exercise Details**: Step-by-step exercise guidance
- **Equipment Integration**: Equipment-specific workout recommendations

### 🍽️ Meal Planner
- **Meal Categories**: Breakfast, Lunch, and Dinner screens
- **Recipe Library**: Detailed recipe screens with ingredients and instructions
- **Nutrition Tracking**: Comprehensive nutritional information
- **Meal Scheduling**: Daily meal planning and organization
- **Recipe Navigation**: Seamless navigation between meal types and recipes
- **Meal Plans**: Pre-designed meal plans for different goals
- **Food Database**: Extensive food and recipe database

### 😴 Sleep Tracker
- **Sleep Quality Monitoring**: Comprehensive sleep analytics
- **Sleep Schedule Management**: Bedtime and wake-up time tracking
- **Sleep Insights**: Detailed sleep pattern analysis
- **Sleep Improvement**: Recommendations for better sleep habits
- **Sleep History**: Historical sleep data tracking

### 👤 Profile Management
- **Personal Data Screen**: Complete profile editing with validation
- **Achievement System**: Unlockable achievements and progress tracking
- **Activity History**: Comprehensive activity logging and history
- **Workout Progress**: Detailed workout analytics and progress charts
- **Health Metrics**: BMI, weight, height, and health goal tracking
- **Meal Planners**: Custom meal plan creation and management
- **Settings**: Comprehensive app settings and preferences
- **Help & Support**: FAQ, tutorials, and support system
- **About**: App information, team details, and legal information

### 📱 Advanced Features
- **Responsive Design**: Optimized for all screen sizes
- **Dark Mode Support**: Theme switching capability
- **Unit Conversion**: Weight (KG/LBS) and Height (CM/IN/FT) toggles
- **Date Picker Integration**: Intuitive date selection for birth dates
- **Image Picker**: Camera and gallery integration
- **Form Validation**: Comprehensive input validation
- **State Management**: Provider pattern for efficient state handling
- **Local Storage**: Persistent data storage
- **Navigation**: Smooth screen transitions and routing

## 🖼️ Screenshots

The app includes the following comprehensive screen collection:

### 1. **Authentication Flow**
   - Welcome screens with fitness goals
   - User registration with profile completion
   - Login with persistent sessions
   - Profile image selection and management

### 2. **Main Dashboard**
   - Personalized BMI overview with progress charts
   - Activity status cards with real-time data
   - Workout progress visualization
   - Quick access to all features
   - Navigation to workout screens

### 3. **Workout Screens**
   - Fullbody Workout Screen
   - Lowerbody Workout Screen
   - Ab Workout Screen
   - Exercise Detail Screens
   - Workout Completion Screens

### 4. **Meal Planning Screens**
   - Breakfast Screen with recipe navigation
   - Lunch Screen with meal options
   - Dinner Screen with dinner recipes
   - Recipe Detail Screens (Blueberry Pancake, Canai Bread, Tasty Burger, etc.)
   - Meal Schedule Screen

### 5. **Profile Management Screens**
   - Personal Data Screen (editable profile information)
   - Achievement Screen (unlockable achievements)
   - Activity History Screen (comprehensive activity logging)
   - Workout Progress Screen (detailed workout analytics)
   - Health Metrics Screen (BMI, health tracking)
   - Meal Planners Screen (custom meal plans)
   - Contact Us Screen (support and feedback)
   - Privacy Policy Screen (comprehensive privacy information)
   - Settings Screen (app preferences and account management)
   - Help & Support Screen (FAQ and tutorials)
   - About Screen (app information and team details)

### 6. **Navigation**
   - Custom bottom navigation with floating action button
   - Smooth transitions between screens
   - Intuitive icon-based navigation
   - Deep linking support

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code
- Android Emulator or Physical Device

### Installation

1. Clone the repository:
```bash
git clone https://github.com/DevFusion-07/Fitify.git
cd fitify
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## 📁 Project Structure

```
lib/
├── main.dart                     # App entry point with Provider setup
├── models/
│   └── user_model.dart          # User data model with BMI calculation
├── services/
│   └── auth_service.dart        # Authentication and data persistence
├── providers/
│   └── auth_provider.dart       # State management for authentication
├── screens/
│   ├── onboarding/              # Onboarding flow screens
│   ├── auth/                   # Authentication screens
│   │   ├── login_screen.dart
│   │   ├── signup_screen.dart
│   │   ├── welcome_screen.dart
│   │   └── complete_profile_screen.dart
│   ├── home/                   # Main dashboard
│   │   └── home_screen.dart
│   ├── workout/                # Workout tracking screens
│   │   ├── fullbody_workout_screen.dart
│   │   ├── lowerbody_workout_screen.dart
│   │   ├── ab_workout_screen.dart
│   │   ├── exercise_detail_screen.dart
│   │   └── workout_completion_screen.dart
│   ├── meal/                   # Meal planning screens
│   │   ├── meal_screen.dart
│   │   ├── breakfast_screen.dart
│   │   ├── lunch_screen.dart
│   │   ├── dinner_screen.dart
│   │   ├── meal_schedule_screen.dart
│   │   └── recipe screens (blueberry_pancake, canai_bread, etc.)
│   ├── sleep/                  # Sleep tracking screens
│   │   └── sleep_screen.dart
│   ├── profile/                # Profile management screens
│   │   ├── profile_screen.dart
│   │   ├── edit_profile_screen.dart
│   │   ├── personal_data_screen.dart
│   │   ├── achievement_screen.dart
│   │   ├── activity_history_screen.dart
│   │   ├── workout_progress_screen.dart
│   │   ├── health_metrics_screen.dart
│   │   ├── meal_planners_screen.dart
│   │   ├── contact_us_screen.dart
│   │   ├── privacy_policy_screen.dart
│   │   ├── settings_screen.dart
│   │   ├── help_support_screen.dart
│   │   └── about_screen.dart
│   ├── goals/                  # Goal selection screens
│   └── splash/                 # Splash and loading screens
├── widgets/                    # Reusable UI components
│   ├── common_widgets.dart
│   ├── bottom_navigation.dart
│   ├── workout_item_widget.dart
│   └── other custom widgets
├── utils/                      # Utility functions and constants
│   ├── app_constants.dart
│   ├── equipment_icons.dart
│   ├── meal_icons.dart
│   ├── performance_utils.dart
│   └── responsive_utils.dart
└── assets/
    ├── images/                 # App images and icons
    │   ├── exercises/          # Exercise images
    │   ├── meal/              # Meal and recipe images
    │   ├── onboarding/        # Onboarding images
    │   └── signup_login/      # Auth screen images
    ├── icons/                 # Custom SVG icons
    └── animations/            # Animation files
```

## 📦 Dependencies

### Core Dependencies
- **flutter**: SDK framework
- **provider**: State management and dependency injection
- **shared_preferences**: Local data persistence
- **google_fonts**: Custom typography (Poppins font family)

### UI/UX Dependencies
- **fl_chart**: Beautiful charts and graphs for progress tracking
- **flutter_svg**: SVG icon support for custom icons
- **image_picker**: Camera and gallery integration for profile pictures

### Utility Dependencies
- **intl**: Internationalization and date formatting
- **table_calendar**: Calendar functionality for scheduling
- **permission_handler**: Device permissions management

## 🎨 Design System

### Color Palette
- **Primary**: `#6B73FF` (Blue) - Main brand color
- **Secondary**: `#8B5CF6` (Purple) - Accent color
- **Success**: `#10B981` (Green) - Success states
- **Warning**: `#F59E0B` (Orange) - Warning states
- **Error**: `#EF4444` (Red) - Error states
- **Background**: `#F8F9FA` (Light Gray) - Background color
- **Text Primary**: `#1F2937` (Dark Gray) - Primary text
- **Text Secondary**: `#6B7280` (Medium Gray) - Secondary text

### Typography
- **Font Family**: Poppins (Google Fonts)
- **Font Weights**: 
  - Regular (400)
  - Medium (500)
  - SemiBold (600)
  - Bold (700)

### Component Design
- **Border Radius**: 12px for cards, 8px for buttons
- **Spacing System**: 8px, 16px, 20px, 24px, 32px
- **Shadow Effects**: Subtle shadows for depth and elevation
- **Gradient Backgrounds**: Linear gradients for emphasis
- **Icon Sizes**: 16px, 20px, 24px, 32px, 40px

## 🔧 Technical Features

### State Management
- **Provider Pattern**: Efficient state management across the app
- **ChangeNotifier**: Reactive UI updates
- **Consumer Widgets**: Optimized widget rebuilds

### Data Persistence
- **SharedPreferences**: Local storage for user data
- **User Model**: Comprehensive user data structure
- **Authentication Service**: Secure user management

### Form Handling
- **Form Validation**: Comprehensive input validation
- **TextEditingController**: Efficient form management
- **GlobalKey<FormState>**: Form state management

### Navigation
- **Named Routes**: Organized routing system
- **MaterialPageRoute**: Standard navigation
- **Modal Bottom Sheets**: Overlay navigation
- **Deep Linking**: URL-based navigation support

### Image Handling
- **Image Picker**: Camera and gallery integration
- **File Management**: Local file storage
- **Error Handling**: Graceful image loading failures

## 🧪 Testing

The app includes comprehensive testing setup:
- **Widget Tests**: UI component testing
- **Unit Tests**: Business logic testing
- **Integration Tests**: End-to-end testing

## 📱 Platform Support

- **Android**: Full support with Material Design
- **iOS**: Full support with Cupertino design elements
- **Web**: Responsive web support
- **Desktop**: Windows, macOS, and Linux support

## 🚀 Performance Optimizations

- **Lazy Loading**: Efficient list rendering
- **Image Optimization**: Compressed and optimized images
- **State Management**: Minimal widget rebuilds
- **Memory Management**: Proper disposal of controllers
- **Responsive Design**: Optimized for all screen sizes

## 🔒 Security Features

- **Local Authentication**: Secure user authentication
- **Data Encryption**: Encrypted local storage
- **Input Validation**: Comprehensive form validation
- **Privacy Protection**: GDPR-compliant data handling

## 🌟 Key Highlights

- **11 Profile Menu Screens**: Comprehensive profile management
- **Local Authentication**: Complete user management system
- **Recipe Navigation**: Seamless meal and recipe browsing
- **Workout Integration**: Direct navigation to workout screens
- **Responsive Design**: Optimized for all devices
- **Modern UI/UX**: Beautiful and intuitive interface
- **Comprehensive Features**: Complete fitness tracking solution

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Design inspiration from modern fitness apps
- Flutter community for excellent packages
- Google Fonts for beautiful typography
- Material Design for UI guidelines

## 📞 Support

If you have any questions or need support, please:
- Open an issue on GitHub
- Contact the development team
- Check the Help & Support screen in the app
- Review the FAQ section

---

**Fitify** - Your comprehensive personal fitness companion 🏃‍♀️💪

*Track your workouts, plan your meals, monitor your sleep, and achieve your fitness goals with our all-in-one fitness tracking app.*