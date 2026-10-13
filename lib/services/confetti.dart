import 'package:bonsui/widgets/scaffold.dart';
import 'package:flutter/material.dart';

class BonsuiConfetti {
  static GlobalKey<BonsuiScaffoldState> key = GlobalKey<BonsuiScaffoldState>();

  static void show({
    int count = 150,
    bool explosion = true,
    bool useHapticFeedback = false,
    Alignment position = Alignment.topCenter,
    Duration duration = const Duration(seconds: 3),
    GlobalKey<BonsuiScaffoldState>? scaffoldKey,
  }) {
    final state = (scaffoldKey ?? key).currentState;
    if (state == null) {
      throw StateError(
        'Attach the confetti key to a mounted BonsuiScaffold before calling show.',
      );
    }
    state.showConfetti(
      count: count,
      explosion: explosion,
      useHapticFeedback: useHapticFeedback,
      position: position,
      duration: duration,
    );
  }
}
