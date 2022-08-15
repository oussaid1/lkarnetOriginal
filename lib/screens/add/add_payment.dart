import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkarnet/blocs/payments/payments_bloc.dart';
import 'package:lkarnet/const/constents.dart';
import 'package:lkarnet/models/payment/payment_model.dart';
import 'package:lkarnet/settings/theme.dart';
import 'package:lkarnet/widgets/date_picker.dart';
import 'package:lkarnet/widgets/dialogs.dart';
import 'package:lkarnet/widgets/glasswidget.dart';
import 'package:lkarnet/widgets/shop_spinner.dart';

import '../../repository/database_operations.dart';

class AddPayment extends ConsumerStatefulWidget {
  final PaymentModel? payment;

  const AddPayment({Key? key, this.payment}) : super(key: key);
  @override
  _AddPaymentState createState() => _AddPaymentState();
}

class _AddPaymentState extends ConsumerState<AddPayment> {
  final GlobalKey<FormState> _formKeyPaidAmount = GlobalKey<FormState>();
  final TextEditingController _paidAmountController = TextEditingController();
  bool canSave = false;
  late DateTime _datePaid;
  String? _id;
  final FocusNode _paidAmountFocusNode = FocusNode();
  String? _shopName;
  void _update() {
    if (widget.payment != null) {
      _id = widget.payment!.id!;
      _paidAmountController.text = widget.payment!.paidAmount.toString();
      _datePaid = widget.payment!.datePaid;
      _shopName = widget.payment!.paidShopName;
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
  Widget build(BuildContext context) {
    final pmntBloc = PaymentsBloc((GetIt.I.get<DatabaseOperations>()));
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
                SizedBox(height: 20),
                _buildShopDropDown(),
                _buildAmountPaid(),
                _buildDatePaid(),
                SizedBox(height: 30),
                _buildSaveButton(context, pmntBloc),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _buildSaveButton(BuildContext context, pmntBloc) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
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
          widget.payment == null ? 'Save' : 'Update',
        ),
        onPressed: !canSave
            ? null
            : () {
                final _payment = PaymentModel(
                  id: _id,
                  paidAmount: double.parse(_paidAmountController.text),
                  datePaid: _datePaid,
                  paidShopName: _shopName!, // ref.read(pickedShop.state).state,
                );
                if (_formKeyPaidAmount.currentState!.validate()) {
                  if (widget.payment == null) {
                    _addPayment(context, _payment, pmntBloc);
                  } else {
                    _updatePayment(context, _payment, pmntBloc);
                  }
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(Dialogs.snackBar('error'));
                }
                //
              },
        style: MThemeData.raisedButtonStyleSave,
      ),
    ]);
  }

  Padding _buildDatePaid() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SelectDate(
        onDateSelected: (value) {
          setState(() {
            _datePaid = value;
          });
        },
      ),
    );
  }

  Form _buildAmountPaid() {
    return Form(
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
            FilteringTextInputFormatter.allow(RegExp(r'(^\-?\d*\.?\d*)')),
          ],
          controller: _paidAmountController,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          textAlign: TextAlign.center,
          maxLength: 10,
          decoration: InputDecoration(
            counterText: '',
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
    );
  }

  Padding _buildShopDropDown() {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 8),
      child: ShopSpinner(
        initialValue: widget.payment?.paidShopName,
        focusNode: _paidAmountFocusNode,
        onShopSelected: (value) {
          setState(() {
            _shopName = value;
          });
          // ref.read(pickedShop.state).state = value;
        },
      ),
    );
  }

  void _addPayment(context, PaymentModel payment, bloc) {
    bloc.add(AddPayment(payment: payment));
    Navigator.of(context).pop();
  }

  void _updatePayment(context, PaymentModel payment, bloc) {
    bloc.add(AddPaymentEvent(payment));
    Navigator.of(context).pop();
  }
}
