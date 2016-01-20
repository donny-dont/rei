// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [IntervalAnimation] interface.
library rei.src.animation.spring_animation;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'animation.dart';
import 'animation_value.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// An animation whose value is determined based on a spring.
abstract class SpringAnimation implements Animation, AnimationValue {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  static const distanceThreshold = 0.0001;
  static const velocityThreshold = 0.0001;

  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The current velocity of the animation.
  double _velocity = 0.0;
  /// The current value of the animation.
  double _value = 0.0;

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The spring constant.
  num get constant;

  /// The friction applied to the spring during movement.
  num get friction;

  num get end;

  //---------------------------------------------------------------------
  // AnimationValue
  //---------------------------------------------------------------------

  @override
  num get value => _value;

  //---------------------------------------------------------------------
  // AnimationValue
  //---------------------------------------------------------------------

  //@override
  void timeUpdate(double dt) {
    dt = dt * 0.001;
    var distance = end.toDouble() - _value;
    var distanceSquared = distance * distance;

    if ((distanceSquared < distanceThreshold) &&
        (_velocity * _velocity < velocityThreshold)) {
      _value = end.toDouble();
      _velocity = 0.0;
    } else {
      _value -= dt * _velocity;
      _velocity += dt *
          ((-constant.toDouble() * distance) -
              (friction.toDouble() * _velocity));
    }
  }
}
