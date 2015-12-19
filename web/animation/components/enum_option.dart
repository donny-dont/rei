// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [EnumOption] mixin.
library rei.web.animation.components.enum_option;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// A function to serialize an enumeration
typedef String SerializeEnum(dynamic value);

/// Behavior for adding option elements for an enum into a select element.
abstract class EnumOption implements PolymerElement {
  void addOptions(html.SelectElement selection,
                  String property,
                  List enums,
                  SerializeEnum serialize) {
    var shouldSelect = true;

    selection.children.addAll(
        enums.map/*<html.OptionElement>*/((value) {
          var name = serialize(value);

          var option = new html.OptionElement(value: name, selected: shouldSelect);
          option.innerHtml = name;

          if (shouldSelect) {
            set(property, name);
            shouldSelect = false;
          }

          return option;
        })
    );
  }
}
