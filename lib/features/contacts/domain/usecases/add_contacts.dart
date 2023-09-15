import 'dart:developer';

import '../../data/datasources/contacts_remote_data_source.dart'; // Import the data source
import '../entities/contact.dart';

// A use case class responsible for adding contacts.
class AddContacts {
  final ContactsRepository repository; // Dependency on the ContactsRepository.

  // Constructor to initialize the repository.
  AddContacts({required this.repository});

  // The main method that adds a contact to the repository.
  Future<void> call(Contact contact) async {
    try {
      // Attempt to add the contact using the provided repository.
      await repository.addContact(contact);
    } catch (e) {
      // If an error occurs, log it for debugging purposes and rethrow it.
      log('Error adding contact: $e');
      rethrow;
    }
  }
}
