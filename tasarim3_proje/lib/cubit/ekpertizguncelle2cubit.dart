import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasarim3_proje/data/entity/ekpertiz_id.dart';
import 'package:tasarim3_proje/data/repo/plakalardao_repository.dart';

class Ekpertizguncelle2cubit extends Cubit<List<EkpertizId>> {
  Ekpertizguncelle2cubit() : super(<EkpertizId>[]);

  PlakalardaoRepository krepo = PlakalardaoRepository();
  CollectionReference collectionPlakaGiris = FirebaseFirestore.instance.collection("EkpertizId");

  Future<void> Ekpertizid() async {
    collectionPlakaGiris.snapshots().listen((event) {
      var bilgiler = <EkpertizId>[];
      var documents = event.docs;

      for (var document in documents) {
        var key = document.id;
        var data = document.data() as Map<String, dynamic>;

        // EkpertizId.fromJson ile EkpertizId nesnesi oluşturuluyor
        var ekpertizId = EkpertizId.fromJson(data, key);
        bilgiler.add(ekpertizId);

      }

      emit(bilgiler);
    });
  }



}
