import 'package:flutter/material.dart';
import 'package:flutter_design_patterns/constants/layout_constants.dart';
import 'package:flutter_design_patterns/design_patterns/adapter/adapter.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/adapter/contacts_section.dart';

class AdapterExample extends StatelessWidget {
  const AdapterExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: SingleChildScrollView(
        padding:
            const EdgeInsets.symmetric(horizontal: LayoutConstants.paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ContactsSection(
                adapter: JsonContactsAdapter(),
                headText: "Contacts from JSON API"),
            const SizedBox(height: LayoutConstants.spaceL),
            ContactsSection(
                adapter: XmlContactsAdapter(),
                headText: "Contacts from XML API"),
          ],
        ),
      ),
    );
  }
}
