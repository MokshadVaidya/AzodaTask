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
    final ContactsBloc contactsBloc = BlocProvider.of<ContactsBloc>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Colors.transparent, 
        elevation: 0, 
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: kPrimaryColor,
          ),
          onPressed: () {
            Navigator.pop(context); // Navigate back when back arrow is pressed
          },
        ),
      ),
      body: BlocConsumer<ContactsBloc, ContactsState>(
        listener: (context, state) {
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
            Future.delayed(const Duration(seconds: 2), () {
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
            return const Center(
              child: Text('Failed to add contact.'),
            );
          } else if (state is ContactsAdd) {
            return const LoadingScreen(
              loadingText: "Adding Contact...",
            );
          } else {
            return ContactForm(contactsBloc: contactsBloc);
          }
        },
      ),
    );
  }
}
