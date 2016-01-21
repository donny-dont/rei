// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [AnimationUI] class.

library rei.web.animation.components.addable;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:async';
import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

import 'package:rei/animation.dart';

//---------------------------------------------------------------------
// Components
//---------------------------------------------------------------------

import 'interval_animation_ui.dart';
import 'keyframe_animation_ui.dart';
import 'keyframe_ui.dart';
import 'sequenced_animation_ui.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Implements the adding of an animation to a group.
///
/// Just using a behavior here instead of making the menu into an element as
/// there are cases where you don't want the ability to add animation types.
@behavior
abstract class Addable implements PolymerElement {
  //---------------------------------------------------------------------
  // Protected methods
  //---------------------------------------------------------------------

  void onElementAdded() {
    // Hide the menu
    hideMenu();
  }

  //---------------------------------------------------------------------
  // Callbacks
  //---------------------------------------------------------------------

  @reflectable
  void showMenu([html.Event event, _]) {
    $['menu'].classes.remove('hide');
  }

  @reflectable
  void hideMenu([html.Event event, _]) {
    $['menu'].classes.add('hide');
  }

  @reflectable
  void addTransition([html.Event event, _]) {
    new PolymerDom(this).append(new IntervalAnimationUI());

    // Notify that something was added
    onElementAdded();
  }

  @reflectable
  void addKeyframeAnimation([html.Event event, _]) {
    print('adding keyframe');
    var keyframeAnimation = new KeyframeAnimationUI();

    // Add an initial keyframes
    var keyframeAnimationDom = Polymer.dom(keyframeAnimation);
    keyframeAnimationDom.append(new KeyframeUI());
    keyframeAnimationDom.append(new KeyframeUI());

    // Add the keyframe animation
    Polymer.dom(this).append(keyframeAnimation);

    // Notify that something was added
    onElementAdded();
  }

  @reflectable
  void addSyncedAnimation([html.Event event, _]) {
    print('adding synced');
    // Notify that something was added
    //onElementAdded();
  }

  @reflectable
  void addSequencedAnimation([html.Event event, _]) {
    print('adding sequenced');
    var sequencedAnimation = new SequencedAnimationUI();

    // Add the sequenced animation
    Polymer.dom(this).append(sequencedAnimation);

    // Notify that something was added
    onElementAdded();
  }
}
