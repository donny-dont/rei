// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains functions to apply a CSS value based on an [AnimationTarget].
library rei.src.animation.css_property;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:rei/animation_target.dart';
import 'package:rei/transformable.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Applies a [value] to the [element].
typedef void _ApplyAnimationTarget(html.Element element, dynamic value);

/// Regular expression for matching numbers.
const _numRegex = r'[-+]?[0-9]+\.?[0-9]*([Ee][+-]?[0-9]+)*';

/// Regular expression for a blur filter value.
final RegExp _blurRegex =
    new RegExp('blur\\(${_numRegex}px\\)');

/// Regular expression for a sepia filter value.
final RegExp _sepiaRegex =
    new RegExp('sepia\\($_numRegex\\)');

/// Regular expression for a grayscale filter value.
final RegExp _grayscaleRegex =
    new RegExp('grayscale\\($_numRegex\\)');

/// Regular expression for a brightness filter value.
final RegExp _brightnessRegex =
    new RegExp('brightness\\($_numRegex\\)');

/// Regular expression for a contrast filter value.
final RegExp _contrastRegex =
    new RegExp('contrast\\($_numRegex\\)');

/// Regular expression for a hue rotation filter value.
final RegExp _hueRotateRegex =
    new RegExp('hue-rotate\\(${_numRegex}deg\\)');

/// Regular expression for an invert filter value.
final RegExp _invertRegex =
    new RegExp('invert\\($_numRegex\\)');

/// Regular expression for a saturate filter value.
final RegExp _saturateRegex =
    new RegExp('saturate\\($_numRegex\\)');

/// List of functions to apply styles.
///
/// Corresponds to the enumerations in [AnimationTarget].
final List<_ApplyAnimationTarget> _applyFunctions = [
  _applyOpacity,    // AnimationTarget.opacity
  _applyBlur,       // AnimationTarget.blur
  _applySepia,      // AnimationTarget.sepia
  _applyGrayscale,  // AnimationTarget.grayscale
  _applyBrightness, // AnimationTarget.brightness
  _applyContrast,   // AnimationTarget.contrast
  _applyHueRotate,  // AnimationTarget.hueRotate
  _applyInvert,     // AnimationTarget.invert
  _applySaturate,   // AnimationTarget.saturate
  _applyTranslateX, // AnimationTarget.translateX
  _applyTranslateY, // AnimationTarget.translateY
  _applyScaleX,     // AnimationTarget.scaleX
  _applyScaleY      // AnimationTarget.scaleY
];

/// Applies the [value] to the [element] for the given [target].
///
/// When applying filters this currently supports multiple filters being
/// applied to the same style but does not support a filter being applied
/// multiple times to the style. Applying the same filter multiple times can
/// turn into a performance bottleneck so this is not recommended anyways.
///
/// For transform targets it is assumed that the [element] is [Transformable].
void applyAnimationTargetValue(AnimationTarget target,
                               html.Element element,
                               double value) {
  _applyFunctions[target.index](element, value);
}

//---------------------------------------------------------------------
// Opacity modifier
//---------------------------------------------------------------------

/// Sets the opacity to the given [value] on the [style].
void _applyOpacity(html.CssStyleDeclaration style, double value) {
  style.opacity = value.toString();
}

//---------------------------------------------------------------------
// Filter modifier
//---------------------------------------------------------------------

// \TODO Revisit to see if Chrome fixed the behavior.

/// The property for a filter.
///
/// This has to be used instead of setting filter on the style declaration as
/// the filter is not unprefixed.
const String _filterProperty = '-webkit-filter';

/// Modifies the [value] using the [regex] and modifying the first match with
/// [replace].
String _modifyStringValue(String value, RegExp regex, String replace) =>
    (regex.hasMatch(value))
        ? value.replaceFirst(regex, replace)
        : value + replace;

/// Applies a filter with the given [value] to the [style] declaration.
///
/// The [regex] is used to find previous applications of the filter to the
/// [style] so multiple filters can be applied to the same element.
void _applyFilter(html.Element element, RegExp regex, String value) {
  var style = element.style;
  var current = style.getPropertyValue(_filterProperty);
  var modified = _modifyStringValue(current, regex, value);

  style.setProperty(_filterProperty, modified);
}

/// Apply a blur filter with the given [value] to the [element].
void _applyBlur(html.Element element, double value) {
  _applyFilter(element, _blurRegex, 'blur(${value}px)');
}

/// Apply a sepia filter with the given [value] to the [element].
void _applySepia(html.Element element, double value) {
  _applyFilter(element, _sepiaRegex, 'sepia($value)');
}

/// Apply a grayscale filter with the given [value] to the [element].
void _applyGrayscale(html.Element element, double value) {
  _applyFilter(element, _grayscaleRegex, 'grayscale($value)');
}

/// Apply a brightness filter with the given [value] to the [element].
void _applyBrightness(html.Element element, double value) {
  _applyFilter(element, _brightnessRegex, 'brightness($value)');
}

/// Apply a contrast with the given [value] to the [element].
void _applyContrast(html.Element element, double value) {
  _applyFilter(element, _contrastRegex, 'contrast($value)');
}

/// Apply a hue rotate filter with the given [value] to the [element].
void _applyHueRotate(html.Element element, double value) {
  _applyFilter(element, _hueRotateRegex, 'hue-rotate(${value}deg)');
}

/// Apply an invert filter with the given [value] to the [element].
void _applyInvert(html.Element element, double value) {
  _applyFilter(element, _invertRegex, 'invert($value)');
}

/// Apply a saturate filter with the given [value] to the [style] declaration.
void _applySaturate(html.Element element, double value) {
  _applyFilter(element, _saturateRegex, 'saturate($value)');
}

//---------------------------------------------------------------------
// Transform modifier
//---------------------------------------------------------------------

/// Applies a translation in the x direction with the given [value] to the
/// [element].
void _applyTranslateX(html.Element element, double value) {
  assert(element is Transformable);
  var transformable = element as Transformable;

  transformable.x = value;
}

/// Applies a translation in the y direction with the given [value] to the
/// [element].
void _applyTranslateY(html.Element element, double value) {
  assert(element is Transformable);
  var transformable = element as Transformable;

  transformable.y = value;
}

/// Applies a scale in the x direction with the given [value] to the [element].
void _applyScaleX(html.Element element, double value) {
  assert(element is Transformable);
  var transformable = element as Transformable;

  transformable.scaleX = value;
}

/// Applies a scale in the y direction with the given [value] to the [element].
void _applyScaleY(html.Element element, double value) {
  assert(element is Transformable);
  var transformable = element as Transformable;

  transformable.scaleY = value;
}
