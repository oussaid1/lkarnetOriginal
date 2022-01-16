import 'package:flutter/material.dart';
import 'package:lkarnet/screens/dash/all_widget.dart';
import 'package:lkarnet/screens/dash/day_widget.dart';
import 'package:lkarnet/screens/dash/month_widget.dart';
import 'package:lkarnet/widgets/glasswidget.dart';

class DashBoardTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Container(),
          flexibleSpace: TabBar(
            indicatorColor: Colors.white,
            unselectedLabelColor: Theme.of(context).dividerColor,
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Day'),
              Tab(text: 'Month'),
            ],
          ),
        ),
        body: BluredContainer(
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              AllDash(),
              DailyDash(),
              MonthlyDash(),
            ],
          ),
        ),
      ),
    );
  }
}
