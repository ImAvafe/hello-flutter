import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'contact.dart';

class ContactGroup {
  factory ContactGroup({
    required int id,
    required String label,
    bool permanent = false,
    String? title,
    List<Contact>? contacts,
  }) {
    final contactsCopy = contacts ?? <Contact>[];
    _sortContacts(contactsCopy);
    return ContactGroup._internal(
      id: id,
      label: label,
      permanent: permanent,
      title: title,
      contacts: contactsCopy,
    );
  }

  ContactGroup._internal({
    required this.id,
    required this.label,
    this.permanent = false,
    String? title,
    List<Contact>? contacts,
  }) : title = title ?? label,
       _contacts = contacts ?? const <Contact>[];

  final int id;
  final bool permanent;
  final String label;
  final String title;
  final List<Contact> _contacts;

  List<Contact> get contacts => _contacts;

  AlphabetizedContactMap get alphabetizedContacts {
    final contactsMap = AlphabetizedContactMap();

    for (final contact in _contacts) {
      final lastInitial = contact.lastName[0].toUpperCase();
      if (contactsMap.containsKey(lastInitial)) {
        contactsMap[lastInitial]!.add(contact);
      } else {
        contactsMap[lastInitial] = [contact];
      }
    }

    return contactsMap;
  }
}

typedef AlphabetizedContactMap = SplayTreeMap<String, List<Contact>>;

void _sortContacts(List<Contact> contacts) {
  contacts.sort((contactA, contactB) {
    final checkLastName = contactA.lastName.compareTo(contactB.lastName);
    if (checkLastName != 0) {
      return checkLastName;
    }

    final checkFirstName = contactA.firstName.compareTo(contactB.lastName);
    if (checkFirstName != 0) {
      return checkFirstName;
    }

    if (contactA.middleName != null && contactB.middleName != null) {
      final checkMiddleName = contactA.middleName!.compareTo(
        contactB.middleName!,
      );
      if (checkMiddleName != 0) {
        return checkMiddleName;
      }
    } else if (contactA.middleName != null || contactB.middleName != null) {
      return contactA.middleName != null ? 1 : -1;
    }

    return contactA.id.compareTo(contactB.id);
  });
}

final allPhone = ContactGroup(
  id: 0,
  permanent: true,
  label: 'All iPhone',
  title: 'iPhone',
  contacts: allContacts.toList(),
);

final friends = ContactGroup(
  id: 1,
  label: 'Friends',
  contacts: [allContacts.elementAt(3)],
);

final work = ContactGroup(id: 2, label: 'Work');

List<ContactGroup> generateSeedData() {
  return [allPhone, friends, work];
}
