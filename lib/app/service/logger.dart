class Logger {
  static void info(String message) {
    print('[INFO] ${DateTime.now()}: $message');
  }

  static void error(String message) {
    print('[ERROR] ${DateTime.now()}: $message');
  }

  static void debug(String message) {
    print('[DEBUG] ${DateTime.now()}: $message');
  }
}