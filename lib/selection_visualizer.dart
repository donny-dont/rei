//  SONY CONFIDENTIAL MATERIAL. DO NOT DISTRIBUTE.
//  SNEI REI (Really Elegant Interface)
//  Copyright (C) 2014-2015 Sony Network Entertainment Inc
//  All Rights Reserved

/// Contains the [SelectionVisualizer] class.
library rei.selection_visualizer;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:rei/selectable.dart';
import 'package:rei/src/bounds.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Provides a visualization of the selectable areas in a document.
///
/// The [SelectionVisualizer] can be used to debug the selectable elements in
/// the document.
class SelectionVisualizer {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The rendering context to draw to.
  final html.CanvasRenderingContext2D context;
  /// The colors to use for each layer.
  final List<String> colors = [
      'rgba(255,   0,   0, 0.2)',
      'rgba(  0, 255,   0, 0.2)',
      'rgba(  0,   0, 255, 0.2)'
  ];
  /// The root element to draw.
  html.Element root;


  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  factory SelectionVisualizer(String canvasSelector) {
    var canvas = html.document.body.querySelector(canvasSelector) as html.CanvasElement;
    var context = canvas.getContext('2d') as html.CanvasRenderingContext2D;

    return new SelectionVisualizer.withContext(context);
  }

  SelectionVisualizer.withContext(this.context);

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  void draw() {
    context.clearRect(0, 0, 1920, 1080);

    _drawSelection(root, 0);
  }

  //---------------------------------------------------------------------
  // Private methods
  //---------------------------------------------------------------------

  void _drawSelection(html.Element element, int level) {
    var bounds = getAbsoluteBounds(element);
    var strokeColor = colors[level % colors.length];
    var fillColor = strokeColor;
    var children;

    if (element is Selectable) {
      fillColor = 'transparent';
      children = (element as Selectable).selectableElements;
    } else {
      strokeColor = 'transparent';
      fillColor = 'rgba(255, 255, 255, 0.5)';
      children = [];
    }

    _drawBounds(bounds, fillColor, strokeColor);

    level++;

    for (var child in children) {
      _drawSelection(child, level);
    }
  }

  void _drawBounds(html.Rectangle bounds, String fillColor, String strokeColor) {
    context
        ..beginPath()
        ..rect(bounds.left, bounds.top, bounds.width, bounds.height)
        ..fillStyle = fillColor
        ..fill()
        ..lineWidth = 4
        ..strokeStyle = strokeColor
        ..stroke();
  }
}
