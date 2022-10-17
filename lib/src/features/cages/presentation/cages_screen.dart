import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gliders/src/features/cages/presentation/cages_add_screen.dart';
import 'package:gliders/src/features/cages/presentation/cages_detail_screen.dart';
import 'package:gliders/src/features/home/presentation/cages_controller.dart';
import 'package:gliders/src/shared/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class CagesScreen extends ConsumerStatefulWidget {
  static const routeName = '/cages';
  const CagesScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CagesScreenState();
}

class _CagesScreenState extends ConsumerState<CagesScreen> {
  @override
  Widget build(BuildContext context) {
    final cages = ref.watch(cagesControllerProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          tooltip: 'Back',
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: HexColor('EBEDEE'),
            prefixIcon: IconButton(
              icon: const Icon(Icons.search_rounded),
              onPressed: () {},
            ),
            iconColor: Colors.black,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent, width: 0),
              borderRadius: BorderRadius.circular(10.r),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent, width: 0),
              borderRadius: BorderRadius.circular(10.r),
            ),
            labelText: "Search by Username",
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              tooltip: 'Add Cages',
              icon: const Icon(
                Icons.add,
                color: Colors.black,
                size: 32,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CagesAddScreen(isEdit: false),
                    ));
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Categories',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ChoiceChip(
                        selectedColor: primary,
                        labelPadding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 18.w),
                        label: Text(
                          'All',
                          style: chipSelected,
                        ),
                        selected: true,
                        onSelected: (newBoolValue) {
                          setState(() {
                            // false = newBoolValue;
                            // articles.clear();
                            // articles.addAll(article);
                          });
                        },
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      ChoiceChip(
                        selectedColor: primary,
                        labelPadding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 18.w),
                        label: Text(
                          'Koloni',
                          style: chipUnSelected,
                        ),
                        selected: false,
                        onSelected: (newBoolValue) {
                          setState(() {
                            // false = newBoolValue;
                            // final sort = article.where((element) => element.isRead == false).toList();

                            // articles.clear();
                            // articles.addAll(sort);
                          });
                        },
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      ChoiceChip(
                        selectedColor: primary,
                        labelPadding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 18.w),
                        label: Text(
                          'Solo',
                          style: chipUnSelected,
                        ),
                        selected: false,
                        onSelected: (newBoolValue) {
                          setState(() {
                            // false = newBoolValue;
                            // final sort = article.where((element) => element.isRead == false).toList();

                            // articles.clear();
                            // articles.addAll(sort);
                          });
                        },
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      ChoiceChip(
                        selectedColor: primary,
                        labelPadding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 18.w),
                        label: Text(
                          'IP',
                          style: chipUnSelected,
                        ),
                        selected: false,
                        onSelected: (newBoolValue) {
                          setState(() {
                            // false = newBoolValue;
                            // final sort = article.where((element) => element.isRead == false).toList();

                            // articles.clear();
                            // articles.addAll(sort);
                          });
                        },
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      PopupMenuButton(
                        itemBuilder: (context) => [
                          const PopupMenuItem(child: Text('Solo IP')),
                          const PopupMenuItem(child: Text('Solo OP')),
                        ],
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 15.w),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.4),
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Others',
                                style: chipUnSelected,
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: HexColor('#626262'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 260, mainAxisSpacing: 10, crossAxisSpacing: 5, crossAxisCount: 2),
              itemCount: cages.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CagesDetailScreen(cages: cages[index]),
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
                                cages[index].images.toString(),
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
                                cages[index].title.toString().toUpperCase(),
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
                                    cages[index].category.toString(),
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(cages[index].gliders!.join(", "), style: GoogleFonts.poppins(fontSize: 12)),
                            ],
                          ),
                        )
                      ],
                    ),
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
