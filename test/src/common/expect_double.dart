// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

library rei.test.src.common.expect_double;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Comparison of double values for test values.
///
/// Compares how close the [actual] value is to the [expected] based on the
/// given [delta].
void expectDouble(double actual, double expected, [double delta = 0.001]) {
  expect(actual, closeTo(actual, delta));
}
