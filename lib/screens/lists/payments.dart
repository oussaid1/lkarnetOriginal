import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lkarnet/models/payment/payment_model.dart';
import 'package:lkarnet/models/shop/shops_data.dart';
import 'package:lkarnet/providers/operationsprovider/operations_provider.dart';
import 'package:lkarnet/screens/add/add_payment.dart';
import 'package:lkarnet/widgets/dialogs.dart';

import '../../components.dart';

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
          ShopsData shopsData = _shopsDataList[index];
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
            IconButton(
                icon: Icon(
                  Icons.mode_edit,
                  size: 30,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                color: Colors.transparent,
                onPressed: () {
                  Dialogs.botomPopUpDialog(
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
            IconButton(
              icon: Icon(
                Icons.delete_forever,
                size: 30,
                color: Theme.of(context).errorColor,
              ),
              color: Colors.transparent,
              onPressed: () {
                Dialogs
                    .dialogSimple(context, title: 'Are you sure !!?', widgets: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 120,
                          child: TextButton(
                            child: Text('Cancel'),
                            onPressed: () => Navigator.pop(context),
                            style: TextButton.styleFrom(
                              textStyle: Theme.of(context).textTheme.headline3,
                              minimumSize: Size(88, 36),
                              elevation: 0,
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Theme.of(context).primaryColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 120,
                          child: TextButton(
                            child: Text(
                              'Ok',
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            onPressed: () => ref
                                .read(operationsProvider)
                                .deletePayment(payment)
                                .then((value) => Navigator.of(context).pop()),
                            style: TextButton.styleFrom(
                              textStyle: Theme.of(context).textTheme.headline3,
                              minimumSize: Size(88, 36),
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              elevation: 0,
                              onSurface: Theme.of(context).colorScheme.primary,
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Theme.of(context).primaryColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                              ),
                            ),
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
          color: Colors.white.withOpacity(0.4),
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
                      Text(
                        '${payment.datePaid.formatted()}',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              '${payment.paidAmount.toPrecision()}',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                          Text(
                            'DH',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
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
