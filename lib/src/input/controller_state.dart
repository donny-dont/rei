// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [ControllerState] class.
library rei.src.input.controller_state;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'button_state.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Contains information on the state of the controller's buttons.
class ControllerState {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The state of the left directional button.
  ButtonState left = ButtonState.released;
  /// The state of the right directional button.
  ButtonState right = ButtonState.released;
  /// The state of the up directional button.
  ButtonState up = ButtonState.released;
  /// The state of the down directional button.
  ButtonState down = ButtonState.released;
  /// The state of the back button.
  ButtonState back = ButtonState.released;
  /// The state of the select button.
  ButtonState select = ButtonState.released;
  /// The state of the left shoulder button.
  ButtonState leftShoulder = ButtonState.released;
  /// The state of the right shoulder button.
  ButtonState rightShoulder = ButtonState.released;
  /// The state of the left trigger button.
  ButtonState leftTrigger = ButtonState.released;
  /// The state of the right trigger button.
  ButtonState rightTrigger = ButtonState.released;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [ControllerState] class.
  ControllerState();

  //---------------------------------------------------------------------
  // Cloneable methods
  //---------------------------------------------------------------------

  /// Copies the values from the object into the [state] object.
  void copyInto(ControllerState state) {
    state
      ..left          = left
      ..right         = right
      ..up            = up
      ..down          = down
      ..back          = back
      ..select        = select
      ..leftShoulder  = leftShoulder
      ..rightShoulder = rightShoulder
      ..leftTrigger   = leftTrigger
      ..rightTrigger  = rightTrigger;
  }
}
