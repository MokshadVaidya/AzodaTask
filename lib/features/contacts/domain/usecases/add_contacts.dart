import 'dart:developer';
import '../../data/datasources/contacts_remote_data_source.dart';
import '../entities/contact.dart';

class AddContacts {
  final ContactsRepository repository;

  AddContacts({required this.repository});

  Future<void> call(Contact contact) async {
    try {
      await repository.addContact(contact);
    } catch (e) {
      log('Error adding contact: $e');
      rethrow;
    }
  }
}
