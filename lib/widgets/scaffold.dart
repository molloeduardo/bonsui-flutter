import 'dart:async';
import 'dart:collection';
import 'package:animate_do/animate_do.dart';
import 'package:bonsui/bonsui.dart';
import 'package:bonsui/enums/animation.dart';
import 'package:bonsui/utils.dart';
import 'package:bonsui/widgets/confetti.dart';
import 'package:bonsui/widgets/notification_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BonsuiScaffold extends StatefulWidget {
  const BonsuiScaffold({
    super.key,
    this.appBar,
    this.body,
    this.resizeToAvoidBottomInset,
    this.bottomNavigationBar,
    this.extendedBody,
    this.floatingActionButtonLocation,
    this.floatingActionButton,
    this.backgroundColor,
    this.safeArea,
    this.scrollable,
    this.padding,
    this.onPop,
    this.canPop,
  });

  final BonsuiAppBar? appBar;
  final Widget? body;
  final bool? resizeToAvoidBottomInset;
  final Widget? bottomNavigationBar;
  final bool? extendedBody;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final bool? safeArea;
  final bool? scrollable;
  final EdgeInsets? padding;
  final PopInvokedWithResultCallback<dynamic>? onPop;
  final bool? canPop;

  @override
  State<BonsuiScaffold> createState() => BonsuiScaffoldState();
}

class BonsuiScaffoldState extends State<BonsuiScaffold>
    with WidgetsBindingObserver {
  final Queue<QueuedNotification> _queue = Queue();
  bool _processing = false;
  final Map<Key, Widget> _confettiEffects = {};

  void showConfetti({
    int count = 100,
    bool explosion = true,
    bool useHapticFeedback = false,
    Alignment position = Alignment.topCenter,
    Duration duration = const Duration(seconds: 3),
  }) {
    if (!mounted) {
      throw StateError('Cannot show confetti on an unmounted BonsuiScaffold.');
    }
    if (count <= 0) {
      throw ArgumentError.value(count, 'count', 'Must be greater than zero.');
    }
    if (duration <= Duration.zero) {
      throw ArgumentError.value(duration, 'duration', 'Must be positive.');
    }
    if (!position.x.isFinite ||
        !position.y.isFinite ||
        position.x.abs() > 1 ||
        position.y.abs() > 1) {
      throw ArgumentError.value(
        position,
        'position',
        'Coordinates must be finite and between -1 and 1.',
      );
    }

    final key = UniqueKey();
    setState(() {
      _confettiEffects[key] = Positioned.fill(
        key: key,
        child: BonsuiConfettiEffect(
          count: count,
          explosion: explosion,
          position: position,
          duration: duration,
          onCompleted: () {
            if (!mounted) return;
            setState(() => _confettiEffects.remove(key));
          },
        ),
      );
    });
    if (useHapticFeedback) {
      unawaited(HapticFeedback.lightImpact());
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateBrightness();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _updateBrightness();
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
    }
  }

  @override
  void didChangePlatformBrightness() {
    _updateBrightness();
  }

  void _updateBrightness() {
    if (!mounted) return;

    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;

    final useDarkMode = BonsuiDesign.autoDarkMode
        ? brightness == Brightness.dark
        : BonsuiDesign.useDarkMode;

    if (BonsuiDesign.useDarkMode == useDarkMode) return;

    setState(() {
      BonsuiDesign.useDarkMode = useDarkMode;
    });
  }

  OverlayEntry? _overlayEntry;
  Completer<void>? _currentDismissed;

  void enqueue(LocalNotification notification) {
    _queue.add(QueuedNotification(notification));
    if (!_processing) _processQueue();
  }

  Future<void> _processQueue() async {
    _processing = true;
    while (_queue.isNotEmpty && mounted) {
      final item = _queue.removeFirst();

      _closeCurrentOverlay();

      _currentDismissed = Completer<void>();
      final animDur =
          BonsuiDesign.animationDurations[BonsuiAnimationDuration.fast]!;
      final hold = item.notification.duration ?? const Duration(seconds: 3);

      _overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          top: MediaQuery.of(context).padding.top + 16,
          left: 16,
          right: 16,
          child: Material(
            color: Colors.transparent,
            child: FadeInDown(
              from: 30,
              duration: animDur,
              child: FadeOutUp(
                from: 60,
                duration: animDur,
                delay: hold,
                child: BonsuiNotificationBanner(
                  notification: item.notification,
                ),
              ),
            ),
          ),
        ),
      );

      // ignore: use_build_context_synchronously
      Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);

      final total = hold + animDur + const Duration(milliseconds: 80);
      Future.delayed(total, () {
        _completeAndClose();
      });

      await _currentDismissed!.future;
      await Future<void>.delayed(const Duration(milliseconds: 100));
    }
    _processing = false;
  }

  void _completeAndClose() {
    if (_currentDismissed != null && !(_currentDismissed!.isCompleted)) {
      _currentDismissed!.complete();
    }
    _closeCurrentOverlay();
  }

  void _closeCurrentOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _queue.clear();
    _confettiEffects.clear();
    _completeAndClose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: widget.onPop,
      canPop: widget.canPop ?? true,
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: widget.backgroundColor ??
                (BonsuiDesign.useDarkMode
                    ? BonsuiDesign.backgroundColorDark
                    : BonsuiDesign.backgroundColor),
            appBar: widget.appBar,
            body: _getBody(),
            resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset ?? true,
            bottomNavigationBar: widget.bottomNavigationBar != null
                ? Theme(
                    data: Theme.of(context).copyWith(
                      splashFactory: Utils.getSplashFactory(),
                    ),
                    child: widget.bottomNavigationBar!,
                  )
                : null,
            extendBody: widget.extendedBody ?? false,
            floatingActionButtonLocation: widget.floatingActionButtonLocation,
            floatingActionButton: widget.floatingActionButton,
          ),
          ..._confettiEffects.values,
        ],
      ),
    );
  }

  Widget _getBody() {
    if (widget.scrollable == true) {
      final scrollView = SingleChildScrollView(
        padding: _getPadding(),
        child: widget.body ?? const SizedBox(),
      );
      return widget.safeArea == true ? SafeArea(child: scrollView) : scrollView;
    } else if (widget.safeArea == true) {
      return SafeArea(
          child: Padding(
              padding: _getPadding(), child: widget.body ?? const SizedBox()));
    } else {
      return Padding(
          padding: _getPadding(), child: widget.body ?? const SizedBox());
    }
  }

  EdgeInsets _getPadding() {
    if (widget.padding != null) {
      return widget.padding!;
    }

    return EdgeInsets.zero;
  }
}
