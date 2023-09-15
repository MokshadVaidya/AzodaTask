import 'package:contact_form/features/contacts/domain/usecases/add_contacts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/contact.dart';
import '../../domain/usecases/get_contacts.dart';
import 'contacts_event.dart';
import 'contacts_state.dart';

// A BLoC (Business Logic Component) responsible for managing contacts.
class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final GetContacts getContacts; // Use case for getting contacts.
  final AddContacts addContacts; // Use case for adding contacts.
  List<Contact> contacts = []; // List to store retrieved contacts.

  // Constructor to initialize the BLoC and its dependencies.
  ContactsBloc({required this.getContacts, required this.addContacts})
      : super(ContactsInitial()) {
    // Define event handlers for various events.

    // Handle the ContactsErrorEvent by emitting a ContactsError state with an error message.
    on<ContactsErrorEvent>((event, emit) {
      emit(ContactsError('Failed to load contacts with error: ${event.message}'));
    });

    // Handle the ContactsLoadEvent by starting the loading process.
    // Attempt to retrieve contacts using the getContacts use case.
    // If successful, emit a ContactsLoadedEvent, otherwise, emit a ContactsErrorEvent.
    on<ContactsLoadEvent>((event, emit) async {
      emit(ContactsLoading()); // Indicate that contacts are being loaded.
      try {
        contacts = await getContacts(); // Retrieve contacts using the use case.
        add(ContactsLoadedEvent()); // Emit a ContactsLoadedEvent to signal success.
      } catch (e) {
        add(ContactsErrorEvent(e.toString())); // Emit a ContactsErrorEvent in case of an error.
      }
    });

    // Handle the ContactsLoadedEvent by emitting a ContactsLoaded state with the retrieved contacts.
    on<ContactsLoadedEvent>((event, emit) {
      emit(ContactsLoaded(contacts));
    });

    // Handle the ContactsAddEvent by starting the contact addition process.
    // Attempt to add the contact using the addContacts use case.
    // If successful, emit a ContactsAddedEvent, otherwise, emit a ContactsErrorEvent.
    on<ContactsAddEvent>((event, emit) async {
      emit(ContactsAdd()); // Indicate that a contact is being added.
      try {
        await addContacts(event.contact); // Add the contact using the use case.
        add(ContactsAddedEvent()); // Emit a ContactsAddedEvent to signal success.
      } catch (e) {
        add(ContactsErrorEvent(e.toString())); // Emit a ContactsErrorEvent in case of an error.
      }
    });

    // Handle the ContactsAddedEvent by emitting a ContactsAdded state to indicate successful contact addition.
    on<ContactsAddedEvent>((event, emit) {
      emit(ContactsAdded());
    });
  }
}
