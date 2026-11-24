bool remoteWins({
  required DateTime remoteUpdatedAt,
  required String remoteDeviceId,
  required DateTime localUpdatedAt,
  required String localDeviceId,
}) {
  var comparison = remoteUpdatedAt.compareTo(localUpdatedAt);
  if (comparison == 0) comparison = remoteDeviceId.compareTo(localDeviceId);

  return comparison > 0;
}
