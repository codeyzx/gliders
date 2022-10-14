import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gliders/src/features/auth/presentation/auth_controller.dart';
import 'package:gliders/src/features/cages/presentation/cages_detail_screen.dart';
import 'package:gliders/src/features/cages/presentation/cages_screen.dart';
import 'package:gliders/src/features/home/presentation/barcodescan_screen.dart';
import 'package:gliders/src/features/home/presentation/cages_controller.dart';
import 'package:gliders/src/features/home/widgets/chart.dart';
import 'package:google_fonts/google_fonts.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(authControllerProvider);
    final cages = ref.watch(cagesControllerProvider);

    List<Map<String, dynamic>> popularNearby = [
      {
        "place": "Kandang 1",
        "location": "Solo",
        "imgPic":
            "https://e7.pngegg.com/pngimages/627/546/png-clipart-dog-crate-puppy-kennel-pet-cage-animals-cage-thumbnail.png",
      },
      {
        "place": "Kandang 2",
        "location": "Koloni",
        "imgPic": "https://www.olaolalombok.com/wp-content/uploads/2017/06/atuh-beach-nusa-penida-03947.jpg",
      },
      {
        "place": "Kandang 3",
        "location": "IP",
        "imgPic":
            "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Kuta_Beach_%286924448550%29.jpg/1200px-Kuta_Beach_%286924448550%29.jpg",
      }
    ];

    List<Map<String, String>> recomendation = [
      {
        "place": "Kuta Beach",
        "location": "Bali, Indonesia",
        "imgPic":
            "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Kuta_Beach_%286924448550%29.jpg/1200px-Kuta_Beach_%286924448550%29.jpg",
      },
      {
        "place": "Ubud Villa",
        "location": "Bali, Indonesia",
        "imgPic": "https://www.ubudvillasrental.com/wp-content/uploads/2019/02/01-Ubud-Villas-Rental-Villa-Bayad-Header.jpg",
      },
      {
        "place": "Nusa Penida Beach",
        "location": "Bali, Indonesia",
        "imgPic": "https://www.olaolalombok.com/wp-content/uploads/2017/06/atuh-beach-nusa-penida-03947.jpg",
      },
    ];

    List menus = [
      {
        "icon": "https://i.ibb.co/9HgyMh6/3658538.png",
        "label": "Cages",
      },
      {
        "icon": "https://i.ibb.co/Pt09Sdz/2942962.png",
        "label": "Statistic",
      },
      {
        "icon": "https://i.ibb.co/RcMMhBr/3009489.png",
        "label": "History",
      },
      {
        "icon": "https://i.ibb.co/w0K3vY6/5996290.png",
        "label": "More",
      }
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            // await ref.read(cagesControllerProvider.notifier).getData();
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
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                              //
                              //User Photo
                              //
                              image: DecorationImage(
                                image: NetworkImage(
                                  users.photo.toString(),
                                ),
                              )),
                        ),
                        const Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //
                            //Lokasi User
                            //
                            Text(
                              "Good morning,",
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
                          onTap: () {},
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
                const Chart(),
                const SizedBox(height: 30),
                //
                //Card suggest
                //
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    menus.length,
                    (index) {
                      var item = menus[index];
                      return Column(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.network(item["icon"]),
                                ),
                                Material(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(60),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const BarcodescanScreen(),
                                          ));
                                    },
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(item["label"]),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),
                //
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
                                          builder: (context) => CagesDetailScreen(cages: item),
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
                                                Text(item.gliders!.join(", "), style: GoogleFonts.poppins(fontSize: 12)),
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
                //
                //Card Recomendation
                //
                // Padding(
                //   padding: const EdgeInsets.only(left: 8.0),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.only(right: 8.0),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             const Text(
                //               "Recomendation",
                //               style: TextStyle(
                //                 fontWeight: FontWeight.bold,
                //                 fontSize: 20,
                //               ),
                //             ),
                //             TextButton(
                //               onPressed: () {
                //                 final glidersLength = ref.read(cagesControllerProvider.notifier).glidersLength;
                //                 Logger().i(glidersLength);
                //               },
                //               child: const Text(
                //                 "See More",
                //                 style: TextStyle(
                //                   fontSize: 16,
                //                   color: Colors.green,
                //                 ),
                //               ),
                //             )
                //           ],
                //         ),
                //       ),
                //       const SizedBox(height: 10),
                //       SingleChildScrollView(
                //         scrollDirection: Axis.horizontal,
                //         child: Row(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: recomendation
                //               .map(
                //                 (e) => SizedBox(
                //                   width: 300,
                //                   child: Card(
                //                     shape: RoundedRectangleBorder(
                //                       borderRadius: BorderRadius.circular(15.0),
                //                     ),
                //                     child: IntrinsicHeight(
                //                       child: Padding(
                //                         padding: const EdgeInsets.all(12.0),
                //                         child: Row(
                //                           children: [
                //                             Container(
                //                               height: 100,
                //                               width: 100,
                //                               decoration: BoxDecoration(
                //                                 borderRadius: BorderRadius.circular(10),
                //                                 color: Colors.cyan,
                //                                 image: DecorationImage(
                //                                   image: NetworkImage(
                //                                     e["imgPic"]!,
                //                                   ),
                //                                   fit: BoxFit.cover,
                //                                 ),
                //                               ),
                //                             ),
                //                             Padding(
                //                               padding: const EdgeInsets.all(8.0),
                //                               child: Column(
                //                                 crossAxisAlignment: CrossAxisAlignment.start,
                //                                 children: [
                //                                   Text(
                //                                     e["place"]!,
                //                                     style: const TextStyle(
                //                                       fontWeight: FontWeight.bold,
                //                                     ),
                //                                   ),
                //                                   const SizedBox(height: 5),
                //                                   Row(
                //                                     children: [
                //                                       const Icon(
                //                                         Icons.map,
                //                                         size: 15,
                //                                         color: Colors.grey,
                //                                       ),
                //                                       Text(
                //                                         e["location"]!,
                //                                         style: Theme.of(context).textTheme.caption,
                //                                       ),
                //                                     ],
                //                                   ),
                //                                 ],
                //                               ),
                //                             )
                //                           ],
                //                         ),
                //                       ),
                //                     ),
                //                   ),
                //                 ),
                //               )
                //               .toList(),
                //         ),
                //       ),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color categoryColors(String category) {
    switch (category) {
      case "koloni":
        return Colors.red;
      case "solo":
        return Colors.black;
      case "ip":
        return Colors.blue;
      default:
        return Colors.white;
    }
  }
}
