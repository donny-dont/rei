// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [IntervalAnimationUI] class.
@HtmlImport('animation_timing_ui.html')
library rei.web.animation.components.animation_timing_ui;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

import 'package:rei/animation.dart';
import 'package:rei/playback_direction.dart';

import 'enum_option.dart';

//---------------------------------------------------------------------
// Component imports
//---------------------------------------------------------------------

import 'styling.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Tag name for the class.
const String _tagName = 'rei-animation-timing-ui';

@PolymerRegister(_tagName)
class AnimationTimingUI extends PolymerElement with EnumOption {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// The name of the tag.
  static const String customTagName = _tagName;

  //---------------------------------------------------------------------
  // Attributes
  //---------------------------------------------------------------------
  /// The number of milliseconds before the animation becomes active.
  @property String delay = '0';
  /// The number of milliseconds after the animation effect completes before
  /// the animation is fully complete.
  @property String endDelay = '0';
  @property String iterationStart = '0';
  /// The number of iterations for the animation.
  @property String iterations = '1';
  /// The duration for a single iteration of the animation in milliseconds.
  @property String duration = '1000';
  @property String direction;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [AnimationTimingUI] class.
  factory AnimationTimingUI() =>
      new html.Element.tag(customTagName) as AnimationTimingUI;

  /// Create an instance of the [AnimationTimingUI] class.
  ///
  /// This constructor should not be called directly. Instead use the
  /// default constructor.
  AnimationTimingUI.created() : super.created();

  //---------------------------------------------------------------------
  // PolymerElement
  //---------------------------------------------------------------------

  void ready() {
    print($);
    addOptions(
        $['playback'] as html.SelectElement,
        'direction',
        PlaybackDirection.values,
        serializePlaybackDirection
    );
  }

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Apply the timing values to the [animation].
  void applyValues(AnimationTiming animation) {
    animation.delay = double.parse(delay);
    animation.endDelay = double.parse(endDelay);
    animation.duration = double.parse(duration);
    animation.iterationStart = double.parse(iterationStart);
    animation.iterations = int.parse(iterations);
    animation.direction = deserializePlaybackDirection(direction);
  }

  //---------------------------------------------------------------------
  // Callbacks
  //---------------------------------------------------------------------

  @reflectable
  void changePlaybackDirection(html.Event event, [dynamic _]) {
    set('direction', (event.target as html.SelectElement).value);
  }
}
