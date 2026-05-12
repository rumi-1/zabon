import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:zabon/app.dart';
import 'package:zabon/state/app_state.dart';

void main() {
  testWidgets('App loads path tab', (WidgetTester tester) async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final appState = AppState();
    await appState.initializeDefaults();

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: appState,
        child: const RoshanApp(),
      ),
    );
    await tester.pump();

    expect(find.text('Path'), findsWidgets);
    expect(find.text('Learn'), findsOneWidget);
  });
}
