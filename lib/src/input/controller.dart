// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [Controller] interface.
library rei.src.input.controller;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'controller_state.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

abstract class Controller {
  void getControllerState(ControllerState copy);
}
