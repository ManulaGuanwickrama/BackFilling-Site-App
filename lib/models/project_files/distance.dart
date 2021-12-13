class Distance {
  late int meters;
  late int kilometers;

  Distance({required this.meters, required this.kilometers});
  Distance.fromMeters(int meters) {
    kilometers = (meters / 1000).floor();
    this.meters = meters % 1000;
  }

  Distance add(int meters) {
    int k = 0;
    int m = 0;
    if (meters + this.meters >= 1000) {
      k = kilometers + 1;
      m = meters + this.meters - 1000;
    } else {
      k = kilometers;
      m = meters + this.meters;
    }
    return Distance(meters: m, kilometers: k);
  }

  int toMeters() {
    return kilometers * 1000 + meters;
  }

  fromMeters(int meters) {
    kilometers = (meters / 1000).floor();
    this.meters = meters % 1000;
  }
}
