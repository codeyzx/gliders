import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gliders/src/features/home/widgets/indicator.dart';

class Chart extends StatefulWidget {
  final double koloniLength;
  final double soloLength;
  final double totalLength;
  final double ipLength;
  final double othersLength;
  final String koloniPercentage;
  final String soloPercentage;
  final String ipPercentage;
  final String othersPercentage;

  const Chart({
    Key? key,
    required this.koloniLength,
    required this.soloLength,
    required this.totalLength,
    required this.ipLength,
    required this.othersLength,
    required this.koloniPercentage,
    required this.soloPercentage,
    required this.ipPercentage,
    required this.othersPercentage,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ChartState();
}

class ChartState extends State<Chart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Card(
        shadowColor: Colors.transparent,
        child: Row(
          children: <Widget>[
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 35,
                    sections: showingSections(
                        koloniPercentage: widget.koloniPercentage,
                        soloPercentage: widget.soloPercentage,
                        ipPercentage: widget.ipPercentage,
                        othersPercentage: widget.othersPercentage,
                        koloniLength: widget.koloniLength,
                        soloLength: widget.soloLength,
                        ipLength: widget.ipLength,
                        othersLength: widget.othersLength),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Indicator(
                  color: Color(0xff0293ee),
                  text: 'Koloni',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xfff8b250),
                  text: 'Solo',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xff845bef),
                  text: 'IP',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Colors.grey,
                  text: 'Others',
                  isSquare: true,
                ),
              ],
            ),
            const SizedBox(
              width: 28,
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(
      {required String koloniPercentage,
      required String soloPercentage,
      required String ipPercentage,
      required String othersPercentage,
      required double koloniLength,
      required double soloLength,
      required double ipLength,
      required double othersLength}) {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: koloniLength.toDouble(),
            title: '$koloniPercentage%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: soloLength.toDouble(),
            title: '$soloPercentage%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: ipLength.toDouble(),
            title: '$ipPercentage%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.grey,
            value: othersLength.toDouble(),
            title: '$othersPercentage%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
