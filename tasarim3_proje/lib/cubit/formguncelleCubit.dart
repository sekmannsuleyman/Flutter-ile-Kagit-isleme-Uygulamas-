import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasarim3_proje/data/entity/plaka_giris.dart';

class FormGuncelleCubit extends Cubit<List<PlakaGiris>> {
  FormGuncelleCubit() : super([]);

  // Firestore koleksiyonuna erişim sağlamak için bir referans oluşturun
  final CollectionReference collectionPlakaGiris = FirebaseFirestore.instance.collection('PlakaGiris');

  Future<void> BilgileriYukle() async {
    try {
      // Firestore'dan verileri alın
      var snapshot = await collectionPlakaGiris.get();
      var bilgi = <PlakaGiris>[];
      var documents = snapshot.docs;

      for (var document in documents) {
        var key = document.id;
        var data = document.data() as Map<String, dynamic>;
        var bilgiler = PlakaGiris.fromJson(data, key);
        bilgi.add(bilgiler);
      }

      // Verileri emite edin
      emit(bilgi);
    } catch (e) {
      // Hata durumunda uygun bir hata mesajı veya işleme yapılabilir
      print("Hata: $e");
    }
  }
}
