// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [Selectable] interface and associated helper functions.
library rei.src.selection.selectable;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;
import 'package:polymer/polymer.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// An interface for implementing selection through a gamepad.
///
/// A gamepad provides movement in five directions. Four of the directions,
/// [up], [down], [left], [right], are handled through the d-pad. The fifth,
/// [back], is the right face button.
abstract class Selectable {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// Specifies that an element is not selectable.
  ///
  /// By default any items in the [Selectable] group can be selected. This
  /// This attribute should be added to any element that cannot be selected.
  static const String notSelectableAttribute = 'data-not-selectable';
  /// The event fired when the selected element is changed.
  static const String selectionChangedEvent = 'selectionchange';
  /// The event fired when the selection moves off element
  static const String selectionOffEvent = 'selectionoff';
  ///
  static html.Element activeSelection = null;

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The currently selected element.
  html.Element get selectedElement;
  /// A list of elements that can be selected from.
  List<html.Element> get selectableElements;
  /// Whether the selectable area allows wrapping from the first element.
  ///
  /// If wrapStart is `true` then it is possible to move from the first
  /// element within [selectableElements] to the last element within it.
  bool get wrapStart;
  /// Whether the selectable area allows wrapping from the last element.
  ///
  /// If wrapEnd is `true` then it is possible to move from the lase element
  /// within [selectableElements] to the first element within it.
  bool get wrapEnd;
  /// Whether the selectable area responds to the back command.
  bool get canMoveBack;

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Enters the selectable area.
  ///
  /// When entering a [Selectable] area the [previous] element that was
  /// was selected should be passed into the method. This gives the
  /// implementation the ability to make a decision based on the previously
  /// selected element. Returns selected element
  html.Element select([html.Element previous = null]);

  /// Exits the selectable area.
  ///
  /// The [back] method is used for when the user needs to exit a selectable
  /// area. This is useful for when the selection area needs to be constrained
  /// within a component.
  void back();

  /// Moves the selection up.
  void up();

  /// Moves the selection down.
  void down();

  /// Moves the selection to the left.
  void left();

  /// Moves the selection to the right.
  void right();

  /// Resets the selection.
  void resetSelection();

  //---------------------------------------------------------------------
  // Class methods
  //---------------------------------------------------------------------

  /// Determines if the [element] can be selected.
  ///
  /// This method checks to see if the [element] has attached the
  /// [notSelectableAttribute]. The check does not account for the element not
  /// being visible within the DOM. This is because the style would have to be
  /// computed which can be a time consuming operation.
  static bool canSelect(html.Element element) {
    return !element.attributes.containsKey(notSelectableAttribute) &&
        element is! html.StyleElement &&
        element is! html.TemplateElement;
        // Note:: you might also want to check tab-index -1 as that's the web convention for not selectable??
  }

  /// Finds the first [html.Element] in [elements] that can be selected.
  ///
  /// Uses the [canSelect] method to determine what is selectable.
  static html.Element findFirstSelectable(List<html.Element> elements) {
    return elements.firstWhere((element) => canSelect(element),
        orElse: () => null);
  }

  /// Finds the last [html.Element] in [elements] that can be selected.
  ///
  /// Uses the [canSelect] method to determine what is selectable.
  static html.Element findLastSelectable(List<html.Element> elements) {
    return elements.lastWhere((element) => canSelect(element),
        orElse: () => null);
  }

  /// Finds the parent of a selected [element].
  ///
  /// This method is used to search both the light DOM and the shadow DOM for
  /// the parent.
  static Selectable findParentSelectable(html.Element element) {
    // \TODO Revisit this with shady DOM implementation

    // See if the element is in the light DOM
    var search;

    search = element.parent;

    while (search != null) {
      if (search is Selectable) {
        return search;
      }

      search = search.parent;
    }

    // See if the element is in the shadow DOM
    search = element.parentNode;

    while (search != null) {
      if (search is html.ShadowRoot) {
        // The host should always be selectable otherwise something has gone
        // horribly wrong
        assert(search.host is Selectable);

        return search.host as Selectable;
      }

      search = search.parentNode;
    }

    // Not selectable!
    return null;
  }

  /// Select Item 
  /// 
  /// Triggers the DOM event or calls the select function
  /// See if the selection hierarchy needs to be entered further
  static html.Element selectElement(html.Element element, [html.Element previous = null]) {
    if (element is Selectable) {
      var selectable = element as Selectable;
      return selectable.select(previous);
    } else {
      if(activeSelection != null) {
        activeSelection.dispatchEvent(new html.CustomEvent(selectionOffEvent, canBubble: true, cancelable:true, detail: element));
      }

      activeSelection = element;

      element.dispatchEvent(new html.CustomEvent(selectionChangedEvent, canBubble: true, cancelable:true, detail: element));
      return element;
    }
  }
}
