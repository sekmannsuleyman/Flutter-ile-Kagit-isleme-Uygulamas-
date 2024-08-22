import 'dart:collection';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../entity/plaka_giris.dart';

var collectionEkpertizId= FirebaseFirestore.instance.collection("EkpertizId");
var collectionPlakaGiris= FirebaseFirestore.instance.collection("PlakaGiris");





class PlakalardaoRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<List<String>> getPlakalar() async {
    try {
      final snapshot = await _firestore.collection('EkpertizId').get();
      return snapshot.docs.map((doc) => doc['plaka_no'] as String).toList();
    } catch (e) {
      print("Plakalar alınırken hata oluştu: $e");
      return [];
    }
  }

  Future<String?> kaydetl(String plakaNo) async {
    try {
      final docRef = await _firestore.collection('EkpertizId').add({
        'plaka_no': plakaNo,
        // Diğer gerekli alanlar
      });
      return docRef.id;
    } catch (e) {
      print("Plaka kaydedilirken hata oluştu: $e");
      return null;
    }
  }


  Future<String> kaydet(String plaka_no) async {
    var yenisBilgi = HashMap<String, dynamic>();
    yenisBilgi["plaka_no"] = plaka_no;


    // Rastgele bir ekspertiz numarası oluştur
    var random = Random();
    int rastgeleEkspertizNo = random.nextInt(
        100000); // 0 ile 99999 arasında rastgele bir sayı
    String ekspertizNo = rastgeleEkspertizNo.toString().padLeft(5, '0');

    // Ekspertiz numarasını ekle
    yenisBilgi["ekpertiz_no"] = ekspertizNo;
    collectionEkpertizId.add(yenisBilgi);
    // Veritabanına ekle
    try {
      print("Veri başarıyla eklendi: $yenisBilgi");
      return ekspertizNo; // Üretilen ekspertiz numarasını döndür
    } catch (e) {
      print("Hata oluştu: $e");
      return ""; // Hata durumunda boş bir string döndür
    }
  }

  final FirebaseFirestore _firestor = FirebaseFirestore.instance;

  Future<List<String>> getEkpertizNumaralari() async {
    try {
      final snapshot = await _firestor.collection('EkpertizId').get();
      return snapshot.docs.map((doc) => doc['ekpertiz_no'] as String).toList();
    } catch (e) {
      print("Veriler çekilirken hata oluştu: $e");
      return [];
    }
  }

  Future<PlakaGiris?> getPlakaGirisByEkpertizNo(String ekpertizNo) async {
    try {
      final querySnapshot = await _firestore
          .collection('PlakaGiris')
          .where('ekpertiz_no', isEqualTo: ekpertizNo)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        final data = doc.data() as Map<String, dynamic>;
        // Modelinize uygun olarak JSON verilerini dönüştürün
        return PlakaGiris.fromJson(data, ekpertizNo);
      } else {
        print("Belirtilen ekspertiz numarası bulunamadı.");
        return null;
      }
    } catch (e) {
      print("Veri çekme hatası: $e");
      return null;
    }
  }


  Future<void> silEkpertizNo(String ekpertizNo) async {
    try {
      final snapshot = await _firestore.collection('EkpertizId').where(
          'ekpertiz_no', isEqualTo: ekpertizNo).get();
      if (snapshot.docs.isNotEmpty) {
        await _firestore.collection('EkpertizId')
            .doc(snapshot.docs.first.id)
            .delete();
      }
    } catch (e) {
      print("Ekspertiz numarası silinirken hata oluştu: $e");
    }
  }

  Future<String> yeniEkpertizNoOlustur(String plakaNo) async {
    // Rastgele bir ekspertiz numarası oluştur
    var random = Random();
    int rastgeleEkspertizNo = random.nextInt(
        100000); // 0 ile 99999 arasında rastgele bir sayı
    String ekspertizNo = rastgeleEkspertizNo.toString().padLeft(5, '0');

    // Ekspertiz numarasını ekle
    var yeniKisi = <String, dynamic>{
      "plaka_no": plakaNo,
      "ekpertiz_no": ekspertizNo,
    };

    // Veritabanına ekle
    try {
      print("Yeni ekspertiz numarası başarıyla eklendi: $yeniKisi");
      return ekspertizNo; // Üretilen ekspertiz numarasını döndür
    } catch (e) {
      print("Hata oluştu: $e");
      return ""; // Hata durumunda boş bir string döndür
    }
  }


  Future<void> kaydets(String ekspertizNo,
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
      String ToplamaAdet,) async {
    var yeniBilgi = HashMap<String, dynamic>();
    yeniBilgi["ekspertizid"] = "";
    yeniBilgi["ekspertizNo"] = ekspertizNo;
    yeniBilgi["IrsaliyeNo"] = IrsaliyeNo;
    yeniBilgi["malKabulTarihi"] = malKabulTarihi;
    yeniBilgi["Gelis_yeri"] = Gelis_yeri;
    yeniBilgi["Rutubet"] = Rutubet;
    yeniBilgi["Ymadde"] = Ymadde;
    yeniBilgi["MekanikHamur"] = MekanikHamur;
    yeniBilgi["Kuse"] = Kuse;
    yeniBilgi["SinifDisi"] = SinifDisi;
    yeniBilgi["PRE"] = PRE;
    yeniBilgi["Balya_Sayisi"] = Balya_Sayisi;
    yeniBilgi["TSE"] = TSE;
    yeniBilgi["Kabul"] = Kabul;
    yeniBilgi["Kagit_turu"] = Kagit_turu;
    yeniBilgi["AciklamaKAh"] = AciklamaKAh;
    yeniBilgi["KARISIK"] = KARISIK;
    yeniBilgi["KARISIKAdet"] = KARISIKAdet;
    yeniBilgi["KARISIKMIX"] = KARISIKMIX;
    yeniBilgi["KARISIKMIXAdet"] = KARISIKMIXAdet;
    yeniBilgi["KIRPINTIOLUK"] = KIRPINTIOLUK;
    yeniBilgi["KIRPINTIOLUKAdet"] = KIRPINTIOLUKAdet;
    yeniBilgi["KRAFTOLUK"] = KRAFTOLUK;
    yeniBilgi["KRAFTOLUKAdet"] = KRAFTOLUKAdet;
    yeniBilgi["KramoKarton"] = KramoKarton;
    yeniBilgi["KramoKartonAdet"] = KramoKartonAdet;
    yeniBilgi["MARKET"] = MARKET;
    yeniBilgi["MARKETAdet"] = MARKETAdet;
    yeniBilgi["OCCA"] = OCCA;
    yeniBilgi["OCCAAdet"] = OCCAAdet;
    yeniBilgi["OCCB"] = OCCB;
    yeniBilgi["OCCBAdet"] = OCCBAdet;
    yeniBilgi["OCCC"] = OCCC;
    yeniBilgi["OCCCAdet"] = OCCCAdet;
    yeniBilgi["PS11"] = PS11;
    yeniBilgi["PS11Adet"] = PS11Adet;
    yeniBilgi["PS12"] = PS12;
    yeniBilgi["PS12Adet"] = PS12Adet;
    yeniBilgi["SelulozKraft"] = SelulozKraft;
    yeniBilgi["SelulozKraftAdet"] = SelulozKraftAdet;
    yeniBilgi["SIVAMAOLUKLU"] = SIVAMAOLUKLU;
    yeniBilgi["SIVAMAOLUKLUAdet"] = SIVAMAOLUKLUAdet;
    yeniBilgi["AciklamaBey"] = AciklamaBey;
    yeniBilgi["BirinciKAlite"] = BirinciKAlite;
    yeniBilgi["BirinciKAliteAdet"] = BirinciKAliteAdet;
    yeniBilgi["IkinciKalite"] = IkinciKalite;
    yeniBilgi["IkinciKaliteAdet"] = IkinciKaliteAdet;
    yeniBilgi["UcuncuKalite"] = UcuncuKalite;
    yeniBilgi["UcuncuKaliteAdet"] = UcuncuKaliteAdet;
    yeniBilgi["BCKKIKI"] = BCKKIKI;
    yeniBilgi["BCKKIKIAdet"] = BCKKIKIAdet;
    yeniBilgi["CokBaskiliKarisik"] = CokBaskiliKarisik;
    yeniBilgi["CokBaskiliKarisikAdet"] = CokBaskiliKarisikAdet;
    yeniBilgi["EkstraBeyaz"] = EkstraBeyaz;
    yeniBilgi["EkstraBeyazAdet"] = EkstraBeyazAdet;
    yeniBilgi["AciklamaSel"] = AciklamaSel;
    yeniBilgi["BCTMP"] = BCTMP;
    yeniBilgi["BCTMPAdet"] = BCTMPAdet;
    yeniBilgi["BHKP"] = BHKP;
    yeniBilgi["BHKPADet"] = BHKPADet;
    yeniBilgi["BSKP"] = BSKP;
    yeniBilgi["BSKPAdet"] = BSKPAdet;
    yeniBilgi["GroundWood"] = GroundWood;
    yeniBilgi["GroundWoodAdet"] = GroundWoodAdet;
    yeniBilgi["MpCtmp"] = MpCtmp;
    yeniBilgi["MpCtmpAdet"] = MpCtmpAdet;
    yeniBilgi["UKP"] = UKP;
    yeniBilgi["UKPAdet"] = UKPAdet;
    yeniBilgi["Aciklama_Yas"] = Aciklama_Yas;
    yeniBilgi["YasMukavemetli"] = YasMukavemetli;
    yeniBilgi["YasMukavemetliAdet"] = YasMukavemetliAdet;
    yeniBilgi["LikidAmbalaj"] = LikidAmbalaj;
    yeniBilgi["LikidAmbalajAdet"] = LikidAmbalajAdet;
    yeniBilgi["KartonBardak"] = KartonBardak;
    yeniBilgi["KartonBardakAdet"] = KartonBardakAdet;
    yeniBilgi["AciklamaGaze"] = AciklamaGaze;
    yeniBilgi["KarisikMix"] = KarisikMix;
    yeniBilgi["KarisikMixAdet"] = KarisikMixAdet;
    yeniBilgi["Iade"] = Iade;
    yeniBilgi["IadeAdet"] = IadeAdet;
    yeniBilgi["Toplama"] = Toplama;
    yeniBilgi["ToplamaAdet"] = ToplamaAdet;

    collectionPlakaGiris.add(yeniBilgi);
  }

  Future<void> guncelle(String ekspertizid,
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
      String ToplamaAdet,) async {
    var yeniBilgis = HashMap<String, dynamic>();

    yeniBilgis["ekspertizid"] = "";
    yeniBilgis["ekspertizNo"] = ekspertizNo;
    yeniBilgis["IrsaliyeNo"] = IrsaliyeNo;
    yeniBilgis["malKabulTarihi"] = malKabulTarihi;
    yeniBilgis["Gelis_yeri"] = Gelis_yeri;
    yeniBilgis["Rutubet"] = Rutubet;
    yeniBilgis["Ymadde"] = Ymadde;
    yeniBilgis["MekanikHamur"] = MekanikHamur;
    yeniBilgis["Kuse"] = Kuse;
    yeniBilgis["SinifDisi"] = SinifDisi;
    yeniBilgis["PRE"] = PRE;
    yeniBilgis["Balya_Sayisi"] = Balya_Sayisi;
    yeniBilgis["TSE"] = TSE;
    yeniBilgis["Kabul"] = Kabul;
    yeniBilgis["Kagit_turu"] = Kagit_turu;
    yeniBilgis["AciklamaKAh"] = AciklamaKAh;
    yeniBilgis["KARISIK"] = KARISIK;
    yeniBilgis["KARISIKAdet"] = KARISIKAdet;
    yeniBilgis["KARISIKMIX"] = KARISIKMIX;
    yeniBilgis["KARISIKMIXAdet"] = KARISIKMIXAdet;
    yeniBilgis["KIRPINTIOLUK"] = KIRPINTIOLUK;
    yeniBilgis["KIRPINTIOLUKAdet"] = KIRPINTIOLUKAdet;
    yeniBilgis["KRAFTOLUK"] = KRAFTOLUK;
    yeniBilgis["KRAFTOLUKAdet"] = KRAFTOLUKAdet;
    yeniBilgis["KramoKarton"] = KramoKarton;
    yeniBilgis["KramoKartonAdet"] = KramoKartonAdet;
    yeniBilgis["MARKET"] = MARKET;
    yeniBilgis["MARKETAdet"] = MARKETAdet;
    yeniBilgis["OCCA"] = OCCA;
    yeniBilgis["OCCAAdet"] = OCCAAdet;
    yeniBilgis["OCCB"] = OCCB;
    yeniBilgis["OCCBAdet"] = OCCBAdet;
    yeniBilgis["OCCC"] = OCCC;
    yeniBilgis["OCCCAdet"] = OCCCAdet;
    yeniBilgis["PS11"] = PS11;
    yeniBilgis["PS11Adet"] = PS11Adet;
    yeniBilgis["PS12"] = PS12;
    yeniBilgis["PS12Adet"] = PS12Adet;
    yeniBilgis["SelulozKraft"] = SelulozKraft;
    yeniBilgis["SelulozKraftAdet"] = SelulozKraftAdet;
    yeniBilgis["SIVAMAOLUKLU"] = SIVAMAOLUKLU;
    yeniBilgis["SIVAMAOLUKLUAdet"] = SIVAMAOLUKLUAdet;
    yeniBilgis["AciklamaBey"] = AciklamaBey;
    yeniBilgis["BirinciKAlite"] = BirinciKAlite;
    yeniBilgis["BirinciKAliteAdet"] = BirinciKAliteAdet;
    yeniBilgis["IkinciKalite"] = IkinciKalite;
    yeniBilgis["IkinciKaliteAdet"] = IkinciKaliteAdet;
    yeniBilgis["UcuncuKalite"] = UcuncuKalite;
    yeniBilgis["UcuncuKaliteAdet"] = UcuncuKaliteAdet;
    yeniBilgis["BCKKIKI"] = BCKKIKI;
    yeniBilgis["BCKKIKIAdet"] = BCKKIKIAdet;
    yeniBilgis["CokBaskiliKarisik"] = CokBaskiliKarisik;
    yeniBilgis["CokBaskiliKarisikAdet"] = CokBaskiliKarisikAdet;
    yeniBilgis["EkstraBeyaz"] = EkstraBeyaz;
    yeniBilgis["EkstraBeyazAdet"] = EkstraBeyazAdet;
    yeniBilgis["AciklamaSel"] = AciklamaSel;
    yeniBilgis["BCTMP"] = BCTMP;
    yeniBilgis["BCTMPAdet"] = BCTMPAdet;
    yeniBilgis["BHKP"] = BHKP;
    yeniBilgis["BHKPADet"] = BHKPADet;
    yeniBilgis["BSKP"] = BSKP;
    yeniBilgis["BSKPAdet"] = BSKPAdet;
    yeniBilgis["GroundWood"] = GroundWood;
    yeniBilgis["GroundWoodAdet"] = GroundWoodAdet;
    yeniBilgis["MpCtmp"] = MpCtmp;
    yeniBilgis["MpCtmpAdet"] = MpCtmpAdet;
    yeniBilgis["UKP"] = UKP;
    yeniBilgis["UKPAdet"] = UKPAdet;
    yeniBilgis["Aciklama_Yas"] = Aciklama_Yas;
    yeniBilgis["YasMukavemetli"] = YasMukavemetli;
    yeniBilgis["YasMukavemetliAdet"] = YasMukavemetliAdet;
    yeniBilgis["LikidAmbalaj"] = LikidAmbalaj;
    yeniBilgis["LikidAmbalajAdet"] = LikidAmbalajAdet;
    yeniBilgis["KartonBardak"] = KartonBardak;
    yeniBilgis["KartonBardakAdet"] = KartonBardakAdet;
    yeniBilgis["AciklamaGaze"] = AciklamaGaze;
    yeniBilgis["KarisikMix"] = KarisikMix;
    yeniBilgis["KarisikMixAdet"] = KarisikMixAdet;
    yeniBilgis["Iade"] = Iade;
    yeniBilgis["IadeAdet"] = IadeAdet;
    yeniBilgis["Toplama"] = Toplama;
    yeniBilgis["ToplamaAdet"] = ToplamaAdet;
    collectionPlakaGiris.doc(ekspertizid).update(yeniBilgis);
  }

}



