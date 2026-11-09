import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../theme/app_theme.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;
  const MovieCard({super.key, required this.movie, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: .96, end: 1),
      duration: const Duration(milliseconds: 350),
      builder: (context, value, child) => Transform.scale(scale: value, child: child),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
              child: Stack(fit: StackFit.expand, children: [
                movie.posterUrl.isEmpty
                    ? _posterFallback()
                    : Image.network(
                        movie.posterUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => _posterFallback(),
                      ),
                Positioned(top: 10, right: 10, child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(8)),
                  child: Row(children: [const Icon(Icons.star, color: Colors.amber, size: 14), const SizedBox(width: 3), Text(movie.rating.toString(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]),
                )),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 11, 12, 13),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(movie.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 4),
                Text(movie.genre, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: Theme.of(context).hintColor, fontSize: 12)),
                const SizedBox(height: 10),
                SizedBox(width: double.infinity, child: FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: AppTheme.red, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 10)),
                  onPressed: onTap,
                  child: const Text('Book now'),
                )),
              ]),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _posterFallback() => Container(
        color: Colors.blueGrey.shade800,
        child: const Icon(Icons.local_movies, size: 52, color: Colors.white54),
      );
}
