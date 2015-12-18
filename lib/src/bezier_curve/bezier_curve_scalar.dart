// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [BezierCurveScalar] class.
library rei.src.bezier_curve.bezier_curve_scalar;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'bezier_curve.dart';
import 'bezier_curve_solver.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// A BezierCurve that solves for a single numeric value.
class BezierCurveScalar extends BezierCurve<num> {
  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [BezierCurveScalar] class with a curve defined
  /// by the given control [points].
  BezierCurveScalar(List<num> points)
      : super(points);

  //---------------------------------------------------------------------
  // BezierCurve
  //---------------------------------------------------------------------

  @override
  num solve(double time, num duration, num start, num end, [num _]) {
    var startDouble = start.toDouble();
    var range = end.toDouble() - startDouble;
    var normalizedTime = time.toDouble() / duration.toDouble();
    var epsilon = BezierCurveSolver.computeEpsilon(duration.toDouble());

    return (range * solver.solve(normalizedTime, epsilon)) + startDouble;
  }
}
