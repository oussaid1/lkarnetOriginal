import 'package:flutter/material.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    Key? key,
    required this.onTap,
    this.count = 0,
  }) : super(key: key);
  final VoidCallback onTap;
  final int count;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: Stack(
        fit: StackFit.expand,
        children: [
          count != 0
              ? Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 235, 93, 83),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        '$count',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
          IconButton(
            icon: Icon(Icons.notifications_active,
                color: Color.fromARGB(193, 233, 233, 233)),
            onPressed: onTap,
          ),
        ],
      ),
    );
  }
}
