// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

library rei.test.src.enum_serializer_test;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:rei/src/enum_serializer.dart';
import 'package:test/test.dart';

//---------------------------------------------------------------------
// Tests
//---------------------------------------------------------------------

enum _TestEnum {
  a,
  b,
  c,
  d
}

void _deserialize() {
  expect(deserializeEnum('a', _TestEnum.values), _TestEnum.a);
  expect(deserializeEnum('b', _TestEnum.values), _TestEnum.b);
  expect(deserializeEnum('c', _TestEnum.values), _TestEnum.c);
  expect(deserializeEnum('d', _TestEnum.values), _TestEnum.d);

  // Check defaults
  expect(deserializeEnum('0000', _TestEnum.values), _TestEnum.values[0]);
  expect(deserializeEnum('0000', _TestEnum.values, 1), _TestEnum.values[1]);
  expect(deserializeEnum('0000', _TestEnum.values, 2), _TestEnum.values[2]);
  expect(deserializeEnum('0000', _TestEnum.values, 3), _TestEnum.values[3]);
}

void _serialize() {
  expect(serializeEnum(_TestEnum.a), 'a');
  expect(serializeEnum(_TestEnum.b), 'b');
  expect(serializeEnum(_TestEnum.c), 'c');
  expect(serializeEnum(_TestEnum.d), 'd');
}

//---------------------------------------------------------------------
// Entry point
//---------------------------------------------------------------------

void main() {
  group('enum_serializer', () {
    test('deserialize', _deserialize);
    test('serialize', _serialize);
  });
}
