import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gliders/src/features/cages/domain/cages/cages.dart';
import 'package:logger/logger.dart';

class CagesScanScreen extends ConsumerStatefulWidget {
  final String id;
  const CagesScanScreen({super.key, required this.id});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CagesScanScreenState();
}

class _CagesScanScreenState extends ConsumerState<CagesScanScreen> {
  Cages? cages;
  @override
  void initState() {
    super.initState();
    getCages();
  }

  Future<void> getCages() async {
    final snapshot = await FirebaseFirestore.instance.collection("cages").doc(widget.id).get();
    if (snapshot.exists) {
      final cage = Cages.fromJson(snapshot.data()!);
      setState(() {
        cages = cage;
      });
      Logger().i(cage);
    }
    Logger().i(cages);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cages'),
      ),
      body: Card(
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
                color: categoryColors(cages?.category.toString().toLowerCase()),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cages?.title.toString() ?? '',
                      style: const TextStyle(
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
                          cages?.category.toString() ?? '',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Column(
                        children: List.generate(
                      cages?.gliders!.length ?? 0,
                      (index) => Text(
                        cages?.gliders![index].toString() ?? '',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Color categoryColors(String? category) {
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
