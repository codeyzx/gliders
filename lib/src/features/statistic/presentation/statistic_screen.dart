import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gliders/src/features/home/presentation/cages_controller.dart';
import 'package:gliders/src/features/home/widgets/chart_cages.dart';
import 'package:gliders/src/features/home/widgets/chart_bar.dart';
import 'package:gliders/src/features/home/widgets/chart_gliders.dart';
import 'package:google_fonts/google_fonts.dart';

class StatisticScreen extends ConsumerStatefulWidget {
  const StatisticScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends ConsumerState<StatisticScreen> {
  @override
  Widget build(BuildContext context) {
    final koloniLength = ref.read(cagesControllerProvider.notifier).koloniLength;
    final soloLength = ref.read(cagesControllerProvider.notifier).soloLength;
    final ipLength = ref.read(cagesControllerProvider.notifier).ipLength;
    final totalLength = ref.read(cagesControllerProvider.notifier).cagesLength;

    final glidersLength = ref.read(cagesControllerProvider.notifier).glidersLength;
    final jantanLength = ref.read(cagesControllerProvider.notifier).glidersJantanLength;
    final betinaLength = ref.read(cagesControllerProvider.notifier).glidersBetinaLength;

    final glidersAge4Length = ref.read(cagesControllerProvider.notifier).glidersAge4Length;
    final glidersAge8Length = ref.read(cagesControllerProvider.notifier).glidersAge8Length;
    final glidersAge12Length = ref.read(cagesControllerProvider.notifier).glidersAge12Length;
    final glidersAge24Length = ref.read(cagesControllerProvider.notifier).glidersAge24Length;

    final koloniPercentage = (koloniLength / totalLength * 100).toStringAsFixed(0);
    final soloPercentage = (soloLength / totalLength * 100).toStringAsFixed(0);
    final ipPercentage = (ipLength / totalLength * 100).toStringAsFixed(0);

    final jantanPercentage = (jantanLength / glidersLength * 100).toStringAsFixed(0);
    final betinaPercentage = (betinaLength / glidersLength * 100).toStringAsFixed(0);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: const Text('Statistic'),
          automaticallyImplyLeading: false,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Cages'),
              Tab(text: 'Gliders'),
              Tab(text: 'Gliders Age'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Today tab
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ChartCages(
                    koloniLength: koloniLength.toDouble(),
                    soloLength: soloLength.toDouble(),
                    totalLength: totalLength.toDouble(),
                    ipLength: ipLength.toDouble(),
                    koloniPercentage: koloniPercentage,
                    soloPercentage: soloPercentage,
                    ipPercentage: ipPercentage,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Notes', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
                        Text(
                          'Total Kandang $totalLength buah',
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'Total Koloni $koloniLength buah ($koloniPercentage%)',
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'Total Solo $soloLength buah ($soloPercentage%)',
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'Total IP $ipLength buah ($ipPercentage%)',
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ChartGliders(
                    jantanLength: jantanLength.toDouble(),
                    betinaLength: betinaLength.toDouble(),
                    jantanPercentage: jantanPercentage,
                    betinaPercentage: betinaPercentage,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Notes', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
                        Text(
                          'Total Sugar Gliders $glidersLength ekor',
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'Total Jantan $jantanLength ekor ($jantanPercentage%)',
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'Total Betina $betinaLength ekor ($betinaPercentage%)',
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            // All tab
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      height: 350,
                      child: ChartBar(
                        glidersAge4Length: glidersAge4Length.toDouble(),
                        glidersAge8Length: glidersAge8Length.toDouble(),
                        glidersAge12Length: glidersAge12Length.toDouble(),
                        glidersAge24Length: glidersAge24Length.toDouble(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Notes', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
                        Text(
                          'Sugar Gliders umur  0-4 Bulan $glidersAge4Length ekor',
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'Sugar Gliders umur  5-8 Bulan $glidersAge8Length ekor',
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'Sugar Gliders umur  9-12 Bulan $glidersAge12Length ekor',
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'Sugar Gliders umur  >1 Tahun $glidersAge24Length ekor',
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
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
