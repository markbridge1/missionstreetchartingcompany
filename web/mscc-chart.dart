import 'package:polymer/polymer.dart';

/**
 * A Polymer Chart Element.
 */
@CustomTag('polymer-mscc-chart')
class MsccChart extends PolymerElement {
  @published int count = 0;

  MsccChart.created() : super.created() {
  }

  void increment() {
    count++;
  }
}