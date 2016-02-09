// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [AnimationManager] class.
library rei.src.animation.animation_manager;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import '../../src/registration_manager.dart';

import 'animation_element.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Manages the updating of [AnimationElement] values.
///
/// The [AnimationManager] should be run within a request animation frame loop
/// at its start.
class AnimationManager extends RegistrationManager<AnimationElement> {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// Singleton instance of the manager class.
  static final AnimationManager _instance = new AnimationManager._();

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [AnimationManager] class.
  ///
  /// The [AnimationManager] is a singleton and all instances are shared.
  factory AnimationManager() => _instance;

  /// Internal constructor for the [AnimationManager] class.
  AnimationManager._();

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Updates the animated elements within the manager which modifies the
  /// transform for the element.
  void update(double dt) {
    updateRegistration();

    for (var element in registered) {
      element.currentTime += dt;
    }
  }
}
