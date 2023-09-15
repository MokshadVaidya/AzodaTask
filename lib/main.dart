import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_form/features/contacts/domain/usecases/add_contacts.dart';
import 'package:contact_form/features/contacts/presentation/bloc/contacts_event.dart';
import 'package:contact_form/splash_screen.dart';
import 'package:contact_form/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'features/contacts/data/datasources/contacts_remote_data_source.dart';
import 'features/contacts/data/datasources/firebase_contacts_remote_data_source.dart';
import 'features/contacts/domain/usecases/get_contacts.dart';
import 'features/contacts/presentation/bloc/contacts_bloc.dart';
import 'features/contacts/presentation/pages/all_contacts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final getIt = GetIt.instance;
  runApp(MyApp(
    getIt: getIt,
  ));
}

class MyApp extends StatelessWidget {
  final GetIt getIt;

  const MyApp({super.key, required this.getIt});

  static MaterialColor primarySwatch = MaterialColor(
    kPrimaryColor.value,
    const <int, Color>{
      50:  kPrimaryColor,
      100: kPrimaryColor,
      200: kPrimaryColor,
      300: kPrimaryColor,
      400: kPrimaryColor,
      500: kPrimaryColor,
      600: kPrimaryColor,
      700: kPrimaryColor,
      800: kPrimaryColor,
      900: kPrimaryColor,
    },
  );
  @override
  Widget build(
    BuildContext context,
  ) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: primarySwatch,
      ),
      home: FutureBuilder(
        future: initializeGetIt(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final contactsBloc = getIt<ContactsBloc>();
            return BlocProvider(
              create: (context) => contactsBloc,
              child: const ContactsPage(),
            );
          } else if (snapshot.hasError) {
            Future.delayed(Duration.zero, () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text('Firebase initialization failed: ${snapshot.error}'),
                ),
              );
            });
          }
          return const SplashScreen();
        },
      ),
    );
  }

  Future<void> initializeGetIt() async {
    await Firebase.initializeApp();
    try {
      getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);

      FirebaseContactsRemoteDataSource firebaseContactsRemoteDataSource =
          FirebaseContactsRemoteDataSource(
        firestore: getIt<FirebaseFirestore>(),
      );

      ContactsRepository contactsRepository = ContactsRepository(
        remoteDataSource: firebaseContactsRemoteDataSource,
      );

      GetContacts getContacts = GetContacts(
        repository: contactsRepository,
      );

      AddContacts addContacts = AddContacts(
        repository: contactsRepository,
      );

      final contactsBloc =
          ContactsBloc(getContacts: getContacts, addContacts: addContacts);
      contactsBloc.add(ContactsLoadEvent());
      getIt.registerSingleton<ContactsBloc>(contactsBloc);
    } catch (e) {
      log('Initialization error: $e');
    }
  }
}
