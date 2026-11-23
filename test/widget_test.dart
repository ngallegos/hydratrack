import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/main.dart';

void main() {
  testWidgets('app shell renders title', (tester) async {
    await tester.pumpWidget(const HydraTrackApp());

    expect(find.text('HydraTrack'), findsOneWidget);
  });
}
