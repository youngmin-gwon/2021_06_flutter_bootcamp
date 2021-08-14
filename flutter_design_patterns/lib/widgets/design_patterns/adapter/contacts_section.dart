import 'package:flutter/material.dart';
import 'package:flutter_design_patterns/constants/layout_constants.dart';

import 'package:flutter_design_patterns/design_patterns/adapter/adapter.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/adapter/contact_card.dart';
import 'package:flutter_design_patterns/widgets/platform_specific/platform_button.dart';

class ContactsSection extends StatefulWidget {
  const ContactsSection({
    Key? key,
    required this.adapter,
    required this.headText,
  }) : super(key: key);

  final IContactsAdapter adapter;
  final String headText;

  @override
  _ContactsSectionState createState() => _ContactsSectionState();
}

class _ContactsSectionState extends State<ContactsSection> {
  List<Contact> contacts = [];

  void _getContacts() {
    setState(() {
      contacts.addAll(widget.adapter.getContacts());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(widget.headText),
          const SizedBox(height: LayoutConstants.spaceM),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: _ContactsSectionContent(
              contacts: contacts,
              onPressed: _getContacts,
            ),
          )
        ]);
  }
}

class _ContactsSectionContent extends StatelessWidget {
  const _ContactsSectionContent({
    Key? key,
    required this.contacts,
    required this.onPressed,
  }) : super(key: key);

  final List<Contact> contacts;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return contacts.isEmpty
        ? PlatformButton(
            text: "Get contacts",
            materialColor: Colors.black,
            materialTextColor: Colors.white,
            onPressed: onPressed,
          )
        : Column(
            children: [
              for (var contact in contacts)
                ContactCard(
                  contact: contact,
                ),
            ],
          );
  }
}
