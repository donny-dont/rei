// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

library rei.src.easing_function.curves;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:typed_data';

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import '../../easing_function.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Bezier curve corresponding to [EasingFunction.linear].
final Float32List _curveLinear = new Float32List.fromList([0.0, 0.0, 1.0, 1.0]);

/// Bezier curve corresponding to [EasingFunction.linear].
final Float32List _curveEase = new Float32List.fromList([0.0, 0.0, 1.0, 1.0]);

/// Bezier curve corresponding to [EasingFunction.linear].
final Float32List _curveEaseIn = new Float32List.fromList([0.0, 0.0, 1.0, 1.0]);

/// Bezier curve corresponding to [EasingFunction.linear].
final Float32List _curveEaseOut =
    new Float32List.fromList([0.0, 0.0, 1.0, 1.0]);

/// Bezier curve corresponding to [EasingFunction.linear].
final Float32List _curveEaseInOut =
    new Float32List.fromList([0.0, 0.0, 1.0, 1.0]);

/// Bezier curve corresponding to [EasingFunction.easeInQuadratic].
final Float32List _curveEaseInQuadratic =
    new Float32List.fromList([0.550, 0.085, 0.680, 0.530]);

/// Bezier curve corresponding to [EasingFunction.easeInCubic].
final Float32List _curveEaseInCubic =
    new Float32List.fromList([0.550, 0.055, 0.675, 0.190]);

/// Bezier curve corresponding to [EasingFunction.easeInQuartic].
final Float32List _curveEaseInQuartic =
    new Float32List.fromList([0.895, 0.030, 0.685, 0.220]);

/// Bezier curve corresponding to [EasingFunction.easeInQuintic].
final Float32List _curveEaseInQuintic =
    new Float32List.fromList([0.755, 0.050, 0.855, 0.060]);

/// Bezier curve corresponding to [EasingFunction.easeInSine].
final Float32List _curveEaseInSine =
    new Float32List.fromList([0.470, 0.000, 0.745, 0.715]);

/// Bezier curve corresponding to [EasingFunction.easeInExponential].
final Float32List _curveEaseInExponential =
    new Float32List.fromList([0.950, 0.050, 0.795, 0.035]);

/// Bezier curve corresponding to [EasingFunction.easeInCircle].
final Float32List _curveEaseInCircle =
    new Float32List.fromList([0.600, 0.040, 0.980, 0.335]);

/// Bezier curve corresponding to [EasingFunction.easeInBack].
final Float32List _curveEaseInBack =
    new Float32List.fromList([0.600, -0.280, 0.735, 0.045]);

/// Bezier curve corresponding to [EasingFunction.easeOutQuad].
final Float32List _curveEaseOutQuadratic =
    new Float32List.fromList([0.250, 0.460, 0.450, 0.940]);

/// Bezier curve corresponding to [EasingFunction.easeOutCubic].
final Float32List _curveEaseOutCubic =
    new Float32List.fromList([0.215, 0.610, 0.355, 1.000]);

/// Bezier curve corresponding to [EasingFunction.easeOutQuartic].
final Float32List _curveEaseOutQuartic =
    new Float32List.fromList([0.165, 0.840, 0.440, 1.000]);

/// Bezier curve corresponding to [EasingFunction.easeOutQuintic].
final Float32List _curveEaseOutQuintic =
    new Float32List.fromList([0.230, 1.000, 0.320, 1.000]);

/// Bezier curve corresponding to [EasingFunction.easeOutSine].
final Float32List _curveEaseOutSine =
    new Float32List.fromList([0.390, 0.575, 0.565, 1.000]);

/// Bezier curve corresponding to [EasingFunction.easeOutExponential].
final Float32List _curveEaseOutExponential =
    new Float32List.fromList([0.190, 1.000, 0.220, 1.000]);

/// Bezier curve corresponding to [EasingFunction.easeOutCircle].
final Float32List _curveEaseOutCircle =
    new Float32List.fromList([0.075, 0.820, 0.165, 1.000]);

/// Bezier curve corresponding to [EasingFunction.easeOutBack].
final Float32List _curveEaseOutBack =
    new Float32List.fromList([0.175, 0.885, 0.320, 1.275]);

/// Bezier curve corresponding to [EasingFunction.easeInOutQuad].
final Float32List _curveEaseInOutQuadratic =
    new Float32List.fromList([0.455, 0.030, 0.515, 0.955]);

/// Bezier curve corresponding to [EasingFunction.easeInOutCubic].
final Float32List _curveEaseInOutCubic =
    new Float32List.fromList([0.645, 0.045, 0.355, 1.000]);

/// Bezier curve corresponding to [EasingFunction.easeInOutQuartic].
final Float32List _curveEaseInOutQuartic =
    new Float32List.fromList([0.770, 0.000, 0.175, 1.000]);

/// Bezier curve corresponding to [EasingFunction.easeInOutQuintic].
final Float32List _curveEaseInOutQuintic =
    new Float32List.fromList([0.860, 0.000, 0.070, 1.000]);

/// Bezier curve corresponding to [EasingFunction.easeInOutSine].
final Float32List _curveEaseInOutSine =
    new Float32List.fromList([0.445, 0.050, 0.550, 0.950]);

/// Bezier curve corresponding to [EasingFunction.easeInOutExponential].
final Float32List _curveEaseInOutExponential =
    new Float32List.fromList([1.000, 0.000, 0.000, 1.000]);

/// Bezier curve corresponding to [EasingFunction.easeInOutCircle].
final Float32List _curveEaseInOutCircle =
    new Float32List.fromList([0.785, 0.135, 0.150, 0.860]);

/// Bezier curve corresponding to [EasingFunction.easeInOutBack].
final Float32List _curveEaseInOutBack =
    new Float32List.fromList([0.680, -0.550, 0.265, 1.550]);

/// Gets the bezier curve associated with the given [value].
Float32List getEasingCurve(EasingFunction value) {
  switch (value) {
    case EasingFunction.linear:
      return _curveLinear;
    case EasingFunction.ease:
      return _curveEase;
    case EasingFunction.easeIn:
      return _curveEaseIn;
    case EasingFunction.easeOut:
      return _curveEaseOut;
    case EasingFunction.easeInOut:
      return _curveEaseInOut;

    case EasingFunction.easeInQuadratic:
      return _curveEaseInQuadratic;
    case EasingFunction.easeInCubic:
      return _curveEaseInCubic;
    case EasingFunction.easeInQuartic:
      return _curveEaseInQuartic;
    case EasingFunction.easeInQuintic:
      return _curveEaseInQuintic;
    case EasingFunction.easeInSine:
      return _curveEaseInSine;
    case EasingFunction.easeInExponential:
      return _curveEaseInExponential;
    case EasingFunction.easeInCircle:
      return _curveEaseInCircle;
    case EasingFunction.easeInBack:
      return _curveEaseInBack;

    case EasingFunction.easeOutQuadratic:
      return _curveEaseOutQuadratic;
    case EasingFunction.easeOutCubic:
      return _curveEaseOutCubic;
    case EasingFunction.easeOutQuartic:
      return _curveEaseOutQuartic;
    case EasingFunction.easeOutQuintic:
      return _curveEaseOutQuintic;
    case EasingFunction.easeOutSine:
      return _curveEaseOutSine;
    case EasingFunction.easeOutExponential:
      return _curveEaseOutExponential;
    case EasingFunction.easeOutCircle:
      return _curveEaseOutCircle;
    case EasingFunction.easeOutBack:
      return _curveEaseOutBack;

    case EasingFunction.easeInOutQuadratic:
      return _curveEaseInOutQuadratic;
    case EasingFunction.easeInOutCubic:
      return _curveEaseInOutCubic;
    case EasingFunction.easeInOutQuartic:
      return _curveEaseInOutQuartic;
    case EasingFunction.easeInOutQuintic:
      return _curveEaseInOutQuintic;
    case EasingFunction.easeInOutSine:
      return _curveEaseInOutSine;
    case EasingFunction.easeInOutExponential:
      return _curveEaseInOutExponential;
    case EasingFunction.easeInOutCircle:
      return _curveEaseInOutCircle;
    // case EasingFunction.easeInOutBack
    default:
      return _curveEaseInOutBack;
  }
}
