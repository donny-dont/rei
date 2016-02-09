// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.


library rei.property;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Whether the value should be reflected to an attribute.
///
/// Reflecting to an attribute is useful during development but has a cost when
/// being used in production.
const bool reflectToAttribute = const String.fromEnvironment('DEBUG') != null;

/// The property declaration.
///
/// This should be used on all properties instead of [property].
const Property reiProperty = reflectToAttribute
    ? const Property(reflectToAttribute: true)
    : property;
