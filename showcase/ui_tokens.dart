// Excerpt from AniLog (https://github.com/devesh-69/anilog) for viewing only.
// © 2026 Devesh Tatkare. All rights reserved. NOT open source: no copying,
// reuse, modification or redistribution is permitted. See LICENSE.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A soft background + readable foreground pair, used for badges, icon
/// circles and stat tiles (e.g. the "Completed" / "Review" labels).
class Tone {
  final Color bg;
  final Color fg;
  const Tone(this.bg, this.fg);
}

/// Redesign tokens derived from the active [ThemeData], so every theme preset
/// (light and dark) gets the same look: raised cards, soft borders and pastel
/// badges computed from that preset's own colors.
class UiTokens {
  final ThemeData theme;
  UiTokens._(this.theme);

  factory UiTokens.of(BuildContext context) => UiTokens._(Theme.of(context));

  ColorScheme get cs => theme.colorScheme;
  bool get isDark => theme.brightness == Brightness.dark;

  /// Page background.
  Color get bg => theme.scaffoldBackgroundColor;

  /// Raised card surface: white on light themes, the scheme surface on dark.
  Color get card => isDark ? cs.surface : Colors.white;

  /// Primary text.
  Color get ink => cs.onSurface;

  /// Secondary text (dates, counts, subtitles). Stays above 4.5:1 on [card].
  Color get muted => Color.lerp(cs.onSurface, card, 0.38)!;

  /// Input / chip outlines.
  Color get border => Color.lerp(cs.onSurface, card, isDark ? 0.78 : 0.82)!;

  /// Hairline separators.
  Color get divider => Color.lerp(cs.onSurface, card, isDark ? 0.86 : 0.89)!;

  /// Fill for neutral chips and inset boxes.
  Color get inset => Color.lerp(bg, cs.onSurface, isDark ? 0.08 : 0.04)!;

  List<BoxShadow> get cardShadow => isDark
      ? const []
      : const [BoxShadow(color: Color(0x0F1E2229), blurRadius: 2, offset: Offset(0, 1))];

  List<BoxShadow> get floatingShadow => [
        BoxShadow(
          color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.10),
          blurRadius: 18,
          offset: const Offset(0, 4),
        ),
      ];

  /// Soft pastel pair built from any accent color.
  Tone tone(Color base) => Tone(
        Color.alphaBlend(base.withValues(alpha: isDark ? 0.24 : 0.17), card),
        isDark ? Color.lerp(base, Colors.white, 0.55)! : Color.lerp(base, Colors.black, 0.55)!,
      );

  Tone get primaryTone => tone(cs.primary);
  Tone get secondaryTone => tone(cs.secondary);
  Tone get tertiaryTone => tone(cs.tertiary);
  Tone get violetTone => tone(const Color(0xFF7A5BC7));

  /// Accent for small text on [card] (darker than primary on light themes).
  Color get link => isDark ? Color.lerp(cs.primary, Colors.white, 0.25)! : Color.lerp(cs.primary, Colors.black, 0.2)!;

  /// Text/icon color on a [link]-filled surface (buttons, FAB, selected pills):
  /// white on dark accents, near-black on the lighter accents of dark themes.
  Color get onLink =>
      ThemeData.estimateBrightnessForColor(link) == Brightness.dark ? Colors.white : const Color(0xFF0E1A20);

  // Typography — Manrope headings, Be Vietnam Pro body (as in the design).
  // Loaded through google_fonts: a bare `fontFamily: 'Manrope'` would fall
  // back to the platform font because the fonts are not bundled as assets.
  TextStyle heading(double size, {FontWeight weight = FontWeight.w800, Color? color}) => GoogleFonts.manrope(
        fontSize: size,
        fontWeight: weight,
        letterSpacing: size >= 24 ? -0.4 : 0,
        height: 1.25,
        color: color ?? ink,
      );

  TextStyle body(double size, {FontWeight weight = FontWeight.w400, Color? color, double? height}) =>
      GoogleFonts.beVietnamPro(
        fontSize: size,
        fontWeight: weight,
        height: height,
        color: color ?? ink,
      );
}

extension UiTokensX on BuildContext {
  UiTokens get ui => UiTokens.of(this);
}
