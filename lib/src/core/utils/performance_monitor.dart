import 'package:flutter/foundation.dart';
import 'dart:developer' as developer;

/// Performance monitoring utility for tracking app performance
class PerformanceMonitor {
  static final PerformanceMonitor _instance = PerformanceMonitor._internal();
  static PerformanceMonitor get instance => _instance;
  
  PerformanceMonitor._internal();
  
  final Map<String, DateTime> _timers = {};
  final Map<String, int> _counters = {};
  
  /// Start timing an operation
  void startTimer(String operation) {
    if (kDebugMode) {
      _timers[operation] = DateTime.now();
    }
  }
  
  /// End timing an operation and log the result
  void endTimer(String operation) {
    if (kDebugMode && _timers.containsKey(operation)) {
      final duration = DateTime.now().difference(_timers[operation]!);
      developer.log(
        'Performance: $operation took ${duration.inMilliseconds}ms',
        name: 'PerformanceMonitor',
      );
      _timers.remove(operation);
    }
  }
  
  /// Increment a counter
  void incrementCounter(String counter) {
    if (kDebugMode) {
      _counters[counter] = (_counters[counter] ?? 0) + 1;
    }
  }
  
  /// Log counter values
  void logCounters() {
    if (kDebugMode) {
      _counters.forEach((key, value) {
        developer.log(
          'Counter: $key = $value',
          name: 'PerformanceMonitor',
        );
      });
    }
  }
  
  /// Clear all timers and counters
  void clear() {
    _timers.clear();
    _counters.clear();
  }
  
  /// Log memory usage (estimated)
  void logMemoryUsage(String context) {
    if (kDebugMode) {
      developer.log(
        'Memory check at: $context',
        name: 'PerformanceMonitor',
      );
    }
  }
}
