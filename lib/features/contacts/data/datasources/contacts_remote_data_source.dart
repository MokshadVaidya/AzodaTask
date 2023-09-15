import 'dart:developer';

import '../../domain/entities/contact.dart';

abstract class ContactsRemoteDataSource {
  Future<List<Contact>> getContacts();
  Future<void> addContact(Contact contact);
}

class ContactsRepository {
  final ContactsRemoteDataSource remoteDataSource;

  ContactsRepository({required this.remoteDataSource});

  Future<List<Contact>> getContacts() async {
    try {
      return remoteDataSource.getContacts();
    } catch (e) {
      log('Error getting contacts: $e');
      rethrow;
    }
    
  }

  Future<void> addContact(Contact contact) async {
    try {
      return remoteDataSource.addContact(contact);
    } catch (e) {
      log('Error adding contact: $e');
      rethrow;
    }
  }
}
