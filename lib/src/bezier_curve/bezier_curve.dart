// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [BezierCurve] class.
library rei.src.bezier_curve.bezier_curve;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'bezier_curve_solver.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Base class for a [BezierCurve].
abstract class BezierCurve<T> {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The computation for the bezier curve.
  final BezierCurveSolver solver;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [BezierCurve] class with a curve defined by
  /// the given control [points].
  BezierCurve(List<num> points)
      : solver = new BezierCurveSolver(points);

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Solves the bezier curve at the given [time] over the given [duration]
  /// whose result is based on the [start] and [end] values.
  ///
  /// Additionally the [value] parameter can be used to provide an initialized
  /// output. This would save on object creation for cases where [T] is not a
  /// simple type like a number but instead a List.
  T solve(double time, num duration, T start, T end, [T value]);
}
