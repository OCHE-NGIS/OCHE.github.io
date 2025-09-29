import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Project {
  final String title;
  final String description;
  final String imageUrl;
  final String repoUrl;
  final String demoUrl;
  final List<String> technologies;

  Project({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.repoUrl,
    required this.demoUrl,
    required this.technologies,
  });
}

class ProjectsSection extends StatelessWidget {
  ProjectsSection({super.key});

  final List<Project> projects = [
    Project(
      title: 'FarmWise AI',
      description: 'Revolutionary agricultural AI platform leveraging machine learning for crop optimization and farm management.',
      imageUrl: 'assets/images/farmwise.png', // TODO: Add image
      repoUrl: 'https://github.com/yourusername/farmwise-ai',
      demoUrl: 'https://farmwise.ai',
      technologies: ['Flutter', 'Python', 'TensorFlow', 'AWS'],
    ),
    Project(
      title: 'HORC Trading Platform',
      description: 'Advanced forex trading platform implementing the Hendray Opening Range Concepts strategy with real-time analytics.',
      imageUrl: 'assets/images/horc.png', // TODO: Add image
      repoUrl: 'https://github.com/yourusername/horc-trading',
      demoUrl: 'https://horc-trading.com',
      technologies: ['Python', 'React', 'Node.js', 'WebSocket'],
    ),
    Project(
      title: 'Portfolio Website',
      description: 'Modern, animated portfolio website built with Flutter Web, showcasing advanced animations and responsive design.',
      imageUrl: 'assets/images/portfolio.png', // TODO: Add image
      repoUrl: 'https://github.com/yourusername/portfolio',
      demoUrl: 'https://your-portfolio.com',
      technologies: ['Flutter', 'Dart', 'HTML5', 'CSS3'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            "Featured Projects",
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
          ).animate().fadeIn().slideY(
                begin: 20,
                end: 0,
                curve: Curves.easeOut,
              ),
          const SizedBox(height: 60),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 1200
                  ? 3
                  : constraints.maxWidth > 800
                      ? 2
                      : 1;
              return Wrap(
                spacing: 20,
                runSpacing: 20,
                children: List.generate(
                  projects.length,
                  (index) => SizedBox(
                    width: (constraints.maxWidth / crossAxisCount) - 40,
                    child: _ProjectCard(
                      project: projects[index],
                      index: index,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final Project project;
  final int index;

  const _ProjectCard({
    required this.project,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder for project image
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(
                  Icons.image_outlined,
                  size: 48,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              project.title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              project.description,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.black54,
                    height: 1.5,
                  ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: project.technologies.map((tech) => Chip(
                label: Text(
                  tech,
                  style: const TextStyle(fontSize: 12),
                ),
                backgroundColor: Colors.blue.shade50,
                side: BorderSide.none,
              )).toList(),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                _ProjectButton(
                  label: 'View Repo',
                  icon: Icons.code,
                  onPressed: () {
                    // TODO: Launch repo URL
                  },
                ),
                const SizedBox(width: 12),
                _ProjectButton(
                  label: 'Live Demo',
                  icon: Icons.launch,
                  onPressed: () {
                    // TODO: Launch demo URL
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    )
        .animate(delay: (100 * index).ms)
        .fadeIn(duration: 600.ms)
        .slideX(begin: 30, end: 0, curve: Curves.easeOutQuart);
  }
}

class _ProjectButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const _ProjectButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<_ProjectButton> createState() => _ProjectButtonState();
}

class _ProjectButtonState extends State<_ProjectButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _isHovered ? Colors.blue.shade700 : Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: _isHovered ? Colors.blue.shade700 : Colors.grey.shade300,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 16,
                color: _isHovered ? Colors.white : Colors.blue.shade700,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  color: _isHovered ? Colors.white : Colors.blue.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}