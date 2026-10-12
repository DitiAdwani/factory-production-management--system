# factory_production_system

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
# Factory Production Management System

A Flutter-based application designed to simplify factory production tracking through machine-wise data entry, downtime monitoring, daily record management, and CSV report export.

## Overview

The Factory Production Management System helps organize production information for different machines in a factory. It provides a structured way to enter, review, and manage production records.

## Features

- **Machine-wise production tracking** — Record production information for different machines.
- **Downtime tracking** — Record machine downtime and its reasons.
- **Daily production records** — Manage production entries by date.
- **Record management** — View and edit saved production entries.
- **CSV export** — Export production data for reporting and further analysis.
- **Flutter-based application** — Built using Flutter and Dart.

## Technology Stack

- **Framework:** Flutter
- **Programming language:** Dart
- **Backend and services:** Firebase configuration is present in the project
- **Data export:** CSV

## Project Structure

```text
lib/
├── config/
├── core/
├── data/
├── models/
├── routes/
├── screens/
├── services/
├── theme/
├── utils/
└── widgets/

android/
ios/
web/
windows/
linux/
macos/
test/
```

## Getting Started

### Prerequisites

Install the following tools before running the application:

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Dart SDK](https://dart.dev/get-dart) (included with Flutter)
- [Visual Studio Code](https://code.visualstudio.com/) or another compatible IDE
- An emulator, simulator, browser, or supported device

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/DitiAdwani/factory-production-management--system.git
   ```

2. Open the project directory:

   ```bash
   cd factory-production-management--system
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Run the application:

   ```bash
   flutter run
   ```

## Development

Check the project for Dart analysis issues:

```bash
flutter analyze
```

Run the available tests:

```bash
flutter test
```

## Future Improvements

Potential enhancements include improved production analytics, additional reporting features, and a more detailed production dashboard.

## Contributing

Suggestions and improvements are welcome. Feel free to open an issue or submit a pull request.

## Author

**Diti Adwani**

## License

No license has been specified yet. Please add a license before permitting others to reuse or distribute this project.
