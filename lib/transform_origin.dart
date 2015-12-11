// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [Direction] enumeration.
library rei.transform_origin;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:rei/src/enum_serializer.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Defines an origin for a transformable element.
enum TransformOrigin {
  /// Transform around the left top.
  leftTop,
  centerTop,
  /// Transform around the center point
  center
}

//---------------------------------------------------------------------
// Serialization
//---------------------------------------------------------------------

/// Deserializes the [value] into the equivalent [TransformOrigin].
///
/// If no value can be found the default is [TransformOrigin.leftTop].
TransformOrigin deserializeTransformOrigin(String value) =>
    deserializeEnum(value, TransformOrigin.values);

/// Serializes the [value] into a string.
String serializeTransformOrigin(TransformOrigin value) =>
    serializeEnum(value);

String transformOriginStyle(TransformOrigin value) {
  switch (value) {
    case TransformOrigin.leftTop:
      return 'left top';
    case TransformOrigin.centerTop:
      return 'center top';
    case TransformOrigin.center:
      return 'center center';
  }
}
