// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Helper methods for performing matrix math calculations around
/// transformations.
library rei.src.matrix_math;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:typed_data';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Computes a 2D transform from translation, [x] and [y], and scaling,
/// [scaleX] and [scaleY], storing the result in [out].
///
/// A 2D translation is stored in a 3x2 matrix with the following layout.
///
///     +------------+------------+------------------+
///     | [0] scaleX | [2]   0    | [4] translationX |
///     +------------+------------+------------------+
///     | [1]   0    | [3] scaleY | [5] translationY |
///     +------------+------------+------------------+
void create2DTransform(Float32List out,
                       num x,
                       num y,
                       num scaleX,
                       num scaleY) {
  out[0] = scaleX.toDouble();
  out[1] = 0.0;
  out[2] = 0.0;
  out[3] = scaleY.toDouble();
  out[4] = x.toDouble();
  out[5] = y.toDouble();
}

/// Performs a multiplication of two 2D transformations, [a] and [b], storing
/// the result in [out].
void multiply2DTransform(Float32List out, Float32List a, Float32List b) {
  // Compute the first column
  out[0] = a[0] * b[0] + a[2] * b[1];
  out[1] = a[1] * b[0] + a[3] * b[1];

  // Compute the second column
  out[2] = a[0] * b[2] + a[2] * b[3];
  out[3] = a[1] * b[2] + a[3] * b[3];

  // Compute the third column
  out[4] = a[0] * b[4] + a[2] * b[5] + a[4];
  out[5] = a[1] * b[4] + a[3] * b[5] + a[5];
}

/// Copies the values of a 2D transformation contained in [a] into [out].
void copy2DTransform(Float32List out, Float32List a) {
  out[0] = a[0];
  out[1] = a[1];
  out[2] = a[2];
  out[3] = a[3];
  out[4] = a[4];
  out[5] = a[5];
}

/// Creates a representation of the [values] in CSS.
String css2DTransform(Float32List values) =>
    'matrix('
    '${values[0]},'
    '${values[1]},'
    '${values[2]},'
    '${values[3]},'
    '${values[4]},'
    '${values[5]})';
