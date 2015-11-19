// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

@TestOn('vm')
library rei.test.src.matrix_math_test;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:typed_data';

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:rei/src/matrix_math.dart';
import 'package:test/test.dart';

//---------------------------------------------------------------------
// Tests
//---------------------------------------------------------------------

void _creation2D() {
  var x = 100.0;
  var y = 200.0;
  var scaleX = 300.0;
  var scaleY = 400.0;

  var out = new Float32List(6);

  create2DTransform(out, x, y, scaleX, scaleY);

  expect(out[0], scaleX);
  expect(out[1], 0.0);
  expect(out[2], 0.0);
  expect(out[3], scaleY);
  expect(out[4], x);
  expect(out[5], y);
}

void _multiply2D() {
  var a = new Float32List(6);
  var b = new Float32List(6);
  var out = new Float32List(6);

  create2DTransform(a, 1.0, 2.0, 3.0, 4.0);
  create2DTransform(b, 2.0, 3.0, 4.0, 5.0);

  multiply2DTransform(out, a, b);

  expect(out[0], 12.0); // Scale X
  expect(out[1],  0.0); // Empty
  expect(out[2],  0.0); // Empty
  expect(out[3], 20.0); // Scale Y
  expect(out[4],  7.0); // Translate X
  expect(out[5], 14.0); // Translate Y
}

void _copy2D() {
  var a = new Float32List(6);
  var out = new Float32List(6);

  for (var i = 0; i < a.length; ++i) {
    expect(out[i], a[i]);
  }
}

//---------------------------------------------------------------------
// Entry point
//---------------------------------------------------------------------

void main() {
  test('create2DTransform', _creation2D);
  test('multiply2DTransform', _multiply2D);
  test('copy2DTransform', _copy2D);
}
