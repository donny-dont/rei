// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains functions for using bezier curves to animate.
library rei.src.animation.bezier_curve;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'dart:typed_data';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Calculates the point at the given [time] using the specified control
/// [points].
///
/// It is assumed that [time] is in the range of \[0.0 - 1.0\]. It is also
/// assumed that [points] has a length of 4.
double calculateBezierPoint(Float32List points, double time) {
  assert(time >= 0.0 && time <= 1.0);
  assert(points.length == 4);

  // A bezier curve can be solved with the following functions
  //
  // B1(t) = t^3
  // B2(t) = 3t^2(1 - t)
  // B3(t) = 3t(1 - t)^2
  // B4(t) = (1 - t)^3
  //
  // Save off variables that will be reused
  var timeSquared = time * time;

  var oneMinusTime = 1.0 - time;
  var oneMinusTimeSquared = oneMinusTime * oneMinusTime;

  // Compute the value
  return
      points[0] * (timeSquared * time) +                 // B1(t)
      points[1] * (3.0 * timeSquared * oneMinusTime) +   // B2(t)
      points[2] * (3.0 * time * oneMinusTimeSquared) +   // B3(t)
      points[3] * (oneMinusTimeSquared * oneMinusTime);  // B4(t)
}

double calculateBezierValue(Float32List points,
                            num time,
                            num duration,
                            num start,
                            num end) {
  var startDouble = start.toDouble();
  var range = end.toDouble() - startDouble;
  var normalizedTime = time.toDouble() / duration.toDouble();

  return (range * calculateBezierPoint(points, normalizedTime)) + startDouble;
}
