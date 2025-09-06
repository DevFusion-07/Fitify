import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Notification",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNotificationItem(
            icon: _buildFoodIcon(),
            message: "Hey, It's time for lunch",
            timestamp: "About 1 minutes ago",
          ),
          const SizedBox(height: 16),
          _buildNotificationItem(
            icon: _buildWorkoutIcon(),
            message: "Don't miss your lowerbody workout",
            timestamp: "About 3 hours ago",
          ),
          const SizedBox(height: 16),
          _buildNotificationItem(
            icon: _buildPancakeIcon(),
            message: "Hey, let's add some meals for your b...",
            timestamp: "About 3 hours ago",
          ),
          const SizedBox(height: 16),
          _buildNotificationItem(
            icon: _buildCelebrationIcon(),
            message: "Congratulations, You have finished A...",
            timestamp: "29 May",
          ),
          const SizedBox(height: 16),
          _buildNotificationItem(
            icon: _buildPlainIcon(),
            message: "Hey, it's time for lunch",
            timestamp: "8 April",
          ),
          const SizedBox(height: 16),
          _buildNotificationItem(
            icon: _buildWorkoutIcon(),
            message: "Ups, You have missed your Lowerbo...",
            timestamp: "3 April",
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem({
    required Widget icon,
    required String message,
    required String timestamp,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          // Icon container
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
            ),
            child: icon,
          ),
          const SizedBox(width: 16),
          // Message and timestamp
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  timestamp,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          // Options icon
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: Colors.grey,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodIcon() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFE4B5),
        borderRadius: BorderRadius.circular(25),
      ),
      child: const Center(
        child: Icon(
          Icons.restaurant,
          color: Color(0xFFFF8C00),
          size: 24,
        ),
      ),
    );
  }

  Widget _buildWorkoutIcon() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(25),
      ),
      child: const Center(
        child: Icon(
          Icons.fitness_center,
          color: Color(0xFF1976D2),
          size: 24,
        ),
      ),
    );
  }

  Widget _buildPancakeIcon() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(25),
      ),
      child: const Center(
        child: Icon(
          Icons.cake,
          color: Color(0xFFFFB300),
          size: 24,
        ),
      ),
    );
  }

  Widget _buildCelebrationIcon() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E8),
        borderRadius: BorderRadius.circular(25),
      ),
      child: const Center(
        child: Icon(
          Icons.celebration,
          color: Color(0xFF4CAF50),
          size: 24,
        ),
      ),
    );
  }

  Widget _buildPlainIcon() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(25),
      ),
      child: const Center(
        child: Icon(
          Icons.notifications,
          color: Color(0xFF1976D2),
          size: 24,
        ),
      ),
    );
  }
}
