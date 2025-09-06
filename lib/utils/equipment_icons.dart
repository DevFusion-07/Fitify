class EquipmentIcons {
  static const Map<String, String> equipmentIcons = {
    // Weight training equipment
    'barbell': 'assets/icons/barbell.svg',
    'dumbbells': 'assets/icons/dumbbell.svg',
    'dumbbell': 'assets/icons/dumbbell.svg',
    'kettlebell': 'assets/icons/dumbbell.svg', // Using dumbbell icon as fallback
    'weight plate': 'assets/icons/barbell.svg',
    'resistance band': 'assets/icons/fitness_center.svg',
    'bench': 'assets/icons/fitness_center.svg',
    
    // Cardio equipment
    'treadmill': 'assets/icons/cardio.svg',
    'exercise bike': 'assets/icons/cardio.svg',
    'elliptical': 'assets/icons/cardio.svg',
    'rowing machine': 'assets/icons/cardio.svg',
    'skipping rope': 'assets/icons/skipping_rope.svg',
    'jump rope': 'assets/icons/skipping_rope.svg',
    
    // Yoga and flexibility
    'yoga mat': 'assets/icons/yoga_mat.svg',
    'mat': 'assets/icons/yoga_mat.svg',
    'foam roller': 'assets/icons/fitness_center.svg',
    'stretching band': 'assets/icons/fitness_center.svg',
    
    // Hydration and accessories
    'water bottle': 'assets/icons/water_bottle.svg',
    'bottle': 'assets/icons/water_bottle.svg',
    'timer': 'assets/icons/timer.svg',
    'stopwatch': 'assets/icons/timer.svg',
    'heart rate monitor': 'assets/icons/timer.svg',
    
    // Bodyweight (no equipment)
    'no equipment': 'assets/icons/fitness_center.svg',
    'bodyweight': 'assets/icons/fitness_center.svg',
    'none': 'assets/icons/fitness_center.svg',
  };

  static String getIconPath(String equipmentName) {
    final normalizedName = equipmentName.toLowerCase().trim();
    
    // Direct match
    if (equipmentIcons.containsKey(normalizedName)) {
      return equipmentIcons[normalizedName]!;
    }
    
    // Partial match
    for (final entry in equipmentIcons.entries) {
      if (normalizedName.contains(entry.key) || entry.key.contains(normalizedName)) {
        return entry.value;
      }
    }
    
    // Default fallback
    return 'assets/icons/fitness_center.svg';
  }

  static List<String> getEquipmentList() {
    return equipmentIcons.keys.toList();
  }
}
