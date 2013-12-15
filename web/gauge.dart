// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library gauge;

import 'dart:html';
import 'dart:async';
import 'dart:js';

class Gauge {
  var jsOptions;
  var jsTable;
  var jsChart;

  // Access to the value of the gauge.
  num _value;
  get value => _value;
  set value(num x) {
    _value = x;
    draw();
  }

  Gauge(Element element, String title, this._value, Map options) {
    final data = [['Label', 'Value'], [title, value]];
    final vis = context["google"]["visualization"];
    jsTable = vis.callMethod('arrayToDataTable', [new JsObject.jsify(data)]);
    jsChart = new JsObject(vis["Gauge"], [element]);
    jsOptions = new JsObject.jsify(options);
    draw();
  }

  void draw() {
    jsTable.callMethod('setValue', [0, 1, value]);
    jsChart.callMethod('draw', [jsTable, jsOptions]);
  }

  static Future load() {
    Completer c = new Completer();
    context["google"].callMethod('load',
       ['visualization', '1', new JsObject.jsify({
         'packages': ['gauge'],
         'callback': new JsFunction.withThis(c.complete)
       })]);
    return c.future;
  }
}