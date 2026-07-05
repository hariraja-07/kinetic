# Kinetic

A Flutter stock ticker demo exploring the architecture behind
[Zerodha](https://zerodha.tech) — India's largest stock broker —
and why they rewrote their platform in Flutter.

<p align="center">
  <a href="LICENSE">
    <img src="https://img.shields.io/badge/License-MIT-blue.svg" alt="License: MIT">
  </a>
</p>

<p align="center">
  <img src="assets/screenshots/home.jpg" style="max-width: 320px; width: 100%;" alt="Home Screen">
</p>

## Why Flutter?

Zerodha went from Native Android → React Native → Flutter.
[Their blog](https://zerodha.tech/blog/from-native-to-react-native-to-flutter/) explains why:

> When 50+ stocks update multiple times per second, you can't rebuild
> the entire UI. Each widget must rebuild independently.

React Native can achieve granular rebuilds, but Zerodha found the
JS-Native bridge latency and setState batching made it unreliable
for high-frequency financial data. Flutter's direct canvas rendering
and ValueNotifier made the same pattern simpler and more performant.

This demo implements that pattern with zero third-party state management.

## Demo

<p align="center">
  <img src="assets/gifs/working.gif" style="max-width: 320px; width: 100%;" alt="App Demo">
</p>

## Features

- 50 Nifty 50 stocks with simulated real-time price updates
- Line chart and candlestick chart with toggle
- Interactive zoom and pan
- Simulated order book (bid/offer depth)
- Session high/low tracking
- Granular widget rebuilds

<p align="center">
  <img src="assets/screenshots/line_chart.jpg" style="max-width: 280px; width: 48%;" alt="Line Chart">
  <img src="assets/screenshots/candle_chart.jpg" style="max-width: 280px; width: 48%;" alt="Candlestick Chart">
</p>

## Architecture

```dart
// Each stock gets its own notifier
stockNotifiers = _stocks.map((s) => ValueNotifier(s)).toList();

// Only this row rebuilds when this stock changes
ValueListenableBuilder<Stock>(
  valueListenable: notifier,
  builder: (context, stock, _) => StockItem(...),
)
```

50 stocks updating every 10-20ms. Only the changed row rebuilds.

## Performance

<p align="center">
  <img src="assets/screenshots/performance_rebuild.png" style="max-width: 500px; width: 100%;" alt="Widget Rebuilds">
</p>

<p align="center">
  <img src="assets/screenshots/performance_fps.png" style="max-width: 500px; width: 100%;" alt="Frame Rendering">
</p>

| Mode | FPS | Notes |
|------|-----|-------|
| Debug | ~46 | Expected overhead from debug tooling |
| Profile | 55-60 | Baseline for production optimization |

## Project Structure

```
lib/
├── main.dart                    # Home screen, price simulation engine
├── models/
│   └── stock.dart               # Stock data class
├── screens/
│   └── stock_detail_screen.dart # Charts, order book, live updates
└── widgets/
    └── stock_item.dart          # Reusable stock list tile
```

## Getting Started

```bash
git clone https://github.com/hariraja-07/kinetic.git
cd kinetic
flutter pub get
flutter run
```

**Requirements:** Flutter SDK ^3.11.0

## Dependencies

| Package | Purpose |
|---------|---------|
| `fl_chart` ^1.2.0 | Line and candlestick charts |

## License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [Zerodha Tech Blog](https://zerodha.tech/blog/from-native-to-react-native-to-flutter/) — Architecture inspiration
- [fl_chart](https://flchart.dev/) — Charting library
