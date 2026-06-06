import 'package:flutter/material.dart';

extension WidgetAnimationExtension on Widget {
  Widget shake({
    Duration duration = const Duration(milliseconds: 500),
    double amplitude = 10,
  }) =>
      _ShakeWidget(
        duration: duration,
        amplitude: amplitude,
        child: this,
      );

  Widget fadeIn({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeIn,
  }) =>
      _FadeInWidget(
        duration: duration,
        curve: curve,
        child: this,
      );

  Widget scaleIn({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeOutBack,
  }) =>
      _ScaleInWidget(
        duration: duration,
        curve: curve,
        child: this,
      );

  Widget pulse({
    Duration duration = const Duration(milliseconds: 1000),
    double maxScale = 1.1,
  }) =>
      _PulseWidget(
        duration: duration,
        maxScale: maxScale,
        child: this,
      );

  Widget bounceIn({
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.elasticOut,
  }) =>
      _BounceInWidget(
        duration: duration,
        curve: curve,
        child: this,
      );
}

class _ShakeWidget extends StatefulWidget {
  const _ShakeWidget({
    required this.child,
    required this.duration,
    required this.amplitude,
  });

  final Widget child;
  final Duration duration;
  final double amplitude;

  @override
  State<_ShakeWidget> createState() => _ShakeWidgetState();
}

class _ShakeWidgetState extends State<_ShakeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticIn),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final offset = widget.amplitude *
              (1 - _animation.value) *
              _controller.value *
              ((_animation.value * 10).toInt().isEven ? 1 : -1);
          return Transform.translate(offset: Offset(offset, 0), child: child);
        },
        child: widget.child,
      );
}

class _FadeInWidget extends StatefulWidget {
  const _FadeInWidget({
    required this.child,
    required this.duration,
    required this.curve,
  });

  final Widget child;
  final Duration duration;
  final Curve curve;

  @override
  State<_FadeInWidget> createState() => _FadeInWidgetState();
}

class _FadeInWidgetState extends State<_FadeInWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
        opacity: _animation,
        child: widget.child,
      );
}

class _ScaleInWidget extends StatefulWidget {
  const _ScaleInWidget({
    required this.child,
    required this.duration,
    required this.curve,
  });

  final Widget child;
  final Duration duration;
  final Curve curve;

  @override
  State<_ScaleInWidget> createState() => _ScaleInWidgetState();
}

class _ScaleInWidgetState extends State<_ScaleInWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ScaleTransition(
        scale: _animation,
        child: widget.child,
      );
}

class _PulseWidget extends StatefulWidget {
  const _PulseWidget({
    required this.child,
    required this.duration,
    required this.maxScale,
  });

  final Widget child;
  final Duration duration;
  final double maxScale;

  @override
  State<_PulseWidget> createState() => _PulseWidgetState();
}

class _PulseWidgetState extends State<_PulseWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 1, end: widget.maxScale).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ScaleTransition(
        scale: _animation,
        child: widget.child,
      );
}

class _BounceInWidget extends StatefulWidget {
  const _BounceInWidget({
    required this.child,
    required this.duration,
    required this.curve,
  });

  final Widget child;
  final Duration duration;
  final Curve curve;

  @override
  State<_BounceInWidget> createState() => _BounceInWidgetState();
}

class _BounceInWidgetState extends State<_BounceInWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ScaleTransition(
        scale: _animation,
        child: widget.child,
      );
}
