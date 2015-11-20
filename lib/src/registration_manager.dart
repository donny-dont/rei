// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [RegistrationManager] interface.
library rei.src.registration_manager;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:collection';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Provides functionality for components to register themselves with a manager.
///
/// Ensures that an element is only registered once. Also handles the case where
/// the contents of the manager are being changed while the registered elements
/// are being iterated over.
class RegistrationManager<T> {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The elements actively being serviced.
  ///
  /// If an element has just been added or removed from the manager this will
  /// not be reflected until the [updateRegistration] method has been called.
  ///
  /// This value should only be accessed by subclasses.
  final List<T> registered = new List<T>();
  /// The elements to add at the next opportunity.
  ///
  /// The manager defers enrollment until [updateRegistration] is called.
  final List<T> _toAdd = new List<T>();
  /// The elements to remove at the next opportunity.
  ///
  /// The manager defers withdrawals until [updateRegistration] is called.
  final List<T> _toRemove = new List<T>();

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [RegistrationManager] class.
  RegistrationManager();

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Registers the [element] to the manager.
  void add(T element) {
    if (_toRemove.contains(element)) {
      // Element should be registered if queued for removal
      assert(_registered.contains(element));

      _toRemove.remove(element);
    } else if ((!_registered.contains(element)) && (!_toAdd.contains(element))) {
      _toAdd.add(element);
    }
  }

  /// Withdrawals the [element] from the manager.
  void remove(T element) {
    if (_toAdd.contains(element)) {
      // Element should not be registered if queued for addition
      assert(!_registered.contains(element));

      _toAdd.remove(element);
    } else if ((_registered.contains(element)) && (!_toRemove.contains(element))) {
      _toRemove.add(element);
    }
  }

  //---------------------------------------------------------------------
  // Protected methods
  //---------------------------------------------------------------------

  /// Updates the elements registered within the manager.
  ///
  /// Any elements that were added through the [add] method will be registered
  /// and any elements that were removed through the [remove] method will
  /// be removed at this point in execution.
  ///
  /// This should only be called by the descending class.
  void updateRegistration() {
    if (_toAdd.isNotEmpty) {
      registered.addAll(_toAdd);
      _toAdd.clear();
    }

    if (_toRemove.isNotEmpty) {
      registered.removeWhere((element) => _toRemove.contains(element));
      _toRemove.clear();
    }
  }
}
