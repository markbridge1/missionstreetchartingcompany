import 'dart:html';
import 'dart:async';
import 'dart:js';
import 'package:polymer/polymer.dart';
import 'package:polymer_expressions/filter.dart' show Transformer;

import 'gauge.dart';
import 'ui_filters.dart';

@CustomTag('polymer-mscc-chart')
class MsccChart extends PolymerElement {
  DivElement visualization;
  InputElement slider;

  @published int min;
  @published int max;
  @published int yellowFrom;
  @published int yellowTo;
  @published int redFrom;
  @published int redTo;
  @published int minorTicks;
  @published int value;

  MsccChart.created() : super.created();

  void enteredView() {
    super.enteredView();

    visualization = shadowRoot.querySelector('#gauge');
    slider = shadowRoot.querySelector("#slider");

    Gauge.load().then((_) {
      int sliderValue() => int.parse(slider.value);

      Gauge gauge = new Gauge(visualization, "Slider", sliderValue(), {
        'min': min,
        'max': max,
        'yellowFrom': yellowFrom,
        'yellowTo': yellowTo,
        'redFrom': redFrom,
        'redTo': redTo,
        'minorTicks': minorTicks
      });
      slider.onChange.listen((_) => gauge.value = sliderValue());
    });
  }

  final Transformer asInteger = new IntToString();
}