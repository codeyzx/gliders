import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gliders/src/features/history/domain/history.dart';
import 'package:gliders/src/features/history/presentation/history_controller.dart';
import 'package:gliders/src/shared/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  static const routeName = '/history';
  const HistoryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  final List<bool> _isSelected = [true, false, false, false];
  List<History> history = [];
  List<History> historyFilter = [];

  @override
  void initState() {
    super.initState();
    initCages();
  }

  Future<void> initCages() async {
    final returnCages = ref.read(historyControllerProvider);
    setState(() {
      history.addAll(returnCages);
      historyFilter.addAll(returnCages);
    });
  }

  @override
  Widget build(BuildContext context) {
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Filter',
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
                        labelPadding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 24.w),
                        label: Text(
                          'All',
                          style: _isSelected[0] ? chipSelected : chipUnSelected,
                        ),
                        selected: _isSelected[0],
                        onSelected: (newBoolValue) {
                          setState(() {
                            if (_isSelected[0] == false) {
                              _isSelected[0] = true;
                              _isSelected[1] = false;
                              _isSelected[2] = false;
                              _isSelected[3] = false;

                              history.clear();
                              history.addAll(historyFilter);
                            }
                            // articles.clear();
                            // articles.addAll(article);
                          });
                        },
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      ChoiceChip(
                        selectedColor: primary,
                        labelPadding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 24.w),
                        label: Text(
                          'Add',
                          style: _isSelected[1] ? chipSelected : chipUnSelected,
                        ),
                        selected: _isSelected[1],
                        onSelected: (newBoolValue) {
                          setState(() {
                            if (_isSelected[1] == false) {
                              _isSelected[1] = true;
                              _isSelected[0] = false;
                              _isSelected[2] = false;
                              _isSelected[3] = false;

                              final koloni = historyFilter.where((element) => element.log == 'add').toList();
                              history.clear();
                              history.addAll(koloni);
                            }
                            // articles.clear();
                            // articles.addAll(article);
                          });
                        },
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      ChoiceChip(
                        selectedColor: primary,
                        labelPadding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 24.w),
                        label: Text(
                          'Update',
                          style: _isSelected[2] ? chipSelected : chipUnSelected,
                        ),
                        selected: _isSelected[2],
                        onSelected: (newBoolValue) {
                          setState(() {
                            if (_isSelected[2] == false) {
                              _isSelected[2] = true;
                              _isSelected[0] = false;
                              _isSelected[1] = false;
                              _isSelected[3] = false;

                              final solo = historyFilter.where((element) => element.log == 'update').toList();
                              history.clear();
                              history.addAll(solo);
                            }
                            // articles.clear();
                            // articles.addAll(article);
                          });
                        },
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      ChoiceChip(
                        selectedColor: primary,
                        labelPadding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 24.w),
                        label: Text(
                          'Delete',
                          style: _isSelected[3] ? chipSelected : chipUnSelected,
                        ),
                        selected: _isSelected[3],
                        onSelected: (newBoolValue) {
                          setState(() {
                            if (_isSelected[3] == false) {
                              _isSelected[3] = true;
                              _isSelected[0] = false;
                              _isSelected[1] = false;
                              _isSelected[2] = false;

                              final ip = historyFilter.where((element) => element.log == 'delete').toList();
                              history.clear();
                              history.addAll(ip);
                            }
                            // articles.clear();
                            // articles.addAll(article);
                          });
                        },
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 1.sw,
              height: 1.sh * 0.7,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: history.length,
                itemBuilder: (context, index) {
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
                },
              ),
            ),
          ],
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
