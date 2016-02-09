// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [AnimationTarget] enumeration.
library rei.animation_target;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'src/enum_serializer.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

enum AnimationTarget {
  /// Targets the opacity style.
  opacity,
  /// Targets the filter style to apply a blur.
  blur,
  /// Targets the filter style to apply a sepia effect.
  sepia,
  /// Targets the filter style to apply a grayscale effect.
  grayscale,
  /// Targets the filter style to apply a brightness effect.
  brightness,
  /// Targets the filter style to apply a contrast effect.
  contrast,
  /// Targets the filter style to apply a hue rotate effect.
  hueRotate,
  /// Targets the filter style to apply an invert effect.
  invert,
  /// Targets the filter style to apply a saturate effect.
  saturate,
  /// Targets the translation in the x direction.
  translateX,
  /// Targets the translation in the y direction.
  translateY,
  /// Targets the scale in the x direction.
  scaleX,
  /// Targets the scale in the y direction.
  scaleY
}

//---------------------------------------------------------------------
// Serialization
//---------------------------------------------------------------------

/// Deserializes the [value] into the equivalent [AnimationTarget].
///
/// If no value can be found the default is [AnimationTarget.opacity].
AnimationTarget deserializeAnimationTarget(String value) =>
    deserializeEnum(value, AnimationTarget.values);

/// Serializes the [value] into a string.
String serializeAnimationTarget(AnimationTarget value) =>
    serializeEnum(value);

//---------------------------------------------------------------------
// Helpers
//---------------------------------------------------------------------

/// Determines whether the [value] is targeting a transformation.
///
/// If a translation is being targeted then the element being used should be
/// transformable to ensure efficiency.
bool isTransformTarget(AnimationTarget value) =>
    value.index >= AnimationTarget.translateX.index;
