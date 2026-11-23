// EXERCISE: decide whether a record from another device should replace ours.
//
// Last-write-wins:
//  - the record with the later updatedAt wins
//  - if updatedAt is exactly equal, the record from the device with the
//    greater deviceId (plain string comparison) wins, so every device
//    reaches the same answer no matter the order they sync in
//  - if both are equal, nothing changes: return false
//
// Returns true when the remote record should replace the local one.
//
// See test/data/sync/last_write_wins_test.dart.
bool remoteWins({
  required DateTime remoteUpdatedAt,
  required String remoteDeviceId,
  required DateTime localUpdatedAt,
  required String localDeviceId,
}) {
  throw UnimplementedError('Exercise: implement remoteWins');
}
