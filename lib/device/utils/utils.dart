// Package imports:
import 'package:intl/intl.dart';

String formatDate(String input) {
  final date = DateTime.tryParse(input);
  return date == null ? '' : DateFormat("dd/MM/yyyy hh:mm").format(date);
}
