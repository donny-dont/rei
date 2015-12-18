// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

@TestOn('vm')
library rei.test.src.bezier_curve.bezier_curve_solver_test;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:typed_data';

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';

import 'package:rei/src/bezier_curve/bezier_curve_solver.dart';

//---------------------------------------------------------------------
// Tests
//---------------------------------------------------------------------

final Float32List _curveLinear = new Float32List.fromList([0.0, 0.0, 1.0, 1.0]);

void expectDouble(double actual, double expected, [double delta = 0.001]) {
  expect(actual, closeTo(actual, delta));
}

void _solve() {
  var linearCurve = new BezierCurveSolver(_curveLinear);

  for (var i = 0.0; i < 1.0; i += 0.01) {
    expectDouble(linearCurve.solve(i), i);
  }
}

//---------------------------------------------------------------------
// Entry point
//---------------------------------------------------------------------

void main() {
  test('solve', _solve);
}
