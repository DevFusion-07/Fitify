class MealIcons {
  static const Map<String, String> mealIcons = {
    // Meal times
    'breakfast': 'assets/icons/breakfast.svg',
    'lunch': 'assets/icons/lunch.svg',
    'dinner': 'assets/icons/dinner.svg',
    'snack': 'assets/icons/snack.svg',

    // Food categories
    'protein': 'assets/icons/protein.svg',
    'vegetables': 'assets/icons/vegetables.svg',
    'fruits': 'assets/icons/fruits.svg',
    'grains': 'assets/icons/breakfast.svg',
    'dairy': 'assets/icons/breakfast.svg',
    'nuts': 'assets/icons/snack.svg',

    // Specific foods
    'salmon': 'assets/icons/protein.svg',
    'chicken': 'assets/icons/protein.svg',
    'beef': 'assets/icons/protein.svg',
    'fish': 'assets/icons/protein.svg',
    'eggs': 'assets/icons/protein.svg',
    'milk': 'assets/icons/breakfast.svg',
    'yogurt': 'assets/icons/breakfast.svg',
    'cheese': 'assets/icons/breakfast.svg',
    'bread': 'assets/icons/breakfast.svg',
    'rice': 'assets/icons/breakfast.svg',
    'pasta': 'assets/icons/breakfast.svg',
    'salad': 'assets/icons/vegetables.svg',
    'apple': 'assets/icons/fruits.svg',
    'banana': 'assets/icons/fruits.svg',
    'orange': 'assets/icons/fruits.svg',
    'carrot': 'assets/icons/vegetables.svg',
    'broccoli': 'assets/icons/vegetables.svg',
    'spinach': 'assets/icons/vegetables.svg',
    'cake': 'assets/icons/snack.svg',
    'pie': 'assets/icons/snack.svg',
  };

  static String getIconPath(String mealName) {
    final normalizedName = mealName.toLowerCase().trim();

    // Direct match
    if (mealIcons.containsKey(normalizedName)) {
      return mealIcons[normalizedName]!;
    }

    // Partial match
    for (final entry in mealIcons.entries) {
      if (normalizedName.contains(entry.key) ||
          entry.key.contains(normalizedName)) {
        return entry.value;
      }
    }

    // Default fallback based on meal time patterns
    if (normalizedName.contains('breakfast') ||
        normalizedName.contains('morning')) {
      return 'assets/icons/breakfast.svg';
    } else if (normalizedName.contains('lunch') ||
        normalizedName.contains('noon')) {
      return 'assets/icons/lunch.svg';
    } else if (normalizedName.contains('dinner') ||
        normalizedName.contains('evening')) {
      return 'assets/icons/dinner.svg';
    } else if (normalizedName.contains('snack') ||
        normalizedName.contains('between')) {
      return 'assets/icons/snack.svg';
    }

    // Default fallback
    return 'assets/icons/breakfast.svg';
  }

  static List<String> getMealList() {
    return mealIcons.keys.toList();
  }
}
