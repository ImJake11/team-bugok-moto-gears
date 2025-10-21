import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimelineComponent extends StatelessWidget {
  final bool isLast;
  final bool isPast;
  final bool isFirst;
  final Widget child;

  // ignore: unused_element_parameter
  const TimelineComponent({
    // ignore: unused_element_parameter
    super.key,
    required this.isLast,
    required this.isPast,
    required this.isFirst,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<MyThemeProvider>();

    return TweenAnimationBuilder<Color?>(
      tween: ColorTween(
        begin: Colors.grey.shade800,
        end: isPast
            ? theme.tertiary
            : Colors.grey.shade800,
      ),
      duration: Duration(milliseconds: 200),
      builder: (_, color, _) => TimelineTile(
        alignment: TimelineAlign.start,
        lineXY: 1.5,
        isFirst: isFirst,
        isLast: isLast,
        indicatorStyle: IndicatorStyle(
          padding: EdgeInsets.only(right: 40),
          height: 30,
          width: 30,
          indicator: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isPast ? theme.primary : Colors.grey.shade800,
            ),
            child: Icon(
              isPast ? Icons.done : Icons.close,
              size: 15,
            ),
          ),
        ),
        hasIndicator: true,
        beforeLineStyle: LineStyle(
          color: color!,
        ),
        endChild: child,
      ),
    );
  }
}
