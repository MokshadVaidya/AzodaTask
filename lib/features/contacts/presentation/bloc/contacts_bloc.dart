import 'package:contact_form/features/contacts/domain/usecases/add_contacts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/contact.dart';
import '../../domain/usecases/get_contacts.dart';
import 'contacts_event.dart';
import 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final GetContacts getContacts;
  final AddContacts addContacts;
  List<Contact> contacts = [];

  ContactsBloc({required this.getContacts, required this.addContacts})
      : super(ContactsInitial()) {
    on<ContactsErrorEvent>((event, emit) {
      emit(ContactsError(
          'Failed to load contacts with error: ${event.message}'));
    });

    on<ContactsLoadEvent>((event, emit) async {
      emit(ContactsLoading());
      try {
        contacts = await getContacts();
        add(ContactsLoadedEvent());
      } catch (e) {
        add(ContactsErrorEvent(e.toString()));
      }
    });
    on<ContactsLoadedEvent>((event, emit) {
      emit(ContactsLoaded(contacts));
    });

    on<ContactsAddEvent>((event, emit) async {
      emit(ContactsAdd());
      try {
        await addContacts(event.contact);
        add(ContactsAddedEvent());
      } catch (e) {
        add(ContactsErrorEvent(e.toString()));
      }
    });
    on<ContactsAddedEvent>((event, emit) {
      emit(ContactsAdded());
    });
  }
}
