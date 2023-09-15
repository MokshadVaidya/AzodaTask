import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import 'package:contact_form/features/contacts/domain/usecases/add_contacts.dart';
import 'package:contact_form/features/contacts/presentation/bloc/contacts_event.dart';
import 'package:contact_form/splash_screen.dart';
import 'package:contact_form/utils/constants.dart';

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

  const MyApp({
    Key? key,
    required this.getIt,
  }) : super(key: key);

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
  Widget build(BuildContext context) {
    // Initialize ScreenUtil for responsive UI.
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (ctx, _) => MaterialApp(
      theme: ThemeData(
        primarySwatch: primarySwatch,
      ),
      home: FutureBuilder(
        future: initializeGetIt(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Retrieve the ContactsBloc instance using BlocProvider.
            final contactsBloc = getIt<ContactsBloc>();
            return BlocProvider(
              create: (context) => contactsBloc,
              child: const ContactsPage(),
            );
          } else if (snapshot.hasError) {
            // If Firebase initialization fails, show an error message.
            Future.delayed(Duration.zero, () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text('Firebase initialization failed: ${snapshot.error}'),
                ),
              );
            });
          }
          // While Firebase is initializing, show the SplashScreen.
          return const SplashScreen();
        },
      ),
    ));
  }

  Future<void> initializeGetIt() async {
    await Firebase.initializeApp();
    try {
      // Register the Firestore instance with GetIt for dependency injection.
      getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);

      // Create a FirebaseContactsRemoteDataSource instance.
      FirebaseContactsRemoteDataSource firebaseContactsRemoteDataSource =
          FirebaseContactsRemoteDataSource(
        firestore: getIt<FirebaseFirestore>(),
      );

      // Create a ContactsRepository instance.
      ContactsRepository contactsRepository = ContactsRepository(
        remoteDataSource: firebaseContactsRemoteDataSource,
      );

      // Create GetContacts and AddContacts use cases.
      GetContacts getContacts = GetContacts(
        repository: contactsRepository,
      );
      AddContacts addContacts = AddContacts(
        repository: contactsRepository,
      );

      // Create and register the ContactsBloc with GetIt.
      final contactsBloc =
          ContactsBloc(getContacts: getContacts, addContacts: addContacts);
      contactsBloc.add(ContactsLoadEvent());
      getIt.registerSingleton<ContactsBloc>(contactsBloc);
    } catch (e) {
      // Handle initialization errors and log them.
      log('Initialization error: $e');
    }
  }
}
