# CineBook – Flutter Movie Ticket Booking Web App

A responsive, interactive movie ticket booking demo built with Flutter and Provider.

## Features
- Responsive desktop, tablet and mobile layouts
- Home screen with searchable movie catalogue
- Movie details and showtime selection
- Interactive cinema seat selection
- Live ticket price calculation
- Customer details form with validation
- Booking confirmation and ticket summary
- Light/dark theme toggle
- Reusable widgets, animations and named navigation

## Run in VS Code
1. Install Flutter SDK and the Flutter/Dart VS Code extensions.
2. Extract this ZIP.
3. Open the `cinebook_flutter` folder in VS Code.
4. In the terminal run:

   ```bash
   flutter pub get
   flutter run -d chrome
   ```

   Or build the web release:

   ```bash
   flutter build web
   ```

## Deploy to GitHub Pages

Pushing to the `main` branch runs the GitHub Actions workflow to analyze, test,
build, and deploy the app. The published site is:

https://vaddepallimadhav.github.io/CineBook/

For the first deployment, set the repository's **Settings → Pages → Build and
deployment → Source** to **GitHub Actions**. The workflow needs the repository's
`GITHUB_TOKEN` permissions for Pages and deployments, which it requests itself.

## Notes
- This is a front-end lab project. Movie/showtime/seat data is sample data.
- The booking flow is functional locally; it does not process real payments or reserve seats on a cinema server.
- Seat selection, form validation, booking summary and confirmation work in app state.
