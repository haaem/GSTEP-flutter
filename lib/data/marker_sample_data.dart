class MarkerInfo {
  String markerId;
  double latitude;
  double longitude;
  String owner;
  int level;
  String message;
  String date;

  MarkerInfo(
      {required this.markerId,
      required this.latitude,
      required this.longitude,
      required this.owner,
      required this.level,
      required this.message,
      required this.date});
}

List<MarkerInfo> markerList = [
  MarkerInfo(
      markerId: '0',
      latitude: 37.555946,
      longitude: 126.981463,
      owner: '장율',
      level: 1,
      message: 'Hi',
      date: '2020.03.28 (토)'),
  MarkerInfo(
      markerId: '1',
      latitude: 38,
      longitude: 126,
      owner: '윤영재',
      level: 2,
      message: 'Hi',
      date: '2020.03.28 (토)'),
  MarkerInfo(
      markerId: '2',
      latitude: 39,
      longitude: 128,
      owner: '이혜민',
      level: 3,
      message: 'Hi',
      date: '2020.03.28 (토)'),
  MarkerInfo(
      markerId: '3',
      latitude: 40,
      longitude: 131,
      owner: '백승연',
      level: 4,
      message: 'Hi',
      date: '2020.03.28 (토)'),
  MarkerInfo(
      markerId: '4',
      latitude: 37.5658,
      longitude: 126.9386,
      owner: '연세대',
      level: 5,
      message: 'Hi',
      date: '2020.03.28 (토)'),
];
