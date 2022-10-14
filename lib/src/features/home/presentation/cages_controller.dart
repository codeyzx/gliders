import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gliders/src/features/home/domain/cages/cages.dart';

class CagesController extends StateNotifier<List<Cages>> {
  CagesController() : super(const []);

  int glidersLength = 0;

  final db = FirebaseFirestore.instance.collection('cages').withConverter(
        fromFirestore: (snapshot, _) => Cages.fromJson(snapshot.data()!),
        toFirestore: (Cages products, _) => products.toJson(),
      );

  Future<void> add({
    required String title,
    required String category,
    required List<String> gliders,
    required String images,
    required String notes,
  }) async {
    final docs = db.doc();
    final cages = Cages(
      id: docs.id,
      title: title,
      category: category,
      gliders: gliders,
      images: images,
      notes: notes,
    );
    await docs.set(cages);
    await getData();
  }

  Future<void> update(Cages? cages) async {
    final docs = db.doc(cages?.id);
    await docs.update({
      'title': cages?.title,
      'category': cages?.category,
      'gliders': cages?.gliders,
      'images': cages?.images,
      'notes': cages?.notes,
    });
    await getData();
  }

  Future<void> delete(String id) async {
    final docs = db.doc(id);
    await docs.delete();
    await getData();
  }

  Future<void> getData() async {
    final data = await db.get();
    final cages = data.docs.map((e) => e.data()).toList();

    final nyoba = cages.map(
      (e) => glidersLength++,
    );
    glidersLength += nyoba.length;
    state = cages;
  }
}

final cagesControllerProvider = StateNotifierProvider<CagesController, List<Cages>>(
  (ref) => CagesController(),
);
