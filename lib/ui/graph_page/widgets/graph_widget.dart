import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';
import 'package:orders_flutter_app/models/order_model.dart';

class GraphWidget extends StatefulWidget {
  final List<OrderModel> orders;
  const GraphWidget({super.key, required this.orders});

  @override
  State<GraphWidget> createState() => _GraphWidgetState();
}

class _GraphWidgetState extends State<GraphWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: _spots,
            isCurved: false,
            barWidth: 4,
            isStrokeCapRound: true,
            dotData: const FlDotData(
              show: false,
            ),
            belowBarData: BarAreaData(
              show: true,
            ),
            aboveBarData: BarAreaData(
              show: false,
            ),
          ),
        ],
        minY: 0,
        titlesData: FlTitlesData(
          show: true,
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            axisNameWidget: Text(
              '2021 Months',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 18,
              interval: 1,
              getTitlesWidget: bottomTitleWidgets,
            ),
          ),
          leftTitles: AxisTitles(
            axisNameSize: 20,
            axisNameWidget: const Text(
              'Orders Number',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              reservedSize: 40,
            ),
          ),
        ),
      ),
      duration: Duration(milliseconds: 150),
      curve: Curves.easeInQuad,
    );
  }

  /// Helper Widget

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Jan';
        break;
      case 1:
        text = 'Feb';
        break;
      case 2:
        text = 'Mar';
        break;
      case 3:
        text = 'Apr';
        break;
      case 4:
        text = 'May';
        break;
      case 5:
        text = 'Jun';
        break;
      case 6:
        text = 'Jul';
        break;
      case 7:
        text = 'Aug';
        break;
      case 8:
        text = 'Sep';
        break;
      case 9:
        text = 'Oct';
        break;
      case 10:
        text = 'Nov';
        break;
      case 11:
        text = 'Dec';
        break;
      default:
        return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// Helper Methods

  List<FlSpot> get _spots {
    final List<double> monthOrdersList = List.generate(12, (_) => 0);
    for (var element in widget.orders) {
      monthOrdersList[element.registered.month - 1] += 1;
    }

    final List<FlSpot> spots = List.filled(12, FlSpot(0, 0));
    for (int i = 0; i < monthOrdersList.length; i++) {
      spots[i] = FlSpot(i.toDouble(), monthOrdersList[i]);
    }
    return spots;
  }
}
