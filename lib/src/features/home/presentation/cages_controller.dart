import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gliders/src/features/cages/domain/cages/cages.dart';
import 'package:gliders/src/features/history/domain/history.dart';

class CagesController extends StateNotifier<List<Cages>> {
  CagesController() : super(const []);

  int cagesLength = 0;
  int koloniLength = 0;
  int soloLength = 0;
  int ipLength = 0;
  int othersLength = 0;

  final db = FirebaseFirestore.instance.collection('cages').withConverter(
        fromFirestore: (snapshot, _) => Cages.fromJson(snapshot.data()!),
        toFirestore: (Cages products, _) => products.toJson(),
      );

  final historyDb = FirebaseFirestore.instance.collection('history').withConverter(
        fromFirestore: (snapshot, _) => History.fromJson(snapshot.data()!),
        toFirestore: (History history, _) => history.toJson(),
      );

  Future<void> add({
    required String title,
    required String category,
    required List<String> gliders,
    required String images,
    required String notes,
    required String name,
    required String photo,
  }) async {
    final docs = db.doc();
    final historyDocs = historyDb.doc();
    final cages = Cages(
      id: docs.id,
      title: title,
      category: category,
      gliders: gliders,
      images: images,
      notes: notes,
    );
    final history = History(
      id: historyDocs.id,
      name: name,
      photo: photo,
      cages: title,
      cagesId: docs.id,
      time: DateTime.now().millisecondsSinceEpoch.toString(),
      log: 'add',
    );

    await docs.set(cages);
    await historyDocs.set(history);
    await getData();
  }

  Future<void> update(
    Cages? cages, {
    required String name,
    required String photo,
  }) async {
    final docs = db.doc(cages?.id);
    final historyDocs = historyDb.doc();
    final history = History(
      id: historyDocs.id,
      name: name,
      photo: photo,
      cages: cages?.title,
      cagesId: cages?.id,
      time: DateTime.now().millisecondsSinceEpoch.toString(),
      log: 'update',
    );

    await docs.update({
      'title': cages?.title,
      'category': cages?.category,
      'gliders': cages?.gliders,
      'images': cages?.images,
      'notes': cages?.notes,
    });
    await historyDocs.set(history);
    await getData();
  }

  Future<void> delete(
    String id, {
    required String name,
    required String photo,
    required String title,
  }) async {
    final docs = db.doc(id);
    await docs.delete();

    final historyDocs = historyDb.doc();
    final history = History(
      id: historyDocs.id,
      name: name,
      photo: photo,
      cages: title,
      cagesId: id,
      time: DateTime.now().millisecondsSinceEpoch.toString(),
      log: 'delete',
    );

    await historyDocs.set(history);
    await getData();
  }

  Future<void> getData() async {
    final data = await db.get();
    final cages = data.docs.map((e) => e.data()).toList();

    // final nyoba = cages.map(
    //   (e) => glidersLength++,
    // );
    // glidersLength += nyoba.length;

    final koloni = cages.where((e) => e.category == 'koloni').toList().length;
    final solo = cages.where((e) => e.category == 'solo').toList().length;
    final ip = cages.where((e) => e.category == 'ip').toList().length;
    final others = cages.where((e) => e.category == 'others').toList().length;

    cagesLength = cages.length;
    koloniLength = koloni;
    soloLength = solo;
    ipLength = ip;
    othersLength = others;

    state = cages;
  }
}

final cagesControllerProvider = StateNotifierProvider<CagesController, List<Cages>>(
  (ref) => CagesController(),
);
