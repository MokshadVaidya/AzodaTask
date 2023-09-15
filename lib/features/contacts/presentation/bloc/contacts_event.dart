// lib/presentation/blocs/contacts_event.dart
import 'package:equatable/equatable.dart';

import '../../domain/entities/contact.dart';

abstract class ContactsEvent extends Equatable {
  const ContactsEvent();

  @override
  List<Object> get props => [];
}

class ContactsLoadEvent extends ContactsEvent {}

class ContactsLoadedEvent extends ContactsEvent {}

class ContactsErrorEvent extends ContactsEvent {
  final String message;

  const ContactsErrorEvent(this.message);

  @override
  List<Object> get props => [message];
}

class ContactsAddEvent extends ContactsEvent {
  final Contact contact;

  const ContactsAddEvent(this.contact);

  @override
  List<Object> get props => [contact];
}

class ContactsAddedEvent extends ContactsEvent {}
