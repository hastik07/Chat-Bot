class ErrorHandler {
  static String getErrorMessage(dynamic error) {
    if (error is String) return error;
    if (error is Exception) return error.toString();
    return 'An unknown error occurred.';
  }
} 