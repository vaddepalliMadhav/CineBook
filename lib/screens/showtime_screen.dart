import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/booking_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/app_header.dart';

class ShowtimeScreen extends StatelessWidget {
  const ShowtimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final booking = context.watch<BookingProvider>();
    final dates = ['Today, Nov 9', 'Tue, Nov 10', 'Wed, Nov 11', 'Thu, Nov 12'];
    final theatres = ['PVR Cinemas • Hyderabad', 'AMB Cinemas • Gachibowli', 'INOX • GSM Mall'];
    final times = ['10:30 AM', '01:45 PM', '06:30 PM', '09:45 PM'];
    return Scaffold(
      appBar: const AppHeader(),
      body: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 850),
        child: ListView(padding: const EdgeInsets.all(22), children: [
          Text('Choose your show', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(booking.selectedMovie.title, style: TextStyle(color: Theme.of(context).hintColor)),
          const SizedBox(height: 26),
          const _SectionTitle('Select date'),
          const SizedBox(height: 12),
          Wrap(spacing: 9, runSpacing: 9, children: dates.map((d) => ChoiceChip(
            label: Text(d), selected: booking.selectedDate == d, onSelected: (_) => booking.chooseDate(d),
            selectedColor: AppTheme.red.withValues(alpha: .2),
          )).toList()),
          const SizedBox(height: 28),
          const _SectionTitle('Select cinema'),
          const SizedBox(height: 12),
          RadioGroup<String>(
            groupValue: booking.selectedTheatre,
            onChanged: (value) {
              if (value != null) booking.chooseTheatre(value);
            },
            child: Column(children: theatres.map((theatre) => Card(child: RadioListTile<String>(
              value: theatre,
              title: Text(theatre),
              subtitle: const Text('Premium • Dolby Atmos available'),
              activeColor: AppTheme.red,
            ))).toList()),
          ),
          const SizedBox(height: 24),
          const _SectionTitle('Select showtime'),
          const SizedBox(height: 12),
          Wrap(spacing: 10, runSpacing: 10, children: times.map((t) => ChoiceChip(
            label: Text(t), selected: booking.selectedTime == t, onSelected: (_) => booking.chooseTime(t),
            selectedColor: AppTheme.red.withValues(alpha: .2),
          )).toList()),
          const SizedBox(height: 30),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppTheme.red, foregroundColor: Colors.white, padding: const EdgeInsets.all(16)),
            onPressed: () => Navigator.pushNamed(context, '/seats'),
            child: const Text('Continue to seat selection'),
          ),
        ]),
      )),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);
  @override
  Widget build(BuildContext context) => Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold));
}
