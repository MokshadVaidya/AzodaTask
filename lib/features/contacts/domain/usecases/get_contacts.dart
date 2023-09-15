import 'dart:developer';

import '../../data/datasources/contacts_remote_data_source.dart';
import '../entities/contact.dart';

class GetContacts {
  final ContactsRepository repository;

  GetContacts({required this.repository});

  Future<List<Contact>> call() async {
    try {
      final contactModels = await repository.getContacts();
      return contactModels;
    } catch (e) {
      log('Error getting contacts: $e');
      rethrow;
    }
  }
}
