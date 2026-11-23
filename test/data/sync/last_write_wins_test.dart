import 'package:flutter_test/flutter_test.dart';
import 'package:hydratrack/data/sync/last_write_wins.dart';

void main() {
  final early = DateTime.utc(2026, 11, 23, 9);
  final late = DateTime.utc(2026, 11, 23, 10);

  bool remote({
    required DateTime remoteAt,
    String remoteDevice = 'b',
    required DateTime localAt,
    String localDevice = 'a',
  }) => remoteWins(
    remoteUpdatedAt: remoteAt,
    remoteDeviceId: remoteDevice,
    localUpdatedAt: localAt,
    localDeviceId: localDevice,
  );

  test('a newer remote record wins', () {
    expect(remote(remoteAt: late, localAt: early), isTrue);
  });

  test('an older remote record loses', () {
    expect(remote(remoteAt: early, localAt: late), isFalse);
  });

  test('timestamps decide even when the device ids disagree', () {
    expect(
      remote(
        remoteAt: late,
        remoteDevice: 'a',
        localAt: early,
        localDevice: 'z',
      ),
      isTrue,
    );
    expect(
      remote(
        remoteAt: early,
        remoteDevice: 'z',
        localAt: late,
        localDevice: 'a',
      ),
      isFalse,
    );
  });

  test('equal timestamps fall back to the greater device id', () {
    expect(
      remote(
        remoteAt: early,
        remoteDevice: 'b',
        localAt: early,
        localDevice: 'a',
      ),
      isTrue,
    );
    expect(
      remote(
        remoteAt: early,
        remoteDevice: 'a',
        localAt: early,
        localDevice: 'b',
      ),
      isFalse,
    );
  });

  test('identical records are a no-op', () {
    expect(
      remote(
        remoteAt: early,
        remoteDevice: 'a',
        localAt: early,
        localDevice: 'a',
      ),
      isFalse,
    );
  });

  test('both devices agree on the winner', () {
    final aWins = remoteWins(
      remoteUpdatedAt: early,
      remoteDeviceId: 'a',
      localUpdatedAt: early,
      localDeviceId: 'b',
    );
    final bWins = remoteWins(
      remoteUpdatedAt: early,
      remoteDeviceId: 'b',
      localUpdatedAt: early,
      localDeviceId: 'a',
    );

    expect(aWins != bWins, isTrue);
  });
}
