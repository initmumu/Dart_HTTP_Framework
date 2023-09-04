class ParameterError implements Exception {
  final String? errorMessage;
  const ParameterError([this.errorMessage]);

  @override
  String toString() => errorMessage ?? 'ParemeterError';
}
