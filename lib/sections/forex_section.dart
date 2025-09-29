import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;

class ForexSection extends StatefulWidget {
  const ForexSection({super.key});

  @override
  State<ForexSection> createState() => _ForexSectionState();
}

class _ForexSectionState extends State<ForexSection> with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _isVisible = true);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      color: Colors.grey.shade50,
      child: Column(
        children: [
          Text(
            "My Forex Trading Career",
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
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Text(
              "For 4-5 years, I've traded forex using the HORC (Hendray Opening Range Concepts) strategy, mastering market analysis and disciplined trading. This journey has not only sharpened my analytical skills but also strengthened my connection to computer science, as I leverage technology to enhance my trading approach.",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.black54,
                    height: 1.6,
                  ),
              textAlign: TextAlign.center,
            ),
          ).animate(target: _isVisible ? 1 : 0).fadeIn(delay: 200.ms).slideY(
                begin: 20,
                end: 0,
                delay: 200.ms,
                curve: Curves.easeOut,
              ),
          const SizedBox(height: 60),
          const CandlestickChart(),
        ],
      ),
    );
  }
}

class CandlestickChart extends StatefulWidget {
  const CandlestickChart({super.key});

  @override
  State<CandlestickChart> createState() => _CandlestickChartState();
}

class _CandlestickChartState extends State<CandlestickChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        height: 300,
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 800),
        child: CustomPaint(
          painter: CandlestickPainter(
            animation: _controller,
            isHovered: _isHovered,
          ),
        ),
      ),
    ).animate().fadeIn(delay: 400.ms).slideY(
          begin: 30,
          end: 0,
          delay: 400.ms,
          curve: Curves.easeOut,
        );
  }
}

class Candle {
  final double open;
  final double high;
  final double low;
  final double close;

  Candle({
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });
}

class CandlestickPainter extends CustomPainter {
  final Animation<double> animation;
  final bool isHovered;

  CandlestickPainter({
    required this.animation,
    required this.isHovered,
  }) : super(repaint: animation);

  final List<Candle> candles = List.generate(
    20,
    (i) {
      final random = math.Random();
      final basePrice = 1.2000 + (random.nextDouble() * 0.1);
      final range = 0.005 + (random.nextDouble() * 0.01);
      final high = basePrice + (random.nextDouble() * range);
      final low = basePrice - (random.nextDouble() * range);
      final open = low + (random.nextDouble() * (high - low));
      final close = low + (random.nextDouble() * (high - low));
      return Candle(
        open: open,
        high: high,
        low: low,
        close: close,
      );
    },
  );

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final candleWidth = size.width / (candles.length * 2);
    final maxPrice = candles.map((c) => c.high).reduce(math.max);
    final minPrice = candles.map((c) => c.low).reduce(math.min);
    final priceRange = maxPrice - minPrice;

    for (var i = 0; i < candles.length; i++) {
      final candle = candles[i];
      final x = (i * candleWidth * 2) + candleWidth;
      
      final progress = animation.value;
      final currentHeight = size.height * progress;

      // Draw price range line
      paint.color = Colors.grey.shade300;
      canvas.drawLine(
        Offset(x, size.height - ((candle.high - minPrice) / priceRange * currentHeight)),
        Offset(x, size.height - ((candle.low - minPrice) / priceRange * currentHeight)),
        paint,
      );

      // Draw candle body
      paint.style = PaintingStyle.fill;
      paint.color = candle.close > candle.open
          ? Colors.green.shade400
          : Colors.red.shade400;

      final rect = Rect.fromLTRB(
        x - candleWidth / 2,
        size.height - ((math.max(candle.open, candle.close) - minPrice) / priceRange * currentHeight),
        x + candleWidth / 2,
        size.height - ((math.min(candle.open, candle.close) - minPrice) / priceRange * currentHeight),
      );

      canvas.drawRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CandlestickPainter oldDelegate) {
    return animation != oldDelegate.animation || isHovered != oldDelegate.isHovered;
  }
}