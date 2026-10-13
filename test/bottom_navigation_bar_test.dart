import 'package:bonsui/bonsui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Vertical navigation uses compact bottom padding', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          bottomNavigationBar: BonsuiBottomNavigationBar(
            horizontalLayout: false,
            currentIndex: 0,
            items: [
              BonsuiBottomNavigationBarItem(icon: Icons.home, label: 'Home'),
              BonsuiBottomNavigationBarItem(
                icon: Icons.settings,
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    final bar = find.byType(BonsuiBottomNavigationBar);
    final container = tester.widget<Container>(
      find.descendant(of: bar, matching: find.byType(Container)).first,
    );
    expect(container.padding, const EdgeInsets.only(top: 12, bottom: 4));
    expect(tester.getSize(bar).height, lessThanOrEqualTo(80));
    expect(tester.takeException(), isNull);
  });

  for (final bottomInset in [0.0, 34.0]) {
    for (final textScale in [1.0, 2.0]) {
      testWidgets(
        'Vertical navigation fits labels with inset $bottomInset and scale $textScale',
        (tester) async {
          var currentIndex = 0;
          var horizontalLayout = true;
          late StateSetter updateState;
          await tester.pumpWidget(
            MaterialApp(
              home: MediaQuery(
                data: MediaQueryData(
                  padding: EdgeInsets.only(bottom: bottomInset),
                  textScaler: TextScaler.linear(textScale),
                ),
                child: StatefulBuilder(
                  builder: (context, setState) {
                    updateState = setState;
                    return Scaffold(
                      bottomNavigationBar: BonsuiBottomNavigationBar(
                        horizontalLayout: horizontalLayout,
                        showUnselectedLabel: true,
                        labelSize: 16,
                        currentIndex: currentIndex,
                        onTap: (index) => setState(() => currentIndex = index),
                        items: [
                          BonsuiBottomNavigationBarItem(
                            icon: Icons.home,
                            label: 'Home',
                          ),
                          BonsuiBottomNavigationBarItem(
                            widgetIcon: const Icon(Icons.settings, size: 40),
                            activeWidgetIcon:
                                const Icon(Icons.settings, size: 48),
                            label: 'Settings',
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          );
          final bar = find.byType(BonsuiBottomNavigationBar);
          final horizontalHeight = tester.getSize(bar).height;

          updateState(() => horizontalLayout = false);
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);
          expect(tester.getSize(bar).height, greaterThan(horizontalHeight));

          await tester.tap(find.text('Settings'));
          await tester.pumpAndSettle();
          expect(currentIndex, 1);
          expect(tester.takeException(), isNull);
          expect(
            tester.widget<BonsuiBottomNavigationBar>(bar).currentIndex,
            1,
          );
        },
      );
    }
  }
}
