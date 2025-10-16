import 'package:flutter/material.dart';
import 'package:team_bugok_business/utils/services/currency_formetter.dart';

class AnimatedTextValueChange extends StatefulWidget {
  final dynamic value;
  final TextStyle textStyle;
  final Duration duration;
  final bool? isCurrency;

  const AnimatedTextValueChange({
    super.key,
    required this.value,
    required this.textStyle,
    required this.duration,
    this.isCurrency,
  });

  @override
  State<AnimatedTextValueChange> createState() =>
      _AnimatedTextValueChangeState();
}

class _AnimatedTextValueChangeState extends State<AnimatedTextValueChange>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late Animation<double> _animation;

  double _oldValue = 0.0;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animateTo(widget.value);
  }

  void _animateTo(dynamic newValue) {
    final double endValue = (newValue is int)
        ? newValue.toDouble()
        : (newValue as double);

    _animation = Tween<double>(begin: _oldValue, end: endValue).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController
      ..reset()
      ..forward();

    _oldValue = endValue;
  }

  @override
  void didUpdateWidget(covariant AnimatedTextValueChange oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value != widget.value) {
      _animateTo(widget.value);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        final value = widget.value;
        if (value is int) {
          return Text(
            _animation.value.toInt().toString(),
            style: widget.textStyle,
          );
        } else if (value is double) {
          if (widget.isCurrency ?? false) {
            return Text(
              currencyFormatter(_animation.value),
              style: widget.textStyle,
            );
          }

          final percentageValue = _animation.value;

          return Text(
            "${percentageValue.toStringAsFixed(0)}%",
            style: widget.textStyle,
          );
        } else {
          return Text(
            value.toString(),
            style: widget.textStyle,
          );
        }
      },
    );
  }
}
