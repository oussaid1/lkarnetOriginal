import 'package:lkarnet/models/payment/payment_model.dart';
import 'package:lkarnet/models/shop/shops_data.dart';
import 'package:lkarnet/providers/operationsprovider/operations_provider.dart';
import 'package:lkarnet/screens/add/add_payment.dart';
import 'package:lkarnet/widgets/dialogs.dart';
import 'package:flutter/material.dart';

import '../../components.dart';
import '../../providers/varproviders/var_providers.dart';
import '../../settings/theme.dart';
import '../../widgets/price_curency_widget.dart';

class PaymentsList extends ConsumerWidget {
  final List<Payment>? lista;
  PaymentsList({
    Key? key,
    this.lista,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    var _shopsDataList = ref.watch(shopsDataListProvider.state).state;

    return Container(
      margin: EdgeInsets.only(top: 10, left: 4, right: 4, bottom: 8),
      child: ListView.builder(
        itemCount: _shopsDataList.length,
        itemBuilder: (BuildContext context, int index) {
          ShopData shopsData = _shopsDataList[index];
          return new ExpansionTile(
            title: Text('${shopsData.shop.shopName}'),
            trailing: Text('${shopsData.paymentsSum}'),
            leading: CircleAvatar(
              child: const Icon(
                Icons.account_circle,
                size: 40,
                color: Colors.grey,
              ),
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 300,
                width: 400,
                child: PayList(
                  lista: shopsData.allPayments,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class PayList extends ConsumerWidget {
  final List<Payment>? lista;
  PayList({
    Key? key,
    this.lista,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 4, right: 4, bottom: 8),
      child: ListView.builder(
        itemCount: lista!.length,
        itemBuilder: (BuildContext context, int index) {
          Payment payment = lista![index];
          return PaymentTile(payment: payment);
        },
      ),
    );
  }
}

class PaymentTile extends ConsumerWidget {
  const PaymentTile({
    Key? key,
    required this.payment,
  }) : super(key: key);

  final Payment payment;

  @override
  Widget build(BuildContext context, ref) {
    return Slidable(
        startActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
                backgroundColor: Colors.transparent,
                icon: Icons.mode_edit,
                label: 'Edit',
                onPressed: (context) {
                  ref.read(pickedDateTime.state).state = payment.datePaid;
                  ref.read(pickedShop.state).state = payment.paidShopName;
                  Dialogs.botomUpDialog(
                      context,
                      AddPayment(
                        payment: payment,
                      ));
                }),
          ],
        ),
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              icon: Icons.delete_forever,
              label: 'Delete',
              backgroundColor: Colors.transparent,
              onPressed: (context2) {
                Dialogs.dialogSimple(context,
                    title: 'Are you sure !!?',
                    widgets: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 120,
                              child: ElevatedButton(
                                child: Text('Cancel'),
                                onPressed: () => Navigator.pop(context),
                                style: MThemeData.raisedButtonStyleCancel,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: 120,
                              child: ElevatedButton(
                                child: Text(
                                  'Ok',
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                                onPressed: () => ref
                                    .read(operationsProvider)
                                    .deletePayment(payment)
                                    .then(
                                        (value) => Navigator.of(context).pop()),
                                style: MThemeData.raisedButtonStyleSave,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]);
              },
            ),
          ],
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radius),
          ),
          color: AppConstants.whiteOpacity,
          child: SizedBox(
            height: 50,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color:
                            Color.fromARGB(255, 255, 137, 59).withOpacity(0.2),
                        // : Color(0xA4E6218D),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(AppConstants.radius),
                          bottomLeft: Radius.circular(AppConstants.radius),
                        ),
                      ),
                      child: Icon(
                        Icons.attach_money_outlined,
                        color: Colors.white.withOpacity(0.5),
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            '${payment.paidShopName}',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          Text(
                            '${payment.datePaid.formatted()}',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.all(4.0),
                              child: PriceNumberZone(
                                price: payment.paidAmount,
                                style: Theme.of(context).textTheme.headline4,
                                withDollarSign: true,
                              )),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
