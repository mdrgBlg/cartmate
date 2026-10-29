import 'package:flutter/material.dart';

/// Sweeps a highlight band over [child] while content is loading.
///
/// `srcATop` repaints every painted pixel of the child with the gradient, so
/// the child must consist only of `ShimmerBox`es and layout widgets (no
/// backgrounds, borders or shadows).
class Shimmer extends StatefulWidget {
  const Shimmer({
    required this.child,
    this.baseColor,
    this.highlightColor,
    super.key,
  });

  final Widget child;
  final Color? baseColor;
  final Color? highlightColor;

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final base = widget.baseColor ?? scheme.surfaceContainerHighest;
    final highlight =
        widget.highlightColor ??
        (scheme.brightness == Brightness.light
            ? scheme.surface
            : Color.alphaBlend(scheme.onSurface.withValues(alpha: 0.12), base));

    if (MediaQuery.disableAnimationsOf(context)) {
      return widget.child;
    }

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        child: widget.child,
        builder: (_, child) => ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) => LinearGradient(
            colors: [base, highlight, base],
            stops: const [0.3, 0.5, 0.7],
            transform: _SlideGradientTransform(_controller.value),
          ).createShader(bounds),
          child: child,
        ),
      ),
    );
  }
}

class _SlideGradientTransform extends GradientTransform {
  const _SlideGradientTransform(this.percent);

  final double percent;

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * (percent * 2 - 1), 0, 0);
  }
}
