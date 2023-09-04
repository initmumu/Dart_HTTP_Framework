class UnsupportedFileFormat implements Exception {
  final String? errorMessage;
  const UnsupportedFileFormat([this.errorMessage]);

  @override
  String toString() => errorMessage ?? 'UnsupportedFileFormat';
}
