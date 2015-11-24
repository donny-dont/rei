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

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Applies a [value] to the [style].
typedef void _ApplyCssProperty(html.CssStyleDeclaration style, dynamic value);

/// Regular expression for a blur filter value.
final RegExp _blurRegex = new RegExp(r'blur\([-+]?[0-9]*\.?[0-9]+px\)');
/// Regular expression for a sepia filter value.
final RegExp _sepiaRegex = new RegExp(r'sepia\([-+]?[0-9]*\.?[0-9]+\)');
/// Regular expression for a grayscale filter value.
final RegExp _grayscaleRegex = new RegExp(r'grayscale\([-+]?[0-9]*\.?[0-9]+\)');
/// Regular expression for a brightness filter value.
final RegExp _brightnessRegex = new RegExp(r'brightness\([-+]?[0-9]*\.?[0-9]+\)');
/// Regular expression for a contrast filter value.
final RegExp _contrastRegex = new RegExp(r'contrast\([-+]?[0-9]*\.?[0-9]+\)');
/// Regular expression for a hue rotation filter value.
final RegExp _hueRotateRegex = new RegExp(r'hue-rotate\([-+]?[0-9]*\.?[0-9]+deg\)');
/// Regular expression for an invert filter value.
final RegExp _invertRegex = new RegExp(r'invert\([-+]?[0-9]*\.?[0-9]+\)');
/// Regular expression for a saturate filter value.
final RegExp _saturateRegex = new RegExp(r'saturate\([-+]?[0-9]*\.?[0-9]+\)');

/// List of functions to apply styles.
///
/// Corresponds to the enumerations in [AnimationTarget].
final List<_ApplyCssProperty> _applyFunctions = [
  _applyOpacity,    // CssTarget.opacity
  _applyBlur,       // CssTarget.blur
  _applySepia,      // CssTarget.sepia
  _applyGrayscale,  // CssTarget.grayscale
  _applyBrightness, // CssTarget.brightness
  _applyContrast,   // CssTarget.contrast
  _applyHueRotate,  // CssTarget.hueRotate
  _applyInvert,     // CssTarget.invert
  _applySaturate    // CssTarget.saturate
];

/// Sets the opacity to the given [value] on the [style].
void _applyOpacity(html.CssStyleDeclaration style, double value) {
  style.opacity = value.toString();
}

/// Modifies the [value] using the [regex] and modifying the first match with
/// [replace].
String _modifyStringValue(String value, RegExp regex, String replace) =>
  (regex.hasMatch(value))
      ? value.replaceFirst(regex, replace)
      : value + replace;

//---------------------------------------------------------------------
// Filter modifier
//---------------------------------------------------------------------

// \TODO Revisit to see if Chrome fixed the behavior.

/// The property for a filter.
///
/// This has to be used instead of setting filter on the style declaration as
/// the filter is not unprefixed.
const String _filterProperty = '-webkit-filter';

/// Applies a filter with the given [value] to the [style] declaration.
///
/// The [regex] is used to find previous applications of the filter to the
/// [style] so multiple filters can be applied to the same element.
void _applyFilter(html.CssStyleDeclaration style, RegExp regex, String value) {
  var current = style.getPropertyValue(_filterProperty);
  var modified = _modifyStringValue(current, regex, value);

  style.setProperty(_filterProperty, modified);
}

/// Apply a blur filter with the given [value] to the [style] declaration.
void _applyBlur(html.CssStyleDeclaration style, double value) {
  _applyFilter(style, _blurRegex, 'blur(${value}px)');
}

/// Apply a sepia filter with the given [value] to the [style] declaration.
void _applySepia(html.CssStyleDeclaration style, double value) {
  _applyFilter(style, _sepiaRegex, 'sepia(${value})');
}

/// Apply a grayscale filter with the given [value] to the [style] declaration.
void _applyGrayscale(html.CssStyleDeclaration style, double value) {
  _applyFilter(style, _grayscaleRegex, 'grayscale(${value})');
}

/// Apply a brightness filter with the given [value] to the [style] declaration.
void _applyBrightness(html.CssStyleDeclaration style, double value) {
  _applyFilter(style, _brightnessRegex, 'brightness(${value})');
}

/// Apply a contrast with the given [value] to the [style] declaration.
void _applyContrast(html.CssStyleDeclaration style, double value) {
  _applyFilter(style, _contrastRegex, 'contrast(${value})');
}

/// Apply a hue rotate filter with the given [value] to the [style] declaration.
void _applyHueRotate(html.CssStyleDeclaration style, double value) {
  _applyFilter(style, _hueRotateRegex, 'hue-rotate(${value}deg)');
}

/// Apply an invert filter with the given [value] to the [style] declaration.
void _applyInvert(html.CssStyleDeclaration style, double value) {
  _applyFilter(style, _invertRegex, 'invert(${value})');
}

/// Apply a saturate filter with the given [value] to the [style] declaration.
void _applySaturate(html.CssStyleDeclaration style, double value) {
  _applyFilter(style, _saturateRegex, 'saturate(${value})');
}

/// Applies the [value] to the [style] for the given [target].
///
/// This currently supports multiple filters being applied to the same [style]
/// but does not support a filter being applied multiple times to the [style].
/// Applying the same filter multiple times can turn into a performance
/// bottleneck so this is not recommended anyways.
void applyValue(AnimationTarget target,
                html.CssStyleDeclaration style,
                double value) {
  _applyFunctions[target.index](style, value);
}
