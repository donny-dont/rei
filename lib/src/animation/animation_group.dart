// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [AnimationGroup] mixin.
library rei.src.transform.animation_group;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'animation.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// A grouping of animations into a larger animation.
///
/// When using a group any playback methods within [animations] will be called
/// by the group itself. Any modification to the play state should happen on
/// the root group to ensure proper behavior.
abstract class AnimationGroup {
  /// A list of animations within this group.
  List<Animation> get animations;
}
