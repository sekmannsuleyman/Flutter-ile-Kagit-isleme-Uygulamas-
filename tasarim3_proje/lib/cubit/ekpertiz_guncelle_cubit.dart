import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasarim3_proje/data/entity/plaka_giris.dart';
import 'package:tasarim3_proje/data/repo/plakalardao_repository.dart';

class EkpertizGuncelleCubit extends Cubit <List<PlakaGiris>>{
  EkpertizGuncelleCubit():super(<PlakaGiris>[]);

var krepo= PlakalardaoRepository();
  var collectionPlakaGiris= FirebaseFirestore.instance.collection("PlakaGiris");


  Future<void> BilgileriYukle() async{
 collectionPlakaGiris.snapshots().listen((event){
  var bilgi=<PlakaGiris>[];
  var documents =event.docs;

  for(var document in documents){

    var key = document.id;
    var data= document.data();
    var bilgiler = PlakaGiris.fromJson(data, key);
    bilgi.add(bilgiler);
  }

  emit(bilgi);
 });

  }





















}
