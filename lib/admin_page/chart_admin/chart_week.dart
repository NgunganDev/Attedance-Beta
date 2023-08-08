import 'package:attedancebeta/color/color_const.dart';
import 'package:attedancebeta/model_data/model_retrieve_attedance.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../presenter/admin_presenter.dart';

class ChartWeek extends ConsumerStatefulWidget {
  final List<ModelAttedance> listData;
  const ChartWeek({super.key, required this.listData});

  @override
  ConsumerState<ChartWeek> createState() => _ChartWeekState();
}

class _ChartWeekState extends ConsumerState<ChartWeek> {
  List<String> dayName = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  PresenterAdmin? _present;

  FlBorderData get myBorder => FlBorderData(
        show: false,
      );

  FlGridData get myGrid => const FlGridData(
        show: true,
      );

  FlTitlesData get myTitle => FlTitlesData(
      bottomTitles: AxisTitles(
          sideTitles: SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          return Text(dayName[value.toInt()]);
        },
      )),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(
          sideTitles: SideTitles(
        showTitles: false,
      )));

  List<BarChartGroupData> get myGroup => dayName.asMap().entries.map((ev) {
        _present!.setList(widget.listData);
        List<List<ModelAttedance>> fuu = _present!.dayList;
        // print('${fuu.length} item');
        return BarChartGroupData(x: ev.key, barRods: [
          BarChartRodData(
              width: 20,
              color:
                  fuu[ev.key].length <= 2 ? ColorUse.mainBg : ColorUse.colorBf,
              borderRadius: BorderRadius.circular(4),
              toY: fuu[ev.key].length.toDouble())
        ]);
      }).toList();

  BarChartData get myData => BarChartData(
      borderData: myBorder,
      maxY: 10,
      titlesData: myTitle,
      gridData: myGrid,
      barGroups: myGroup);
  @override
  void initState() {
    super.initState();
    _present = ref.read(presenterFour);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      padding: EdgeInsets.only(
          top: size.height * 0.05,
          // right: size.width * 0.03,
          bottom: size.height * 0.05),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
             SizedBox(
              height: size.height * 0.03,
            ),
            Text(
              'Grafik Mingguan',
              style: TextStyle(
                  fontSize: size.height * 0.035, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Container(
                width: size.width,
                height: size.height * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: BarChart(myData)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
              width: size.width,
              height: size.height * 0.1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 5,
                        backgroundColor: ColorUse.mainBg,
                      ),
                      SizedBox(
                        width: size.width * 0.03,
                      ),
                      Text(
                        'Good',
                        style: TextStyle(
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 5,
                        backgroundColor: ColorUse.colorBf,
                      ),
                      SizedBox(
                        width: size.width * 0.03,
                      ),
                      Text(
                        'Not Yet',
                        style: TextStyle(
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
