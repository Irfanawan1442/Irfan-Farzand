import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeline_tile/timeline_tile.dart';

class AboutSection extends ConsumerWidget {
  const AboutSection({Key? key}) : super(key: key);

  Widget _buildKeyMetrics() {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Key Metrics',
            style: TextStyle(
              fontSize: 20,
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
              childAspectRatio: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              final metrics = [
                {'title': '1', 'subtitle': 'Projects Completed', 'icon': Icons.rocket_launch, 'color': Colors.orange},
                {'title': '1', 'subtitle': 'University Project', 'icon': Icons.school, 'color': Colors.green},
                {'title': '1', 'subtitle': 'Awards Won', 'icon': Icons.emoji_events, 'color': Colors.purple},
                {'title': '1 yr', 'subtitle': 'Experience', 'icon': Icons.code, 'color': Colors.blue},
              ];

              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                color: Colors.grey.shade800,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [
                        metrics[index]['color'] as Color,
                        (metrics[index]['color'] as Color).withOpacity(0.2),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        metrics[index]['icon'] as IconData,
                        color: Colors.white,
                        size: 28,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        metrics[index]['title'] as String,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        metrics[index]['subtitle'] as String,
                        style: TextStyle(
                          color: Colors.grey.shade300,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ).animate(delay: (100 * index).ms).slideY().fadeIn();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedTimeline() {
    final timelineItems = [
      {
        'year': '2024',
        'title': 'Flutter & Python Developer',
        'company': 'Current',
        'description': 'Working on Flutter and Python projects while pursuing university studies.',
      },

      {
        'year': '2023',
        'title': 'University Project',
        'company': 'University',
        'description': 'Completed production-level project as part of university CMS Portal.',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Journey',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ).animate().slideX().fadeIn(),
        const SizedBox(height: 20),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: timelineItems.length,
          itemBuilder: (context, index) {
            final item = timelineItems[index];
            return TimelineTile(
              alignment: TimelineAlign.manual,
              lineXY: 0.2,
              isFirst: index == 0,
              isLast: index == timelineItems.length - 1,
              indicatorStyle: IndicatorStyle(
                width: 40,
                height: 40,
                indicator: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.purple],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      item['year']!.substring(2),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              beforeLineStyle: const LineStyle(color: Colors.blue),
              endChild: Container(
                constraints: const BoxConstraints(minHeight: 120),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Card(
                  elevation: 4,
                  color: Colors.grey.shade800,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title']!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          item['company']!,
                          style: TextStyle(
                            color: Colors.blue.shade300,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item['description']!,
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ).animate(delay: (200 * index).ms).slideX().fadeIn();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    'About Me',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: Colors.white,
                    ),
                  ),
                ).animate().slideX().fadeIn(),
                const SizedBox(height: 30),
                Card(
                  elevation: 8,
                  shadowColor: Colors.blue.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.code, color: Colors.blue),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '1 Year Experience',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue.shade300,
                                    ),
                                  ),
                                  Text(
                                    'Flutter, Dart & Python Development',
                                    style: TextStyle(
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Student developer passionate about creating efficient applications using Flutter and Python. Experienced in building production-ready university projects and client work, with a focus on clean code and user experience.',
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.6,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        _buildKeyMetrics(),
                      ],
                    ),
                  ),
                ).animate().scale().fadeIn(),
                const SizedBox(height: 30),
                _buildEnhancedTimeline(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}