// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [TransformableElement] mixin.
library rei.src.transform.transformable_element;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;
import 'dart:typed_data';

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';

import '../../transform_origin.dart';
import '../matrix_math.dart';

import 'transformable_manager.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

@behavior
abstract class TransformableElement implements PolymerBase {
  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The [html.Element] to apply the transformation to.
  ///
  /// This element's style will be directly modified whenever [applyTransform]
  /// is called to reflect the applicable CSS transform.
  html.Element get transformableElement;

  TransformOrigin get transformOrigin;

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Updates the translation for the element.
  void updateTransform() {
    if (updateWorldMatrix()) {
      transformableElement.style.transform = css2DTransform(worldMatrix);
    }
  }

  //---------------------------------------------------------------------
  // Transformable
  //---------------------------------------------------------------------

  Float32List get worldMatrix;

  bool get propagateTransformChange => false;

  bool updateWorldMatrix();

  //---------------------------------------------------------------------
  // Polymer Lifecycle
  //---------------------------------------------------------------------

  static void ready(TransformableElement element) {
    var style = element.transformableElement.style;

    // Set the origin to the upper left corner
    style.transformOrigin = transformOriginStyle(element.transformOrigin);

    // Adding will change property
    style.willChange = 'transform';

    // In webkit browsers a 2D transform will not promote the element to its
    // own compositor layer. To force this the backface-visibility attribute
    // is set to hidden.
    style.backfaceVisibility = 'hidden';
  }

  static void attached(TransformableElement element) {
    new TransformableManager().add(element);
  }

  static void detached(TransformableElement element) {
    new TransformableManager().remove(element);
  }
}
