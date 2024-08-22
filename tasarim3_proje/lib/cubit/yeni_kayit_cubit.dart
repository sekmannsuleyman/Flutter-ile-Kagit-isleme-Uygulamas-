import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasarim3_proje/data/repo/plakalardao_repository.dart';

class YeniKayitCubit extends Cubit<void> {
  YeniKayitCubit() : super(0);

  final PlakalardaoRepository krepo = PlakalardaoRepository();
  var collectionEkpertizId= FirebaseFirestore.instance.collection("EkpertizId");

  final krepoo=PlakalardaoRepository();
  Future<void>kaydet (String plaka_no) async{
  await krepoo.kaydet( plaka_no);
  }





}
