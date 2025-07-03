// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(name) => "Hello ${name}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "continueBtn": MessageLookupByLibrary.simpleMessage("continue"),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "fillAllFields": MessageLookupByLibrary.simpleMessage("Fill all fields"),
    "forgot": MessageLookupByLibrary.simpleMessage("forgot"),
    "greeting": m0,
    "hasAccount": MessageLookupByLibrary.simpleMessage(
      "Already have an account?",
    ),
    "helloWorld": MessageLookupByLibrary.simpleMessage("Hello World"),
    "hide": MessageLookupByLibrary.simpleMessage("hide"),
    "login": MessageLookupByLibrary.simpleMessage("Log In"),
    "loginTitle": MessageLookupByLibrary.simpleMessage(
      "Enter your login details to access your account",
    ),
    "logout": MessageLookupByLibrary.simpleMessage("Logout"),
    "newAccount": MessageLookupByLibrary.simpleMessage("New Account"),
    "newAccountTitle": MessageLookupByLibrary.simpleMessage(
      "Start by entering your email address below.",
    ),
    "newPassword": MessageLookupByLibrary.simpleMessage("Create Password"),
    "newPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Your password must have at least one symbol & 8 or more characters.",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "show": MessageLookupByLibrary.simpleMessage("show"),
  };
}
