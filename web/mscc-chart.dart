import 'package:polymer/polymer.dart';
import 'package:js/js.dart' as js;

import 'dart:html';
import 'dart:async';
import 'dart:js';

/**
 * A Polymer Chart Element.
 */
@CustomTag('polymer-mscc-chart')
class MsccChart extends PolymerElement {

  var jsOptions;
  var jsTable;
  var jsChart;
  var data;
  var vis;
  
  // Access to the value of the gauge.
  num _value;
  get value => _value;
  set value(num x) {
    _value = x;
//    draw();
  }

  MsccChart.created() : super.created() {
    print("in chart dart");
//    jsChart = new JsObject(vis["Gauge"], [element]);
//    jsOptions = new JsObject.jsify(options);
//    draw();

  }
  
  void enteredView() {
    super.enteredView();
    final data = [['Label', 'Value'], [title, value]];
    final vis = context["google"]["visualization"];
    jsTable = vis.callMethod('arrayToDataTable', [new JsObject.jsify(data)]);
    shadowRoot.querySelector("#polymer-mscc-chart")
      .setInnerHtml("<h4>hi!</h4>", validator: new NodeValidatorBuilder.common());
  }

}