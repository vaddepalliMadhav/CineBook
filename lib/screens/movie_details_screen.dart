import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/booking_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/app_header.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movie = context.watch<BookingProvider>().selectedMovie;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: const AppHeader(),
      body: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 1050),
        child: ListView(padding: const EdgeInsets.all(22), children: [
          if (width > 650)
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _poster(movie.posterUrl, 260),
              const SizedBox(width: 28),
              Expanded(child: _details(context, movie)),
            ])
          else
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(child: _poster(movie.posterUrl, 230)),
              const SizedBox(height: 22),
              _details(context, movie),
            ]),
        ]),
      )),
    );
  }

  Widget _poster(String url, double height) => ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Image.network(url, height: height, width: height * .68, fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Container(height: height, width: height * .68, color: Colors.blueGrey, child: const Icon(Icons.movie, size: 60))),
  );

  Widget _details(BuildContext context, movie) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(movie.title, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900)),
    const SizedBox(height: 12),
    Wrap(spacing: 8, runSpacing: 8, children: [
      _tag(context, '⭐ ${movie.rating}'), _tag(context, movie.duration), _tag(context, movie.language), _tag(context, movie.certificate),
    ]),
    const SizedBox(height: 22),
    Text('About the movie', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
    const SizedBox(height: 8),
    Text(movie.description, style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6)),
    const SizedBox(height: 22),
    Text('Genre', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
    const SizedBox(height: 5),
    Text(movie.genre),
    const SizedBox(height: 28),
    SizedBox(width: 220, child: FilledButton(
      style: FilledButton.styleFrom(backgroundColor: AppTheme.red, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16)),
      onPressed: () => Navigator.pushNamed(context, '/showtimes'),
      child: const Text('Select showtime  →'),
    )),
  ]);

  Widget _tag(BuildContext context, String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
    decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(9)),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
  );
}
