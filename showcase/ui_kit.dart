// Excerpt from AniLog (https://github.com/devesh-69/anilog) for viewing only.
// © 2026 Devesh Tatkare. All rights reserved. NOT open source: no copying,
// reuse, modification or redistribution is permitted. See LICENSE.

import 'package:flutter/material.dart';
import '../../../core/theme/ui_tokens.dart';

/// Raised rounded card used across the redesign.
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Color? color;
  final BoxBorder? border;

  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(14),
    this.radius = 18,
    this.onTap,
    this.onLongPress,
    this.color,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final ui = context.ui;
    final shape = BorderRadius.circular(radius);
    return Container(
      decoration: BoxDecoration(
        color: color ?? ui.card,
        borderRadius: shape,
        border: border,
        boxShadow: ui.cardShadow,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: shape,
          onTap: onTap,
          onLongPress: onLongPress,
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}

/// Rounded filter / choice pill (34px high). Selected = filled accent.
class PillChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final Color? selectedColor;
  final IconData? icon;

  const PillChip({
    super.key,
    required this.label,
    this.selected = false,
    this.onTap,
    this.selectedColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final ui = context.ui;
    final fill = selectedColor ?? ui.link;
    final fg = selected ? (ThemeData.estimateBrightnessForColor(fill) == Brightness.dark ? Colors.white : Colors.black) : ui.ink;
    return Semantics(
      selected: selected,
      button: true,
      child: Material(
        color: selected ? fill : ui.card,
        shape: StadiumBorder(side: selected ? BorderSide.none : BorderSide(color: ui.border)),
        child: InkWell(
          customBorder: const StadiumBorder(),
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 34),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 16, color: fg),
                    const SizedBox(width: 6),
                  ],
                  Text(label, style: ui.body(13, weight: selected ? FontWeight.w600 : FontWeight.w500, color: fg)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Small rounded label, e.g. "Completed · Auto", "Review", genre chips.
class ToneBadge extends StatelessWidget {
  final String label;
  final Tone? tone;
  final bool outlined;

  const ToneBadge({super.key, required this.label, this.tone, this.outlined = false});

  @override
  Widget build(BuildContext context) {
    final ui = context.ui;
    final t = tone ?? ui.primaryTone;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: outlined ? null : t.bg,
        borderRadius: BorderRadius.circular(8),
        border: outlined ? Border.all(color: ui.border) : null,
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: ui.body(11, weight: outlined ? FontWeight.w500 : FontWeight.w600, color: outlined ? ui.ink : t.fg),
      ),
    );
  }
}

/// Large screen title with an optional subtitle and trailing actions.
class ScreenHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<Widget> actions;
  final EdgeInsetsGeometry padding;

  const ScreenHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.actions = const [],
    this.padding = const EdgeInsets.fromLTRB(20, 16, 12, 8),
  });

  @override
  Widget build(BuildContext context) {
    final ui = context.ui;
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Semantics(header: true, child: Text(title, style: ui.heading(26))),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(subtitle!, style: ui.body(13, color: ui.muted)),
                ],
              ],
            ),
          ),
          ...actions,
        ],
      ),
    );
  }
}

/// Number + caption tile on a pastel tone (month recap, stats).
class StatTile extends StatelessWidget {
  final String value;
  final String label;
  final Tone tone;

  const StatTile({super.key, required this.value, required this.label, required this.tone});

  @override
  Widget build(BuildContext context) {
    final ui = context.ui;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: tone.bg, borderRadius: BorderRadius.circular(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: ui.heading(20, color: tone.fg)),
          const SizedBox(height: 2),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(label, maxLines: 1, style: ui.body(11, color: tone.fg)),
          ),
        ],
      ),
    );
  }
}

/// Day / section divider: "Today · Thu 16 ———".
class LabeledDivider extends StatelessWidget {
  final String label;
  const LabeledDivider({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final ui = context.ui;
    return Row(
      children: [
        Text(label, style: ui.heading(13, weight: FontWeight.w700, color: ui.muted)),
        const SizedBox(width: 10),
        Expanded(child: Container(height: 1, color: ui.divider)),
      ],
    );
  }
}

/// Uppercase settings-style section label.
class SectionLabel extends StatelessWidget {
  final String text;
  final Widget? trailing;
  const SectionLabel(this.text, {super.key, this.trailing});

  @override
  Widget build(BuildContext context) {
    final ui = context.ui;
    return Row(
      children: [
        Text(text.toUpperCase(), style: ui.body(12, weight: FontWeight.w600, color: ui.muted).copyWith(letterSpacing: 0.7)),
        if (trailing != null) ...[const SizedBox(width: 8), trailing!],
      ],
    );
  }
}

/// Bottom-sheet chrome: drag handle, title and close button.
class SheetHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;
  const SheetHeader({super.key, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    final ui = context.ui;
    return Column(
      children: [
        Container(
          width: 40,
          height: 4,
          margin: const EdgeInsets.only(top: 10, bottom: 8),
          decoration: BoxDecoration(color: ui.border, borderRadius: BorderRadius.circular(2)),
        ),
        Row(
          children: [
            Expanded(child: Semantics(header: true, child: Text(title, style: ui.heading(20)))),
            ?trailing,
            IconButton(
              tooltip: 'Close',
              icon: Icon(Icons.close_rounded, color: ui.ink),
              onPressed: () => Navigator.of(context).maybePop(),
            ),
          ],
        ),
      ],
    );
  }
}

/// Primary call-to-action button (52px, rounded 16).
class PrimaryAction extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool busy;
  const PrimaryAction({super.key, required this.label, this.onPressed, this.busy = false});

  @override
  Widget build(BuildContext context) {
    final ui = context.ui;
    return SizedBox(
      height: 52,
      width: double.infinity,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: ui.link,
          foregroundColor: ui.onLink,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: ui.heading(15, weight: FontWeight.w700),
          disabledBackgroundColor: ui.inset,
        ),
        onPressed: busy ? null : onPressed,
        child: busy
            ? SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2.4, color: ui.onLink))
            : Text(label),
      ),
    );
  }
}
