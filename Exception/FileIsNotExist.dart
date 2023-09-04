class FileIsNotExist implements Exception {
  final String? errorMessage;
  const FileIsNotExist([this.errorMessage]);

  @override
  String toString() => errorMessage ?? 'FileIsNotExist';
}
