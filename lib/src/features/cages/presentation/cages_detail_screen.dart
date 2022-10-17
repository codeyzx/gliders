import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gliders/src/features/cages/presentation/cages_add_screen.dart';
import 'package:gliders/src/features/home/domain/cages/cages.dart';
import 'package:gliders/src/features/home/presentation/cages_controller.dart';
import 'package:gliders/src/shared/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';

class CagesDetailScreen extends ConsumerStatefulWidget {
  final Cages? cages;
  final String? id;
  const CagesDetailScreen({super.key,  this.cages, this.id});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CagesDetailScreenState();
}

class _CagesDetailScreenState extends ConsumerState<CagesDetailScreen> {
  Cages? cagesFromScan;

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      getCages();
    }
  }

  Future<void> getCages() async {
    final snapshot = await FirebaseFirestore.instance.collection("cages").doc(widget.id).get();
    if (snapshot.exists) {
      final cage = Cages.fromJson(snapshot.data()!);
      setState(() {
        cagesFromScan = cage;
      });
      Logger().i(cage);
    }
    Logger().i(cagesFromScan);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // <-- Set this
      appBar: AppBar(
        backgroundColor: Colors.transparent, // <-- this
        shadowColor: Colors.transparent, // <-- and this
      ),
      body: widget.id != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                  image: NetworkImage(widget.cages?.images.toString() ?? 'https://picsum.photos/500/300?random=1'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        cagesFromScan?.title.toString().toUpperCase() ?? 'null',
                        style: GoogleFonts.poppins(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Category ${cagesFromScan?.category}',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Jumlah ${cagesFromScan?.gliders?.length} SG',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Gliders: \n${cagesFromScan?.gliders?.toString().replaceAll('[', '').replaceAll(']', '')}',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      if (cagesFromScan?.notes != '')
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'notes',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              cagesFromScan?.notes.toString() ?? 'null',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        )
                    ],
                  ),
                )
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                  image: NetworkImage(widget.cages?.images.toString() ?? 'https://picsum.photos/500/300?random=1'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.cages?.title.toString().toUpperCase() ?? 'null',
                        style: GoogleFonts.poppins(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Category ${widget.cages?.category}',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Jumlah ${widget.cages?.gliders?.length} SG',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Gliders: \n${widget.cages?.gliders?.toString().replaceAll('[', '').replaceAll(']', '')}',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      if (widget.cages?.notes != '')
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'notes',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              widget.cages?.notes.toString() ?? 'null',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        )
                    ],
                  ),
                )
              ],
            ),

      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.10), offset: const Offset(0, -2), blurRadius: 4, spreadRadius: 0),
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Material(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CagesAddScreen(isEdit: true, cages: widget.cages),
                      ));
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.edit,
                      color: Colors.amber,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'EDIT',
                      style: btmsheet,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 1,
              height: double.infinity,
              color: Colors.black,
            ),
            Material(
              child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Delete cages'),
                          content: const Text('Are you sure you want to delete this cages?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                ref.read(cagesControllerProvider.notifier).delete(widget.cages!.id.toString());
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        );
                      });
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'DELETE',
                      style: btmsheet,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
