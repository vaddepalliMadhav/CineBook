import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/booking_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/app_header.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _phone = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final booking = context.watch<BookingProvider>();
    return Scaffold(
      appBar: const AppHeader(),
      body: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 850),
        child: ListView(padding: const EdgeInsets.all(22), children: [
          Text('Booking summary', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 18),
          Card(child: Padding(padding: const EdgeInsets.all(18), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(booking.selectedMovie.title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _line(context, 'Cinema', booking.selectedTheatre),
            _line(context, 'Date', booking.selectedDate),
            _line(context, 'Showtime', booking.selectedTime),
            _line(context, 'Seats', (booking.selectedSeats.toList()..sort()).join(', ')),
            const Divider(height: 26),
            _line(context, 'Tickets (${booking.selectedSeats.length} × ₹180)', '₹${booking.totalPrice.toStringAsFixed(0)}', bold: true),
          ]))),
          const SizedBox(height: 22),
          Text('Your details', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Form(key: _formKey, child: Column(children: [
            TextFormField(
              controller: _name,
              decoration: const InputDecoration(labelText: 'Full name', prefixIcon: Icon(Icons.person_outline)),
              textCapitalization: TextCapitalization.words,
              validator: (v) => v == null || v.trim().length < 2 ? 'Please enter your name' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _phone,
              decoration: const InputDecoration(labelText: 'Mobile number', prefixIcon: Icon(Icons.phone_outlined)),
              keyboardType: TextInputType.phone,
              maxLength: 10,
              validator: (v) => v == null || !RegExp(r'^[6-9][0-9]{9}$').hasMatch(v) ? 'Enter a valid 10-digit mobile number' : null,
            ),
          ])),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: AppTheme.red.withValues(alpha: .09), borderRadius: BorderRadius.circular(12)),
            child: const Row(children: [
              Icon(Icons.info_outline, color: AppTheme.red),
              SizedBox(width: 10),
              Expanded(child: Text('Demo checkout: no real payment will be collected.')),
            ]),
          ),
          const SizedBox(height: 20),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppTheme.red, foregroundColor: Colors.white, padding: const EdgeInsets.all(16)),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<BookingProvider>().setCustomer(_name.text.trim(), _phone.text.trim());
                Navigator.pushNamed(context, '/confirmation');
              }
            },
            child: const Text('Confirm booking'),
          ),
        ]),
      )),
    );
  }

  Widget _line(BuildContext context, String label, String value, {bool bold = false}) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(child: Text(label, style: TextStyle(color: Theme.of(context).hintColor))),
      const SizedBox(width: 12),
      Flexible(child: Text(value, textAlign: TextAlign.end, style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.w500))),
    ]),
  );
}
