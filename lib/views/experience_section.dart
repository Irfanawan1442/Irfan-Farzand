import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ExperienceItem {
  final String period;
  final String duration;
  final String role;
  final String company;
  final List<String> achievements;
  final Color accentColor;

  ExperienceItem({
    required this.period,
    required this.duration,
    required this.role,
    required this.company,
    required this.achievements,
    this.accentColor = Colors.blue,
  });
}

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({Key? key}) : super(key: key);

  Widget _buildExperienceCard(ExperienceItem item) {
    return Card(
      elevation: 8,
      shadowColor: item.accentColor.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.grey.shade900,
              Colors.grey.shade800,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              top: -20,
              child: Icon(
                Icons.work_outline,
                size: 100,
                color: item.accentColor.withOpacity(0.1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Period and Duration
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.period,
                        style: TextStyle(
                          color: item.accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: item.accentColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          item.duration,
                          style: TextStyle(
                            color: item.accentColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Role and Company
                  Text(
                    item.role,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    item.company,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Achievements
                  ...item.achievements.map((achievement) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.arrow_right,
                          color: item.accentColor,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            achievement,
                            style: TextStyle(
                              color: Colors.grey[300],
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // List of Experience Items
    final experienceItems = [
      ExperienceItem(
        period: 'Jan 2025 - Present',
        duration: '6 Months',
        role: 'Flutter Developer',
        company: 'University CMS Portal',
        achievements: [
          'Developed a CMS portal using Flutter',
          'Integrated APIs and Firebase for real-time data management',
          'Worked with SQLite for local storage of user data',
          'Implemented FCM for push notifications',
          'Followed MVC  architectures for code structure'
        ],
        accentColor: Colors.blueAccent,
      ),

    ];

    return AnimationLimiter(
      child: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: experienceItems.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 500),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: _buildExperienceCard(experienceItems[index]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
