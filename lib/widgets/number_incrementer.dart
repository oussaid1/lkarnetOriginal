// stateless numberIncrementer
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../const/constents.dart';

@immutable
class NumberIncrementer extends StatefulWidget {
  final Function(double) onDecrement;
  final Function(double) onIncrement;
  //final int value;
  NumberIncrementer({
    Key? key,
    required this.onDecrement,
    required this.onIncrement,
    // this.value = 0,
  }) : super(key: key);

  @override
  State<NumberIncrementer> createState() => _NumberIncrementerState();
}

class _NumberIncrementerState extends State<NumberIncrementer> {
  double _quantity = 1;
  @override
  void dispose() {
    _quantity = 1;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Card(
          color: AppConstants.whiteOpacity,
          child: Container(
            height: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    icon: Icon(
                      CupertinoIcons.minus_circle,
                    ),
                    onPressed: () {
                      setState(() {
                        if (_quantity > 0.5) {
                          _quantity -= 0.5;
                          widget.onDecrement(_quantity);
                        }
                      });
                    }),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(_quantity.toString()),
                  ),
                ),
                IconButton(
                    icon: Icon(
                      CupertinoIcons.plus_circle,
                    ),
                    onPressed: () {
                      setState(() {
                        _quantity += 0.5;
                        widget.onIncrement(_quantity);
                      });
                    }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
