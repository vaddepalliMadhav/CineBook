import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:cinebook/app.dart';
import 'package:cinebook/providers/booking_provider.dart';

void main() {
  testWidgets('CineBook opens the movie catalogue', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => BookingProvider(),
        child: const CineBookApp(),
      ),
    );

    expect(find.text('Find your movie'), findsOneWidget);
  });
}
