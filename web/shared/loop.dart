
library rei.web.shared.loop;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:rei/animation.dart';
import 'package:rei/application.dart';
import 'package:rei/transformable.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// The animation manager for the application.
final _animationManager = new AnimationManager();
/// The transformable manager for the application.
final _transformableManager = new TransformableManager();

void start() {
  var loop = new UpdateLoop();

  loop.onFrame = _onFrame;
  loop.start();
}

void _onFrame(Time time) {
  _animationManager.update(time.deltaTime);
  _transformableManager.update();
}
