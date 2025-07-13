import 'package:flutter/material.dart';

class TypingIndicator extends StatefulWidget {
  final double screenWidth;
  final bool isVisible;

  const TypingIndicator({
    super.key,
    required this.screenWidth,
    this.isVisible = false,
  });

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(3, (index) {
      return AnimationController(
        duration: Duration(milliseconds: 600 + (index * 200)),
        vsync: this,
      );
    });

    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      );
    }).toList();

    _startAnimation();
  }

  void _startAnimation() {
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 200), () {
        if (mounted) {
          _controllers[i].repeat(reverse: true);
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isVisible) return const SizedBox.shrink();

    final dotSize = widget.screenWidth * 0.02; // Responsive dot size
    final containerSize = widget.screenWidth * 0.08; // Responsive container size

    return Container(
      margin: EdgeInsets.only(
        left: widget.screenWidth * 0.02,
        bottom: widget.screenWidth * 0.02,
      ),
      padding: EdgeInsets.all(widget.screenWidth * 0.025),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(containerSize / 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (index) {
          return AnimatedBuilder(
            animation: _animations[index],
            builder: (context, child) {
              return Container(
                width: dotSize * (0.5 + (_animations[index].value * 0.5)),
                height: dotSize * (0.5 + (_animations[index].value * 0.5)),
                margin: EdgeInsets.symmetric(horizontal: dotSize * 0.3),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  shape: BoxShape.circle,
                ),
              );
            },
          );
        }),
      ),
    );
  }
} 