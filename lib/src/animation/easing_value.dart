// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [EasingValue] mixin.
library rei.src.transform.easing_value;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';

import 'package:rei/bezier_curve.dart';
import 'package:rei/easing_function.dart';

import 'animation_timing.dart';
import 'computed_timing.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

@behavior
abstract class EasingValue<T> {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  BezierCurve<T> _curve;

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  BezierCurve<T> get curve => _curve;

  dynamic get easing;

  //---------------------------------------------------------------------
  // Callbacks
  //---------------------------------------------------------------------


}
