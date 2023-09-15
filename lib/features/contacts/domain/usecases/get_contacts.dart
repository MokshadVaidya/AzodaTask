import 'dart:developer';

import '../../data/datasources/contacts_remote_data_source.dart'; // Import the data source
import '../entities/contact.dart';

// A use case class responsible for retrieving contacts.
class GetContacts {
  final ContactsRepository repository; // Dependency on the ContactsRepository.

  // Constructor to initialize the repository.
  GetContacts({required this.repository});

  // The main method that retrieves a list of contacts.
  Future<List<Contact>> call() async {
    try {
      // Attempt to get the list of contacts using the provided repository.
      final contactModels = await repository.getContacts();
      return contactModels; // Return the list of retrieved contacts.
    } catch (e) {
      // If an error occurs, log it for debugging purposes and rethrow it.
      log('Error getting contacts: $e');
      rethrow;
    }
  }
}
