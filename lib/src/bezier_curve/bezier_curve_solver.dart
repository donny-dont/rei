// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [BezierCurveSolver] class.
library rei.src.bezier_curve.bezier_curve_solver;

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Solves a bezier curve using the same implementation as what is found in
/// WebKit based browsers.
class BezierCurveSolver {
  static const double _epsilon = 1.0 / (200.0 * 400.0);

  static double computeEpsilon(double duration) {
    var computed = 1.0 / (200 * duration);

    return computed <= _epsilon ? computed : _epsilon;
  }

  /// The control points.
  final List<num> points;
  final double _ax;
  final double _bx;
  final double _cx;
  final double _ay;
  final double _by;
  final double _cy;

  factory BezierCurveSolver(List<num> points) {
    var p1x = points[0].toDouble();
    var p1y = points[1].toDouble();
    var p2x = points[2].toDouble();
    var p2y = points[3].toDouble();

    // Compute x components
    var cx = 3.0 * p1x;
    var bx = 3.0 * (p2x - p1x) - cx;
    var ax = 1.0 - cx - bx;

    // Compute y components
    var cy = 3.0 * p1y;
    var by = 3.0 * (p2y - p1y) - cy;
    var ay = 1.0 - cy - by;

    return new BezierCurveSolver._(points, ax, bx, cx, ay, by, cy);
  }

  BezierCurveSolver._(this.points,
                      this._ax,
                      this._bx,
                      this._cx,
                      this._ay,
                      this._by,
                      this._cy);

  double solve(double time, [double epsilon = _epsilon]) =>
      _sampleCurveY(_solveCurveX(time, epsilon));

  double _sampleCurveX(double t) =>
      ((_ax * t + _bx) * t + _cx) * t;

  double _sampleCurveY(double t) =>
      ((_ay * t + _by) * t + _cy) * t;

  double _sampleCurveDerivativeX(double t) =>
      (((3.0 * _ax * t) + (2.0 * _bx)) * t) + _cx;

  double _solveCurveX(double x, double epsilon) {
    var t2 = x;

    for (var i = 0; i < 8; ++i) {
      var x2 = _sampleCurveX(t2) - x;
      if (x2.abs() < epsilon) {
        return t2;
      }

      var d2 = _sampleCurveDerivativeX(t2);
      if (d2.abs() < 1e-6) {
        break;
      }

      t2 -= x2 / d2;
    }

    var t0 = 0.0;
    var t1 = 1.0;
    t2 = x;

    if (t2 < t0) {
      return t0;
    } else if (t2 > t1) {
      return t1;
    }

    while (t0 < t1) {
      var x2 = _sampleCurveX(t2);
      if ((x2 - x).abs() < epsilon) {
        return t2;
      } else if (x > x2) {
        t0 = t2;
      } else {
        t1 = t2;
      }

      t2 = (t1 - t0) * 0.5 + t0;
    }

    return t2;
  }
}
