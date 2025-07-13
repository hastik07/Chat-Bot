# AI Chatbot App

A professional AI chatbot mobile application built with Flutter, Supabase, Provider, Hive, and 21st.dev SDK for 3D UI elements.

## Features
- **User authentication** (email/password, social login)
- **Real-time chat with AI assistant**
- **Modern chat UI** with media, emoji, and typing indicators
- **Interactive 3D AI avatar**
- **Offline support and encrypted local storage**
- **MVVM architecture, clean code, and comprehensive testing**
- **Responsive design** that adapts to all device sizes

## Responsive Design
- **Flexible layouts** using LayoutBuilder and relative sizing
- **Adaptive typography** that scales with screen width
- **Responsive components** (message bubbles, chat input, buttons)
- **Multi-device support** (phones, tablets, different orientations)
- **Touch-friendly interface** with proper sizing

## Project Structure
```
lib/
  core/           # Common utilities, error handling, logging, themes
  data/           # Data sources (Supabase, Hive, etc.), models, repositories
  domain/         # Business logic, use cases, entities
  presentation/   # UI: screens, widgets, providers (state management)
  services/       # AI, 3D, analytics, etc.
  main.dart

test/
  unit/
  widget/
```

## Getting Started
1. Install Flutter (latest stable) and run `flutter pub get`.
2. Set up a Supabase project and add your URL and anon key in `lib/main.dart`.
3. Run the app: `flutter run`

## Responsive Testing
- Test on different device sizes (small, medium, large phones, tablets)
- Verify portrait and landscape orientations
- Check touch target sizes and usability
- See `RESPONSIVE_TESTING_GUIDE.md` for detailed testing instructions

## Dependencies
- Flutter
- Provider
- Supabase Flutter
- Hive & Hive Flutter
- path_provider
- 21st.dev SDK (3D UI)

## Contributing
- Follow MVVM and clean code principles
- Write unit and widget tests
- Document your code
- Test responsive design across devices

---
For more details, see the API and testing documentation (coming soon).
