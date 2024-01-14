extension DurationExtension on Duration {
  Future<dynamic> get delay => Future.delayed(this);
}
