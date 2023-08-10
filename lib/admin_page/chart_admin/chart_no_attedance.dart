import 'package:attedancebeta/color/color_const.dart';
import 'package:attedancebeta/presenter/admin_presenter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model_data/model_retrieve_attedance.dart';

class ChartNoAttedance extends ConsumerStatefulWidget {
  final List<ModelAttedance> myList;
  const ChartNoAttedance({super.key, required this.myList});

  @override
  ConsumerState<ChartNoAttedance> createState() => _ChartNoAttedanceState();
}

class _ChartNoAttedanceState extends ConsumerState<ChartNoAttedance> {
  PresenterAdmin? _present;

// barChart dari list untuk yang non attedance dan where => data minggu ini dimulai dari senin
  List<String> dayName = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  BarTouchData get touchNon => BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.white,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            return BarTooltipItem('${rod.toY.toInt()} orang',
               const TextStyle(color: Colors.black, fontSize: 20));
          },
        ),
      );
  FlTitlesData get titleNon => FlTitlesData(
        // show: true,
        bottomTitles: AxisTitles(
            sideTitles: SideTitles(
          reservedSize: 30,
          showTitles: true,
          getTitlesWidget: (value, meta) {
            return Text(dayName[value.toInt()]);
          },
        )),
        rightTitles: const AxisTitles(
            sideTitles: SideTitles(
          showTitles: false,
        )),
        topTitles: const AxisTitles(
            sideTitles: SideTitles(
          showTitles: false,
        )),
      );
  FlBorderData get borderNon => FlBorderData(show: false);

  List<BarChartGroupData> get nonGroup => dayName.asMap().entries.map((e) {
        return BarChartGroupData(x: e.key, barRods: [
          BarChartRodData(
              toY: _present!.refactorNon[e.key].length.toDouble(),
              width: 20,
              borderRadius: BorderRadius.circular(4),
              color: _present!.refactorNon[e.key].length <= 2
                  ? ColorUse.colorBf
                  : ColorUse.mainBg)
        ]);
      }).toList();

  FlGridData get gridNon => const FlGridData(
        show: true,
      );
  BarChartData get chartNon => BarChartData(
      maxY: 10,
      barTouchData: touchNon,
      borderData: borderNon,
      gridData: gridNon,
      barGroups: nonGroup,
      titlesData: titleNon);

  @override
  void initState() {
    super.initState();
    _present = ref.read(presenterFour);
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(chartNon);
  }
}
