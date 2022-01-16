import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkarnet/models/payment/payment_model.dart';
import 'package:lkarnet/providers/operationsprovider/operations_provider.dart';
import 'package:lkarnet/providers/varproviders/add_payment.dart';
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
  void _update() {
    if (widget.payment != null) {
      setState(() {
        _paidAmountController.text = widget.payment!.paidAmount.toString();
        paidAmount = widget.payment!.paidAmount;
        selectedShop = widget.payment!.paidShopName.toString();
      });
    }
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
                  child: ShopSpinner(),
                ),
                Form(
                  key: _formKeyPaidAmount,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (text) {
                        if (text!.isEmpty) {
                          return '';
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'(^\-?\d*\.?\d*)')),
                      ],
                      controller: _paidAmountController,
                      onChanged: (text) =>
                          paidAmount = double.tryParse(text.trim())!,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(6.0),
                          borderSide: new BorderSide(),
                        ),
                        hintText: '00.00',
                        hintStyle: GoogleFonts.robotoSlab(),
                        contentPadding: EdgeInsets.only(top: 4),
                        // prefixIcon: Icon(Icons.qr_code),
                        fillColor: Colors.white.withOpacity(0.5),
                        filled: true,
                        label: Text(
                          'Paid Amount',
                          style: GoogleFonts.robotoSlab(),
                        ),
                        prefixIcon: Icon(
                          Icons.monetization_on_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SelectDate(),
                ),
                SizedBox(
                  height: 30,
                ),
                widget.payment != null
                    ? _buildUpdate(context, ref)
                    : _buildSave(context, ref),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _buildSave(BuildContext context, ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: MThemeData.textButtonStyleCancel,
        ),
        TextButton(
          child: Text(
            'Save',
            style: Theme.of(context).textTheme.headline3,
          ),
          onPressed: () {
            final _op = ref.read(operationsProvider);
            if (_formKeyPaidAmount.currentState!.validate()) {
              _op.addPayment().then((value) {
                if (value) _formKeyPaidAmount.currentState!.reset();
              });
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(Dialogs.snackBar('error'));
            }
            //
          },
          style: MThemeData.textButtonStyleSave,
        ),
      ],
    );
  }

  Row _buildUpdate(BuildContext context, ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: MThemeData.textButtonStyleCancel,
        ),
        TextButton(
          child: Text(
            'Update',
            style: Theme.of(context).textTheme.headline3,
          ),
          onPressed: () {
            final _op = ref.read(operationsProvider);
            if (_formKeyPaidAmount.currentState!.validate()) {
              _op.updatePayment(widget.payment!.id!).then((value) {
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
          style: MThemeData.textButtonStyleSave,
        ),
      ],
    );
  }
}
