import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lkarnet/models/statistics/statistics_model.dart';
import 'package:lkarnet/models/statistics/tagged.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../components.dart';

class SemiPeiWidget extends ConsumerWidget {
  final List<ChartData> chartData;
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
        DoughnutSeries<ChartData, String>(
          innerRadius: '80',
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.tag,
          yValueMapper: (ChartData data, _) => data.value,
          dataLabelMapper: (ChartData data, _) => data.tag,

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

class PeiWidget extends ConsumerWidget {
  final List<ChartData> chartData;

  PeiWidget(this.chartData);

  @override
  Widget build(BuildContext context, wacth) {
    return SfCircularChart(
      margin: EdgeInsets.zero,
      //  centerY: '220',
      series: <CircularSeries>[
        PieSeries<ChartData, String>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.tag,
          yValueMapper: (ChartData data, _) => data.value,
          dataLabelMapper: (ChartData data, _) => data.tag,
          explode: false,
          // All the segments will be exploded
          explodeAll: true,
          enableTooltip: true,
          name: 'Home',
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

class LineChartWidgetDate extends ConsumerWidget {
  final List<Tagged> chartData;

  LineChartWidgetDate(this.chartData);

  @override
  Widget build(BuildContext context, wacth) {
    return SfCartesianChart(
      margin: EdgeInsets.zero,
      legend: Legend(isVisible: false),
      primaryXAxis: DateTimeAxis(
        majorGridLines: MajorGridLines(width: 0),
        interval: 1,
        dateFormat: DateFormat.MMM(),
        intervalType: DateTimeIntervalType.months,
        minimum: DateTime(2020, 1, 1),
        maximum: DateTime(2020, 12, 31),
      ),
      series: <ChartSeries>[
        SplineSeries<Tagged, DateTime>(
          dataSource: chartData,
          xValueMapper: (Tagged data, _) => data.date,
          yValueMapper: (Tagged data, _) => data.itemsSum,
          dataLabelMapper: (Tagged data, _) => data.tag,

          enableTooltip: true,
          name: 'Home',
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

class LineChartWidget extends ConsumerWidget {
  final List<ChartData> chartData;

  LineChartWidget(this.chartData);

  @override
  Widget build(BuildContext context, wacth) {
    return SfCartesianChart(
      //primaryXAxis: DateTimeAxis(),
      primaryXAxis: CategoryAxis(),
      series: <ChartSeries>[
        // Renders spline chart
        SplineSeries<ChartData, String>(
          dataSource: chartData,
          xValueMapper: (ChartData sales, _) => sales.tag,
          yValueMapper: (ChartData sales, _) => sales.value,
        ),
      ],
    );
  }
}

class BarChartWidget extends ConsumerWidget {
  final List<ChartData> chartData;

  BarChartWidget(this.chartData);

  @override
  Widget build(BuildContext context, wacth) {
    return SfCartesianChart(
      //primaryXAxis: DateTimeAxis(),
      primaryXAxis: CategoryAxis(),
      series: <ChartSeries>[
        // Renders spline chart
        BarSeries<ChartData, String>(
          dataSource: chartData,
          xValueMapper: (ChartData sales, _) => sales.tag,
          yValueMapper: (ChartData sales, _) => sales.value,
        ),
      ],
    );
  }
}

class ColumnChartWidget extends ConsumerWidget {
  final List<ChartData> chartData;

  ColumnChartWidget(this.chartData);

  @override
  Widget build(BuildContext context, wacth) {
    return SfCartesianChart(
      //primaryXAxis: DateTimeAxis(),
      primaryXAxis: CategoryAxis(),
      series: <ChartSeries>[
        // Renders spline chart
        ColumnSeries<ChartData, String>(
          dataSource: chartData,
          xValueMapper: (ChartData sales, _) => sales.tag,
          yValueMapper: (ChartData sales, _) => sales.value,
        ),
      ],
    );
  }
}
