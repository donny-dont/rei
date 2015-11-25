// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

library rei.web.selection.main;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:async';
import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';

import 'package:rei/selectable.dart';
import 'package:rei/components/selection_group.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// The currently selected element.
html.Element _selected;
/// The currently selected group.
Selectable _selectedGroup;

/// Callback for an [event] where a key is released.
void _onKeyUp(html.KeyboardEvent event) {
  var keyCode = event.keyCode;

  if (keyCode == html.KeyCode.LEFT) {
    _selectedGroup.left();
  } else if (keyCode == html.KeyCode.RIGHT){
    _selectedGroup.right();
  } else if (keyCode == html.KeyCode.UP) {
    _selectedGroup.up();
  } else if (keyCode == html.KeyCode.DOWN) {
    _selectedGroup.down();
  }
}

/// Callback for an [event] where a selection occurred.
void _onSelectionChanged(html.CustomEvent event) {
  if (_selected != null) {
    _selected.classes.remove('selected');
  }

  _selected = event.detail as html.Element;
  _selected.classes.add('selected');

  _selectedGroup = _selected.parent as Selectable;
}

/// Application entry-point.
Future<Null> main() async {
  await initPolymer();

  html.document.body.style.opacity = '1';

  // Setup the listeners
  html.window.onKeyUp.listen(_onKeyUp);
  html.window.on[Selectable.selectionChangedEvent].listen(_onSelectionChanged);

  // Begin the selection
  _selectedGroup = html.querySelector(SelectionGroup.customTagName) as SelectionGroup;
  _selectedGroup.select();
}
