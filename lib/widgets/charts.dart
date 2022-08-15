import 'package:flutter/material.dart';
import 'package:lkarnet/models/statistics/statistics_model.dart';
import 'package:lkarnet/models/statistics/tagged.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../components.dart';
import '../models/kitchen/kitchen_element.dart';

class SemiPeiWidget extends ConsumerWidget {
  final List<ItemsChartData> chartData;
  final Widget widget;
  SemiPeiWidget(this.chartData, this.widget);

  @override
  Widget build(BuildContext context, wacth) {
    return SfCircularChart(
      annotations: <CircularChartAnnotation>[
        CircularChartAnnotation(
          widget: Container(child: widget),
        )
      ],
      margin: EdgeInsets.zero,
      series: <CircularSeries>[
        DoughnutSeries<ItemsChartData, String>(
          innerRadius: '80',
          dataSource: chartData,
          xValueMapper: (ItemsChartData data, _) => data.tag,
          yValueMapper: (ItemsChartData data, _) => data.value,
          dataLabelMapper: (ItemsChartData data, _) => data.tag,

          // All the segments will be exploded

          dataLabelSettings: DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.outside,
              // Renders background rectangle and fills it with series color
              useSeriesColor: true),
          //angle of pie
        ),
      ],
    );
  }
}

class PeiWidget extends StatelessWidget {
  final List<ItemsChartData> chartData;
  final String? title;
  const PeiWidget({Key? key, required this.chartData, this.title});

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      margin: EdgeInsets.zero,
      legend: Legend(
        isVisible: true,
        position: LegendPosition.left,
        // alignment: ChartAlignment.center,
        // width: '120',
      ),
      title: ChartTitle(
        text: title ?? '',
        // textStyle: TextStyle(
        //   fontSize: 20,
        //   fontWeight: FontWeight.bold,
        // ),
      ),
      // title: ChartTitle(
      //     textStyle: Theme.of(context).textTheme.subtitle1,
      //     text: 'Most Frequent Products',
      //     alignment: ChartAlignment.far),
      // //  centerY: '220',

      series: <CircularSeries>[
        PieSeries<ItemsChartData, String>(
          dataSource: chartData,
          xValueMapper: (ItemsChartData data, _) => data.tag,
          yValueMapper: (ItemsChartData data, _) =>
              data.itemCalculations.totalPrice,
          dataLabelMapper: (ItemsChartData data, _) =>
              data.itemCalculations.totalCount.toString(),
          explode: true,
          // All the segments will be exploded

          explodeAll: true,
          enableTooltip: true,
          // name: 'Home',
          dataLabelSettings: DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.inside,
              // Renders background rectangle and fills it with series color
              useSeriesColor: true),

          // ending angle of pie
        ),
      ],
    );
  }
}

class PeiWidgetForTagged extends StatelessWidget {
  final List<Tagged> chartData;
  final String? title;
  const PeiWidgetForTagged({
    Key? key,
    required this.chartData,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      margin: EdgeInsets.zero,
      legend: Legend(
        isVisible: true,
        position: LegendPosition.left,
        // alignment: ChartAlignment.center,
        // width: '120',
      ),

      title: ChartTitle(
        text: title ?? '',
      ),
      //  centerY: '220',

      series: <CircularSeries>[
        PieSeries<Tagged, String>(
          dataSource: chartData,
          xValueMapper: (Tagged data, _) => data.tag,
          yValueMapper: (Tagged data, _) =>
              data.shopDataCalculations.itemsSumAfterPayment,
          dataLabelMapper: (Tagged data, _) =>
              data.shopDataCalculations.itemsSumAfterPayment.toString(),
          explode: true,
          // All the segments will be exploded

          explodeAll: true,
          enableTooltip: true,
          // name: 'Home',
          dataLabelSettings: DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.inside,
              // Renders background rectangle and fills it with series color
              useSeriesColor: true),

          // ending angle of pie
        ),
      ],
    );
  }
}

class LineChartWidgetDate extends StatelessWidget {
  final List<ItemsChartData> chartData;
  final String? title;

  const LineChartWidgetDate({Key? key, required this.chartData, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(text: title ?? ''),
      margin: EdgeInsets.zero,
      legend: Legend(isVisible: true, position: LegendPosition.top),
      primaryXAxis: DateTimeAxis(
        majorGridLines: MajorGridLines(width: 0),

        dateFormat: DateFormat('MMM-yy'),
        // intervalType: DateTimeIntervalType.months,
        labelRotation: 90,
      ),
      series: <ChartSeries>[
        SplineSeries<ItemsChartData, DateTime>(
          xAxisName: 'Date',
          yAxisName: 'Consumption',
          dataSource: chartData,
          xValueMapper: (ItemsChartData data, _) => data.date,
          yValueMapper: (ItemsChartData data, _) =>
              data.itemCalculations.totalPrice,
          dataLabelMapper: (ItemsChartData data, _) =>
              DateFormat('MM-yy').format(data.date!).toString(),
          color: Colors.white.withOpacity(0.5),
          width: 1,
          enableTooltip: true,
          // name: 'Home',
          dataLabelSettings: DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.inside,
              // Renders background rectangle and fills it with series color
              useSeriesColor: true),

          // ending angle of pie
        ),
      ],
    );
  }
}

// class LineChartWidget extends ConsumerWidget {
//   final List<ChartData> chartData;

//   LineChartWidget(this.chartData);

//   @override
//   Widget build(BuildContext context, wacth) {
//     return SfCartesianChart(
//       title: ChartTitle(text: 'Shops Consumption'),
//       //primaryXAxis: DateTimeAxis(),
//       primaryXAxis: CategoryAxis(),
//       series: <ChartSeries>[
//         // Renders spline chart
//         SplineSeries<ChartData, String>(
//           dataSource: chartData,
//           xValueMapper: (ChartData sales, _) => sales.tag,
//           yValueMapper: (ChartData sales, _) => sales.value,
//         ),
//       ],
//     );
//   }
// }

// class BarChartWidget extends ConsumerWidget {
//   final List<ChartData> chartData;

//   BarChartWidget(this.chartData);

//   @override
//   Widget build(BuildContext context, wacth) {
//     return SfCartesianChart(
//       title: ChartTitle(text: 'Shops Consumption'),
//       //primaryXAxis: DateTimeAxis(),
//       primaryXAxis: CategoryAxis(),
//       series: <ChartSeries>[
//         // Renders spline chart
//         BarSeries<ChartData, String>(
//           dataSource: chartData,
//           xValueMapper: (ChartData sales, _) => sales.tag,
//           yValueMapper: (ChartData sales, _) => sales.value,

//         ),
//       ],
//     );
//   }
// }

class ColumnChartWidget extends StatelessWidget {
  final List<Tagged> chartData;
  final String? title;
  const ColumnChartWidget({Key? key, required this.chartData, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    chartData
      ..sort((a, b) => b.shopDataCalculations.itemsSumAfterPayment
          .compareTo(a.shopDataCalculations.itemsSumAfterPayment));
    return SfCartesianChart(
      title: ChartTitle(text: title ?? ''),
      //primaryXAxis: DateTimeAxis(),
      primaryXAxis: CategoryAxis(),
      series: <ChartSeries>[
        // Renders spline chart
        ColumnSeries<Tagged, String>(
          width: 0.4,
          dataSource: chartData,
          //color: AppConstants.whiteOpacity,
          color: Colors.white.withOpacity(0.5),
          xValueMapper: (Tagged sales, _) => sales.tag,
          yValueMapper: (Tagged sales, _) =>
              sales.shopDataCalculations.itemsSumAfterPayment,
          // pointColorMapper: (Tagged sales, _) => sales.color,
          dataLabelMapper: (Tagged sales, _) =>
              sales.shopDataCalculations.itemsSumAfterPayment.toString(),
        ),
      ],
    );
  }
}

class ColumnChartKitchenElWidget extends ConsumerWidget {
  final List<KitchenElementModel> kitchenData;

  ColumnChartKitchenElWidget(this.kitchenData);

  @override
  Widget build(BuildContext context, wacth) {
    return SfCartesianChart(
      title: ChartTitle(
          text: 'Kitchen Elements Availability',
          textStyle: Theme.of(context).textTheme.headline6),
      primaryYAxis: NumericAxis(
        minimum: 0,
        maximum: 10,
        interval: 2,
        labelFormat: '{value}%',
        axisLine: AxisLine(
          width: 0,
        ),
        majorTickLines: MajorTickLines(size: 0),
      ),
      primaryXAxis: CategoryAxis(
          //  labelRotation: 90,
          ),
      series: <ChartSeries>[
        // Renders spline chart
        ColumnSeries<KitchenElementModel, String>(
          width: 0.5,
          legendItemText: 'Kitchen Elements',
          dataSource: kitchenData,
          color: Colors.white.withOpacity(0.5),
          xValueMapper: (KitchenElementModel sales, _) => sales.title,
          yValueMapper: (KitchenElementModel sales, _) => sales.availability,
        ),
      ],
    );
  }
}
