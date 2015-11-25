// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [Animation] interface.
library rei.src.animation.animation;

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// An animation based on time.
abstract class Animation {
  /// Updates the animation using the given time difference, [dt].
  void update(double dt);
}
