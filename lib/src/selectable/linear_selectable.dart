// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [LinearSelectable] mixin.
library rei.src.selection.linear_selectable;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';

import 'package:rei/direction.dart';

import 'selectable.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Defines a selection behavior that moves selection along a single axis.
///
/// The axis to move along is specified in [direction]. If the value is set to
/// [Direction.horizontal] then the selection will be along the x-axis. If the
/// value is set to [Direction.vertical] then the selection will be along the
/// y-axis.
///
/// The elements that are selectable need to be defined in the
/// [selectableElements] property which is expected to be present within the
/// class mixing in [LinearSelectable]. The selection will happen according
/// to the ordering of the [selectableElements].
///
/// Additionally the [selectInternal] method can be used to change the behavior
/// of the initial selection of an element.
@behavior
abstract class LinearSelectable implements Selectable {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The currently selected element.
  html.Element _selectedElement;

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The direction to allow movement in.
  Direction get direction;

  //---------------------------------------------------------------------
  // Element
  //---------------------------------------------------------------------

  html.Element get parent;

  //---------------------------------------------------------------------
  // Selectable
  //---------------------------------------------------------------------

  @override
  List<html.Element> get selectableElements => Selectable.findAllSelectable();

  @override
  html.Element get selectedElement => _selectedElement;

  @override
  html.Element select([html.Element element = null]) {
    var selected = selectInternal(element);

    // Check that the value received from onSelect is a valid one
    //
    // Since this can be overridden by an implementing class the value should
    // be sanitized. It needs to be selectable and contained within the
    // selectableElements list.
    assert((selected == null) ||
        ((Selectable.canSelect(selected)) &&
            (selectableElements.contains(selected))));

    // If there was no preference from onSelect then just get the first
    // selectable element from the container
    if (selected == null) {
      selected = Selectable.findFirstSelectable(selectableElements);
    }

    return _selectElement(selected);
  }

  @override
  void back() {
    if (canMoveBack) {
      selectPrevious();
    } else if (parent is Selectable) {
      var selectable = parent as Selectable;

      selectable.back();
    }
  }

  @override
  void up() {
    if((direction == Direction.vertical) && (selectPrevious() != null))
      return;

    if (parent is Selectable) {
      var selectable = parent as Selectable;
      selectable.up();
    }
  }

  @override
  void down() {
    if((direction == Direction.vertical) && (selectNext() != null))
      return;

    if (parent is Selectable) {
      var selectable = parent as Selectable;
      selectable.down();
    }
  }

  @override
  void left() {
    if((direction == Direction.horizontal) && (selectPrevious() != null))
      return;

    if (parent is Selectable) {
      var selectable = parent as Selectable;
      selectable.left();
    }
  }

  @override
  void right() {
    if((direction == Direction.horizontal) && (selectNext() != null))
      return;

    if (parent is Selectable) {
      var selectable = parent as Selectable;
      selectable.right();
    }
  }

  @override
  void resetSelection() {
    _selectedElement = null;
  }

  //---------------------------------------------------------------------
  // Protected methods
  //---------------------------------------------------------------------

  /// Selects an element when [select] is called.
  ///
  /// This method gives an opportunity to override the behavior of the [select]
  /// method. Additional logic can be applied when setting the selection.
  /// Examples would be.
  ///
  /// - Selecting based on the location of the previous element.
  /// - Choosing a different starting element based on the model data, for
  ///   a rating selection.
  ///
  /// When the method returns `null` this signals that the group should pick
  /// the element to select based on the currently selected element within the
  /// group. This is the default behavior when it is not overridden.
  html.Element selectInternal(html.Element previous) {
    return null;
  }

  //---------------------------------------------------------------------
  // Private methods
  //---------------------------------------------------------------------

  /// Retrieves the previous element within the container.
  html.Element selectPrevious() {
    var _selList = selectableElements;

    // Get Index of Selection
    var indexOfSel = _selList.indexOf(selectedElement);
    if (indexOfSel >= 0) {

      var maxSteps = _selList.length;

      // Iterate ONLY through the selectableElements
      // Previous implentation went through siblings without respecting selectableElements
      for (var i = 1; (i < maxSteps) && (wrapStart || (i <= indexOfSel)); i++) {
        var element = _selList[(indexOfSel-i) % maxSteps];
        if(Selectable.canSelect(element)) {
          return _selectElement(element);
        }
      }

      return null;
    } 

    return _selectElement(Selectable.findFirstSelectable(_selList));
  }

  /// Retrieves the next element within the container.
  html.Element selectNext() {
     var _selList = selectableElements;

    // Get Index of Selection
    var indexOfSel = _selList.indexOf(selectedElement);
    if (indexOfSel >= 0) {

      var maxSteps = _selList.length;

      // Iterate ONLY through the selectableElements
      // Previous implentation went through siblings without respecting selectableElements
      for (var i = 1; (i < maxSteps) && (wrapEnd || ((indexOfSel+i) < maxSteps)); i++) {
        var element = _selList[(indexOfSel+i) % maxSteps];
        if(Selectable.canSelect(element)) {
          return _selectElement(element);
        }
      }

      return null;
    } 

    return _selectElement(Selectable.findLastSelectable(_selList));
  }

  /// Selects the given [element].
  ///
  /// If the [element] is itself a [Selectable] then its select method will be
  /// called. Otherwise a [Selectable.selectionChangedEvent] will be dispatched
  /// with the selected [element] contained in the detail field of the
  /// [Html.CustomEvent].
  ///
  /// The method returns true if the [element] was selected; false otherwise
  /// which is only the case if the element is null.
  html.Element _selectElement(html.Element element) {
    if (element == null) {
      return null;
    }

    // Ensure that the element being selected is contained in the
    // selectableElements container. If this is not the case then the contract
    // of selectableElements is being violated.
    assert(selectableElements.contains(element));
    

    // Get the previous element
    var previous = _selectedElement;

    // Set the selection
    _selectedElement = element;

    // See if the selection hierarchy needs to be entered further
    if (element is Selectable) {
      var selectable = element as Selectable;

      element = selectable.select(previous);
    } else {
      element.dispatchEvent(new html.CustomEvent(Selectable.selectionChangedEvent, canBubble: true, cancelable:true, detail: element));
    }

    return element;
  }

}
