import 'dart:developer';

import '../../domain/entities/contact.dart';

// Abstract class representing the remote data source for contacts.
abstract class ContactsRemoteDataSource {
  // Fetch a list of contacts from a remote data source.
  Future<List<Contact>> getContacts();

  // Add a contact to the remote data source.
  Future<void> addContact(Contact contact);
}

// Repository class responsible for managing contacts data.
class ContactsRepository {
  // Remote data source for contacts.
  final ContactsRemoteDataSource remoteDataSource;

  // Constructor to initialize the repository with a remote data source.
  ContactsRepository({required this.remoteDataSource});

  // Retrieve a list of contacts from the remote data source.
  Future<List<Contact>> getContacts() async {
    try {
      // Attempt to fetch contacts from the remote data source.
      return remoteDataSource.getContacts();
    } catch (e) {
      // If an error occurs, log it for debugging purposes and rethrow it.
      log('Error getting contacts: $e');
      rethrow;
    }
  }

  // Add a contact to the remote data source.
  Future<void> addContact(Contact contact) async {
    try {
      // Attempt to add the contact to the remote data source.
      return remoteDataSource.addContact(contact);
    } catch (e) {
      // If an error occurs, log it for debugging purposes and rethrow it.
      log('Error adding contact: $e');
      rethrow;
    }
  }
}
