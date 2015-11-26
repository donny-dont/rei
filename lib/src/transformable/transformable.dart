// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [Transformable] mixin.
library rei.src.transform.transformable;

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

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

@behavior
abstract class Transformable {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// The event fired when the transform is changed.
  static const String transformChangedEvent = 'transformchange';
  /// A scratch matrix to use when computing the world transformation.
  ///
  /// Used to prevent the creation of multiple temporary matrices.
  static final _scratchMatrix = new Float32List(6);

  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The local 2D matrix.
  final Float32List localMatrix = new Float32List(6);
  /// The world 2D matrix.
  final Float32List worldMatrix = new Float32List(6);
  /// Whether the world matrix is up to date.
  bool _isDirty = true;

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The translation in the x direction.
  num get x;
  set x(num value);
  /// The translation in the y direction.
  num get y;
  set y(num value);
  /// The scale in the x direction.
  num get scaleX;
  set scaleX(num value);
  /// The scale in the y direction.
  num get scaleY;
  set scaleY(num value);
  /// Whether a transform changed event should be propagated.
  bool get propagateTransformChange;
  /// The translation in the x direction within the world.
  num get worldX => worldMatrix[4];
  /// The translation in the y direction within the world.
  num get worldY => worldMatrix[5];

  //---------------------------------------------------------------------
  // PolymerElement
  //---------------------------------------------------------------------

  html.CustomEvent fire(String type,
                       {detail,
                        bool canBubble: true,
                        bool cancelable: true,
                        html.Node node});

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Callback for when any of the values affecting the transformation are
  /// changed.
  ///
  /// This is used instead of wrapping as a getter/setter pair.
  @Observe('x,y,scaleX,scaleY')
  void valueChanged(_, __, ___, ____) {
    _isDirty = true;

    if (propagateTransformChange) {
      fire(transformChangedEvent);
    }
  }

  /// Callback for when a [transformationChangedEvent] occurs.
  @Listen(transformChangedEvent)
  void onTransformChanged([html.CustomEvent event, _]) {
    _isDirty = true;

    if (!propagateTransformChange) {
      event.stopPropagation();
    }
  }

  /// Updates the world matrix for the element.
  ///
  /// If the matrix was updated then `true` is returned; otherwise it returns
  /// `false`. This is done to avoid setting the CSS transform style
  /// unnecessarily.
  bool updateWorldMatrix() {
    if (_isDirty) {
      create2DTransform(localMatrix, x, y, scaleX, scaleY);

      // Get a count of the number of Transformable elements within the element
      var childCount = 0;
      // Get the children within the element
      var children = new PolymerDom(this).children;

      // Update the world matrix for the child elements
      for (var child in children) {
        if (child is Transformable) {
          var transformable = child as Transformable;
          transformable.updateWorldMatrix();

          ++childCount;
        }
      }

      // Update the world matrix for this element
      if (childCount != 0) {
        // Determine which matrix to multiply into.
        //
        // This ensures that the world matrix is set by the last multiplication
        // of the child nodes. For odd counts it should use the world matrix
        // initially. For even counts the scratch matrix is used. This is all
        // to ensure that no additional matrices are created during the
        // computation.
        var out = (childCount % 2 == 1) ? worldMatrix : _scratchMatrix;
        var lhs = localMatrix;

        for (var child in children) {
          if (child is Transformable) {
            var transformable = child as Transformable;

            multiply2DTransform(out, lhs, transformable.worldMatrix);

            lhs = out;

            // Swap the matrix to output to
            out = (lhs == worldMatrix) ? _scratchMatrix : worldMatrix;
          }
        }
      } else {
        copy2DTransform(worldMatrix, localMatrix);
      }

      return true;
    } else {
      return false;
    }
  }
}
