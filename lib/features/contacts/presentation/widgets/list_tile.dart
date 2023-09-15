import 'package:flutter/material.dart';
import '../../../../utils/constants.dart';
import 'detail_text.dart';

class CustomListTile extends StatelessWidget {
  final String name;
  final String email;
  final String number;
  final String address;

  const CustomListTile({
    super.key,
    required this.name,
    this.email = '',
    this.number = '',
    this.address = '',
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      decoration: kBoxDecoration,
      child: Padding(
        padding: EdgeInsets.all(kDefaultPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: kPrimaryColor,
              child: Text(
                name.substring(0, 1).toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: kDefaultPadding),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomDetailText(
                    name: name,
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),

                  // Display email, number and address only if they are not empty.
                  email != ''
                      ? CustomDetailText(name: email)
                      : const SizedBox(),
                  number != ''
                      ? CustomDetailText(name: number)
                      : const SizedBox(),
                  address != ''
                      ? CustomDetailText(name: address)
                      : const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
