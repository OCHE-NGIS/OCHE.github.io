import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeSection extends StatefulWidget {
  final Function()? onExplorePressed;

  const HomeSection({super.key, this.onExplorePressed});

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> with SingleTickerProviderStateMixin {
  late AnimationController _backgroundController;
  late Animation<Color?> _backgroundAnimation;

  @override
  void initState() {
    super.initState();
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(reverse: true);

    _backgroundAnimation = TweenSequence<Color?>([
      TweenSequenceItem(
        tween: ColorTween(
          begin: Colors.blue.shade50,
          end: Colors.blue.shade100,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: ColorTween(
          begin: Colors.blue.shade100,
          end: Colors.blue.shade50,
        ),
        weight: 1,
      ),
    ]).animate(_backgroundController);
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _backgroundAnimation,
      builder: (context, child) {
        return Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: _backgroundAnimation.value,
          ),
          child: child,
        );
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DefaultTextStyle(
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    "Hi, I'm OCHE",
                    speed: const Duration(milliseconds: 200),
                  ),
                ],
                isRepeatingAnimation: false,
              ),
            ),
            const SizedBox(height: 24),
            Animate(
              effects: const [
                FadeEffect(delay: Duration(milliseconds: 800)),
                SlideEffect(
                  begin: Offset(0, 20),
                  end: Offset(0, 0),
                  delay: Duration(milliseconds: 800),
                ),
              ],
              child: Text(
                "I craft AI-driven startups, trade forex with precision,\nand design innovative products",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.black54,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 48),
            Animate(
              effects: const [
                FadeEffect(delay: Duration(milliseconds: 1200)),
                ScaleEffect(
                  begin: Offset(0.95, 0.95),
                  end: Offset(1, 1),
                  delay: Duration(milliseconds: 1200),
                ),
              ],
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: widget.onExplorePressed,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade700,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.shade200,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Text(
                      "Explore My Work",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ).animate(
                    onPlay: (controller) => controller.repeat(reverse: true),
                  ).scale(
                    begin: const Offset(1, 1),
                    end: const Offset(1.05, 1.05),
                    duration: const Duration(seconds: 2),
                    curve: Curves.easeInOut,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}