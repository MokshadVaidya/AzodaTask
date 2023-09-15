import 'package:contact_form/features/contacts/presentation/widgets/loading.dart';
import 'package:contact_form/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../bloc/contacts_bloc.dart';
import '../bloc/contacts_event.dart';
import '../bloc/contacts_state.dart';
import '../widgets/add_contact_form.dart';

class AddContactPage extends StatelessWidget {
  const AddContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the ContactsBloc instance using BlocProvider.
    final ContactsBloc contactsBloc = BlocProvider.of<ContactsBloc>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: kPrimaryColor,
          ),
          onPressed: () {
            Navigator.pop(context); // Navigate back when the back arrow is pressed.
          },
        ),
      ),
      body: BlocConsumer<ContactsBloc, ContactsState>(
        listener: (context, state) {
          // Listen for state changes and show a Snackbar if there's an error.
          if (state is ContactsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ContactsAdded) {
            // Display a success animation and navigate back after contact is added.
            Future.delayed(const Duration(seconds: 2), () {
              // Reload contacts after adding a new contact.
              contactsBloc.add(ContactsLoadEvent());
              Navigator.pop(context);
            });
            return Center(
              child: Lottie.asset(
                'assets/success.json',
                width: 150,
                height: 150,
              ),
            );
          } else if (state is ContactsError) {
            // Display an error message if adding contact fails.
            return const Center(
              child: Text('Failed to add contact.'),
            );
          } else if (state is ContactsAdd) {
            // Display a loading screen while the contact is being added.
            return const LoadingScreen(
              loadingText: "Adding Contact...",
            );
          } else {
            // Display the AddContactForm widget to input contact details.
            return ContactForm(contactsBloc: contactsBloc);
          }
        },
      ),
    );
  }
}
