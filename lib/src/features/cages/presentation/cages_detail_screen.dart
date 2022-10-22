import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:gliders/src/features/auth/presentation/auth_controller.dart';
import 'package:gliders/src/features/cages/domain/cages/cages.dart';
import 'package:gliders/src/features/cages/domain/gliders/gliders.dart';
import 'package:gliders/src/features/cages/presentation/cages_add_screen.dart';
import 'package:gliders/src/features/home/presentation/cages_controller.dart';
import 'package:gliders/src/shared/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class CagesDetailScreen extends ConsumerStatefulWidget {
  final Cages? product;
  final String? id;
  const CagesDetailScreen({Key? key, this.product, this.id}) : super(key: key);

  @override
  ConsumerState<CagesDetailScreen> createState() => _CagesDetailScreenState();
}

class _CagesDetailScreenState extends ConsumerState<CagesDetailScreen> {
  late Cages products;

  List<Gliders> gliders = [];
  int itemCount = 1;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      getData();
    } else {
      getDataFromScan();
    }
  }

  void getData() {
    products = widget.product!;
    var iterable = products.gliders!.map((e) => Gliders.fromJson(e)).toList();
    final List<Gliders> glider = iterable;
    gliders.addAll(glider);
  }

  Future<void> getDataFromScan() async {
    final snapshot = await FirebaseFirestore.instance.collection("cages").doc(widget.id).get();
    if (snapshot.exists) {
      final cage = Cages.fromJson(snapshot.data()!);
      setState(() {
        products = cage;
      });
    }
    // TODO: ADD GLIDERS FILTER HERE
  }

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(authControllerProvider);
    return Scaffold(
      backgroundColor: neutral,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.h),
        child: AppBar(
          primary: true,
          backgroundColor: whitish,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset("assets/icons/arrow-left-icon.png"),
          ),
          title: Text(
            "Detail Cages",
            style: appBarTitle,
          ),
          actions: [
            IconButton(
              onPressed: () async {
                // show qr code
                final directory = await getApplicationDocumentsDirectory();
                final path = directory.path;
                final file = File('$path/qr.png');
                final imageFile = await file.writeAsBytes(
                  (await QrPainter(
                    data: products.id!,
                    version: QrVersions.auto,
                    gapless: false,
                    color: Colors.black,
                    emptyColor: Colors.white,
                  ).toImageData(500))!
                      .buffer
                      .asUint8List(),
                );
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Image.file(imageFile),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              final success = await GallerySaver.saveImage(imageFile.path);
                              if (!mounted) return;
                              if (success == true) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Berhasil disimpan"),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Gagal disimpan"),
                                  ),
                                );
                              }
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                            child: const Text("Save"),
                          ),
                        ),
                        // share button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              await Share.shareXFiles(
                                [XFile(imageFile.path)],
                                subject: "QR Code",
                              );
                              if (!mounted) return;
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                            child: const Text("Share"),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              icon: Icon(
                Icons.qr_code_2_rounded,
                size: 26,
                color: black,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              // "https://i.pinimg.com/1200x/da/66/47/da6647f1615e67791fa6644d1a7663fa.jpg",
              products.images.toString(),
              width: 1.sw,
              height: 290.h,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    // "Pharma Hemp Chicken Treats",
                    products.title.toString().toUpperCase(),
                    style: productItemTitle,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "${products.gliders!.length} Ekor Gliders",
                    style: productItemRatingBlackGray,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Container(
              width: 1.sw,
              height: 1.h,
              color: gray,
            ),
            SizedBox(
              height: 16.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: productDescBigTitle,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Text(
                        "Kategori  ",
                        style: productDescSubTitleBlack,
                      ),
                      Text(
                        // "Kucing",
                        products.category.toString(),
                        style: productDescSubTitlePrimary,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Gliders",
                        style: productDescSubTitleBlack,
                      ),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: gliders.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('${index + 1}\t->\t', style: productDescSubTitlePrimary),
                                  Text(
                                    "Jenis ${gliders[index].name}",
                                    style: productDescSubTitlePrimary,
                                  ),
                                  Text(
                                    "Gender ${gliders[index].gender}",
                                    style: productDescSubTitlePrimary,
                                  ),
                                  Text(
                                    "${gliders[index].age} Bulan",
                                    style: productDescSubTitlePrimary,
                                  ),
                                ],
                              )),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Text(
                    // "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sit faucibus amet nullam cras volutpat. Consectetur dignissim lorem condimentum arcu sit. Ridiculus malesuada dolor ultrices semper erat suscipit eget.",
                    'Catatan\n${products.notes}',
                    style: productDescText,
                  ),
                  SizedBox(
                    height: 106.h,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 15.h),
        width: 1.sw,
        height: 72.h,
        decoration: BoxDecoration(color: whitish, boxShadow: [
          BoxShadow(color: black.withOpacity(0.10), blurRadius: 4, spreadRadius: 0, offset: const Offset(0, -2)),
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: SizedBox(
                width: 154.w,
                height: 42.h,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CagesAddScreen(isEdit: true, cages: widget.product),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Text(
                        "Edit",
                        style: productKeranjang,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: SizedBox(
                width: 154.w,
                height: 42.h,
                child: ElevatedButton(
                  onPressed: () {
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
                                  ref.read(cagesControllerProvider.notifier).delete(widget.product!.id.toString(),
                                      title: widget.product!.title.toString(),
                                      name: users.name.toString(),
                                      photo: users.photo.toString());
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          );
                        });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.delete_forever_rounded,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Text(
                        "Delete",
                        style: productKeranjang,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
