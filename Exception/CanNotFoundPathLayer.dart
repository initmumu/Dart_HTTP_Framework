class CanNotFoundPathLayer implements Exception {
  final String? errorMessage;
  const CanNotFoundPathLayer([this.errorMessage]);

  @override
  String toString() => errorMessage ?? 'CanNotFoundPathLayer';
}
