import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/auth/auth_form.dart';
import '../../widgets/auth/social_login_buttons.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AuthForm(
              buttonText: 'Sign In',
              isLoading: authProvider.isLoading,
              onSubmit: (email, password) async {
                await authProvider.signIn(email, password);
                if (authProvider.isLoggedIn) {
                  Navigator.pushReplacementNamed(context, '/profile');
                } else if (authProvider.error != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(authProvider.error!)),
                  );
                }
              },
            ),
            const SizedBox(height: 16),
            SocialLoginButtons(
              isLoading: authProvider.isLoading,
              onGoogle: () {
                // TODO: Implement Google sign-in
              },
              onApple: () {
                // TODO: Implement Apple sign-in
              },
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/signup');
              },
              child: const Text('Don\'t have an account? Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
} 