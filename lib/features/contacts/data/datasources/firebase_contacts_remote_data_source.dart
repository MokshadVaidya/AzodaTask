import 'dart:developer';

import '../../domain/entities/contact.dart';
import 'contacts_remote_data_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Implementation of the remote data source for contacts using Firebase Firestore.
class FirebaseContactsRemoteDataSource implements ContactsRemoteDataSource {
  final FirebaseFirestore firestore;

  FirebaseContactsRemoteDataSource({required this.firestore});

  @override
  Future<List<Contact>> getContacts() async {
    try {
      // Attempt to fetch contacts from the Firestore 'contacts' collection.
      final querySnapshot = await firestore.collection('contacts').get();

      // Map the Firestore documents to Contact entities and return them as a list.
      return querySnapshot.docs
          .map((doc) => Contact.fromMap(doc.data()))
          .toList();
    } catch (e) {
      // If an error occurs, log it for debugging purposes and rethrow it.
      log('Error getting contacts: $e');
      rethrow;
    }
  }

  @override
  Future<void> addContact(Contact contact) async {
    try {
      // Attempt to add a contact to the Firestore 'contacts' collection.
      await FirebaseFirestore.instance.collection('contacts').add({
        'name': contact.name,
        'phoneNumber': contact.phoneNumber,
        'address': contact.address,
        'email': contact.email,
      });
    } catch (e) {
      // If an error occurs, log it for debugging purposes and rethrow it.
      log('Error adding contact: $e');
      rethrow;
    }
  }
}
