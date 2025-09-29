import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Skill {
  final String name;
  final IconData icon;
  final String description;

  Skill({
    required this.name,
    required this.icon,
    required this.description,
  });
}

class AboutSection extends StatelessWidget {
  AboutSection({super.key});

  final List<Skill> skills = [
    Skill(
      name: 'Flutter Development',
      icon: Icons.flutter_dash,
      description: 'Cross-platform app development with modern UI/UX',
    ),
    Skill(
      name: 'Python & AI',
      icon: Icons.code,
      description: 'AI/ML development and automation',
    ),
    Skill(
      name: 'Business Management',
      icon: Icons.business,
      description: 'Strategic planning and team leadership',
    ),
    Skill(
      name: 'Product Design',
      icon: Icons.design_services,
      description: 'User-centered design and innovation',
    ),
    Skill(
      name: 'Startup Scaling',
      icon: Icons.trending_up,
      description: 'Growth strategies and optimization',
    ),
    Skill(
      name: 'AI Integration',
      icon: Icons.smart_toy,
      description: 'Implementing AI solutions in business',
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
            "Self-taught polymath with a passion for innovation,\nblending code, design, and strategy to build impactful solutions.",
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.black87,
                  height: 1.5,
                ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 200.ms).slideY(
                begin: 20,
                end: 0,
                delay: 200.ms,
                curve: Curves.easeOut,
              ),
          const SizedBox(height: 60),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 1000
                  ? 3
                  : constraints.maxWidth > 600
                      ? 2
                      : 1;
              return Wrap(
                spacing: 20,
                runSpacing: 20,
                children: List.generate(
                  skills.length,
                  (index) => SizedBox(
                    width: (constraints.maxWidth / crossAxisCount) - 40,
                    child: _SkillCard(
                      skill: skills[index],
                      delay: (index * 200).ms,
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

class _SkillCard extends StatelessWidget {
  final Skill skill;
  final Duration delay;

  const _SkillCard({
    required this.skill,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              skill.icon,
              size: 40,
              color: Colors.blue.shade700,
            ),
            const SizedBox(height: 16),
            Text(
              skill.name,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              skill.description,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.black54,
                  ),
            ),
          ],
        ),
      ),
    )
        .animate(delay: delay)
        .fadeIn(duration: 600.ms)
        .slideX(begin: 30, end: 0, curve: Curves.easeOutQuart);
  }
}