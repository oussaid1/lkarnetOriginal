import 'package:flutter/material.dart';
import 'package:lkarnet/models/statistics/statistics_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../components.dart';

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
    if (chartData.isEmpty) {
      return Container();
    }
    if (chartData.isNotEmpty) {
      chartData.sort((a, b) => b.itemCalculations.totalPrice
          .compareTo(a.itemCalculations.totalPrice));
    }

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
          dataSource: chartData.limit(10),
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

class LineChartWidgetDate extends StatelessWidget {
  final List<ItemsChartData> chartData;
  final String? title;

  const LineChartWidgetDate({Key? key, required this.chartData, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    chartData.sort((b, a) => a.date.compareTo(b.date));
    return SfCartesianChart(
      title: ChartTitle(
          text: title ?? '', textStyle: Theme.of(context).textTheme.bodySmall),
      margin: EdgeInsets.zero,
      legend: Legend(isVisible: true, position: LegendPosition.top),
      primaryXAxis: DateTimeAxis(
        majorGridLines: MajorGridLines(width: 0),
        dateFormat: DateFormat.yMMMd(),
        intervalType: DateTimeIntervalType.months,
        labelRotation: 90,
      ),
      series: <ChartSeries>[
        SplineSeries<ItemsChartData, DateTime>(
          // sortingOrder: SortingOrder.ascending,
          dataSource: chartData,
          xValueMapper: (ItemsChartData data, _) => data.date,
          yValueMapper: (ItemsChartData data, _) =>
              data.itemCalculations.totalPrice,
          dataLabelMapper: (ItemsChartData data, _) => data.date.ddmmyyyy(),
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

class ColumnChartWidget extends StatelessWidget {
  final List<ItemsChartData> chartData;
  final String? title;
  const ColumnChartWidget({Key? key, required this.chartData, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // chartData
    //   ..sort((a, b) => b.shopDataCalculations.itemsSumAfterPayment
    //       .compareTo(a.shopDataCalculations.itemsSumAfterPayment));
    return SfCartesianChart(
      title: ChartTitle(
          text: title ?? '', textStyle: Theme.of(context).textTheme.bodySmall),
      primaryXAxis: DateTimeAxis(),
      //primaryXAxis: CategoryAxis(),
      series: <ChartSeries>[
        // Renders spline chart
        ColumnSeries<ItemsChartData, DateTime>(
          width: 0.4,
          dataSource: chartData,
          //color: AppConstants.whiteOpacity,
          color: Colors.white.withOpacity(0.5),
          xValueMapper: (ItemsChartData sales, _) => sales.tag,
          yValueMapper: (ItemsChartData sales, _) =>
              sales.itemCalculations.totalCount,
          // pointColorMapper: (Tagged sales, _) => sales.color,
          dataLabelMapper: (ItemsChartData sales, _) =>
              sales.itemCalculations.totalCount.toString(),
        ),
      ],
    );
  }
}
