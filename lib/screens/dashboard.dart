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
    return MonthlyDash();
  }

// build custom listTile

}
