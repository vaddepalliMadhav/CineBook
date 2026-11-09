import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/booking_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/app_header.dart';

class SeatSelectionScreen extends StatelessWidget {
  const SeatSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final booking = context.watch<BookingProvider>();
    final width = MediaQuery.sizeOf(context).width;
    const rows = ['A', 'B', 'C', 'D', 'E'];
    const unavailable = {'A4', 'B6', 'C2', 'D8', 'E5'};
    return Scaffold(
      appBar: const AppHeader(),
      body: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 850),
        child: ListView(padding: const EdgeInsets.all(20), children: [
          Text('Select your seats', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text('${booking.selectedMovie.title} • ${booking.selectedDate} • ${booking.selectedTime}', style: TextStyle(color: Theme.of(context).hintColor)),
          const SizedBox(height: 28),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(14)),
            child: const Column(children: [
              Icon(Icons.tv, size: 26),
              SizedBox(height: 5),
              Text('SCREEN THIS WAY', style: TextStyle(letterSpacing: 3, fontSize: 11, fontWeight: FontWeight.bold)),
            ]),
          ),
          const SizedBox(height: 28),
          ...rows.map((row) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(width: 20, child: Text(row, style: const TextStyle(fontWeight: FontWeight.bold))),
              const SizedBox(width: 8),
              ...List.generate(8, (i) {
                final seat = '$row${i + 1}';
                final taken = unavailable.contains(seat);
                final selected = booking.selectedSeats.contains(seat);
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: width < 400 ? 2 : 4),
                  child: InkWell(
                    onTap: taken ? null : () => booking.toggleSeat(seat),
                    borderRadius: BorderRadius.circular(7),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: width < 400 ? 29 : 36,
                      height: 32,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: taken ? Colors.grey.shade700 : selected ? AppTheme.red : const Color(0xFF2E8B70).withValues(alpha: .75),
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(color: selected ? Colors.white : Colors.transparent, width: 1.5),
                      ),
                      child: Text('${i + 1}', style: const TextStyle(fontSize: 10, color: Colors.white)),
                    ),
                  ),
                );
              }),
              const SizedBox(width: 8),
              SizedBox(width: 20, child: Text(row, style: const TextStyle(fontWeight: FontWeight.bold))),
            ]),
          )),
          const SizedBox(height: 22),
          const Wrap(alignment: WrapAlignment.center, spacing: 18, runSpacing: 8, children: [
            _Legend(color: Color(0xFF2E8B70), label: 'Available'),
            _Legend(color: AppTheme.red, label: 'Selected'),
            _Legend(color: Colors.grey, label: 'Occupied'),
          ]),
          const SizedBox(height: 26),
          Card(child: Padding(padding: const EdgeInsets.all(16), child: Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('${booking.selectedSeats.length} seats selected', style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(booking.selectedSeats.isEmpty ? 'Choose at least one seat' : (booking.selectedSeats.toList()..sort()).join(', '), style: TextStyle(color: Theme.of(context).hintColor)),
            ])),
            Text('₹${booking.totalPrice.toStringAsFixed(0)}', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
          ]))),
          const SizedBox(height: 14),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppTheme.red, foregroundColor: Colors.white, padding: const EdgeInsets.all(16)),
            onPressed: booking.selectedSeats.isEmpty ? null : () => Navigator.pushNamed(context, '/checkout'),
            child: const Text('Continue to checkout'),
          ),
        ]),
      )),
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String label;
  const _Legend({required this.color, required this.label});
  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: [
    Container(width: 13, height: 13, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4))),
    const SizedBox(width: 6),
    Text(label, style: const TextStyle(fontSize: 12)),
  ]);
}
