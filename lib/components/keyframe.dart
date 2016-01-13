// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [Keyframe] class.
library rei.components.keyframe;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';

import 'package:rei/animation.dart' as animation;
import 'package:rei/bezier_curve.dart';
import 'package:rei/easing_function.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Tag name for the class.
const String _tagName = 'rei-keyframe';

/// An element that holds keyframe information.
@PolymerRegister(_tagName)
class Keyframe extends PolymerElement with animation.Keyframe<num>,
                                           PolymerSerialize {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// The name of the tag.
  static const String customTagName = _tagName;

  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  @override
  BezierCurve<num> curve;

  //---------------------------------------------------------------------
  // Attributes
  //---------------------------------------------------------------------

  @override
  @Property(reflectToAttribute: true)
  num value = 1.0;
  @override
  @Property(reflectToAttribute: true)
  num frameOffset;
  /// The easing function or bezier curve to use when computing the animation
  /// value.
  @Property(reflectToAttribute: true)
  dynamic easing = EasingFunction.ease;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [Keyframe] class.
  factory Keyframe() =>
      new html.Element.tag(customTagName) as Keyframe;

  /// Create an instance of the [Keyframe] class.
  ///
  /// This constructor should not be called directly. Instead use the
  /// default constructor.
  Keyframe.created() : super.created();

  //---------------------------------------------------------------------
  // PolymerElement
  //---------------------------------------------------------------------

  void ready() {
    style.display = 'none';
  }

  //---------------------------------------------------------------------
  // PolymerSerialize
  //---------------------------------------------------------------------

  @override
  dynamic deserialize(String value, Type type) {
    if (type == dynamic) {
      if (value.startsWith('[')) {
        type = List;
      } else {
        return deserializeEasingFunction(value);
      }
    }

    return super.deserialize(value, type);
  }

  @override
  String serialize(Object value) =>
      (value is EasingFunction)
          ? serializeEasingFunction(value) : super.serialize(value);

  //---------------------------------------------------------------------
  // Callbacks
  //---------------------------------------------------------------------

  @Observe('easing')
  void easingChanged(dynamic value) {
    var curveValues = (value is EasingFunction)
        ? animation.getEasingCurve(value)
        : value;

    curve = new BezierCurveScalar(curveValues as List<num>);
  }
}
