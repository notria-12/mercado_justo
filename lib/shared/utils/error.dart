class Failure implements Exception {
  final String title;
  final String message;

  Failure({required this.title, required this.message});
}
