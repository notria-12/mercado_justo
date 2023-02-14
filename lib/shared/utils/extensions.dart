import 'package:intl/intl.dart';

extension DateStringExtension on DateTime? {
  String get toDate => getFormart(this, "dd/MM/yyyy");

  String getFormart(DateTime? value, String format) {
    if (value == null) return '';

    DateFormat formatter = DateFormat(format);

    String newValue = formatter.format(value);
    return newValue;
  }
}
