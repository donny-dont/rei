// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

@TestOn('vm')
library rei.test.direction_serializer.direction_serializer;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:rei/direction.dart';
import 'package:test/test.dart';

//---------------------------------------------------------------------
// Tests
//---------------------------------------------------------------------

void _deserialize() {
  expect(deserializeDirection('horizontal'), Direction.horizontal);
  expect(deserializeDirection('vertical'), Direction.vertical);

  // Check defaults
  expect(deserializeDirection('0000'), Direction.horizontal);
}

void _serialize() {
  expect(serializeDirection(Direction.horizontal), 'horizontal');
  expect(serializeDirection(Direction.vertical), 'vertical');
}

//---------------------------------------------------------------------
// Entry point
//---------------------------------------------------------------------

void main() {
  group('DirectionSerializer', () {
    test('deserializeDirection', _deserialize);
    test('serializeDirection', _serialize);
  });
}
