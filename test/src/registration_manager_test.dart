// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

@TestOn('vm')
library rei.test.src.registration_manager_test;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';

import 'package:rei/src/registration_manager.dart';

//---------------------------------------------------------------------
// Tests
//---------------------------------------------------------------------

/// Adds elements to the [manager].
///
/// Simply adds elements from 0 to [count].
void _addElementsToManager(RegistrationManager<int> manager, int count) {
  for (var i = 0; i < count; ++i) {
    manager.add(i);
  }
}

/// Removes elements from the [manager].
///
/// Simply removes elements from 0 to [count].
void _removeElementsFromManager(RegistrationManager<int> manager, int count) {
  for (var i = 0; i < count; ++i) {
    manager.remove(i);
  }
}

/// Checks the number of components present in the [manager] [before] and [after] its updated.
void _checkRegisteredCountBeforeAfter(RegistrationManager<int> manager, int before, int after) {
  var registered = manager.registered;

  expect(registered.length, before);

  manager.updateRegistration();

  expect(registered.length, after);
}

//---------------------------------------------------------------------
// Entry point
//---------------------------------------------------------------------

void main() {
  const int repeatCount = 20;

  test('Adding elements', () {
    var manager = new RegistrationManager<int>();

    _addElementsToManager(manager, repeatCount);
    _checkRegisteredCountBeforeAfter(manager, 0, repeatCount);
  });

  test('Adding elements multiple times', () {
    var manager = new RegistrationManager<int>();

    for (var i = 0; i < repeatCount; ++i) {
      _addElementsToManager(manager, repeatCount);
    }

    _checkRegisteredCountBeforeAfter(manager, 0, repeatCount);
  });

  test('Removing elements', () {
    var manager = new RegistrationManager<int>();

    _addElementsToManager(manager, repeatCount);
    _checkRegisteredCountBeforeAfter(manager, 0, repeatCount);

    _removeElementsFromManager(manager, repeatCount);
    _checkRegisteredCountBeforeAfter(manager, repeatCount, 0);
  });

  test('Removing elements multiple times', () {
    var manager = new RegistrationManager<int>();

    _addElementsToManager(manager, repeatCount);
    _checkRegisteredCountBeforeAfter(manager, 0, repeatCount);

    for (var i = 0; i < repeatCount; ++i) {
      _removeElementsFromManager(manager, repeatCount);
    }

    _checkRegisteredCountBeforeAfter(manager, repeatCount, 0);
  });

  test('Adding and removing elements before update', () {
    var manager = new RegistrationManager<int>();

    _addElementsToManager(manager, repeatCount);
    _removeElementsFromManager(manager, repeatCount);

    _checkRegisteredCountBeforeAfter(manager, 0, 0);
  });
}
