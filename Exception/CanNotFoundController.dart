class CanNotFoundController implements Exception {
  final String? errorMessage;
  const CanNotFoundController([this.errorMessage]);

  @override
  String toString() => errorMessage ?? 'CanNotFoundController';
}
