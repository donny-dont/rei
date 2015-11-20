//  SONY CONFIDENTIAL MATERIAL. DO NOT DISTRIBUTE.
//  SNEI REI (Really Elegant Interface)
//  Copyright (C) 2014-2015 Sony Network Entertainment Inc
//  All Rights Reserved

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
  // PolymerElement
  //---------------------------------------------------------------------

  html.CustomEvent fire(String type,
                       {detail,
                        bool canBubble: true,
                        bool cancelable: true,
                        html.Node node});

  //---------------------------------------------------------------------
  // Selectable
  //---------------------------------------------------------------------

  @override
  html.Element get selectedElement => _selectedElement;

  @override
  void select([html.Element element = null]) {
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
      selected = _getSelectedElement();
    }

    _selectElement(selected);
  }

  @override
  void back() {
    if (canMoveBack) {
      _previous();
    } else if (parent is Selectable) {
      var selectable = parent as Selectable;

      selectable.back();
    }
  }

  @override
  void up() {
    var selected = (direction == Direction.vertical) ? _previous() : false;

    if ((!selected) && (parent is Selectable)) {
      var selectable = parent as Selectable;

      selectable.up();
    }
  }

  @override
  void down() {
    var selected = (direction == Direction.vertical) ? _next() : false;

    if ((!selected) && (parent is Selectable)) {
      var selectable = parent as Selectable;

      selectable.down();
    }
  }

  @override
  void left() {
    var selected = (direction == Direction.horizontal) ? _previous() : false;

    if ((!selected) && (parent is Selectable)) {
      var selectable = parent as Selectable;

      selectable.left();
    }
  }

  @override
  void right() {
    var selected = (direction == Direction.horizontal) ? _next() : false;

    if ((!selected) && (parent is Selectable)) {
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
  bool _previous() {
    var selectedElement = _getSelectedElement();
    var previous;

    if (selectedElement != null) {
      // Find the previous selectable element
      previous = selectedElement.previousElementSibling;

      while ((previous != null) && (!Selectable.canSelect(previous))) {
        previous = previous.previousElementSibling;
      }

      // Check if the element should wrap
      if ((previous == null) && (wrapStart)) {
        previous = Selectable.findLastSelectable(selectableElements);
      }
    }

    return _selectElement(previous);
  }

  /// Retrieves the next element within the container.
  bool _next() {
    var selectedElement = _getSelectedElement();
    var next;

    if (selectedElement != null) {
      // Find the next selectable element
      next = selectedElement.nextElementSibling;

      while ((next != null) && (!Selectable.canSelect(next))) {
        next = next.nextElementSibling;
      }

      // Check if the element should wrap
      if ((next == null) && (wrapEnd)) {
        next = Selectable.findFirstSelectable(selectableElements);
      }
    }

    return _selectElement(next);
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
  bool _selectElement(html.Element element) {
    if (element == null) return false;

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

      selectable.select(previous);
    } else {
      fire(Selectable.selectionChangedEvent, detail: element);
    }

    return true;
  }

  /// Finds the currently selected element.
  ///
  /// The currently selected element is verified by determining if the element
  /// is still contained in the element. This could happen if the element is
  /// removed programmatically from the container. If this happens then the
  /// first selectable element is chosen.
  html.Element _getSelectedElement() {
    // Verify that the selected element is present within the container
    var hasSelection = (_selectedElement != null) &&
        (selectableElements.contains(_selectedElement));

    return hasSelection
        ? _selectedElement
        : Selectable.findFirstSelectable(selectableElements);
  }
}
