library ui_filters;

import 'package:polymer_expressions/filter.dart';

class IntToString extends Transformer<int, String> {
  int forward(String s) => s == null ? null : int.parse(s, onError: (s) => null);
  String reverse(int i) => '$i';
}