// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// The Rei Animation library contains behaviors for creating animations as
/// custom elements.
///
/// The library supports creating the following types of animation.
///
/// * [BezierCurveAnimation] - An animation whose value is computed using a
///   bezier curve, which can be defined through an [EasingFunction].
/// * [KeyframeAnimation] - An animation whose value is defined through the use
///   of individual [Keyframe]s.
/// * [SpringAnimation] - An animation defined through the physics of a spring,
///   which can be used to provide kinetic scrolling effects.
///
/// The library also supports grouping of animations together to provide a
/// larger animation that is run on the same timeline.
///
/// * [SyncedAnimation] - Runs a group of animations concurrently.
/// * [SequencedAnimation] - Runs a group of animations in succession.
///
/// An animation group should not contain animations that do not implement the
/// [AnimationTiming] interface, such as the [SpringAnimation]. It should also
/// not be used on animations that can function independently of each other.
///
/// The functionality of the library is meant to mirror the
/// [Web Animations API](https://w3c.github.io/web-animations/) as closely as
/// possible. Any specific behavior changes are noted within the documentation
/// for cases that do not map directly to the specification. It does not however
/// use the polyfills for the specification as things like transformations
/// cannot be tracked properly without doing the calculations in script.
/// However the library can at a future time transition to using those APIs for
/// things other than transformations as the specification and browser support
/// is solidified.
library rei.animation;

//---------------------------------------------------------------------
// Exports
//---------------------------------------------------------------------

export 'src/animation/animation.dart';
export 'src/animation/animation_element.dart';
export 'src/animation/animation_manager.dart';
export 'src/animation/animation_target_value.dart';
export 'src/animation/animation_update.dart';
export 'src/animation/bezier_curve_animation.dart';
export 'src/animation/easing_function_curves.dart';
export 'src/animation/interval_animation.dart';
export 'src/animation/keyframe.dart';
export 'src/animation/keyframe_animation.dart';
export 'src/animation/spring_animation.dart';
export 'src/animation/synced_animation.dart';
