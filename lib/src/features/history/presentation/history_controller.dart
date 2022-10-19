import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gliders/src/features/history/domain/history.dart';

class HistoryController extends StateNotifier<List<History>> {
  HistoryController() : super(const []);

  final db = FirebaseFirestore.instance.collection('history').withConverter(
        fromFirestore: (snapshot, _) => History.fromJson(snapshot.data()!),
        toFirestore: (History history, _) => history.toJson(),
      );

  Future<void> getData() async {
    final data = await db.get();
    final cages = data.docs.map((e) => e.data()).toList();

    state = cages;
  }
}

final historyControllerProvider = StateNotifierProvider<HistoryController, List<History>>(
  (ref) => HistoryController(),
);
