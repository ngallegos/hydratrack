import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/core/format.dart';

void main() {
  group('formatMl', () {
    test('formats small values without separators', () {
      expect(formatMl(0), '0 ml');
      expect(formatMl(250), '250 ml');
    });

    test('groups thousands', () {
      expect(formatMl(1000), '1,000 ml');
      expect(formatMl(2500), '2,500 ml');
      expect(formatMl(1234567), '1,234,567 ml');
    });

    test('keeps the sign for negatives', () {
      expect(formatMl(-1250), '-1,250 ml');
    });
  });
}
