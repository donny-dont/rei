// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [KeyboardController] class.
library rei.src.input.keyboard_controller;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'button_state.dart';
import 'controller.dart';
import 'controller_state.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// A [Controller] that emulates a gamepad through the keyboard.
class KeyboardController implements Controller {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// The shared instance of the [KeyboardController].
  static final KeyboardController _instance = new KeyboardController._();

  /// The key code for the left shoulder button.
  static int leftShoulderKeyCode = html.KeyCode.F5;
  /// The key code for the right shoulder button.
  static int rightShoulderKeyCode = html.KeyCode.F6;
  /// The key code for the left trigger.
  static int leftTriggerKeyCode = html.KeyCode.F7;
  /// The key code for the right trigger.
  static int rightTriggerKeyCode = html.KeyCode.F8;

  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The state of the [KeyboardController].
  final ControllerState _controllerState = new ControllerState();

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [KeyboardController] class.
  ///
  /// Only one instance of the [KeyboardController] class is available.
  factory KeyboardController() {
    return _instance;
  }

  /// Creates an instance of the [KeyboardController] class.
  KeyboardController._() {
    html.window.onKeyDown.listen(_onKeyDown);
    html.window.onKeyUp.listen(_onKeyUp);
  }

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Gets the current [ControllerState].
  ///
  /// Copies the values in the underlying [ControllerState] to [copy].
  void getControllerState(ControllerState copy) {
    assert(copy != null);

    _controllerState.copyInto(copy);
  }

  //---------------------------------------------------------------------
  // Private methods
  //---------------------------------------------------------------------

  /// Callback for when a key is pressed within the window.
  static void _onKeyDown(html.KeyboardEvent event) {
    _updateKeyState(event.keyCode, ButtonState.pressed);
  }

  /// Callback for when a key is released within the window.
  static void _onKeyUp(html.KeyboardEvent event) {
    _updateKeyState(event.keyCode, ButtonState.released);
  }

  /// Updates the controller state when a button's state is changed.
  static void _updateKeyState(int keyCode, ButtonState state) {
    var controllerState = _instance._controllerState;

    switch (keyCode) {
      case html.KeyCode.LEFT:
        controllerState.left = state;
        break;
      case html.KeyCode.RIGHT:
        controllerState.right = state;
        break;
      case html.KeyCode.UP:
        controllerState.up = state;
        break;
      case html.KeyCode.DOWN:
        controllerState.down = state;
        break;
      case html.KeyCode.ESC:
        controllerState.back = state;
        break;
      case html.KeyCode.ENTER:
        controllerState.select = state;
        break;
    }

    if (keyCode == leftShoulderKeyCode) {
      controllerState.leftShoulder = state;
    } else if (keyCode == rightShoulderKeyCode) {
      controllerState.rightShoulder = state;
    } else if (keyCode == leftTriggerKeyCode) {
      controllerState.leftTrigger = state;
    } else if (keyCode == rightTriggerKeyCode) {
      controllerState.rightTrigger = state;
    }
  }
}
