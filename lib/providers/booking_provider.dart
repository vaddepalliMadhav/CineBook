import 'package:flutter/foundation.dart';
import '../models/movie.dart';

class BookingProvider extends ChangeNotifier {
  bool isDarkMode = true;
  Movie selectedMovie = sampleMovies.first;
  String selectedDate = 'Today, Nov 9';
  String selectedTheatre = 'PVR Cinemas • Hyderabad';
  String selectedTime = '06:30 PM';
  final Set<String> selectedSeats = {};
  String customerName = '';
  String customerPhone = '';
  String bookingId = '';

  double get ticketPrice => 180;
  double get totalPrice => selectedSeats.length * ticketPrice;

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }

  void chooseMovie(Movie movie) {
    selectedMovie = movie;
    selectedSeats.clear();
    notifyListeners();
  }

  void chooseDate(String date) {
    selectedDate = date;
    notifyListeners();
  }

  void chooseTheatre(String theatre) {
    selectedTheatre = theatre;
    notifyListeners();
  }

  void chooseTime(String time) {
    selectedTime = time;
    notifyListeners();
  }

  void toggleSeat(String seat) {
    if (selectedSeats.contains(seat)) {
      selectedSeats.remove(seat);
    } else {
      selectedSeats.add(seat);
    }
    notifyListeners();
  }

  void setCustomer(String name, String phone) {
    customerName = name;
    customerPhone = phone;
    bookingId = 'CB${DateTime.now().millisecondsSinceEpoch.toString().substring(6)}';
    notifyListeners();
  }

  void resetBooking() {
    selectedSeats.clear();
    customerName = '';
    customerPhone = '';
    notifyListeners();
  }
}
