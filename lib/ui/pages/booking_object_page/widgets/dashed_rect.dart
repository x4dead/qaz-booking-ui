// ignore_for_file: unnecessary_this
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:qaz_booking_ui/themes/colors/app_colors.dart';
import 'package:qaz_booking_ui/utils/constants/ui_constants.dart';

enum BorderType { circle, rRect, rect, oval }

class DashedRect extends StatelessWidget {
  final double? strokeWidth;
  final List<double>? dashPattern;
  final Color? color;
  final Gradient? gradient;
  final BorderType? borderType;
  final Radius? radius;
  final StrokeCap? strokeCap;
  final PathBuilder? customPath;
  final EdgeInsets? padding;
  final Widget child;
  const DashedRect(
      {super.key,
      this.color = AppColors.colorGray,
      this.strokeWidth = 1.0,
      required this.child,
      this.dashPattern = const [4.2, 4],
      this.gradient,
      this.borderType = BorderType.rRect,
      this.radius = const Radius.circular(12),
      this.strokeCap = StrokeCap.butt,
      this.customPath,
      this.padding = kPZero});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedPainter(
          color: color!,
          strokeCap: strokeCap!,
          customPath: customPath,
          gradient: gradient,
          strokeWidth: strokeWidth!,
          radius: radius!,
          borderType: borderType!,
          dashPattern: dashPattern!,
          padding: padding!),
      child: child,
    );
  }
}

typedef PathBuilder = Path Function(Size);

class DashedPainter extends CustomPainter {
  final double strokeWidth;
  final List<double> dashPattern;
  final Color color;
  final Gradient? gradient;
  final BorderType borderType;
  final Radius radius;
  final StrokeCap strokeCap;
  final PathBuilder? customPath;
  final EdgeInsets padding;

  DashedPainter({
    this.strokeWidth = 2,
    this.dashPattern = const <double>[3, 1],
    this.color = Colors.black,
    this.gradient,
    this.borderType = BorderType.rect,
    this.radius = const Radius.circular(0),
    this.strokeCap = StrokeCap.butt,
    this.customPath,
    this.padding = EdgeInsets.zero,
  }) {
    assert(dashPattern.isNotEmpty, 'Dash Pattern cannot be empty');
  }

  @override
  void paint(Canvas canvas, Size originalSize) {
    final Size size;
    if (padding == EdgeInsets.zero) {
      size = originalSize;
    } else {
      canvas.translate(padding.left, padding.top);
      size = Size(
        originalSize.width - padding.horizontal,
        originalSize.height - padding.vertical,
      );
    }

    Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..strokeCap = strokeCap
      ..style = PaintingStyle.stroke;

    if (gradient != null) {
      final rect = Offset.zero & size;
      paint.shader = gradient!.createShader(rect);
    } else {
      paint.color = color;
    }

    Path _path;
    if (customPath != null) {
      _path = dashPath(
        customPath!(size),
        dashArray: CircularIntervalList(dashPattern),
      );
    } else {
      _path = _getPath(size);
    }

    canvas.drawPath(_path, paint);
  }

  /// Returns a [Path] based on the the [borderType] parameter
  Path _getPath(Size size) {
    Path path;
    switch (borderType) {
      case BorderType.circle:
        path = _getCirclePath(size);
        break;
      case BorderType.rRect:
        path = _getRRectPath(size, radius);
        break;
      case BorderType.rect:
        path = _getRectPath(size);
        break;
      case BorderType.oval:
        path = _getOvalPath(size);
        break;
    }

    return dashPath(path, dashArray: CircularIntervalList(dashPattern));
  }

  /// Returns a circular path of [size]
  Path _getCirclePath(Size size) {
    double w = size.width;
    double h = size.height;
    double s = size.shortestSide;

    return Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            w > s ? (w - s) / 2 : 0,
            h > s ? (h - s) / 2 : 0,
            s,
            s,
          ),
          Radius.circular(s / 2),
        ),
      );
  }

  /// Returns a Rounded Rectangular Path with [radius] of [size]
  Path _getRRectPath(Size size, Radius radius) {
    return Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            0,
            0,
            size.width,
            size.height,
          ),
          radius,
        ),
      );
  }

  /// Returns a path of [size]
  Path _getRectPath(Size size) {
    return Path()
      ..addRect(
        Rect.fromLTWH(
          0,
          0,
          size.width,
          size.height,
        ),
      );
  }

  /// Return an oval path of [size]
  Path _getOvalPath(Size size) {
    return Path()
      ..addOval(
        Rect.fromLTWH(
          0,
          0,
          size.width,
          size.height,
        ),
      );
  }

  @override
  bool shouldRepaint(DashedPainter oldDelegate) {
    return oldDelegate.strokeWidth != this.strokeWidth ||
        oldDelegate.color != this.color ||
        oldDelegate.dashPattern != this.dashPattern ||
        oldDelegate.padding != this.padding ||
        oldDelegate.borderType != this.borderType;
  }
}

Path dashPath(
  Path source, {
  required CircularIntervalList<double> dashArray,
  DashOffset? dashOffset,
}) {
  assert(dashArray != null); // ignore: unnecessary_null_comparison

  dashOffset = dashOffset ?? const DashOffset.absolute(0.0);
  // TODO: Is there some way to determine how much of a path would be visible today?

  final Path dest = Path();
  for (final PathMetric metric in source.computeMetrics()) {
    double distance = dashOffset._calculate(metric.length);
    bool draw = true;
    while (distance < metric.length) {
      final double len = dashArray.next;
      if (draw) {
        dest.addPath(metric.extractPath(distance, distance + len), Offset.zero);
      }
      distance += len;
      draw = !draw;
    }
  }

  return dest;
}

enum _DashOffsetType { absolute, percentage }

class DashOffset {
  DashOffset.percentage(double percentage)
      : _rawVal = percentage.clamp(0.0, 1.0),
        _dashOffsetType = _DashOffsetType.percentage;

  const DashOffset.absolute(double start)
      : _rawVal = start,
        _dashOffsetType = _DashOffsetType.absolute;

  final double _rawVal;
  final _DashOffsetType _dashOffsetType;

  double _calculate(double length) {
    return _dashOffsetType == _DashOffsetType.absolute
        ? _rawVal
        : length * _rawVal;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is DashOffset &&
        other._rawVal == _rawVal &&
        other._dashOffsetType == _dashOffsetType;
  }

  @override
  int get hashCode => Object.hash(_rawVal, _dashOffsetType);
}

class CircularIntervalList<T> {
  CircularIntervalList(this._vals);

  final List<T> _vals;
  int _idx = 0;

  T get next {
    if (_idx >= _vals.length) {
      _idx = 0;
    }
    return _vals[_idx++];
  }
}
