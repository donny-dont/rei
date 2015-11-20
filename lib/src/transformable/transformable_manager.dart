// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [TransformManager] class.
library rei.src.transformable.transformable_manager;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:rei/src/registration_manager.dart';

import 'transformable_element.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Manages the updating of [TransformableElement]'s transformations.
///
/// The [TransformableManager] should be run within a request animation frame
/// loop after any animations that would modify the transformable target. This
/// ensures that the [TransformableElement]s style is only updated during
/// the frame and only occurs a single time. Anything that requires access to
/// the transformation data should query for it after the [update] method is
/// called on the manager.
///
/// By default whenever a [TransformableElement] is attached to the DOM it will
/// register itself with the manager. When detached it will remove that
/// registration. Elements should not be manually attached.
class TransformableManager extends RegistrationManager<TransformableElement> {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// Singleton instance of the manager class.
  static final TransformableManager _instance = new TransformableManager._();

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [TransformableManager] class.
  ///
  /// The [TransformableManager] is a singleton and all instances are shared.
  factory TransformableManager() => _instance;

  /// Internal constructor for the [TransformableManager] class.
  ///
  /// Used by the
  TransformableManager._();

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Updates the transformable elements within the manager which modifies the
  /// transform for the element.
  void update() {
    updateRegistration();

    for (var element in registered) {
      element.update();
    }
  }
}
