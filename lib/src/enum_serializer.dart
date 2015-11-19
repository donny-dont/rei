// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Helper methods for serializing an enum so it can be used as an attribute in
/// a custom element.
library rei.src.enum_serializer;

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

// \TODO Use type annotations if Dart gets support for generic functions

/// Deserializes an enumeration.
///
/// Determines if [serialized] matches an item within [values]. If it does not
/// then the value at [defaultIndex] is returned instead.
///
/// The toString method of an enumeration takes the form name.value so the
/// matching is done by looking at what the string ends with.
dynamic deserializeEnum(String serialized,
                        List values,
                       [int defaultIndex = 0]) {
  serialized = serialized.toLowerCase();

  return values.firstWhere(
      (enumeration) => enumeration.toString().toLowerCase().endsWith(serialized),
      orElse: () => values[defaultIndex]
  );
}

/// Serializes an enumeration.
String serializeEnum(dynamic value) {
  var valueString = value.toString();
  var lastIndex = valueString.lastIndexOf('.');

  return valueString.substring(lastIndex + 1).toLowerCase();
}
