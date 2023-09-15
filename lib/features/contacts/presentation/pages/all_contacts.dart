import 'package:contact_form/features/contacts/presentation/pages/add_contact.dart';
import 'package:contact_form/features/contacts/presentation/widgets/loading.dart';
import 'package:contact_form/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/contacts_bloc.dart';
import '../bloc/contacts_state.dart';
import '../widgets/list_tile.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the ContactsBloc instance using BlocProvider.
    final ContactsBloc contactsBloc = BlocProvider.of<ContactsBloc>(context);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the AddContactPage using MaterialPageRoute and provide ContactBloc using BlocProvider.
          Navigator.push(context, MaterialPageRoute(
            builder: (ctx) {
              return BlocProvider.value(
                value: contactsBloc,
                child: const AddContactPage(),
              );
            },
          ));
        },
        child: const Icon(Icons.add),
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
          if (state is ContactsLoading) {
            // Display a loading screen while contacts are being loaded.
            return const LoadingScreen(
              loadingText: "Loading Contacts...",
            );
          } else if (state is ContactsLoaded) {
            final contacts = state.contacts;
            return CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.height * 0.3,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      'Contacts',
                      style: kHeadTextStyle,
                    ),
                    centerTitle: true,
                    background: Container(
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      final contact = contacts[index];
                      return CustomListTile(
                        name: contact.name,
                        email: contact.email,
                        number: contact.phoneNumber,
                        address: contact.address,
                      );
                    },
                    childCount: contacts.length,
                  ),
                ),
              ],
            );
          } else if (state is ContactsError) {
            // Display an error message if loading fails.
            return Text('Error: ${state.message}');
          } else {
            // Display a message when there's no data.
            return const Text('No data');
          }
        },
      ),
    );
  }
}
