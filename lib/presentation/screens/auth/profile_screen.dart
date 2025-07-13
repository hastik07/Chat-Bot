import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _displayNameController = TextEditingController();
  final _avatarUrlController = TextEditingController();

  @override
  void dispose() {
    _displayNameController.dispose();
    _avatarUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;
    if (user == null) {
      Future.microtask(() => Navigator.pushReplacementNamed(context, '/login'));
      return const SizedBox.shrink();
    }
    _displayNameController.text = user.displayName ?? '';
    _avatarUrlController.text = user.avatarUrl ?? '';
    
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;
        
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Profile',
              style: TextStyle(fontSize: screenWidth * 0.045),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(screenWidth * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.05),
                CircleAvatar(
                  radius: screenWidth * 0.1,
                  backgroundImage: user.avatarUrl != null && user.avatarUrl!.isNotEmpty
                      ? NetworkImage(user.avatarUrl!)
                      : null,
                  child: user.avatarUrl == null || user.avatarUrl!.isEmpty
                      ? Icon(Icons.person, size: screenWidth * 0.08)
                      : null,
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  user.email,
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                TextField(
                  controller: _displayNameController,
                  decoration: InputDecoration(
                    labelText: 'Display Name',
                    labelStyle: TextStyle(fontSize: screenWidth * 0.035),
                  ),
                  style: TextStyle(fontSize: screenWidth * 0.035),
                ),
                SizedBox(height: screenHeight * 0.02),
                TextField(
                  controller: _avatarUrlController,
                  decoration: InputDecoration(
                    labelText: 'Avatar URL',
                    labelStyle: TextStyle(fontSize: screenWidth * 0.035),
                  ),
                  style: TextStyle(fontSize: screenWidth * 0.035),
                ),
                SizedBox(height: screenHeight * 0.04),
                SizedBox(
                  width: double.infinity,
                  height: screenHeight * 0.06,
                  child: ElevatedButton(
                    onPressed: authProvider.isLoading
                        ? null
                        : () async {
                            await authProvider.updateProfile(
                              displayName: _displayNameController.text,
                              avatarUrl: _avatarUrlController.text,
                            );
                            if (authProvider.error != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(authProvider.error!)),
                              );
                            }
                          },
                    child: authProvider.isLoading
                        ? SizedBox(
                            width: screenWidth * 0.05,
                            height: screenWidth * 0.05,
                            child: const CircularProgressIndicator(),
                          )
                        : Text(
                            'Update Profile',
                            style: TextStyle(fontSize: screenWidth * 0.035),
                          ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                SizedBox(
                  width: double.infinity,
                  height: screenHeight * 0.06,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/chat');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      'Start Chat',
                      style: TextStyle(fontSize: screenWidth * 0.035),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                SizedBox(
                  width: double.infinity,
                  height: screenHeight * 0.06,
                  child: ElevatedButton(
                    onPressed: authProvider.isLoading
                        ? null
                        : () async {
                            await authProvider.signOut();
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      'Sign Out',
                      style: TextStyle(fontSize: screenWidth * 0.035),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
} 