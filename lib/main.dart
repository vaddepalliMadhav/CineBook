import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'providers/booking_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => BookingProvider(),
      child: const CineBookApp(),
    ),
  );
}
