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
import 'package:rei/src/animation/css_property.dart';

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
  applyValue(AnimationTarget.blur, style, blurValue);
  _expectFilter(style, 'blur(${blurValue}px)');

  blurValue = 1.5;
  applyValue(AnimationTarget.blur, style, blurValue);
  _expectFilter(style, 'blur(${blurValue}px)');

  sepiaValue = 0.2;
  applyValue(AnimationTarget.sepia, style, sepiaValue);
  _expectFilter(style, 'blur(${blurValue}px) sepia(${sepiaValue})');

  sepiaValue = 0.8;
  applyValue(AnimationTarget.sepia, style, sepiaValue);
  _expectFilter(style, 'blur(${blurValue}px) sepia(${sepiaValue})');

  grayscaleValue = 0.5;
  applyValue(AnimationTarget.grayscale, style, grayscaleValue);
  _expectFilter(style, 'blur(${blurValue}px) sepia(${sepiaValue}) grayscale(${grayscaleValue})');

  grayscaleValue = 0.1;
  applyValue(AnimationTarget.grayscale, style, grayscaleValue);
  _expectFilter(style, 'blur(${blurValue}px) sepia(${sepiaValue}) grayscale(${grayscaleValue})');
}

//---------------------------------------------------------------------
// Entry point
//---------------------------------------------------------------------

void main() {
  test('applyValue', _applyValue);
}
