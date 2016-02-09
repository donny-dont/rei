// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [Animation] interface.
library rei.src.animation.animation;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import '../../animation_target.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// An animation based on time.
abstract class Animation {
  //---------------------------------------------------------------------
  // Class members
  //---------------------------------------------------------------------

  /// Event for when an animation has completed.
  static const String animationCompleteEvent = 'animation-complete';
  /// Event for when a value on the animation was changed which would modify
  /// the computed timings.
  static const String animationTimingChangedEvent = 'animation-timing';

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The rate of playback for the animation.
  ///
  /// To increase the speed of the animation the value should be greater than
  /// 1.0. To slow down the speed of animation the value should be between
  /// \[0.0, 1.0\]. To reverse the animation a negative value can be used for
  /// cases where the animation is based on an interval.
  num get playbackRate;
  set playbackRate(num value);

  /// The current time of the animation.
  ///
  /// This value will be in the range of 0.0 to the total time of the animation
  /// based on its total effect time.
  ///
  /// Typically this value is only modified when the animation is being updated
  /// through the [AnimationManager]. However the value can be manually changed
  /// in code to perform a scrubbing operation for an animation specified by
  /// an interval. When modifying it directly the [playbackRate] is not taken
  /// into consideration. This is different behavior than the Web Animations API
  /// which applies the [playbackRate].
  double get currentTime;
  set currentTime(double value);

  /// The element that the animation will effect.
  html.Element get animatedElement;
  set animatedElement(html.Element value);

  /// The target of the animation on the element.
  AnimationTarget get animationTarget;
  set animationTarget(AnimationTarget target);

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Begins the animation.
  ///
  /// If the [Animation] is within a group then this method should only be
  /// called on the outermost enclosing element.
  void play();
  /// Pauses the animation.
  ///
  /// If the [Animation] is within a group then this method should only be
  /// called on the outermost enclosing element.
  void pause();
}
