import 'package:dart_style/dart_style.dart';

String formatCode(String code) {
  final formatter = DartFormatter(fixes: [StyleFix.functionTypedefs]);
  try {
    return formatter.format(code);
  } on FormatterException catch (ex) {
    return code;
  }
}
