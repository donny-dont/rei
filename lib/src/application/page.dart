// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [Time] class.
library rei.src.application.page;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;

//---------------------------------------------------------------------
// Package libraries
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';
import 'package:rei/input.dart';
import 'package:rei/selectable.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

@behavior
class Page {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// Attribute for adding a class to an element when selected.
  ///
  /// This allows for the visual of a selected item to be updated when it is
  /// selected. This should only be used if there does need to be a change in
  /// the visual as adding/removing classes can become a bottleneck on PS4.
  static const String selectedClassAttribute = 'data-selected-class';

  /// The minimum delay between button presses in milliseconds.
  static const double _minSelectionDelay = 50.0;
  /// The maximum delay between button presses in milliseconds.
  static const double _maxSelectionDelay = 200.0;
  /// The amount to ease the selection by.
  static const double _selectionModifier = 0.75;

  static const double _selectionTimeReset = -1.0;

  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The [Controller] used for navigating the UI.
  final Controller _controller = new KeyboardController();
  /// The last state of the controller.
  final ControllerState _controllerState = new ControllerState();
  /// The current selection group within the UI.
  Selectable _selectedGroup;
  /// The currently selected element within the UI.
  html.Element _selectedElement;
  /// The delay for selection.
  double _selectionDelay = _maxSelectionDelay;
  /// The next time the left button will be recognized.
  double _nextLeftTime = _selectionTimeReset;
  /// The next time the right button will be recognized.
  double _nextRightTime = _selectionTimeReset;
  /// The next time the up button will be recognized.
  double _nextUpTime = _selectionTimeReset;
  /// The next time the down button will be recognized.
  double _nextDownTime = _selectionTimeReset;

  /// Whether the input should be flipped horizontally.
  ///
  /// This is used for RTL languages as the browser will mirror the layout
  /// automatically.
  bool _flipHorizontal = false;

  /// The area that the highlight can be displayed in.
  ///
  /// Allows the highlight to be clipped to a certain area. This should be
  /// specified for any page which clips elements to an area smaller than the
  /// screen.
  html.Rectangle highlightArea = new html.Rectangle(0, 0, 1920, 1080);

  //---------------------------------------------------------------------
  // PolymerElement
  //---------------------------------------------------------------------

  void attachedPage() {
    // Determine if the controller needs to flip horizontally.
    var dir = html.document.body.attributes['dir'];
    _flipHorizontal = (dir != null) && (dir == 'rtl');
  }

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  void update(double time) {
    if (_selectedGroup == null) return;

    // Save off the last states
    var lastSelectState = _controllerState.select;
    var lastBackState = _controllerState.back;
    var lastLeftTriggerState = _controllerState.leftTrigger;
    var lastRightTriggerState = _controllerState.rightTrigger;
    var lastLeftShoulderState = _controllerState.leftShoulder;
    var lastRightShoulderState = _controllerState.rightShoulder;

    _controller.getControllerState(_controllerState);

    // Check for the left button being pressed
    if (_controllerState.left == ButtonState.released) {
      _nextLeftTime = _selectionTimeReset;
    } else if (_nextLeftTime < time) {
      _selectionDelay = _computeNextDelay(_nextLeftTime, _selectionDelay);
      _nextLeftTime = time + _selectionDelay;

      if (!_flipHorizontal) {
        _selectedGroup.left();
      } else {
        _selectedGroup.right();
      }
    }

    // Check for the right button being pressed
    if (_controllerState.right == ButtonState.released) {
      _nextRightTime = _selectionTimeReset;
    } else if (_nextRightTime < time) {
      _selectionDelay = _computeNextDelay(_nextRightTime, _selectionDelay);
      _nextRightTime = time + _selectionDelay;

      if (!_flipHorizontal) {
        _selectedGroup.right();
      } else {
        _selectedGroup.left();
      }
    }

    // Check for the up button being pressed.
    if (_controllerState.up == ButtonState.released) {
      _nextUpTime = _selectionTimeReset;
    } else if (_nextUpTime < time) {
      _selectionDelay = _computeNextDelay(_nextUpTime, _selectionDelay);
      _nextUpTime = time + _selectionDelay;

      _selectedGroup.up();
    }

    // Check for the down button being pressed.
    if (_controllerState.down == ButtonState.released) {
      _nextDownTime = _selectionTimeReset;
    } else if (_nextDownTime < time) {
      _selectionDelay = _computeNextDelay(_nextDownTime, _selectionDelay);
      _nextDownTime = time + _selectionDelay;

      _selectedGroup.down();
    }

    // Check if select button is pressed.
    //
    // Triggers click() when select button is released.
    var selectState = _controllerState.select;

    if ((selectState == ButtonState.released) && (selectState != lastSelectState)) {
      _selectedElement.click();
    }

    // Check if back button is pressed.
    var backState = _controllerState.back;

    if ((backState == ButtonState.released) && (backState != lastBackState)) {
      _selectedGroup.back();

      onBack();
    }

    // Check if left shoulder button is pressed
    var leftShoulderState = _controllerState.leftShoulder;

    if ((leftShoulderState == ButtonState.released) && (leftShoulderState != lastLeftShoulderState)) {
      onLeftShoulder();
    }

    // Check if left shoulder button is pressed
    var rightShoulderState = _controllerState.rightShoulder;

    if ((rightShoulderState == ButtonState.released) && (rightShoulderState != lastRightShoulderState)) {
      onRightShoulder();
    }

    // Check if left trigger is pressed.
    var leftTriggerState = _controllerState.leftTrigger;

    if ((leftTriggerState == ButtonState.released) && (leftTriggerState != lastLeftTriggerState)) {
      onLeftTrigger();
    }

    // Check if right trigger is pressed.
    var rightTrigger = _controllerState.rightTrigger;

    if ((rightTrigger == ButtonState.released) && (rightTrigger != lastRightTriggerState)) {
      onRightTrigger();
    }
  }

  //---------------------------------------------------------------------
  // Protected methods
  //---------------------------------------------------------------------

  void onBack() {}

  void onLeftTrigger() {}
  void onRightTrigger() {}

  void onLeftShoulder() {}
  void onRightShoulder() {}

  //---------------------------------------------------------------------
  // Private methods
  //---------------------------------------------------------------------

  /// Callback for when a selection is changed.
  @Listen(Selectable.selectionChangedEvent)
  void onSelectionChange(html.CustomEvent event, _) {
    var selectedElement = event.detail;

    if (selectedElement == _selectedElement) {
      return;
    }

    var selectedAttributes;

    if (_selectedElement != null) {
      _selectedElement.blur();

      selectedAttributes = _selectedElement.attributes;

      if (selectedAttributes.containsKey(selectedClassAttribute)) {
        _selectedElement.classes.remove(selectedAttributes[selectedClassAttribute]);
      }
    }

    _selectedElement = selectedElement;
    _selectedElement.focus();

    selectedAttributes = _selectedElement.attributes;

    if (selectedAttributes.containsKey(selectedClassAttribute)) {
      _selectedElement.classes.add(selectedAttributes[selectedClassAttribute]);
    }

    _selectedGroup = Selectable.findParentSelectable(_selectedElement);
  }

  static double _computeNextDelay(double nextTime, double delay) {
    // See if the default value is being used
    if (nextTime == _selectionTimeReset) {
      return _maxSelectionDelay;
    }

    var modified = delay * _selectionModifier;

    return (modified > _minSelectionDelay) ? modified : _minSelectionDelay;
  }
}
