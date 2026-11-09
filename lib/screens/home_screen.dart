import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/movie.dart';
import '../providers/booking_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/app_header.dart';
import '../widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String query = '';
  String category = 'All';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final columns = width >= 1100 ? 4 : width >= 720 ? 3 : 2;
    final movies = sampleMovies.where((m) {
      final matchesQuery = m.title.toLowerCase().contains(query.toLowerCase()) || m.genre.toLowerCase().contains(query.toLowerCase());
      final matchesCategory = category == 'All' || m.genre.toLowerCase().contains(category.toLowerCase());
      return matchesQuery && matchesCategory;
    }).toList();

    return Scaffold(
      appBar: const AppHeader(),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1240),
          child: ListView(padding: EdgeInsets.symmetric(horizontal: width < 600 ? 16 : 28, vertical: 12), children: [
            Container(
              padding: EdgeInsets.all(width < 600 ? 22 : 36),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(colors: [Color(0xFF4A1420), Color(0xFF201B2B), Color(0xFF171923)]),
              ),
              child: Row(children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('YOUR NEXT GREAT\nMOVIE NIGHT STARTS HERE', style: TextStyle(fontSize: 12, letterSpacing: 2, color: Colors.white70, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Text('Big stories.\nBigger screen.', style: TextStyle(fontSize: width < 600 ? 29 : 43, height: 1.08, fontWeight: FontWeight.w900, color: Colors.white)),
                  const SizedBox(height: 12),
                  const Text('Discover movies and book your favourite seats.', style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    style: FilledButton.styleFrom(backgroundColor: AppTheme.red, foregroundColor: Colors.white),
                    onPressed: () => _openMovie(context, sampleMovies.first),
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Explore featured movie'),
                  ),
                ])),
                if (width >= 650) const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Icon(Icons.local_movies_rounded, size: 120, color: Colors.white24),
                ),
              ]),
            ),
            const SizedBox(height: 28),
            Text('Find your movie', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(
              onChanged: (v) => setState(() => query = v),
              decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search by movie or genre'),
            ),
            const SizedBox(height: 14),
            Wrap(spacing: 8, children: ['All', 'Action', 'Drama', 'Comedy', 'Adventure'].map((c) =>
              ChoiceChip(label: Text(c), selected: category == c, onSelected: (_) => setState(() => category = c),
                selectedColor: AppTheme.red.withValues(alpha: .2))).toList()),
            const SizedBox(height: 24),
            Row(children: [
              Expanded(child: Text('Now showing', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold))),
              Text('${movies.length} movies', style: TextStyle(color: Theme.of(context).hintColor)),
            ]),
            const SizedBox(height: 12),
            if (movies.isEmpty) const Padding(padding: EdgeInsets.all(30), child: Center(child: Text('No movies found. Try another search.')))
            else GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: movies.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns, crossAxisSpacing: 14, mainAxisSpacing: 14, childAspectRatio: width < 400 ? .59 : .66,
              ),
              itemBuilder: (_, i) => MovieCard(movie: movies[i], onTap: () => _openMovie(context, movies[i])),
            ),
            const SizedBox(height: 30),
            Center(child: Text('CineBook • Your seat, your story', style: TextStyle(color: Theme.of(context).hintColor))),
          ]),
        ),
      ),
    );
  }

  void _openMovie(BuildContext context, Movie movie) {
    context.read<BookingProvider>().chooseMovie(movie);
    Navigator.pushNamed(context, '/movie');
  }
}
