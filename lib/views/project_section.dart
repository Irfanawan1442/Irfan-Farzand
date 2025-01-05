import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'about_view.dart';
import 'experience_section.dart';

class ProjectItem {
  final String title;
  final String description;
  final String imageUrl;
  final List<String> technologies;
  final String? demoUrl;
  final String? githubUrl;

  ProjectItem({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.technologies,
    this.demoUrl,
    this.githubUrl,
  });
}

// Sample Data
final List<ProjectItem> projects = [
  ProjectItem(
    title: 'E-Commerce App',
    description: 'A full-featured e-commerce application with clean architecture',
    imageUrl: 'assets/images/project1.jpg',
    technologies: ['Flutter', 'Firebase', 'Riverpod'],
    demoUrl: 'https://example.com/demo',
    githubUrl: 'https://github.com/example/project',
  ),
  // Add more projects...
];

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({Key? key}) : super(key: key);

  Widget _buildProjectCard(ProjectItem project) {
    return Card(
      elevation: 8,
      shadowColor: Colors.blue.withOpacity(0.2),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: project.imageUrl,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[850]!,
                      highlightColor: Colors.grey[800]!,
                      child: Container(
                        height: 150,
                        color: Colors.white,
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 150,
                      color: Colors.grey[850],
                      child: const Icon(Icons.error),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Project Title
                  Text(
                    project.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // Project Description
                  Text(
                    project.description,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),

                  // Technologies
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: project.technologies.map((tech) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.blue.withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        tech,
                        style: TextStyle(
                          color: Colors.blue[300],
                          fontSize: 12,
                        ),
                      ),
                    )).toList(),
                  ),
                  const SizedBox(height: 12),

                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (project.githubUrl != null)
                        IconButton(
                          icon: const Icon(Icons.code, color: Colors.white70),
                          onPressed: () => launch(project.githubUrl!),
                          tooltip: 'View Code',
                        ),
                      if (project.demoUrl != null)
                        IconButton(
                          icon: const Icon(Icons.launch, color: Colors.white70),
                          onPressed: () => launch(project.demoUrl!),
                          tooltip: 'Live Demo',
                        ),
                    ],
                  ),
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
    return LayoutBuilder(
      builder: (context, constraints) {
        // Adjust the number of columns based on the screen width
        int crossAxisCount = 2; // Default for larger screens
        if (constraints.maxWidth < 600) {
          crossAxisCount = 1; // Single column for small screens
        } else if (constraints.maxWidth < 1200) {
          crossAxisCount = 2; // Two columns for medium screens
        } else {
          crossAxisCount = 3; // Three columns for large screens
        }

        return AnimationLimiter(
          child: GridView.builder(
            padding: const EdgeInsets.all(20),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 0.8,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                columnCount: crossAxisCount,
                duration: const Duration(milliseconds: 500),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: _buildProjectCard(projects[index]),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
