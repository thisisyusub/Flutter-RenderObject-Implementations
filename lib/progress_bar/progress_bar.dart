import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class ProgressBar extends LeafRenderObjectWidget {
  const ProgressBar({
    super.key,
    required this.dotColor,
    required this.thumbColor,
    required this.thumbSize,
  });

  final Color dotColor;
  final Color thumbColor;
  final double thumbSize;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderProgressBar(
      dotColor: dotColor,
      thumbColor: thumbColor,
      thumbSize: thumbSize,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderProgressBar renderObject) {
    renderObject
      ..dotColor = dotColor
      ..thumbColor = thumbColor
      ..thumbSize = thumbSize;
  }

  @override
  void debugFillProperties(
    DiagnosticPropertiesBuilder properties,
  ) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty(
      'dotColor',
      dotColor,
    ));
    properties.add(ColorProperty(
      'thumbColor',
      thumbColor,
    ));
    properties.add(DoubleProperty(
      'thumbSize',
      thumbSize,
    ));
  }
}

class RenderProgressBar extends RenderBox {
  RenderProgressBar({
    required Color dotColor,
    required Color thumbColor,
    required double thumbSize,
  })  : _dotColor = dotColor,
        _thumbColor = thumbColor,
        _thumbSize = thumbSize {
    _horizontalDrag = HorizontalDragGestureRecognizer()
      ..onStart = (details) {
        _updateThumbPosition(details.localPosition);
      }
      ..onUpdate = (details) {
        _updateThumbPosition(details.localPosition);
      };
  }

  Color _dotColor;
  Color get dotColor => _dotColor;
  set dotColor(Color value) {
    if (_dotColor == value) {
      return;
    }

    _dotColor = value;
    markNeedsPaint();
  }

  Color _thumbColor;
  Color get thumbColor => _thumbColor;
  set thumbColor(Color value) {
    if (_thumbColor == value) {
      return;
    }

    _thumbColor = value;
    markNeedsPaint();
  }

  double _thumbSize;
  double get thumbSize => _thumbSize;
  set thumbSize(double value) {
    if (_thumbSize == value) {
      return;
    }

    _thumbSize = value;
    markNeedsLayout();
  }

  double _currentThumbvalue = 0.5;

  @override
  void performLayout() {
    size = getDryLayout(constraints);
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final width = constraints.maxWidth;
    final height = thumbSize;
    final barSize = Size(width, height);
    return constraints.constrain(barSize);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;
    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    final dotPaint = Paint()
      ..color = dotColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;

    final barPaint = Paint()
      ..color = thumbColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;

    final spacing = size.width / 10;

    for (int i = 0; i <= 10; i++) {
      var upperPoint = Offset(spacing * i, size.height * 0.75);
      final lowerPoint = Offset(spacing * i, size.height);

      if (i % 5 == 0) {
        upperPoint = Offset(spacing * i, size.height * 0.25);
      }

      if (upperPoint.dx <= _currentThumbvalue * size.width) {
        canvas.drawLine(upperPoint, lowerPoint, barPaint);
      } else {
        canvas.drawLine(upperPoint, lowerPoint, dotPaint);
      }
    }

    final thumbPaint = Paint()..color = thumbColor;
    final thumbDx = _currentThumbvalue * size.width;

    final thumbLinePoint1 = Offset(0, size.height / 2);
    final thumbLinePoint2 = Offset(thumbDx, size.height / 2);
    canvas.drawLine(thumbLinePoint1, thumbLinePoint2, barPaint);

    final center = Offset(thumbDx, size.height / 2);
    canvas.drawCircle(center, thumbSize / 2, thumbPaint);

    canvas.restore();
  }

  late final HorizontalDragGestureRecognizer _horizontalDrag;

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    assert(debugHandleEvent(event, entry));

    if (event is PointerDownEvent) {
      _horizontalDrag.addPointer(event);
    }
  }

  void _updateThumbPosition(Offset localPosition) {
    final dx = localPosition.dx.clamp(0, size.width);
    _currentThumbvalue = double.parse((dx / size.width).toStringAsFixed(1));
    markNeedsPaint();
    markNeedsSemanticsUpdate();
  }
}
