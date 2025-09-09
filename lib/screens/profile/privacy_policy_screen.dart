import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/common_widgets.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          'Privacy Policy',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            CommonCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Privacy Policy',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Last updated: January 15, 2024',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'This Privacy Policy describes how Fitify collects, uses, and protects your personal information when you use our fitness tracking application.',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Information We Collect
            _buildSection('Information We Collect', [
              'Personal Information: Name, email address, date of birth, gender, height, weight, and profile picture.',
              'Health Data: Workout history, meal logs, sleep patterns, heart rate, and other fitness metrics.',
              'Device Information: Device type, operating system, app version, and unique device identifiers.',
              'Usage Data: How you interact with our app, features used, and time spent in the app.',
              'Location Data: Optional location information for workout tracking and weather-based recommendations.',
            ]),

            // How We Use Your Information
            _buildSection('How We Use Your Information', [
              'Provide personalized fitness recommendations and workout plans.',
              'Track your progress and generate health reports.',
              'Send you notifications about workouts, meals, and health tips.',
              'Improve our app features and user experience.',
              'Provide customer support and respond to your inquiries.',
              'Ensure app security and prevent fraud.',
            ]),

            // Information Sharing
            _buildSection('Information Sharing', [
              'We do not sell, trade, or rent your personal information to third parties.',
              'We may share anonymized, aggregated data for research and analytics purposes.',
              'We may share information with service providers who help us operate our app.',
              'We may disclose information if required by law or to protect our rights.',
              'We may share information in case of a business merger or acquisition.',
            ]),

            // Data Security
            _buildSection('Data Security', [
              'We use industry-standard encryption to protect your data.',
              'Your data is stored on secure servers with restricted access.',
              'We regularly update our security measures to protect against threats.',
              'We use secure authentication methods to verify your identity.',
              'We monitor our systems for suspicious activity.',
            ]),

            // Your Rights
            _buildSection('Your Rights', [
              'Access: You can view and download your personal data at any time.',
              'Correction: You can update or correct your information in the app settings.',
              'Deletion: You can request deletion of your account and associated data.',
              'Portability: You can export your data in a standard format.',
              'Opt-out: You can disable notifications and data collection features.',
              'Complaint: You can file a complaint with relevant data protection authorities.',
            ]),

            // Data Retention
            _buildSection('Data Retention', [
              'We retain your personal information as long as your account is active.',
              'Health and fitness data is kept for analysis and progress tracking.',
              'We may retain certain information for legal and regulatory compliance.',
              'You can request data deletion at any time through the app.',
              'Deleted data is permanently removed from our systems within 30 days.',
            ]),

            // Children\'s Privacy
            _buildSection('Children\'s Privacy', [
              'Our app is not intended for children under 13 years of age.',
              'We do not knowingly collect personal information from children under 13.',
              'If we discover we have collected data from a child under 13, we will delete it immediately.',
              'Parents can contact us to review or delete their child\'s information.',
              'We recommend parental supervision for users under 18.',
            ]),

            // International Transfers
            _buildSection('International Data Transfers', [
              'Your data may be transferred to and processed in countries other than your own.',
              'We ensure appropriate safeguards are in place for international transfers.',
              'We comply with applicable data protection laws in all jurisdictions.',
              'We use standard contractual clauses approved by relevant authorities.',
              'You can contact us for more information about data transfer safeguards.',
            ]),

            // Changes to Privacy Policy
            _buildSection('Changes to This Privacy Policy', [
              'We may update this Privacy Policy from time to time.',
              'We will notify you of significant changes through the app or email.',
              'Continued use of the app after changes constitutes acceptance.',
              'We recommend reviewing this policy periodically.',
              'Previous versions are available upon request.',
            ]),

            // Contact Information
            CommonCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contact Us',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'If you have any questions about this Privacy Policy or our data practices, please contact us:',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildContactInfo('Email', 'privacy@fitify.com'),
                  _buildContactInfo('Phone', '+1-555-FITIFY'),
                  _buildContactInfo(
                    'Address',
                    '123 Fitness Street\nHealth City, HC 12345',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<String> points) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: CommonCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            ...points.map((point) => _buildBulletPoint(point)),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8, right: 12),
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Color(0xFF6B73FF),
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey.shade700,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: const Color(0xFF6B73FF),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
