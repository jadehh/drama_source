/*
 * @File     : logger
 * @Author   : jade
 * @Date     : 2024/08/14 04:09:53
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:logger/logger.dart';

class FLogger {
  late Logger _logger;

  static final FLogger _instance = FLogger._internal();

  static FLogger get instance => _instance;

  factory FLogger() {
    return _instance;
  }

  FLogger._internal() {
    _logger = Logger(printer: PrettyPrinter());
  }

  static FLogger get() {
    return _instance;
  }

  void d(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.d(message, time: time, error: error, stackTrace: stackTrace);
  }

  void i(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.i(message, time: time, error: error, stackTrace: stackTrace);
  }
}





