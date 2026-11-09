import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/booking_provider.dart';
import 'screens/home_screen.dart';
import 'screens/movie_details_screen.dart';
import 'screens/showtime_screen.dart';
import 'screens/seat_selection_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/confirmation_screen.dart';
import 'theme/app_theme.dart';

class CineBookApp extends StatelessWidget {
  const CineBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = context.watch<BookingProvider>().isDarkMode;
    return MaterialApp(
      title: 'CineBook',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: dark ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/',
      routes: {
        '/': (_) => const HomeScreen(),
        '/movie': (_) => const MovieDetailsScreen(),
        '/showtimes': (_) => const ShowtimeScreen(),
        '/seats': (_) => const SeatSelectionScreen(),
        '/checkout': (_) => const CheckoutScreen(),
        '/confirmation': (_) => const ConfirmationScreen(),
      },
    );
  }
}
