
abstract class AnimationUpdate {
  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The rate at which the animation progresses.
  ///
  /// This value can be used to speed up, when greater than 1.0, or slow down,
  /// when less than 1.0, the playback of the animation. Negative values can
  /// be used to reverse the animation's playback.
  num get playbackRate;
  set playbackRate(num value);

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Updates the animation using the given time difference, [dt].
  void timeUpdate(double dt) {
    timeUpdateInternal(playbackRate.toDouble() * dt);
  }

  //---------------------------------------------------------------------
  // Protected methods
  //---------------------------------------------------------------------

  void timeUpdateInternal(double dt);
}
