import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class IMCGauge extends StatelessWidget {
  final double imcValue;

  const IMCGauge({super.key, required this.imcValue});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 450,
      height: 400,
      child: Column(
        children: [
          SizedBox(
            height: 400,
            child: SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  radiusFactor: 1.05,
                  minimum: 10,
                  maximum: 45,
                  startAngle: 180,
                  endAngle: 0,
                  showTicks: false,
                  showLabels: false,
                  axisLineStyle: const AxisLineStyle(
                    thickness: 0.22,
                    thicknessUnit: GaugeSizeUnit.factor,
                  ),

                  ranges: <GaugeRange>[
                    GaugeRange(
                      startValue: 10,
                      endValue: 18.5,
                      color: Colors.blue,
                      startWidth: 0.22,
                      endWidth: 0.22,
                      sizeUnit: GaugeSizeUnit.factor,
                    ),
                    GaugeRange(
                      startValue: 18.5,
                      endValue: 25,
                      color: Colors.green,
                      startWidth: 0.22,
                      endWidth: 0.22,
                      sizeUnit: GaugeSizeUnit.factor,
                    ),
                    GaugeRange(
                      startValue: 25,
                      endValue: 30,
                      color: Colors.yellow,
                      startWidth: 0.22,
                      endWidth: 0.22,
                      sizeUnit: GaugeSizeUnit.factor,
                    ),
                    GaugeRange(
                      startValue: 30,
                      endValue: 35,
                      color: Colors.orangeAccent,
                      startWidth: 0.22,
                      endWidth: 0.22,
                      sizeUnit: GaugeSizeUnit.factor,
                    ),
                    GaugeRange(
                      startValue: 35,
                      endValue: 40,
                      color: Colors.orange,
                      startWidth: 0.22,
                      endWidth: 0.22,
                      sizeUnit: GaugeSizeUnit.factor,
                    ),
                    GaugeRange(
                      startValue: 40,
                      endValue: 45,
                      color: Colors.red,
                      startWidth: 0.22,
                      endWidth: 0.22,
                      sizeUnit: GaugeSizeUnit.factor,
                    ),
                  ],

                  pointers: <GaugePointer>[
                    NeedlePointer(
                      value: imcValue == 0 ? 10 : imcValue,

                      needleLength: 0.75,
                      needleStartWidth: 1,
                      needleEndWidth: 12,

                      knobStyle: const KnobStyle(
                        knobRadius: 0.06,
                        color: Colors.black,
                      ),
                      needleColor: Colors.black,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
