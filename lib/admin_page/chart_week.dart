import 'package:attedancebeta/color/color_const.dart';
import 'package:attedancebeta/model_data/model_retrieve_attedance.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../data_representation/data_r.dart';

class ChartWeek extends StatefulWidget{
  final List<ModelAttedance> listData;
  final Representation dataD;
  const ChartWeek({super.key, required this.listData, required this.dataD});

  @override
  State<ChartWeek> createState() => _ChartWeekState();
}

class _ChartWeekState extends State<ChartWeek> {
  List<String> dayName = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white
      ),
      padding: EdgeInsets.only(
          top: size.height * 0.05,
          // right: size.width * 0.03,
          bottom: size.height * 0.05),
      child: BarChart(BarChartData(
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
            show: true,
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
              showTitles: true,
              // reservedSize: 10,
              getTitlesWidget: (value, meta) {
                return Text(dayName[value.toInt()]);
              },
            ))),
        maxY: 10,
        gridData: const FlGridData(show: false),
        barGroups: dayName.asMap().entries.map((ev) {
          List<List<ModelAttedance>> fuu = [
            widget.dataD.mondayData(),
            widget.dataD.tueData(),
            widget.dataD.wedData(),
            widget.dataD.thuData(),
            widget.dataD.friData(),
            widget.dataD.satData(),
            widget.dataD.sunData()
          ];
          return BarChartGroupData(x: ev.key, barRods: [
            BarChartRodData(
                width: size.width * 0.04,
                color: fuu[ev.key].length <= 2
                    ? ColorUse.mainBg
                    : ColorUse.colorBf,
                borderRadius: BorderRadius.circular(4),
                toY: fuu[ev.key].length.toDouble())
          ]);
        }).toList(),
      )),
    );
  }
}
