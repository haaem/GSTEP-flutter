class MarkerInfo {
  String markerId;
  double latitude;
  double longitude;
  String owner;
  String imagePath;

  MarkerInfo({
    required this.markerId,
    required this.latitude,
    required this.longitude,
    required this.owner,
    required this.imagePath
  });
}

List<MarkerInfo> markerList = [
  MarkerInfo(
    markerId: '0',
      latitude: 37.555946,
      longitude: 126.981463,
      owner: '장율',
      imagePath: "assets/images/marker.png"
  ),
  MarkerInfo(
    markerId: '1',
      latitude: 38,
      longitude: 126,
      owner: '윤영재',
      imagePath: "assets/images/marker.png"
  ),
  MarkerInfo(
    markerId: '2',
      latitude: 39,
      longitude: 128,
      owner: '이혜민',
      imagePath: "assets/images/marker.png"
  ),
  MarkerInfo(
    markerId: '3',
      latitude: 40,
      longitude: 131,
      owner: '백승연',
      imagePath: "assets/images/marker.png"
  ),
  MarkerInfo(
      markerId: '4',
      latitude: 37.5658,
      longitude: 126.9386,
      owner: '연세대',
      imagePath: "assets/images/marker.png"
  ),
];