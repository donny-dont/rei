// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [Direction] enumeration.
library rei.direction;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'src/enum_serializer.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Defines a direction for an element to flow in.
enum Direction {
  /// The element flows horizontally, left and right.
  horizontal,
  /// The element flows vertically, up and down.
  vertical
}

//---------------------------------------------------------------------
// Serialization
//---------------------------------------------------------------------

/// Deserializes the [value] into the equivalent [Direction].
///
/// If no value can be found the default is [Direction.horizontal].
Direction deserializeDirection(String value) =>
  deserializeEnum(value, Direction.values);

/// Serializes the [value] into a string.
String serializeDirection(Direction value) =>
  serializeEnum(value);
