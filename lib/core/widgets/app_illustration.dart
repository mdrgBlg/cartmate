import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Decorative SVG illustration recoloured to the current [ColorScheme].
///
/// The SVG files use fixed placeholder colours that are swapped at load time,
/// so one file serves both light and dark themes.
class AppIllustration extends StatelessWidget {
  const AppIllustration({required this.asset, this.height = 160, super.key});

  final String asset;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      height: height,
      colorMapper: _IllustrationColorMapper.fromScheme(
        Theme.of(context).colorScheme,
      ),
      excludeFromSemantics: true,
    );
  }
}

@immutable
class _IllustrationColorMapper extends ColorMapper {
  const _IllustrationColorMapper({
    required this.primary,
    required this.tint,
    required this.accent,
    required this.neutral,
    required this.paper,
    required this.error,
  });

  factory _IllustrationColorMapper.fromScheme(ColorScheme scheme) =>
      _IllustrationColorMapper(
        primary: scheme.primary.toARGB32(),
        tint: scheme.primaryContainer.toARGB32(),
        accent: scheme.secondary.toARGB32(),
        neutral: scheme.surfaceContainerHighest.toARGB32(),
        paper: scheme.surface.toARGB32(),
        error: scheme.error.toARGB32(),
      );

  // Ints: sendable to the compute isolate and cheap to compare (cache key).
  final int primary;
  final int tint;
  final int accent;
  final int neutral;
  final int paper;
  final int error;

  @override
  Color substitute(
    String? id,
    String elementName,
    String attributeName,
    Color color,
  ) => switch (color.toARGB32() & 0x00FFFFFF) {
    0x4F46E5 => Color(primary),
    0xA5B4FC => Color(tint),
    0xF59E0B => Color(accent),
    0xE5E7EB => Color(neutral),
    0xFFFFFF => Color(paper),
    0xEF4444 => Color(error),
    _ => color,
  };

  @override
  bool operator ==(Object other) =>
      other is _IllustrationColorMapper &&
      other.primary == primary &&
      other.tint == tint &&
      other.accent == accent &&
      other.neutral == neutral &&
      other.paper == paper &&
      other.error == error;

  @override
  int get hashCode => Object.hash(primary, tint, accent, neutral, paper, error);
}
