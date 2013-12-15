import 'dart:html' show DivElement, InputElement, window;
import 'package:polymer/polymer.dart' show CustomTag, PolymerElement, published;
import 'package:polymer_expressions/filter.dart' show Transformer;

import 'gauge.dart' show Gauge;
import 'ui_filters.dart' show IntToString;

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

    window.onResize.listen(resize);
    resize(null);

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

  void resize(e) {
    visualization.style.height = '${slider.clientWidth}px';
  }

  final Transformer asInteger = new IntToString();
}