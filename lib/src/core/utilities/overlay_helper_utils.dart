import 'package:flutter/material.dart';
import 'package:sol_replace_revamp/src/core/globals/variables.dart';

/// Generic overlay helper utility that can be used for any overlay widget
class OverlayHelperUtils {
  static OverlayEntry? _overlayEntry;
  static DateTime? _showTime;

  static void show(
    Widget widget, {
    Duration minDuration = const Duration(seconds: 2),
  }) {
    _showOverlay(widget, minDuration);
  }

  static void _showOverlay(Widget widget, Duration minDuration) {
    if (_overlayEntry != null) {
      debugPrint('⚠️ Overlay already showing - skipping');
      return;
    }

    try {
      final materialAppContext = materialAppKey.currentContext;
      if (materialAppContext == null) {
        throw Exception('MaterialApp context is null');
      }

      // Create the overlay entry
      _overlayEntry = OverlayEntry(builder: (context) => widget);

      _insertOverlay(materialAppContext);

      _showTime = DateTime.now();
      debugPrint('✅ Overlay inserted successfully');
    } catch (e) {
      debugPrint('❌ Overlay insertion failed: $e');
      throw Exception('Failed to show overlay: $e');
    }
  }

  static void _insertOverlay(BuildContext context) {
    // Try multiple approaches to insert the overlay
    final approaches = [
      () => _tryNavigatorOverlay(context),
      () => _tryOverlayOfWithRoot(context),
      () => _tryOverlayOfWithoutRoot(context),
      () => _tryFindOverlayInWidgetTree(context),
    ];

    Exception? lastException;

    for (int i = 0; i < approaches.length; i++) {
      try {
        approaches[i]();
        debugPrint('✅ Overlay inserted successfully using approach ${i + 1}');
        return;
      } catch (e) {
        lastException = e as Exception;
        debugPrint('❌ Approach ${i + 1} failed: $e');
      }
    }

    // If all approaches failed, throw the last exception
    throw lastException ?? Exception('All overlay insertion approaches failed');
  }

  static void _tryNavigatorOverlay(BuildContext context) {
    final navigator = Navigator.of(context);
    if (navigator.overlay == null) {
      throw Exception('Navigator or Navigator overlay is null');
    }
    navigator.overlay!.insert(_overlayEntry!);
  }

  static void _tryOverlayOfWithRoot(BuildContext context) {
    final overlay = Overlay.of(context, rootOverlay: true);
    overlay.insert(_overlayEntry!);
  }

  static void _tryOverlayOfWithoutRoot(BuildContext context) {
    final overlay = Overlay.of(context);
    overlay.insert(_overlayEntry!);
  }

  static void _tryFindOverlayInWidgetTree(BuildContext context) {
    final overlay = _findOverlayInWidgetTree(context);
    if (overlay == null) {
      throw Exception('Could not find overlay in widget tree');
    }
    overlay.insert(_overlayEntry!);
  }

  static OverlayState? _findOverlayInWidgetTree(BuildContext context) {
    try {
      // Try to find the Navigator and get its overlay
      final navigator = Navigator.of(context);
      return navigator.overlay;
    } catch (e) {
      debugPrint('Error finding overlay in widget tree: $e');
    }
    return null;
  }

  static Future<void> hide({ Duration minDuration = const Duration(seconds: 2),}) async {
    if (_overlayEntry == null) {
      debugPrint('⚠️ No overlay to hide');
      return;
    }

    try {
      // Always respect the minimum duration if provided
      if (_showTime != null) {
        final elapsed = DateTime.now().difference(_showTime!);
        
        if (elapsed < minDuration) {
          final remaining = minDuration - elapsed;
          debugPrint(
            '⏳ Waiting ${remaining.inMilliseconds}ms before hiding overlay...',
          );
          await Future.delayed(remaining);
        }
      }

      debugPrint('🎭 Removing overlay...');
      _overlayEntry?.remove();
      _overlayEntry = null;
      _showTime = null;
      debugPrint('✅ Overlay removed successfully');
    } catch (e) {
      // If there's an error hiding the overlay, just clean up the references
      debugPrint('❌ Error hiding overlay: $e');
      _overlayEntry = null;
      _showTime = null;
      throw Exception('Failed to hide overlay: $e');
    }
  }

  /// Check if an overlay is currently showing
  static bool get isShowing => _overlayEntry != null;

  /// Get the current overlay entry (for advanced usage)
  static OverlayEntry? get currentOverlayEntry => _overlayEntry;

  /// Force hide the overlay without waiting for minimum duration
  static void forceHide() {
    if (_overlayEntry != null) {
      debugPrint('🎭 Force removing overlay...');
      _overlayEntry?.remove();
      _overlayEntry = null;
      _showTime = null;
      debugPrint('✅ Overlay force removed successfully');
    }
  }
}
