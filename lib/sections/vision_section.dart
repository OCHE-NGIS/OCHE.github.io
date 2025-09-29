import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class VisionSection extends StatefulWidget {
  const VisionSection({super.key});

  @override
  State<VisionSection> createState() => _VisionSectionState();
}

class _VisionSectionState extends State<VisionSection> with SingleTickerProviderStateMixin {
  late AnimationController _iconController;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _iconController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _isVisible = true);
    });
  }

  @override
  void dispose() {
    _iconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      color: Colors.grey.shade50,
      child: Column(
        children: [
          ScaleTransition(
            scale: Tween<double>(
              begin: 0.95,
              end: 1.05,
            ).animate(
              CurvedAnimation(
                parent: _iconController,
                curve: Curves.easeInOut,
              ),
            ),
            child: Icon(
              Icons.agriculture,
              size: 64,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 40),
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                Text(
                  "Vision",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                ).animate(target: _isVisible ? 1 : 0).fadeIn().slideY(
                      begin: 20,
                      end: 0,
                      curve: Curves.easeOut,
                    ),
                const SizedBox(height: 32),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Building FarmWise AI to revolutionize agriculture through AI and scalable tech.',
                      textAlign: TextAlign.center,
                      textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.black87,
                            height: 1.5,
                          ),
                      speed: const Duration(milliseconds: 50),
                    ),
                  ],
                  isRepeatingAnimation: false,
                  displayFullTextOnTap: true,
                ),
                const SizedBox(height: 24),
                Text(
                  "Empowering industries with intelligent, user-centric solutions.",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.black54,
                        height: 1.5,
                      ),
                  textAlign: TextAlign.center,
                ).animate(target: _isVisible ? 1 : 0).fadeIn(delay: 2.seconds).slideY(
                      begin: 20,
                      end: 0,
                      delay: 2.seconds,
                      curve: Curves.easeOut,
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}