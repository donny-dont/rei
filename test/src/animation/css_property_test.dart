// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

@TestOn('browser')
library rei.test.src.animation.css_property;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';

import 'package:rei/animation_target.dart';
import 'package:rei/src/animation/animation_target_value.dart';

//---------------------------------------------------------------------
// Tests
//---------------------------------------------------------------------

void _expectFilter(html.CssStyleDeclaration style, String expected) {
  expect(style.getPropertyValue('-webkit-filter'), expected);
}

void _applyValue() {
  var element = new html.DivElement();
  var style = element.style;
  var blurValue;
  var sepiaValue;
  var grayscaleValue;

  blurValue = 0.5;
  applyAnimationTargetValue(AnimationTarget.blur, element, blurValue);
  _expectFilter(style, 'blur(${blurValue}px)');

  blurValue = 1.5;
  applyAnimationTargetValue(AnimationTarget.blur, element, blurValue);
  _expectFilter(style, 'blur(${blurValue}px)');

  sepiaValue = 0.2;
  applyAnimationTargetValue(AnimationTarget.sepia, element, sepiaValue);
  _expectFilter(style, 'blur(${blurValue}px) sepia($sepiaValue)');

  sepiaValue = 0.8;
  applyAnimationTargetValue(AnimationTarget.sepia, element, sepiaValue);
  _expectFilter(style, 'blur(${blurValue}px) sepia($sepiaValue)');

  grayscaleValue = 0.5;
  applyAnimationTargetValue(AnimationTarget.grayscale, element, grayscaleValue);
  _expectFilter(style, 'blur(${blurValue}px) sepia($sepiaValue) grayscale($grayscaleValue)');

  grayscaleValue = 0.1;
  applyAnimationTargetValue(AnimationTarget.grayscale, element, grayscaleValue);
  _expectFilter(style, 'blur(${blurValue}px) sepia($sepiaValue) grayscale($grayscaleValue)');
}

//---------------------------------------------------------------------
// Entry point
//---------------------------------------------------------------------

void main() {
  test('applyValue', _applyValue);
}
