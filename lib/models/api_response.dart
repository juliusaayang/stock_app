class APIResponse<T> {
  T data;
  bool error;
  String errorMessage;

  APIResponse({
    required this.data,
    this.error = false,
    required this.errorMessage,
  });
}
