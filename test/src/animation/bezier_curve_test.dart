// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

@TestOn('vm')
library rei.test.src.animation.bezier_curve_test;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:typed_data';

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';

import 'package:rei/src/animation/bezier_curve.dart';

//---------------------------------------------------------------------
// Tests
//---------------------------------------------------------------------

final Float32List _curveLinear = new Float32List.fromList([0.0, 0.0, 1.0, 1.0]);

void expectDouble(double actual, double expected, [double delta = 0.001]) {
  expect(actual, closeTo(actual, delta));
}

void _bezierPoint() {
  var linearCurve = new BezierCurve(_curveLinear);

  for (var i = 0.0; i < 1.0; i += 0.01) {
    expectDouble(linearCurve.solveUnit(i), i);
  }
  /*
  expect(calculateBezierPoint(_curveLinear, 0.0), 0.0);
  expect(calculateBezierPoint(_curveLinear, 0.5), 0.5);
  expect(calculateBezierPoint(_curveLinear, 1.0), 1.0);
  */
}

//---------------------------------------------------------------------
// Entry point
//---------------------------------------------------------------------

void main() {
  test('applyValue', _bezierPoint);
}
