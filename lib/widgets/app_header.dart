import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/booking_provider.dart';
import '../theme/app_theme.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: InkWell(
        onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false),
        child: const Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.movie_creation_rounded, color: AppTheme.red, size: 30),
          SizedBox(width: 9),
          Text('CineBook', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: -.5)),
        ]),
      ),
      actions: [
        if (MediaQuery.sizeOf(context).width > 600)
          TextButton(onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false), child: const Text('Home')),
        IconButton(
          tooltip: 'Toggle theme',
          onPressed: () => context.read<BookingProvider>().toggleTheme(),
          icon: Icon(context.watch<BookingProvider>().isDarkMode ? Icons.light_mode : Icons.dark_mode),
        ),
        const SizedBox(width: 12),
      ],
    );
  }
}
