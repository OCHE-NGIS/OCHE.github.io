import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'sections/home_section.dart';
import 'sections/about_section.dart';
import 'sections/forex_section.dart';
import 'sections/projects_section.dart';
import 'sections/vision_section.dart';
import 'sections/contact_section.dart';

void main() {
  Animate.restartOnHotReload = true;
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OCHE - Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _projectsKey = GlobalKey();
  
  void _scrollToProjects() {
    final RenderBox renderBox = 
        _projectsKey.currentContext?.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    
    _scrollController.animateTo(
      position.dy,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            HomeSection(onExplorePressed: _scrollToProjects),
            AboutSection(),
            const ForexSection(),
            Container(key: _projectsKey, child: ProjectsSection()),
            const VisionSection(),
            const ContactSection(),
          ],
        ),
      ),
    );
  }
}
