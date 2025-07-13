import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class GlowingMicButton extends StatefulWidget {
  final VoidCallback? onTap;
  final double size;
  const GlowingMicButton({super.key, this.onTap, this.size = 120});

  @override
  State<GlowingMicButton> createState() => _GlowingMicButtonState();
}

class _GlowingMicButtonState extends State<GlowingMicButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _glowAnim = Tween<double>(begin: 0.7, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _glowAnim,
        builder: (context, child) {
          return Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.neonPink.withValues(alpha: 0.5),
                  AppColors.neonPurple.withValues(alpha: 0.7),
                  AppColors.neonBlue.withValues(alpha: 0.3),
                  Colors.transparent,
                ],
                stops: [0.3, 0.7, 0.9, 1.0],
                radius: _glowAnim.value,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.neonPink.withValues(alpha: 0.5),
                  blurRadius: 32 * _glowAnim.value,
                  spreadRadius: 8 * _glowAnim.value,
                ),
                BoxShadow(
                  color: AppColors.neonPurple.withValues(alpha: 0.3),
                  blurRadius: 48 * _glowAnim.value,
                  spreadRadius: 16 * _glowAnim.value,
                ),
              ],
            ),
            child: Center(
              child: Container(
                width: widget.size * 0.55,
                height: widget.size * 0.55,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [AppColors.neonPink, AppColors.neonPurple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.neonPink.withValues(alpha: 0.7),
                      blurRadius: 16,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.mic,
                  color: Colors.white,
                  size: widget.size * 0.32,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
} 