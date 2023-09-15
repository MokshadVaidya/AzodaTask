import 'dart:developer';

import '../../domain/entities/contact.dart';
import 'contacts_remote_data_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseContactsRemoteDataSource implements ContactsRemoteDataSource {
  final FirebaseFirestore firestore;

  FirebaseContactsRemoteDataSource({required this.firestore});

  @override
  Future<List<Contact>> getContacts() async {
    try {
      final querySnapshot = await firestore.collection('contacts').get();
    return querySnapshot.docs
        .map((doc) => Contact.fromMap(doc.data()))
        .toList();
    } catch (e) {
      log('Error getting contacts: $e');
      rethrow;
    }
  }
  @override
  Future<void> addContact(Contact contact) async {
    try {
      await FirebaseFirestore.instance.collection('contacts').add({
      'name': contact.name,
      'phoneNumber': contact.phoneNumber,
      'address': contact.address,
      'email': contact.email,
    });
    } catch (e) {
      log('Error adding contact: $e');
      rethrow;
    }
    
  }
}
