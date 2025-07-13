import 'package:flutter/material.dart';

class SocialLoginButtons extends StatelessWidget {
  final VoidCallback onGoogle;
  final VoidCallback onApple;
  final bool isLoading;

  const SocialLoginButtons({
    super.key,
    required this.onGoogle,
    required this.onApple,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: isLoading ? null : onGoogle,
          icon: const Icon(Icons.account_circle),
          label: const Text('Sign in with Google'),
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: isLoading ? null : onApple,
          icon: const Icon(Icons.apple),
          label: const Text('Sign in with Apple'),
        ),
      ],
    );
  }
} 