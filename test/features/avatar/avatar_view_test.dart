import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/features/avatar/avatar_band.dart';
import 'package:hydratrack/features/avatar/avatar_shape.dart';
import 'package:hydratrack/features/avatar/avatar_view.dart';
import 'package:material_ui/material_ui.dart';

const _water = AvatarBand(
  categoryId: 'water',
  colorValue: 0xFF2196F3,
  start: 0,
  end: 0.5,
);

Widget _host(
  List<AvatarBand> bands, {
  AvatarShape shape = AvatarShape.bottle,
}) => MaterialApp(
  home: Scaffold(
    body: Center(
      child: SizedBox(
        height: 300,
        child: AvatarView(
          shape: shape,
          bands: bands,
          semanticsLabel: 'Hydration progress',
          animateWave: false,
        ),
      ),
    ),
  ),
);

void main() {
  group('AvatarShape', () {
    for (final shape in AvatarShape.values) {
      test('${shape.name} path fits inside its bounds and is non-empty', () {
        final size = Size(100 * shape.aspectRatio, 100);

        final bounds = shape.buildPath(size).getBounds();

        expect(bounds.isEmpty, isFalse);
        expect(bounds.left, greaterThanOrEqualTo(-0.01));
        expect(bounds.top, greaterThanOrEqualTo(-0.01));
        expect(bounds.right, lessThanOrEqualTo(size.width + 0.01));
        expect(bounds.bottom, lessThanOrEqualTo(size.height + 0.01));
      });
    }
  });

  group('AvatarView', () {
    testWidgets('exposes a semantics label', (tester) async {
      await tester.pumpWidget(_host([_water]));

      expect(find.bySemanticsLabel('Hydration progress'), findsOneWidget);
    });

    testWidgets('renders every shape without throwing', (tester) async {
      for (final shape in AvatarShape.values) {
        await tester.pumpWidget(_host([_water], shape: shape));
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('animates to new bands and settles', (tester) async {
      await tester.pumpWidget(_host([_water]));

      await tester.pumpWidget(_host([_water.copyWith(end: 0.9)]));
      await tester.pump(const Duration(milliseconds: 300));
      expect(tester.hasRunningAnimations, isTrue);

      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  });
}
