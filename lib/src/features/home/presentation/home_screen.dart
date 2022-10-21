import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gliders/src/features/auth/presentation/auth_controller.dart';
import 'package:gliders/src/features/auth/presentation/sign_in_screen.dart';
import 'package:gliders/src/features/cages/presentation/cages_detail_screens.dart';
import 'package:gliders/src/features/cages/presentation/cages_screen.dart';
import 'package:gliders/src/features/history/presentation/history_controller.dart';
import 'package:gliders/src/features/history/presentation/history_screen.dart';
import 'package:gliders/src/features/home/presentation/cages_controller.dart';
import 'package:gliders/src/features/home/widgets/chart_cages.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:logger/logger.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = 'home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int length = 0;

  @override
  void initState() {
    super.initState();
    initProducts();
  }

  Future<void> initProducts() async {
    await ref.read(cagesControllerProvider.notifier).getData();
    await ref.read(historyControllerProvider.notifier).getData();
  }

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(authControllerProvider);
    final cages = ref.watch(cagesControllerProvider);
    final history = ref.watch(historyControllerProvider);

    final koloniLength = ref.read(cagesControllerProvider.notifier).koloniLength;
    final soloLength = ref.read(cagesControllerProvider.notifier).soloLength;
    final ipLength = ref.read(cagesControllerProvider.notifier).ipLength;
    final othersLength = ref.read(cagesControllerProvider.notifier).othersLength;
    final totalLength = ref.read(cagesControllerProvider.notifier).cagesLength;

    final koloniPercentage = (koloniLength / totalLength * 100).toStringAsFixed(0);
    final soloPercentage = (soloLength / totalLength * 100).toStringAsFixed(0);
    final ipPercentage = (ipLength / totalLength * 100).toStringAsFixed(0);
    final othersPercentage = (othersLength / totalLength * 100).toStringAsFixed(0);

    String checkTime() {
      final now = DateTime.now();
      final hour = DateFormat('kk').format(now);
      final intHour = int.parse(hour);
      if (intHour >= 4 && intHour < 11) {
        return 'Good morning,';
      } else if (intHour >= 11 && intHour < 15) {
        return 'Good afternoon,';
      } else if (intHour >= 15 && intHour < 18) {
        return 'Good evening,';
      } else {
        return 'Good night,';
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await ref.read(cagesControllerProvider.notifier).getData();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                //Header
                //
                Container(
                  width: double.infinity,
                  height: 80,
                  color: HexColor('#F2FEFF'),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Material(
                          child: InkWell(
                            onTap: () async {
                              //show dialog to confirm logout
                              await showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Logout'),
                                  content: const Text('Are you sure you want to logout?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await ref.read(authControllerProvider.notifier).googleSignOut();
                                        if (mounted) {
                                          context.goNamed(SignInScreen.routeName);
                                        }
                                      },
                                      child: const Text('Logout'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  //
                                  //User Photo
                                  //
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      users.photo.toString(),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //
                            //Lokasi User
                            //
                            Text(
                              checkTime(),
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              users.name.toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                        //
                        //Badge Notifikasi
                        //
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            final gliders = cages.map((e) => e.gliders).toList();

                            final glidersBetina =
                                gliders.map((e) => e!.where((element) => element.containsValue('betina')).length).toList();
                            final glidersBetinaLength = glidersBetina.reduce((value, element) => value + element);
                            Logger().e(glidersBetinaLength);
                          },
                          child: const SizedBox(
                            width: 32.0,
                            child: Icon(
                              Icons.notifications,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ChartCages(
                    koloniLength: koloniLength.toDouble(),
                    soloLength: soloLength.toDouble(),
                    totalLength: totalLength.toDouble(),
                    ipLength: ipLength.toDouble(),
                    othersLength: othersLength.toDouble(),
                    koloniPercentage: koloniPercentage,
                    soloPercentage: soloPercentage,
                    ipPercentage: ipPercentage,
                    othersPercentage: othersPercentage),
                const SizedBox(height: 10),
                //
                //Card suggest
                //
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: List.generate(
                //     menus.length,
                //     (index) {
                //       var item = menus[index];
                //       return Column(
                //         children: [
                //           Container(
                //             height: 60,
                //             width: 60,
                //             decoration: BoxDecoration(
                //               color: Colors.blueAccent.withOpacity(0.2),
                //               borderRadius: BorderRadius.circular(12),
                //             ),
                //             child: Stack(
                //               children: [
                //                 Padding(
                //                   padding: const EdgeInsets.all(10.0),
                //                   child: Image.network(item["icon"]),
                //                 ),
                //                 Material(
                //                   color: Colors.transparent,
                //                   borderRadius: BorderRadius.circular(60),
                //                   child: InkWell(
                //                     onTap: () {
                //                       Navigator.push(
                //                           context,
                //                           MaterialPageRoute(
                //                             builder: (context) => const BarcodescanScreen(),
                //                           ));
                //                     },
                //                     borderRadius: BorderRadius.circular(60),
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //           const SizedBox(height: 5),
                //           Text(item["label"]),
                //         ],
                //       );
                //     },
                //   ),
                // ),
                // const SizedBox(height: 30),
                // //
                //Card Popular Nearby
                //
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Cages",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.blueAccent.withOpacity(0.1),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CagesScreen(),
                                  ));
                            },
                            child: const Text(
                              "See All",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: cages
                              .map(
                                (item) => InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CagesDetailScreens(product: item),
                                        ));
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: IntrinsicHeight(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 200,
                                            height: 150,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  item.images.toString(),
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item.title.toString().toUpperCase(),
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.category,
                                                      size: 15,
                                                      color: Colors.grey,
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      item.category.toString(),
                                                      style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w400,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 8),
                                                // Text(item.gliders!.join(", "), style: GoogleFonts.poppins(fontSize: 12)),
                                                Text(
                                                  item.gliders!.map((e) => e['name']).toList().join(', '),
                                                  style: GoogleFonts.poppins(fontSize: 12),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                // Row(
                                                //   children: item.gliders!.map((e) {
                                                //     // get values of name
                                                //     var name = e["name"];
                                                //     return Row(
                                                //       children: [
                                                //         Text(
                                                //           name.toString(),
                                                //           style: GoogleFonts.poppins(
                                                //             fontSize: 12,
                                                //             fontWeight: FontWeight.w400,
                                                //           ),
                                                //         ),
                                                //         const SizedBox(width: 5),
                                                //       ],
                                                //     );
                                                //   }).toList(),
                                                // )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "History",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              JustTheTooltip(
                                triggerMode: TooltipTriggerMode.tap,
                                content: Container(
                                  height: 90,
                                  width: 100,
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            color: Colors.greenAccent.withOpacity(0.6),
                                            size: 18,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Add",
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            color: Colors.orangeAccent.withOpacity(0.5),
                                            size: 18,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Update",
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            color: Colors.redAccent.withOpacity(0.6),
                                            size: 18,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Delete",
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                  decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    size: 10,
                                    Icons.question_mark,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.blueAccent.withOpacity(0.1),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HistoryScreen(),
                                  ));
                            },
                            child: const Text(
                              "See All",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                          bottom: 10.0,
                        ),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: history.length,
                          itemBuilder: (context, index) {
                            if (index < 4) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 4,
                                      offset: const Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: InkWell(
                                  onTap: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 50,
                                            margin: const EdgeInsets.symmetric(horizontal: 10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  history[index].photo.toString(),
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 100,
                                                  child: Text(
                                                    overflow: TextOverflow.fade,
                                                    history[index].name.toString().toUpperCase(),
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                    DateFormat('dd MMMM, kk:mm').format(DateTime.fromMillisecondsSinceEpoch(
                                                        int.tryParse(history[index].time.toString())!)),
                                                    style: GoogleFonts.poppins(fontSize: 12)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                          margin: const EdgeInsets.only(right: 10),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: logColors(history[index].log.toString()),
                                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                                          ),
                                          child: Text(history[index].cages.toString(),
                                              style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w300))),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color logColors(String category) {
    switch (category) {
      case "add":
        return Colors.greenAccent.withOpacity(0.6);
      case "update":
        return Colors.orangeAccent.withOpacity(0.5);
      case "delete":
        return Colors.redAccent.withOpacity(0.6);
      default:
        return Colors.grey;
    }
  }
}
