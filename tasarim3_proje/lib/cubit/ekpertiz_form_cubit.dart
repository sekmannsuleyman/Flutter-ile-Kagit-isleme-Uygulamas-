import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasarim3_proje/data/repo/plakalardao_repository.dart';

class EkpertizFormCubit extends Cubit <void>{
  EkpertizFormCubit(): super(0);


  final krepo=PlakalardaoRepository();
  var collectionPlakaGiris= FirebaseFirestore.instance.collection("PlakaGiris");
  Future<void>kaydets (
  String ekspertizNo,
  String IrsaliyeNo,
  String malKabulTarihi,
  String Gelis_yeri,
  String Rutubet,
  String Ymadde,
  String MekanikHamur,
  String Kuse,
  String SinifDisi,
  String PRE,
  String Balya_Sayisi,
  String TSE,
  String Kabul,
  String Kagit_turu,
  String AciklamaKAh,
  String KARISIK,
  String KARISIKAdet,
  String KARISIKMIX,
  String KARISIKMIXAdet,
  String KIRPINTIOLUK,
  String KIRPINTIOLUKAdet,
  String KRAFTOLUK,
  String KRAFTOLUKAdet,
  String KramoKarton,
  String KramoKartonAdet,
  String MARKET,
  String MARKETAdet,
  String OCCA,
  String OCCAAdet,
  String OCCB,
  String OCCBAdet,
  String OCCC,
  String OCCCAdet,
  String PS11,
  String PS11Adet,
  String PS12,
  String PS12Adet,
  String SelulozKraft,
  String SelulozKraftAdet,
  String SIVAMAOLUKLU,
  String SIVAMAOLUKLUAdet,
  String AciklamaBey,
  String BirinciKAlite,
  String BirinciKAliteAdet,
  String IkinciKalite,
  String IkinciKaliteAdet,
  String UcuncuKalite,
  String UcuncuKaliteAdet,
  String BCKKIKI,
  String BCKKIKIAdet,
  String CokBaskiliKarisik,
  String CokBaskiliKarisikAdet,
  String EkstraBeyaz,
  String EkstraBeyazAdet,
  String AciklamaSel,
  String BCTMP,
  String BCTMPAdet,
  String BHKP,
  String BHKPADet,
  String BSKP,
  String BSKPAdet,
  String GroundWood,
  String GroundWoodAdet,
  String MpCtmp,
  String MpCtmpAdet,
  String UKP,
  String UKPAdet,
  String Aciklama_Yas,
  String YasMukavemetli,
  String YasMukavemetliAdet,
  String LikidAmbalaj,
  String LikidAmbalajAdet,
  String KartonBardak,
  String KartonBardakAdet,
  String AciklamaGaze,
  String KarisikMix,
  String KarisikMixAdet,
  String Iade,
  String IadeAdet,
  String Toplama,
  String ToplamaAdet,
  )async {
  await krepo.kaydets(
  ekspertizNo,
  IrsaliyeNo,
  malKabulTarihi,
  Gelis_yeri,
  Rutubet,
  Ymadde,
  MekanikHamur,
  Kuse,
  SinifDisi,
  PRE,
  Balya_Sayisi,
  TSE,
  Kabul,
  Kagit_turu,
  AciklamaKAh,
  KARISIK,
  KARISIKAdet,
  KARISIKMIX,
  KARISIKMIXAdet,
  KIRPINTIOLUK,
  KIRPINTIOLUKAdet,
  KRAFTOLUK,
  KRAFTOLUKAdet,
  KramoKarton,
  KramoKartonAdet,
  MARKET,
  MARKETAdet,
  OCCA,
  OCCAAdet,
  OCCB,
  OCCBAdet,
  OCCC,
  OCCCAdet,
  PS11,
  PS11Adet,
  PS12,
  PS12Adet,
  SelulozKraft,
  SelulozKraftAdet,
  SIVAMAOLUKLU,
  SIVAMAOLUKLUAdet,
  AciklamaBey,
  BirinciKAlite,
  BirinciKAliteAdet,
  IkinciKalite,
  IkinciKaliteAdet,
  UcuncuKalite,
  UcuncuKaliteAdet,
  BCKKIKI,
  BCKKIKIAdet,
  CokBaskiliKarisik,
  CokBaskiliKarisikAdet,
  EkstraBeyaz,
  EkstraBeyazAdet,
  AciklamaSel,
  BCTMP,
  BCTMPAdet,
  BHKP,
  BHKPADet,
  BSKP,
  BSKPAdet,
  GroundWood,
  GroundWoodAdet,
  MpCtmp,
  MpCtmpAdet,
  UKP,
  UKPAdet,
  Aciklama_Yas,
  YasMukavemetli,
  YasMukavemetliAdet,
  LikidAmbalaj,
  LikidAmbalajAdet,
  KartonBardak,
  KartonBardakAdet,
  AciklamaGaze,
  KarisikMix,
  KarisikMixAdet,
  Iade,
  IadeAdet,
  Toplama,
  ToplamaAdet,
  );

  }



}