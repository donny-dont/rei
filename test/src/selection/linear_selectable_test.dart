//  SONY CONFIDENTIAL MATERIAL. DO NOT DISTRIBUTE.
//  SNEI REI (Really Elegant Interface)
//  Copyright (C) 2014-2015 Sony Network Entertainment Inc
//  All Rights Reserved

@TestOn('browser')
library rei.test.src.selection.linear_selectable_test;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:async';
import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';
import 'package:test/test.dart';

import 'package:rei/direction.dart';
import 'package:rei/selectable.dart';

import 'linear_selectable_test_element.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Callback for when events should be checked.
typedef void _ResultCallback();

/// Creates a timer which invokes the [callback] to verify the test passed.
///
/// Adds a wait for the given [milliseconds] to ensure that all actions
/// complete before verification. This is used to ensure that all the DOM
/// events have been handled beforehand.
void _waitForEvents(_ResultCallback callback, [int milliseconds = 5]) {
  new Timer(new Duration(milliseconds: milliseconds), expectAsync(callback));
}

/// Callback for a selection event.
typedef void _SelectionCallback(html.CustomEvent event);

/// Creates an event callback which adds to [selections] whenever an event occurs.
_SelectionCallback _createSelectionCallback(List<html.Element> selections) {
  return (html.CustomEvent event) {
    var selected = event.target as html.Element;

    selections.add(selected);
  };
}

/// The direction to move the selection in.
enum MoveDirection {
  left,
  right,
  up,
  down
}

/// Changes the selection within [selectable] by the given [moves].
void _moveSelection(Selectable selectable, List<MoveDirection> moves) {
  for (var move in moves) {
    switch (move) {
      case MoveDirection.left:
        selectable.left();
        break;
      case MoveDirection.right:
        selectable.right();
        break;
      case MoveDirection.up:
        selectable.up();
        break;
      default: // case MoveDirection.down
        selectable.down();
        break;
    }
  }
}

/// Moves the selection within [selectable] in a single [direction] across the entire contents.
///
/// The [repeat] value specifies how many times the movement should be
/// repeated. By default its 1. Multiple repetitions are used to test the
/// the wrapping of elements.
void _moveSelectionInDirection(LinearSelectable selectable, MoveDirection direction, [int repeat = 1]) {
  var moveCount = selectable.selectableElements.length;
  var moves = new List<MoveDirection>.filled((moveCount * repeat) - 1, direction);

  selectable.select();

  _moveSelection(selectable, moves);
}

LinearSelectableTestElement _createSelectionGroup(int childCount, Direction direction, bool wrap, [int notSelectableEvery = 0]) {
  var selectable = new LinearSelectableTestElement();

  selectable.direction = direction;
  selectable.wrapStart = wrap;
  selectable.wrapEnd = wrap;

  for (var i = 0; i < childCount; ++i) {
    var child = new html.DivElement();
    var attributes = child.attributes;

    if ((notSelectableEvery != 0) && (i % notSelectableEvery == 0)) {
      attributes[Selectable.notSelectableAttribute];
    }

    // Add the index so an element can be verified
    attributes['data-index'] = i.toString();

    selectable.children.add(child);
  }

  html.document.body.children.add(selectable);

  return selectable;
}

//---------------------------------------------------------------------
// Tests
//---------------------------------------------------------------------

/// The number of moves to make.
const int _moveCount = 20;
/// The number of times to repeat.
///
/// This is used to verify wrapping.
const int _repeat = 3;

/// Test a horizontal group without a wrapping.
void _horizontalGroupWithoutWrap() {
  var selections = new List<html.Element>();
  var selectionSubscription;
  var selectable;

  setUp(() {
    selectable = _createSelectionGroup(_moveCount, Direction.horizontal, false);
    selectionSubscription = selectable.on[Selectable.selectionChangedEvent].listen(_createSelectionCallback(selections));
  });

  tearDown(() {
    // Cancel the subscription
    selectionSubscription.cancel();

    // Remove the element
    var parent = selectable.parent;
    parent.children.remove(selectable);

    // Clear the selections
    selections.clear();
  });

  test('Moving left', () {
    _moveSelectionInDirection(selectable, MoveDirection.left, _repeat);

    _waitForEvents(() {
      expect(selections.length, 1);
    });
  });

  test('Moving right', () {
    _moveSelectionInDirection(selectable, MoveDirection.right, _repeat);

    _waitForEvents(() {
      expect(selections.length, _moveCount);
    });
  });

  test('Moving up', () {
    _moveSelectionInDirection(selectable, MoveDirection.up, _repeat);

    _waitForEvents(() {
      expect(selections.length, 1);
    });
  });

  test('Moving down', () {
    _moveSelectionInDirection(selectable, MoveDirection.down, _repeat);

    _waitForEvents(() {
      expect(selections.length, 1);
    });
  });
}

//---------------------------------------------------------------------
// Entry point
//---------------------------------------------------------------------

Future<Null> main() async {
  await initPolymer();

  group('Single horizontal group', _horizontalGroupWithoutWrap);
}
