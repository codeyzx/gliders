import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gliders/src/features/cages/presentation/cages_add_screen.dart';
import 'package:gliders/src/features/home/domain/cages/cages.dart';
import 'package:gliders/src/features/home/presentation/cages_controller.dart';
import 'package:gliders/src/shared/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class CagesDetailScreen extends ConsumerWidget {
  final Cages? cages;
  const CagesDetailScreen({super.key, required this.cages});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
            image: NetworkImage(cages?.images.toString() ?? 'https://picsum.photos/500/300?random=1'),
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
                  cages?.title.toString().toUpperCase() ?? 'null',
                  style: GoogleFonts.poppins(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Category ${cages?.category}',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Jumlah ${cages?.gliders?.length} SG',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Gliders: \n${cages?.gliders?.toString().replaceAll('[', '').replaceAll(']', '')}',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                if (cages?.notes != '')
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
                        cages?.notes.toString() ?? 'null',
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
                        builder: (context) => CagesAddScreen(isEdit: true, cages: cages),
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
                                ref.read(cagesControllerProvider.notifier).delete(cages!.id.toString());
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
