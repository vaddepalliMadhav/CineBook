import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/booking_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/app_header.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final booking = context.watch<BookingProvider>();
    final seats = booking.selectedSeats.toList()..sort();
    return Scaffold(
      appBar: const AppHeader(),
      body: Center(
          child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 620),
        child: ListView(padding: const EdgeInsets.all(22), children: [
          const SizedBox(height: 18),
          const Icon(Icons.check_circle_rounded,
              color: Color(0xFF2EAD79), size: 76),
          const SizedBox(height: 12),
          Text('Booking confirmed!',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.w900)),
          const SizedBox(height: 6),
          Text('Your movie plan is ready. Enjoy the show!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).hintColor)),
          const SizedBox(height: 26),
          Card(
              child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(children: [
                    const Icon(Icons.movie_filter_rounded,
                        size: 36, color: AppTheme.red),
                    const SizedBox(height: 8),
                    Text('CINEBOOK',
                        style: TextStyle(
                            letterSpacing: 4,
                            color: Theme.of(context).hintColor,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15),
                    Text(booking.selectedMovie.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.w900),
                        textAlign: TextAlign.center),
                    const SizedBox(height: 18),
                    _ticketLine(context, 'BOOKING ID', booking.bookingId),
                    _ticketLine(context, 'NAME', booking.customerName),
                    _ticketLine(context, 'CINEMA', booking.selectedTheatre),
                    _ticketLine(context, 'DATE & TIME',
                        '${booking.selectedDate} • ${booking.selectedTime}'),
                    _ticketLine(context, 'SEATS', seats.join(', ')),
                    const Divider(height: 28),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('TOTAL PAID',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('₹${booking.totalPrice.toStringAsFixed(0)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                      fontWeight: FontWeight.w900,
                                      color: AppTheme.red)),
                        ]),
                    const SizedBox(height: 18),
                    Container(
                      width: 118,
                      height: 118,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Theme.of(context).dividerColor),
                          borderRadius: BorderRadius.circular(12)),
                      child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.qr_code_2_rounded, size: 82),
                            Text('DEMO TICKET',
                                style:
                                    TextStyle(fontSize: 8, letterSpacing: 1)),
                          ]),
                    ),
                    const SizedBox(height: 10),
                    Text('Show this ticket at the cinema entrance.',
                        style: TextStyle(
                            color: Theme.of(context).hintColor, fontSize: 12)),
                  ]))),
          const SizedBox(height: 18),
          FilledButton(
            style: FilledButton.styleFrom(
                backgroundColor: AppTheme.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16)),
            onPressed: () {
              context.read<BookingProvider>().resetBooking();
              Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
            },
            child: const Text('Back to home'),
          ),
        ]),
      )),
    );
  }

  Widget _ticketLine(BuildContext context, String label, String value) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
              width: 112,
              child: Text(label,
                  style: TextStyle(
                      fontSize: 10,
                      letterSpacing: 1,
                      color: Theme.of(context).hintColor,
                      fontWeight: FontWeight.bold))),
          Expanded(
              child: Text(value,
                  textAlign: TextAlign.end,
                  style: const TextStyle(fontWeight: FontWeight.w600))),
        ]),
      );
}
