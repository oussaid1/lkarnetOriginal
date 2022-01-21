import 'package:lkarnet/models/shop/shops_data.dart';

import '../components.dart';
import 'dash/month_widget.dart';

class ShopDetailsMain extends StatefulWidget {
  const ShopDetailsMain({Key? key, this.shopsData}) : super(key: key);
  final ShopsData? shopsData;
  @override
  _ShopDetailsState createState() => _ShopDetailsState();
}

class _ShopDetailsState extends State<ShopDetailsMain> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GlassMaterial(
      circleWidgets: [
        Positioned(
          width: 140,
          height: 140,
          left: 10,
          top: 120,
          child: AppAssets.blueCircleWidget,
        ),
        Positioned(
          width: 180,
          height: 180,
          right: 80,
          top: 200,
          child: AppAssets.purpleCircleWidget,
        ),
        Positioned(
          width: 180,
          height: 180,
          left: 40,
          bottom: 80,
          child: AppAssets.pinkCircleWidget,
        ),
      ],
      gradientColors: [
        Color.fromARGB(255, 237, 155, 48),
        Color.fromARGB(255, 220, 157, 75),
        Color.fromARGB(255, 227, 237, 48),
        // Color.fromARGB(255, 48, 199, 237),
        // Color.fromARGB(255, 48, 199, 237),
      ],
      centerWidget: MonthlyDash(),
    );
  }

// build custom listTile

}
