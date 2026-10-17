// Excerpt from AniLog (https://github.com/devesh-69/anilog) for viewing only.
// © 2026 Devesh Tatkare. All rights reserved. NOT open source: no copying,
// reuse, modification or redistribution is permitted. See LICENSE.

import 'package:flutter/material.dart';
import '../../../core/theme/ui_tokens.dart';
import '../../../domain/entities/anime_enums.dart';

/// Base hue per watch status (shared by the library rows and the stats charts).
Color statusBaseColor(AnimeStatus status) => switch (status) {
      AnimeStatus.completed => const Color(0xFF3E9467),
      AnimeStatus.watching => const Color(0xFF1E7FA3),
      AnimeStatus.dropped => const Color(0xFFD0603F),
      AnimeStatus.onHold => const Color(0xFF7A5BC7),
      AnimeStatus.planToWatch => const Color(0xFF8A93A0),
    };

/// Readable text color for a status label on a card.
Color statusInk(UiTokens ui, AnimeStatus status) {
  final base = statusBaseColor(status);
  return ui.isDark ? Color.lerp(base, Colors.white, 0.35)! : Color.lerp(base, Colors.black, 0.18)!;
}

String statusLabel(AnimeStatus status) => switch (status) {
      AnimeStatus.watching => 'Watching',
      AnimeStatus.completed => 'Completed',
      AnimeStatus.onHold => 'On hold',
      AnimeStatus.dropped => 'Dropped',
      AnimeStatus.planToWatch => 'Planned',
    };

String mediaTypeLabel(MediaType type) => switch (type) {
      MediaType.tv => 'TV',
      MediaType.movie => 'Movie',
      MediaType.ova => 'OVA',
      MediaType.ona => 'ONA',
      MediaType.special => 'Special',
      MediaType.music => 'Music',
      MediaType.unknown => 'Other',
    };
