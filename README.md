# Fitify - Fitness Tracking App

A comprehensive Flutter fitness tracking application with workout, meal, and sleep tracking features. Built with modern UI/UX design principles and a clean, intuitive interface.

## Features

### 🏠 Home Dashboard
- BMI tracking with visual progress indicators
- Daily activity status (Heart Rate, Water Intake, Sleep, Calories)
- Workout progress charts
- Latest workout summaries
- Today's target overview

### 🏋️ Workout Tracker
- Workout scheduling and planning
- Exercise library with detailed instructions
- Progress tracking and analytics
- Custom workout creation
- Workout completion tracking

### 🍽️ Meal Planner
- Daily meal scheduling
- Nutrition tracking and analytics
- Food database with nutritional information
- Recipe recommendations
- Meal planning tools

### 😴 Sleep Tracker
- Sleep quality monitoring
- Sleep schedule management
- Sleep analytics and insights
- Bedtime and alarm settings
- Sleep improvement recommendations

### 👤 Profile Management
- User profile completion
- Goal setting and tracking
- Progress photos
- Achievement tracking
- Personal data management

## Screenshots

The app includes the following key screens:

1. **Onboarding Flow**
   - Welcome screens with fitness goals
   - User registration and login
   - Profile completion
   - Goal selection

2. **Main Dashboard**
   - BMI overview with progress charts
   - Activity status cards
   - Workout progress visualization
   - Quick access to all features

3. **Navigation**
   - Custom bottom navigation with floating action button
   - Smooth transitions between screens
   - Intuitive icon-based navigation

## Getting Started

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code
- Android Emulator or Physical Device

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/fitify.git
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

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── screens/
│   ├── onboarding/          # Onboarding flow screens
│   ├── auth/               # Authentication screens
│   ├── home/               # Main dashboard
│   ├── workout/            # Workout tracking screens
│   ├── meal/               # Meal planning screens
│   ├── sleep/              # Sleep tracking screens
│   ├── profile/            # Profile management screens
│   └── goals/              # Goal selection screens
├── widgets/                # Reusable UI components
└── assets/
    ├── images/             # App images and icons
    ├── icons/              # Custom icons
    └── animations/         # Animation files
```

## Dependencies

- **fl_chart**: For creating beautiful charts and graphs
- **google_fonts**: For custom typography
- **flutter_svg**: For SVG icon support
- **intl**: For internationalization
- **table_calendar**: For calendar functionality
- **shared_preferences**: For local data storage
- **provider**: For state management
- **image_picker**: For photo selection
- **permission_handler**: For device permissions

## Design System

### Colors
- Primary: `#6B73FF` (Blue)
- Secondary: `#8B5CF6` (Purple)
- Background: `#F8F9FA` (Light Gray)
- Text: `#1F2937` (Dark Gray)

### Typography
- Font Family: Poppins
- Weights: Regular (400), Medium (500), SemiBold (600), Bold (700)

### Components
- Rounded corners (12px radius)
- Consistent spacing (8px, 16px, 24px, 32px)
- Shadow effects for depth
- Gradient backgrounds for emphasis

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Design inspiration from modern fitness apps
- Flutter community for excellent packages
- Google Fonts for beautiful typography

## Support

If you have any questions or need support, please open an issue on GitHub or contact the development team.

---

**Fitify** - Your personal fitness companion 🏃‍♀️💪
