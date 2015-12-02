// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains functions to compute and store the bounds of an element.
///
///
library rei.src.bounds;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:rei/transformable.dart';
import 'package:rei/selectable.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// An attribute containing the position along the x axis of the element
/// relative to its parent.
const String relativeXAttribute = 'data-relative-x';
/// An attribute containing the position along the y axis of the element
/// relative to its parent.
const String relativeYAttribute = 'data-relative-y';

/// An attribute containing the absolute position along the x axis of the
/// element relative to the document.
const String absoluteXAttribute = 'data-absolute-x';
/// An attribute containing the absolute position along the y axis of the
/// element relative to the document.
const String absoluteYAttribute = 'data-absolute-y';

/// An attribute containing the computed width of the element.
const String widthAttribute = 'data-width';
/// An attribute containing the computed height of the element.
const String heightAttribute = 'data-height';

void computeBoundsTree(html.Element root, [html.Rectangle bounds]) {
  if (bounds == null) {
    bounds = new html.Rectangle(0, 0, 0, 0);
  }

  _computeBoundsTree(bounds, root, false);
}

void _computeBoundsTree(html.Rectangle parentBounds, html.Element element, bool useRelative) {
  // Determine if relative coordinates should be used.
  //
  // If the child is Transformable then relative will be used and this will
  // trickle down to other elements in the tree.
  useRelative = (useRelative) ? true : element is Transformable;

  var bounds;

  if (useRelative) {
    bounds = _computeRelativeBounds(parentBounds, element);
  } else {
    bounds = _computeAbsoluteBounds(element);
  }

  // Iterate into the children to get the rest of the tree.
  var children = _getChildren(element);

  for (var child in children) {
    _computeBoundsTree(bounds, child, useRelative);
  }
}

html.Rectangle _computeAbsoluteBounds(html.Element element) {
  var bounds = element.getBoundingClientRect();
  var attributes = element.attributes;

  attributes[absoluteXAttribute] = bounds.left.toString();
  attributes[absoluteYAttribute] = bounds.top.toString();
  attributes[widthAttribute] = bounds.width.toString();
  attributes[heightAttribute] = bounds.height.toString();

  return bounds;
}

html.Rectangle _computeRelativeBounds(html.Rectangle parentBounds, html.Element element) {
  var bounds = element.getBoundingClientRect();
  var attributes = element.attributes;

  var x = bounds.left - parentBounds.left;
  var y = bounds.top - parentBounds.top;

  if (element is Transformable) {
    var transformable = element as Transformable;

    x -= transformable.worldX;
    y -= transformable.worldY;
  }

  attributes[relativeXAttribute] = x.toString();
  attributes[relativeYAttribute] = y.toString();
  attributes[widthAttribute] = bounds.width.toString();
  attributes[heightAttribute] = bounds.height.toString();

  return bounds;
}

List<html.Element> _getChildren(html.Element parent) {
  if (parent is Selectable) {
    var selectable = parent as Selectable;

    return selectable.selectableElements;
  } else {
    return parent.children;
  }
}

/// Retrieves the absolute bounds of the [element].
html.Rectangle getAbsoluteBounds(html.Element element) {
  var attributes = element.attributes;

  // See if the absolute position was already determined
  //
  // Currently the assumption is that if one absolute attribute is set then the
  // other will be present.
  if (attributes.containsKey(absoluteXAttribute)) {
    var x = _parseDoubleAttribute(absoluteXAttribute, attributes);
    var y = _parseDoubleAttribute(absoluteYAttribute, attributes);
    var width = _parseDoubleAttribute(widthAttribute, attributes);
    var height = _parseDoubleAttribute(heightAttribute, attributes);

    return new html.Rectangle(x, y, width, height);
  } else if (attributes.containsKey(relativeXAttribute)) {
    // Get the absolute bounds of the parent
    var parent = Selectable.findParentSelectable(element) as html.Element;
    var parentBounds = (parent != null)
        ? getAbsoluteBounds(parent)
        : new html.Rectangle(0.0, 0.0, 0.0, 0.0);

    // Get the element's relative bounds
    var x = _parseDoubleAttribute(relativeXAttribute, attributes) + parentBounds.left;
    var y = _parseDoubleAttribute(relativeYAttribute, attributes) + parentBounds.top;
    var width = _parseDoubleAttribute(widthAttribute, attributes);
    var height = _parseDoubleAttribute(heightAttribute, attributes);

    // Account for transformations
    //
    // \TODO ACCOUNT FOR SCALE
    if (element is Transformable) {
      var transformable = element as Transformable;

      x += transformable.worldX;
      y += transformable.worldY;
    }

    return new html.Rectangle(x, y, width, height);
  } else {
    var parent = Selectable.findParentSelectable(element) as html.Element;
    var child = element;
    var parentBounds = new html.Rectangle(0.0, 0.0, 0.0, 0.0);
    var useRelative = false;

    while (true) {
      var parentAttributes = parent.attributes;

      if (parentAttributes.containsKey(absoluteXAttribute)) {
        parentBounds = getAbsoluteBounds(parent);

        break;
      } else if (parentAttributes.containsKey(relativeXAttribute)) {
        parentBounds = getAbsoluteBounds(parent);
        useRelative = true;

        break;
      } else {
        child = parent;
        parent = Selectable.findParentSelectable(parent) as html.Element;

        if (parent == null) {
          useRelative = parent is Transformable;
          break;
        }
      }
    }

    // Compute the bounds tree
    _computeBoundsTree(parentBounds, child, useRelative);

    // Try it again
    return getAbsoluteBounds(element);
  }
}

/// Parses the attribute with the given [key] into a [double].
///
/// Currently assumes that the attribute is present.
double _parseDoubleAttribute(String key, Map<String, String> attributes) =>
    double.parse(attributes[key]);
