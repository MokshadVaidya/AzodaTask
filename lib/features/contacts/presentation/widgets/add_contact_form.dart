import 'package:contact_form/features/contacts/presentation/widgets/text_field.dart';
import 'package:flutter/material.dart';
import '../../../../utils/constants.dart';
import '../../domain/entities/contact.dart';
import '../bloc/contacts_bloc.dart';
import '../bloc/contacts_event.dart';

class ContactForm extends StatelessWidget {
  ContactForm({
    super.key,
    required this.contactsBloc,
  });

  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ContactsBloc contactsBloc;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: kBoxDecoration,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Hello.",
                        style: kHeadTextStyle.copyWith(color: kPrimaryColor),
                      ),
                      const Text(
                        "Let Us know you better !!",
                        style: kSubHeadTextStyle,
                      )
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: kDefaultPadding),
                  decoration: kBoxDecoration,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      CustomTextField(
                        label: "Name",
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        label: "Number",
                        controller: numberController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a number';
                          } else {
                            final numericValue =
                                value.replaceAll(RegExp(r'[^0-9]'), '');

                            if (numericValue.length != 10) {
                              return 'Please enter a valid 10-digit phone number';
                            }

                            return null;
                          }
                        },
                      ),
                      CustomTextField(
                        label: "Address",
                        controller: addressController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an address';
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        label: "Email",
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          bool isValidEmail(String email) {
                            final RegExp emailRegex = RegExp(
                              r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
                              caseSensitive: false,
                            );

                            return emailRegex.hasMatch(email);
                          }

                          if (value == null || value.isEmpty) {
                            return 'Please enter an email address';
                          }
                          if (!isValidEmail(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                    ]),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final contact = Contact(
                      name: nameController.text,
                      phoneNumber: numberController.text,
                      address: addressController.text,
                      email: emailController.text,
                    );
                    contactsBloc.add(ContactsAddEvent(contact));
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
