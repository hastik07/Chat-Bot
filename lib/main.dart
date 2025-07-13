import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;

import 'core/theme/app_theme.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/chat/chat_repository.dart';
import 'domain/usecases/auth_usecases.dart';
import 'domain/usecases/chat/chat_usecases.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/providers/chat/chat_provider.dart';
import 'presentation/screens/auth/login_screen.dart';
import 'presentation/screens/auth/profile_screen.dart';
import 'presentation/screens/auth/signup_screen.dart';
import 'presentation/screens/chat/chat_screen.dart';
import 'presentation/screens/landing/landing_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocDir.path);

  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://gxyqaorjzoriggkkbbxb.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imd4eXFhb3Jqem9yaWdna2tiYnhiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTIzMTkxMjgsImV4cCI6MjA2Nzg5NTEyOH0.Xr67fiHA91OmNNGksHlertlDqQxJq0dQwXhu2wECl8g',
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(AuthUseCases(AuthRepository())),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(ChatUseCases(ChatRepository())),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Chatbot App',
      theme: appThemeDark,
      initialRoute: '/landing',
      routes: {
        '/landing': (_) => const LandingScreen(),
        '/login': (_) => const LoginScreen(),
        '/signup': (_) => const SignupScreen(),
        '/profile': (_) => const ProfileScreen(),
        '/chat': (_) => const ChatScreen(),
      },
    );
  }
}
