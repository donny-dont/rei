// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [BezierCurveList] class.
library rei.src.bezier_curve.bezier_curve_list;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'bezier_curve.dart';
import 'bezier_curve_solver.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// A BezierCurve that solves for a List of numeric values.
class BezierCurveList extends BezierCurve<List<num>> {
  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [BezierCurveList] class with a curve defined
  /// by the given control [points].
  BezierCurveList(List<num> points)
      : super(points);

  //---------------------------------------------------------------------
  // BezierCurve
  //---------------------------------------------------------------------

  @override
  List<num> solve(double time,
                  num duration,
                  List<num> start,
                  List<num> end,
                 [List<num> value]) {
    var count = start.length;

    // Initialize the return value if required
    value ??= new List<num>(count);

    assert(end.length == count);
    assert(value.length == count);

    // Get the normalized time
    var normalizedTime = time.toDouble() / duration.toDouble();

    // Get epsilon
    var epsilon = BezierCurveSolver.computeEpsilon(duration.toDouble());

    // Solve the values
    for (var i = 0; i < count; ++i) {
      var startDouble = start[i].toDouble();
      var range = end[i].toDouble() - startDouble;

      value[i] =
          (range * solver.solve(normalizedTime, epsilon)) + startDouble;
    }

    return value;
  }
}
