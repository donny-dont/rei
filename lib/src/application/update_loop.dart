// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [UpdateLoop] class.
library rei.src.application.update_loop;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'time.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// The callback for an animation frame.
typedef void AnimationFrame(Time time);

/// Handles the update loop for an application.
class UpdateLoop {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// The shared instance of the [UpdateLoop].
  static final UpdateLoop _instance = new UpdateLoop._();

  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// Whether the update loop is currently running.
  bool _running = false;
  /// The current animation frame.
  int _animationFrame;

  /// The function to call on each frame.
  AnimationFrame onFrame;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [UpdateLoop] class.
  ///
  /// Only one instance of the [UpdateLoop] class is available.
  factory UpdateLoop() => _instance;

  /// Creates an instance of the [UpdateLoop] class.
  UpdateLoop._() {
    html.document.onVisibilityChange.listen(_onVisibilityChange);
  }

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// Whether the update loop is currently running.
  bool get running => _running;

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Starts up the update loop.
  void start() {
    if (!_running) {
      _animationFrame = html.window.requestAnimationFrame(_onUpdate);

      _running = true;
    }
  }

  /// Pauses the update loop.
  void stop() {
    if (running) {
      html.window.cancelAnimationFrame(_animationFrame);

      _running = false;
    }
  }

  //---------------------------------------------------------------------
  // Private methods
  //---------------------------------------------------------------------

  /// Internal update loop.
  ///
  /// Makes calls to [Html.Window.requestAnimationFrame] to drive the update
  /// loop. Handles updating the current [GameTime]. Additionally has to handle
  /// the updating of [GamePad]s because the API is not event based.
  static void _onUpdate(num time) {
    var onFrame = _instance.onFrame;

    // In Chrome the value passed to the animation frame is based off of
    // window.performance.now. This is not the case for all browsers. Switching
    // the time to the value returned from now() fixes any animations using
    // now() within the application.
    time = html.window.performance.now();

    Time.update(time);

    if (onFrame != null) {
      onFrame(new Time());
    }

    _instance._animationFrame = html.window.requestAnimationFrame(_onUpdate);
  }

  /// Callback for when a visibility [event] occurs.
  static void _onVisibilityChange(html.Event event) {
    var updateLoop = _instance;

    if (html.document.hidden) {
      updateLoop.stop();
    } else {
      updateLoop.start();
    }
  }
}
