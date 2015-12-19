// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [IntervalAnimationUI] class.
@HtmlImport('interval_animation_ui.html')
library rei.web.animation.components.interval_animation_ui;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

import 'package:rei/playback_direction.dart';

import 'enum_option.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Tag name for the class.
const String _tagName = 'rei-interval-animation-ui';

@PolymerRegister(_tagName)
class IntervalAnimationUI extends PolymerElement with EnumOption {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// The name of the tag.
  static const String customTagName = _tagName;

  //---------------------------------------------------------------------
  // Attributes
  //---------------------------------------------------------------------

  /// The duration of the animation.
  @property String duration = '1';
  /// The delay before the animation begins.
  @property String delay = '0';
  /// The number of iterations the animation should go through.
  @property String iterations = '1';
  /// The playback direction
  @property String playbackDirection;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [IntervalAnimationUI] class.
  factory IntervalAnimationUI() =>
      new html.Element.tag(customTagName) as IntervalAnimationUI;

  /// Create an instance of the [IntervalAnimationUI] class.
  ///
  /// This constructor should not be called directly. Instead use the
  /// default constructor.
  IntervalAnimationUI.created() : super.created();

  //---------------------------------------------------------------------
  // PolymerElement
  //---------------------------------------------------------------------

  void ready() {
    addOptions(
        $['playback'] as html.SelectElement,
        'playbackDirection',
        PlaybackDirection.values,
        serializePlaybackDirection
    );
  }

  //---------------------------------------------------------------------
  // Callbacks
  //---------------------------------------------------------------------

  @reflectable
  void changePlaybackDirection([html.Event event, _]) {
    set('playbackDirection', (event.target as html.SelectElement).value);
  }
}
