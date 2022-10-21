import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gliders/src/features/home/widgets/indicator.dart';

class ChartGliders extends StatefulWidget {
  final double jantanLength;
  final double betinaLength;
  final String jantanPercentage;
  final String betinaPercentage;

  const ChartGliders({
    Key? key,
    required this.jantanLength,
    required this.betinaLength,
    required this.jantanPercentage,
    required this.betinaPercentage,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ChartGlidersState();
}

class ChartGlidersState extends State<ChartGliders> {
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
                      jantanPercentage: widget.jantanPercentage,
                      betinaPercentage: widget.betinaPercentage,
                      jantanLength: widget.jantanLength,
                      betinaLength: widget.betinaLength,
                    ),
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
                  text: 'Jantan',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xfff8b250),
                  text: 'Betina',
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

  List<PieChartSectionData> showingSections({
    required String jantanPercentage,
    required String betinaPercentage,
    required double jantanLength,
    required double betinaLength,
  }) {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: jantanLength.toDouble(),
            title: '$jantanPercentage%',
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
            value: betinaLength.toDouble(),
            title: '$betinaPercentage%',
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
