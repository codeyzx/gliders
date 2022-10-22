import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gliders/src/features/cages/domain/cages/cages.dart';
import 'package:gliders/src/features/history/domain/history.dart';

class CagesController extends StateNotifier<List<Cages>> {
  CagesController() : super(const []);

  int cagesLength = 0;
  int koloniLength = 0;
  int soloLength = 0;
  int ipLength = 0;
  int glidersLength = 0;
  int glidersJantanLength = 0;
  int glidersBetinaLength = 0;
  int glidersAge4Length = 0;
  int glidersAge8Length = 0;
  int glidersAge12Length = 0;
  int glidersAge24Length = 0;

  final db = FirebaseFirestore.instance.collection('cages').withConverter(
        fromFirestore: (snapshot, _) => Cages.fromJson(snapshot.data()!),
        toFirestore: (Cages products, _) => products.toJson(),
      );

  final historyDb = FirebaseFirestore.instance.collection('history').withConverter(
        fromFirestore: (snapshot, _) => History.fromJson(snapshot.data()!),
        toFirestore: (History history, _) => history.toJson(),
      );

  Future<String> uploadImages(String imagesPath) async {
    final value = await FirebaseStorage.instance.ref().child('cages/${DateTime.now()}.png').putFile(File(imagesPath));
    return value.ref.getDownloadURL();
  }

  Future<void> add({
    required String title,
    required String category,
    required List<Map<String, dynamic>> gliders,
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

    final gliders = cages.map((e) => e.gliders).toList();
    final glidersTotal = gliders.map((e) => e!.length).toList();
    final glidersLengthTemp = glidersTotal.reduce((value, element) => value + element);

    final glidersJantan = gliders.map((e) => e!.where((element) => element.containsValue('jantan')).length).toList();
    final glidersJantanLengthTemp = glidersJantan.reduce((value, element) => value + element);

    final glidersBetina = gliders.map((e) => e!.where((element) => element.containsValue('betina')).length).toList();
    final glidersBetinaLengthTemp = glidersBetina.reduce((value, element) => value + element);

    final glidersAge = gliders.map((e) => e!.map((e) => e['age']).toList()).toList();
    final glidersAge2 = glidersAge.map((e) => e.map((e) => e).toList()).toList();
    final glidersAge3 = glidersAge2.map((e) => e.where((element) => element <= 4).toList()).toList();
    final glidersAge4 = glidersAge3.map((e) => e.length).toList();
    final glidersAge4LengthTemp = glidersAge4.reduce((value, element) => value + element);

    final glidersAge5 = glidersAge2.map((e) => e.where((element) => element > 4 && element <= 8).toList()).toList();
    final glidersAge6 = glidersAge5.map((e) => e.length).toList();
    final glidersAge8LengthTemp = glidersAge6.reduce((value, element) => value + element);

    final glidersAge7 = glidersAge2.map((e) => e.where((element) => element > 8 && element <= 12).toList()).toList();
    final glidersAge8 = glidersAge7.map((e) => e.length).toList();
    final glidersAge12LengthTemp = glidersAge8.reduce((value, element) => value + element);

    final glidersAge9 = glidersAge2.map((e) => e.where((element) => element > 12 && element <= 24).toList()).toList();
    final glidersAge10 = glidersAge9.map((e) => e.length).toList();
    final glidersAge24LengthTemp = glidersAge10.reduce((value, element) => value + element);

    cagesLength = cages.length;
    koloniLength = koloni;
    soloLength = solo;
    ipLength = ip;
    glidersLength = glidersLengthTemp;
    glidersJantanLength = glidersJantanLengthTemp;
    glidersBetinaLength = glidersBetinaLengthTemp;
    glidersAge4Length = glidersAge4LengthTemp;
    glidersAge8Length = glidersAge8LengthTemp;
    glidersAge12Length = glidersAge12LengthTemp;
    glidersAge24Length = glidersAge24LengthTemp;

    state = cages;
  }
}

final cagesControllerProvider = StateNotifierProvider<CagesController, List<Cages>>(
  (ref) => CagesController(),
);
