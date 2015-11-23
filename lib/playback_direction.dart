// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [PlaybackDirection] enumeration.
library rei.playback_direction;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:rei/src/enum_serializer.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Defines a direction for the animation to playback in.
enum PlaybackDirection {
  /// Animation should play in the forward direction as specified.
  forward,
  /// Animation should play in the reverse direction as specified.
  reverse,
  /// Even iterations are played in the forward direction as specified while
  /// odd iterations are played in the reverse direction.
  alternate,
  /// Even iterations are played in the reverse direction as specified while
  /// odd iterations are played in the forward direction.
  alternateReverse
}

//---------------------------------------------------------------------
// Serialization
//---------------------------------------------------------------------

/// Deserializes the [value] into the equivalent [PlaybackDirection].
///
/// If no value can be found the default is [PlaybackDirection.forward].
PlaybackDirection deserializePlaybackDirection(String value) =>
    deserializeEnum(value, PlaybackDirection.values);

/// Serializes the [value] into a string.
String serializePlaybackDirection(PlaybackDirection value) =>
    serializeEnum(value);
