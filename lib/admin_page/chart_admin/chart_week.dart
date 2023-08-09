import 'package:attedancebeta/admin_page/chart_admin/chart_no_attedance.dart';
import 'package:attedancebeta/color/color_const.dart';
import 'package:attedancebeta/model_data/model_retrieve_attedance.dart';
import 'package:attedancebeta/state/state_manage.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
  String? selectDrop;
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
        List<List<ModelAttedance>> fuu = _present!.refactorData;
        print('${fuu.length} item');
        return BarChartGroupData(x: ev.key, barRods: [
          BarChartRodData(
              width: 20,
              color:
                  fuu[ev.key].length <= 2 ? ColorUse.mainBg : ColorUse.colorBf,
              borderRadius: BorderRadius.circular(4),
              toY: fuu[ev.key].length.toDouble())
        ]);
      }).toList();

  BarTouchData get touchNon => BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.white,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            return BarTooltipItem('${rod.toY.toInt()} orang',
                TextStyle(color: Colors.black, fontSize: 20));
          },
        ),
      );

  BarChartData get myData => BarChartData(
      barTouchData: touchNon,
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
    final watchBarState = ref.watch(stateBarChart);
    final size = MediaQuery.sizeOf(context);
    return Container(
      padding:
          EdgeInsets.only(top: size.height * 0.05, bottom: size.height * 0.05),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              'Grafik Mingguan',
              style: TextStyle(
                  fontSize: size.height * 0.035, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: size.height * 0.03,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Text(
                        'Pilihan',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: _present!.chartDrop
                          .map((String item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      value: selectDrop,
                      onChanged: (value) {
                        setState(() {
                          selectDrop = value!;
                          ref
                              .read(stateBarChart.notifier)
                              .update((state) => value);
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: ColorUse.colorText),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        height: size.height * 0.08,
                        width: size.width * 0.4,
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Container(
                width: size.width,
                height: size.height * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: watchBarState == 'kehadiran'
                    ? BarChart(myData)
                    : ChartNoAttedance(myList: widget.listData)),
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
