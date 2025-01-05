import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SkillsSection extends ConsumerWidget {
  const SkillsSection({Key? key}) : super(key: key);

  Widget _buildSkillCard(String skillName, double level, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.grey.shade800,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              skillName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: level / 100,
                minHeight: 8,
                backgroundColor: Colors.grey.shade900,
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '${level.toInt()}%',
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCertificateCard(Map<String, dynamic> certificate, int index) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.grey.shade800,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              certificate['color'] as Color,
              (certificate['color'] as Color).withOpacity(0.2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              certificate['icon'] as IconData,
              color: Colors.white,
              size: 30,
            ),
            const SizedBox(height: 15),
            Text(
              certificate['name'] as String,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              certificate['issuer'] as String,
              style: TextStyle(
                color: Colors.grey.shade300,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              certificate['date'] as String,
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    ).animate(delay: (100 * index).ms).slideY().fadeIn();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final technicalSkills = [
      {'name': 'Flutter/Dart', 'level': 85.0, 'color': Colors.blue},
      {'name': 'Python', 'level': 80.0, 'color': Colors.green},
      {'name': 'React.js', 'level': 75.0, 'color': Colors.cyan},
      {'name': 'JavaScript', 'level': 70.0, 'color': Colors.yellow},
      {'name': 'HTML/CSS', 'level': 85.0, 'color': Colors.orange},
    ];

    final softSkills = [
      {'name': 'Problem Solving', 'level': 90.0, 'color': Colors.purple},
      {'name': 'Communication', 'level': 85.0, 'color': Colors.pink},
      {'name': 'Team Collaboration', 'level': 80.0, 'color': Colors.teal},
    ];

    final certificates = [
      {
        'name': 'Flutter Development Bootcamp',
        'issuer': 'Udemy',
        'date': '2023',
        'icon': Icons.code,
        'color': Colors.blue,
      },
      {
        'name': 'Python Professional Certification',
        'issuer': 'Python Institute',
        'date': '2023',
        'icon': Icons.psychology,
        'color': Colors.green,
      },
      {
        'name': 'Web Development Certification',
        'issuer': 'FreeCodeCamp',
        'date': '2023',
        'icon': Icons.web,
        'color': Colors.orange,
      },
    ];

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.blue, Colors.purple],
                  ).createShader(bounds),
                  child: const Text(
                    'Skills & Certificates',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: Colors.white,
                    ),
                  ),
                ).animate().slideX().fadeIn(),
                const SizedBox(height: 30),

                // Technical Skills Section
                const Text(
                  'Technical Skills',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ).animate().slideX().fadeIn(),
                const SizedBox(height: 20),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: technicalSkills.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemBuilder: (context, index) => _buildSkillCard(
                    technicalSkills[index]['name'] as String,
                    technicalSkills[index]['level'] as double,
                    technicalSkills[index]['color'] as Color,
                  ).animate(delay: (100 * index).ms).slideX().fadeIn(),
                ),

                const SizedBox(height: 30),

                // Soft Skills Section
                const Text(
                  'Soft Skills',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ).animate().slideX().fadeIn(),
                const SizedBox(height: 20),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: softSkills.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemBuilder: (context, index) => _buildSkillCard(
                    softSkills[index]['name'] as String,
                    softSkills[index]['level'] as double,
                    softSkills[index]['color'] as Color,
                  ).animate(delay: (100 * index).ms).slideX().fadeIn(),
                ),

                const SizedBox(height: 30),

                // Certificates Section
                const Text(
                  'Certificates',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ).animate().slideX().fadeIn(),
                const SizedBox(height: 20),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: certificates.length,
                  itemBuilder: (context, index) => _buildCertificateCard(
                    certificates[index],
                    index,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}