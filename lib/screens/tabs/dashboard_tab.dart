import 'package:flutter/material.dart';
import 'package:lkarnet/screens/dash/all_widget.dart';
import 'package:lkarnet/screens/dash/day_widget.dart';
import 'package:lkarnet/screens/dash/month_widget.dart';

class DashBoardTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: Container(),
          flexibleSpace: TabBar(
            unselectedLabelColor: Theme.of(context).dividerColor,
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Day'),
              Tab(text: 'Month'),
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            AllDash(),
            DailyDash(),
            MonthlyDash(),
          ],
        ),
      ),
    );
  }
}
