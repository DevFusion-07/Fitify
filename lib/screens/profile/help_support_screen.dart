import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/common_widgets.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'All';

  final List<Map<String, dynamic>> _faqItems = [
    {
      'category': 'Getting Started',
      'question': 'How do I create an account?',
      'answer':
          'To create an account, tap "Sign Up" on the login screen, enter your email and password, and follow the verification steps.',
    },
    {
      'category': 'Getting Started',
      'question': 'How do I set up my profile?',
      'answer':
          'After creating an account, you\'ll be guided through setting up your profile including personal information, fitness goals, and preferences.',
    },
    {
      'category': 'Getting Started',
      'question': 'How do I track my first workout?',
      'answer':
          'Go to the Workout tab, select a workout plan, and follow the guided exercises. The app will automatically track your progress.',
    },
    {
      'category': 'Workouts',
      'question': 'How do I customize my workout plan?',
      'answer':
          'Go to Settings > Workout Preferences to customize your workout plan, set goals, and adjust difficulty levels.',
    },
    {
      'category': 'Workouts',
      'question': 'Can I add custom exercises?',
      'answer':
          'Yes, you can add custom exercises by going to the workout screen and tapping the "+" button to add your own exercises.',
    },
    {
      'category': 'Workouts',
      'question': 'How do I track my progress?',
      'answer':
          'Your progress is automatically tracked in the Progress tab. You can view detailed statistics, charts, and achievements.',
    },
    {
      'category': 'Nutrition',
      'question': 'How do I log my meals?',
      'answer':
          'Go to the Meal tab, select the meal type (breakfast, lunch, dinner, snack), and search for or add your food items.',
    },
    {
      'category': 'Nutrition',
      'question': 'How accurate are the calorie counts?',
      'answer':
          'Our calorie database is regularly updated and verified. However, individual results may vary based on preparation methods.',
    },
    {
      'category': 'Nutrition',
      'question': 'Can I create custom meal plans?',
      'answer':
          'Yes, you can create custom meal plans by going to Meal Planners and selecting "Create Custom Plan".',
    },
    {
      'category': 'Sleep',
      'question': 'How do I track my sleep?',
      'answer':
          'Go to the Sleep tab and tap "Start Sleep Tracking" before bed. The app will track your sleep duration and quality.',
    },
    {
      'category': 'Sleep',
      'question': 'What sleep metrics are tracked?',
      'answer':
          'We track sleep duration, sleep quality, bedtime consistency, and provide insights to improve your sleep habits.',
    },
    {
      'category': 'Account',
      'question': 'How do I change my password?',
      'answer':
          'Go to Settings > Account > Change Password. Enter your current password and create a new one.',
    },
    {
      'category': 'Account',
      'question': 'How do I sync my data across devices?',
      'answer':
          'Your data automatically syncs when you log in with the same account on different devices. Make sure you\'re connected to the internet.',
    },
    {
      'category': 'Account',
      'question': 'How do I delete my account?',
      'answer':
          'Go to Settings > Account Actions > Delete Account. This action is permanent and cannot be undone.',
    },
    {
      'category': 'Technical',
      'question': 'The app is running slowly. What should I do?',
      'answer':
          'Try closing and reopening the app, clearing the cache in Settings, or restarting your device.',
    },
    {
      'category': 'Technical',
      'question': 'I\'m not receiving notifications. How do I fix this?',
      'answer':
          'Check your device\'s notification settings for Fitify and ensure notifications are enabled in the app settings.',
    },
    {
      'category': 'Technical',
      'question': 'How do I update the app?',
      'answer':
          'Go to your device\'s app store (Google Play or App Store) and check for updates. Install any available updates.',
    },
  ];

  final List<String> _categories = [
    'All',
    'Getting Started',
    'Workouts',
    'Nutrition',
    'Sleep',
    'Account',
    'Technical',
  ];

  List<Map<String, dynamic>> get _filteredFAQs {
    List<Map<String, dynamic>> filtered = _faqItems;

    // Filter by category
    if (_selectedCategory != 'All') {
      filtered = filtered
          .where((item) => item['category'] == _selectedCategory)
          .toList();
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((item) {
        return item['question'].toLowerCase().contains(
              _searchQuery.toLowerCase(),
            ) ||
            item['answer'].toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    return filtered;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          'Help & Support',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search for help...',
                prefixIcon: const Icon(Icons.search, color: Color(0xFF6B73FF)),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF6B73FF)),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),

          // Category Filter
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategory == category;

                return Container(
                  margin: const EdgeInsets.only(right: 12),
                  child: FilterChip(
                    label: Text(
                      category,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? Colors.white : Colors.grey.shade600,
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    backgroundColor: Colors.white,
                    selectedColor: const Color(0xFF6B73FF),
                    checkmarkColor: Colors.white,
                    side: BorderSide(
                      color: isSelected
                          ? const Color(0xFF6B73FF)
                          : Colors.grey.shade300,
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // Quick Help Section
          if (_searchQuery.isEmpty && _selectedCategory == 'All')
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: CommonCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quick Help',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildQuickHelpItem(
                      'Getting Started Guide',
                      'Learn the basics of using Fitify',
                      Icons.play_circle,
                      () => _showGettingStartedGuide(),
                    ),
                    _buildQuickHelpItem(
                      'Video Tutorials',
                      'Watch step-by-step tutorials',
                      Icons.video_library,
                      () => _showVideoTutorials(),
                    ),
                    _buildQuickHelpItem(
                      'Contact Support',
                      'Get help from our support team',
                      Icons.support_agent,
                      () => Navigator.pushNamed(context, '/contact-us'),
                    ),
                  ],
                ),
              ),
            ),

          const SizedBox(height: 20),

          // FAQ List
          Expanded(
            child: _filteredFAQs.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No results found',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try adjusting your search or filters',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _filteredFAQs.length,
                    itemBuilder: (context, index) {
                      final faq = _filteredFAQs[index];
                      return _buildFAQItem(faq);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickHelpItem(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFF6B73FF).withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(icon, color: const Color(0xFF6B73FF), size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem(Map<String, dynamic> faq) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        title: Text(
          faq['question'] as String,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          faq['category'] as String,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: const Color(0xFF6B73FF),
            fontWeight: FontWeight.w500,
          ),
        ),
        iconColor: const Color(0xFF6B73FF),
        collapsedIconColor: Colors.grey.shade400,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              faq['answer'] as String,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey.shade700,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showGettingStartedGuide() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Getting Started Guide',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),

                    _buildGuideStep(
                      '1',
                      'Create Your Account',
                      'Sign up with your email address and create a secure password.',
                    ),
                    _buildGuideStep(
                      '2',
                      'Complete Your Profile',
                      'Add your personal information, fitness goals, and preferences.',
                    ),
                    _buildGuideStep(
                      '3',
                      'Choose Your Workout Plan',
                      'Select a workout plan that matches your fitness level and goals.',
                    ),
                    _buildGuideStep(
                      '4',
                      'Start Tracking',
                      'Begin logging your workouts, meals, and sleep to track your progress.',
                    ),
                    _buildGuideStep(
                      '5',
                      'Stay Consistent',
                      'Use the app daily to build healthy habits and achieve your goals.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuideStep(String number, String title, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFF6B73FF),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showVideoTutorials() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Video tutorials are coming soon!'),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
