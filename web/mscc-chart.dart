import 'dart:html' show DivElement, InputElement, window;
import 'package:polymer/polymer.dart' show CustomTag, PolymerElement, published;
import 'package:polymer_expressions/filter.dart' show Transformer;

import 'gauge.dart' show Gauge;
import 'ui_filters.dart' show IntToString;

@CustomTag('polymer-mscc-chart')
class MsccChart extends PolymerElement {
  @published int min;
  @published int max;
  @published int yellowFrom;
  @published int yellowTo;
  @published int redFrom;
  @published int redTo;
  @published int minorTicks;
  @published int value;

  DivElement visualization;
  DivElement sliderContainer;
  InputElement slider;

  Gauge gauge;

  MsccChart.created() : super.created();

  void enteredView() {
    super.enteredView();

    visualization = shadowRoot.querySelector('#gauge');
    sliderContainer = shadowRoot.querySelector("#slider-container");
    slider = shadowRoot.querySelector("#slider");

    window.onResize.listen((_) => resize());
    resize();

    Gauge.load().then((_) {
      int sliderValue() => int.parse(slider.value);
      int sliderChange(_) => gauge.value = sliderValue();

      gauge = new Gauge(visualization, "Slider", sliderValue(), {
        'min': min,
        'max': max,
        'yellowFrom': yellowFrom,
        'yellowTo': yellowTo,
        'redFrom': redFrom,
        'redTo': redTo,
        'minorTicks': minorTicks
      });
      slider.onChange.listen(sliderChange);
    });
  }

  void resize() {
    int gaugeHeight = this.clientHeight - sliderContainer.marginEdge.height;
    if (gaugeHeight > 0) {
      visualization.style.height = '${gaugeHeight}px';
    }
    if (gauge != null) gauge.draw();
  }

  final Transformer asInteger = new IntToString();
}