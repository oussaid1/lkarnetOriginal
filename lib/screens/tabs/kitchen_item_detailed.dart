import 'package:flutter/material.dart';
import 'package:lkarnet/widgets/date_picker.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../components.dart';

class KitchenItemDetailsScreen extends StatelessWidget {
  const KitchenItemDetailsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F5F7),
      appBar: AppBar(
        title: Text('Kitchen Item Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: BluredContainer(
                width: 400,
                height: 440,
                child: Column(
                  children: [
                    Container(
                      height: 300,
                      width: 300,
                      child: Availibility(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 40,
                      width: 300,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Expired Date',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SelectDate(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final availibilityProvider = StateProvider<double>((ref) {
  return 0;
});

class Availibility extends ConsumerWidget {
  const Availibility({
    Key? key,
  }) : super(key: key);
  //final double   availability();
  @override
  Widget build(BuildContext context, ref) {
    double x = ref.watch(availibilityProvider.state).state;
    return SizedBox(
      width: 30,
      height: 30,
      child: GestureDetector(
        onTap: () {
          if (x < 10) {
            ref.read(availibilityProvider.state).state++;
          } else {
            ref.read(availibilityProvider.state).state = 0;
          }
        },
        child: SfRadialGauge(
          // backgroundColor: Colors.white,
          axes: <RadialAxis>[
            RadialAxis(
              labelFormat: '$x',
              labelOffset: 15,
              labelsPosition: ElementsPosition.inside,
              axisLabelStyle:
                  GaugeTextStyle(fontSize: 8, fontWeight: FontWeight.bold),
              minimum: 0,
              maximum: 10,
              showLabels: true,
              showTicks: false,
              startAngle: 270,
              endAngle: 270,
              axisLineStyle: AxisLineStyle(
                thickness: 0.05,
                color: Color.fromARGB(37, 124, 79, 79),
                thicknessUnit: GaugeSizeUnit.factor,
              ),
              pointers: <GaugePointer>[
                RangePointer(
                  color: Color.fromARGB(98, 189, 77, 77),
                  value: x,
                  width: 0.95,
                  pointerOffset: 0.05,
                  sizeUnit: GaugeSizeUnit.factor,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
