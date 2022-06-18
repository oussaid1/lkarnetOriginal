import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkarnet/const/constents.dart';
import 'package:lkarnet/models/payment/payment_model.dart';
import 'package:lkarnet/providers/operationsprovider/operations_provider.dart';
import 'package:lkarnet/providers/varproviders/var_providers.dart';
import 'package:lkarnet/settings/theme.dart';
import 'package:lkarnet/widgets/date_picker.dart';
import 'package:lkarnet/widgets/dialogs.dart';
import 'package:lkarnet/widgets/glasswidget.dart';
import 'package:lkarnet/widgets/shop_spinner.dart';

class AddPayment extends ConsumerStatefulWidget {
  final Payment? payment;

  const AddPayment({Key? key, this.payment}) : super(key: key);
  @override
  _AddPaymentState createState() => _AddPaymentState();
}

class _AddPaymentState extends ConsumerState<AddPayment> {
  final GlobalKey<FormState> _formKeyPaidAmount = GlobalKey<FormState>();
  final TextEditingController _paidAmountController = TextEditingController();

  late DateTime _datePaid;
  final FocusNode _paidAmountFocusNode = FocusNode();
  String? _shop;
  void _update() {
    if (widget.payment != null) {
      setState(() {
        _paidAmountController.text = widget.payment!.paidAmount.toString();
      });
    }
  }

  void clear() {
    _paidAmountController.clear();
  }

  @override
  void initState() {
    _update();
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Material(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: BluredContainer(
          width: 400,
          height: 400,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 8),
                  child: ShopSpinner(
                    initialValue: widget.payment?.paidShopName,
                    focusNode: _paidAmountFocusNode,
                    onShopSelected: (value) {
                      setState(() {
                        _shop = value;
                      });
                      // ref.read(pickedShop.state).state = value;
                    },
                  ),
                ),
                Form(
                  key: _formKeyPaidAmount,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      focusNode: _paidAmountFocusNode,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (text) {
                        if (text!.isEmpty) {
                          return 'please enter amount';
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'(^\-?\d*\.?\d*)')),
                      ],
                      controller: _paidAmountController,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: '00.00',
                        hintStyle: GoogleFonts.robotoSlab(),
                        contentPadding: EdgeInsets.only(top: 4),
                        // prefixIcon: Icon(Icons.qr_code),
                        fillColor: AppConstants.whiteOpacity,
                        filled: true,
                        label: Text(
                          'Paid Amount',
                          style: GoogleFonts.robotoSlab(),
                        ),
                        prefixIcon: Icon(
                          Icons.monetization_on_outlined,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SelectDate(
                    onDateSelected: (value) {
                      _datePaid = value;
                      ref.read(pickedDateTime.state).state = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                widget.payment == null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            child: Text(
                              'Cancel',
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: MThemeData.raisedButtonStyleCancel,
                          ),
                          ElevatedButton(
                            child: Text(
                              'Save',
                            ),
                            onPressed: () {
                              final _op = ref.read(operationsProvider);
                              final _payment = Payment(
                                paidAmount:
                                    double.parse(_paidAmountController.text),
                                datePaid: ref.read(pickedDateTime.state).state,
                                paidShopName:
                                    _shop!, // ref.read(pickedShop.state).state,
                              );
                              if (_formKeyPaidAmount.currentState!.validate()) {
                                _op.addPayment(_payment).then((value) {
                                  if (value)
                                    _formKeyPaidAmount.currentState!.reset();
                                });
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(Dialogs.snackBar('error'));
                              }
                              //
                            },
                            style: MThemeData.raisedButtonStyleSave,
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            child: Text(
                              'Cancel',
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: MThemeData.raisedButtonStyleCancel,
                          ),
                          ElevatedButton(
                            child: Text(
                              'Update',
                            ),
                            onPressed: () {
                              final _op = ref.read(operationsProvider);
                              final _payment = Payment(
                                id: widget.payment!.id,
                                paidAmount:
                                    double.parse(_paidAmountController.text),
                                datePaid:
                                    _datePaid, //ref.read(pickedDateTime.state).state,
                                paidShopName:
                                    _shop!, // ref.read(pickedShop.state).state,
                              );
                              if (_formKeyPaidAmount.currentState!.validate()) {
                                _op.updatePayment(_payment).then((value) {
                                  if (value) Navigator.pop(context);
                                });
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(Dialogs.snackBar('error'));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(Dialogs.snackBar('error'));
                              }
                              //
                            },
                            style: MThemeData.raisedButtonStyleSave,
                          ),
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
