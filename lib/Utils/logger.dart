import 'package:flutter/cupertino.dart';

class Logger {

  Logger({required this.tag});
  static const String DebugLog = 'DEBUG';
  static const String InfoLog = 'INFO';
  static const String ErrorLog = 'ERROR';

  final String tag;

  void debug(String message) {
    debugPrint('| $DebugLog | [ $tag ]  $message');
  }

  void error(String message) {
    debugPrint('| $ErrorLog | [ $tag ]  $message');
  }

  void info(String message) {
    debugPrint('| $InfoLog | [ $tag ]  $message');
  }
}
