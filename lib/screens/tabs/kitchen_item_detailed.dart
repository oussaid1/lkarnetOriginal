import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lkarnet/widgets/date_picker.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../components.dart';
import '../../settings/theme.dart';
import '../add/add_kitechen_element.dart';

class KitchenItemDetailsScreen extends StatefulWidget {
  const KitchenItemDetailsScreen({Key? key}) : super(key: key);

  @override
  State<KitchenItemDetailsScreen> createState() =>
      _KitchenItemDetailsScreenState();
}

class _KitchenItemDetailsScreenState extends State<KitchenItemDetailsScreen> {
  int priority = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F5F7),
      appBar: AppBar(
        title: Text('Kitchen Item Details'),
      ),
      body: Center(
        child: SizedBox(
          // width: 200,
          child: UpdateKitchenElement(),
        ),
      ),
    );
  }
}

class PiorityRatingWidget extends StatelessWidget {
  const PiorityRatingWidget({
    Key? key,
    required this.onRatingChanged,
  }) : super(key: key);
  final void Function(int) onRatingChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Priority', style: Theme.of(context).textTheme.bodyText1),
        SizedBox(
          width: 10,
        ),
        RatingBar.builder(
          initialRating: 2,
          itemSize: 20,
          minRating: 1,
          direction: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
          onRatingUpdate: (rating) {
            onRatingChanged(rating.toInt());
          },
        ),
      ],
    );
  }
}

class UpdateKitchenElement extends StatelessWidget {
  const UpdateKitchenElement({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 440,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: BluredContainer(
                width: 400,
                height: 440,
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      child: Availibility(),
                    ),
                    SizedBox(
                      height: 10,
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
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SelectDate(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 120,
                          child: TextButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: MThemeData.textButtonStyleCancel),
                        ),
                        Container(
                          width: 120,
                          child: TextButton(
                              child: Text(
                                'Save',
                                style: Theme.of(context).textTheme.headline3,
                              ),
                              onPressed: () {},
                              style: MThemeData.textButtonStyleSave),
                        ),
                      ],
                    )
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
      width: 35,
      height: 35,
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
              maximumLabels: 1,
              labelOffset: 45,
              labelsPosition: ElementsPosition.inside,
              axisLabelStyle:
                  GaugeTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              minimum: 0,
              maximum: 10,
              showLabels: true,
              showTicks: false,
              startAngle: 270,
              endAngle: 270,
              axisLineStyle: AxisLineStyle(
                thickness: 0.05,
                color: Color.fromARGB(120, 78, 62, 62),
                thicknessUnit: GaugeSizeUnit.factor,
              ),
              pointers: <GaugePointer>[
                RangePointer(
                  color: Color.fromARGB(98, 189, 77, 77),
                  value: x,
                  width: 0.95,
                  // pointerOffset: 0.05,
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

class PriorityWidget extends StatelessWidget {
  const PriorityWidget({Key? key, this.priority = 1}) : super(key: key);
  final int priority;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 10,
      child: getStars(priority),
    );
  }

  Widget getStars(int priority) {
    switch (priority) {
      case 1:
        return Row(
          children: [
            Icon(
              Icons.star_rate_rounded,
              color: Colors.yellow,
              size: 10,
            ),
            Icon(
              Icons.star_rate_rounded,
              color: Colors.yellow,
              size: 10,
            ),
            Icon(
              Icons.star_rate_rounded,
              color: Colors.yellow,
              size: 10,
            ),
          ],
        );
      case 2:
        return Row(
          children: [
            Icon(
              Icons.star_rate_rounded,
              color: Colors.yellow,
              size: 10,
            ),
            Icon(
              Icons.star_rate_rounded,
              color: Colors.yellow,
              size: 10,
            ),
            Icon(
              Icons.star_border_rounded,
              color: Colors.yellow,
              size: 10,
            ),
          ],
        );
      case 3:
        return Row(
          children: [
            Icon(
              Icons.star_border_rounded,
              color: Colors.yellow,
              size: 10,
            ),
            Icon(
              Icons.star_border_rounded,
              color: Colors.yellow,
              size: 10,
            ),
            Icon(
              Icons.star_border_rounded,
              color: Colors.yellow,
              size: 10,
            ),
          ],
        );
      default:
        return Row(
          children: [
            Icon(
              Icons.star_border_rounded,
              color: Colors.yellow,
              size: 10,
            ),
            Icon(
              Icons.star_border_rounded,
              color: Colors.yellow,
              size: 10,
            ),
            Icon(
              Icons.star_border_rounded,
              color: Colors.yellow,
              size: 10,
            ),
          ],
        );
    }
  }
}
