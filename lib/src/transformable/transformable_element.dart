// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

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

import 'package:rei/src/matrix_math.dart';

import 'transformable_manager.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

@behavior
abstract class TransformableElement {
  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The [html.Element] to apply the transformation to.
  ///
  /// This element's style will be directly modified whenever [applyTransform]
  /// is called to reflect the applicable CSS transform.
  html.Element get transformableElement;

  //---------------------------------------------------------------------
  // PolymerElement
  //---------------------------------------------------------------------

  // \TODO Change to appropriate names after https://github.com/dart-lang/sdk/issues/23770

  void readyTransformableElement() {
    var style = transformableElement.style;

    // Set the origin to the upper left corner
    style.transformOrigin = 'left top 0';

    // Adding will change property
    style.willChange = 'transform';

    // In webkit browsers a 2D transform will not promote the element to its
    // own compositor layer. To force this the backface-visibility attribute
    // is set to hidden.
    style.backfaceVisibility = 'hidden';
  }

  void attachedTransformableElement() {
    new TransformableManager().add(this);
  }

  void detachedTransformableElement() {
    new TransformableManager().remove(this);
  }

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Updates the translation for the element.
  void update() {
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
}
