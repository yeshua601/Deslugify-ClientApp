import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Auth / Onboarding
import 'screens/landing_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/otp_screen.dart';
import 'screens/account_created_screen.dart';

// Main App Screens
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/messages_screen.dart';
import 'screens/live_tracking_screen.dart';
import 'screens/upload_images_screen.dart';
import 'screens/ai_verification_screen.dart';
import 'screens/schedule_service_screen.dart';
import 'screens/pending_requests_screen.dart';
import 'screens/ongoing_requests_screen.dart';
import 'screens/scheduled_requests_screen.dart';
import 'screens/request_history_screen.dart';
import 'screens/feedback_screen.dart';
import 'screens/call_screen.dart';
import 'screens/notification_preferences_screen.dart';
import 'screens/security_screen.dart';
import 'screens/theme_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const DeslugifyApp());
}

class DeslugifyApp extends StatelessWidget {
  const DeslugifyApp({super.key});

  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        fontFamily: 'Inter',
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF8FAF3),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF003D1A),
          brightness: Brightness.light,
          primary: const Color(0xFF003D1A),
          secondary: const Color(0xFF006D38),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF003D1A),
          elevation: 0,
          centerTitle: true,
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        fontFamily: 'Inter',
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F1410),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF94F4AD),
          brightness: Brightness.dark,
          primary: const Color(0xFF94F4AD),
          secondary: const Color(0xFF6BCF8E),
          surface: const Color(0xFF1A211C),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A211C),
          foregroundColor: Color(0xFF94F4AD),
          elevation: 0,
          centerTitle: true,
        ),
        cardColor: const Color(0xFF1A211C),
        dialogTheme: const DialogThemeData(
          backgroundColor: Color(0xFF1A211C),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeMode,
      builder: (context, mode, _) {
        // Update status bar icons for light/dark
        final isDark = mode == ThemeMode.dark ||
            (mode == ThemeMode.system &&
                WidgetsBinding.instance.platformDispatcher.platformBrightness ==
                    Brightness.dark);

        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                isDark ? Brightness.light : Brightness.dark,
            statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
          ),
        );

        return MaterialApp(
          title: 'Deslugify',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: mode,
          home: const DeslugifyHomeScreen(),
          routes: {
            // Auth
            '/landing': (context) => const DeslugifyHomeScreen(),
            '/login': (context) => const LoginScreen(),
            '/register': (context) => const SignUpScreen(),
            '/otp': (context) => const VerifyIdentityScreen(),
            '/account-created': (context) => const AccountCreatedScreen(),

            // Main
            '/home': (context) => const DashboardScreen(),
            '/profile': (context) => const ProfileScreen(),
            '/messages': (context) => const MessagesScreen(),
            '/live-call': (context) => const LiveCallScreen(),
            '/live-tracking': (context) => const LiveTrackingScreen(),
            '/upload-images': (context) => const UploadImagesScreen(),
            '/ai-verification': (context) => const AIImageVerificationScreen(),
            '/schedule-service': (context) => const ScheduleServiceScreen(),
            '/pending-requests': (context) => const PendingRequestsScreen(),
            '/ongoing-requests': (context) => const OngoingRequestsScreen(),
            '/scheduled-requests': (context) => const ScheduledRequestsScreen(),
            '/request-history': (context) => const RequestHistoryScreen(),
            '/feedback': (context) => const ServiceFeedbackScreen(),
            '/notification-preferences': (context) =>
                const NotificationPreferencesScreen(),
            '/security': (context) => const SecurityScreen(),
          },
        );
      },
    );
  }
}