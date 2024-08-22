class PlakaGiris {
 String ekspertizid;
 String ekspertizNo;
 String IrsaliyeNo;
 String malKabulTarihi;
 String Gelis_yeri;
 String Rutubet;
 String Ymadde;
 String MekanikHamur;
 String Kuse;
 String SinifDisi;
 String PRE;
 String Balya_Sayisi;
 String TSE;
 String Kabul;
 String Kagit_turu;
 String AciklamaKAh;
 String KARISIK;
 String KARISIKAdet;
 String KARISIKMIX;
 String KARISIKMIXAdet;
 String KIRPINTIOLUK;
 String KIRPINTIOLUKAdet;
 String KRAFTOLUK;
 String KRAFTOLUKAdet;
 String KramoKarton;
 String KramoKartonAdet;
 String MARKET;
 String MARKETAdet;
 String OCCA;
 String OCCAAdet;
 String OCCB;
 String OCCBAdet;
 String OCCC;
 String OCCCAdet;
 String PS11;
 String PS11Adet;
 String PS12;
 String PS12Adet;
 String SelulozKraft;
 String SelulozKraftAdet;
 String SIVAMAOLUKLU;
 String SIVAMAOLUKLUAdet;
 String AciklamaBey;
 String BirinciKAlite;
 String BirinciKAliteAdet;
 String IkinciKalite;
 String IkinciKaliteAdet;
 String UcuncuKalite;
 String UcuncuKaliteAdet;
 String BCKKIKI;
 String BCKKIKIAdet;
 String CokBaskiliKarisik;
 String CokBaskiliKarisikAdet;
 String EkstraBeyaz;
 String EkstraBeyazAdet;
 String AciklamaSel;
 String BCTMP;
 String BCTMPAdet;
 String BHKP;
 String BHKPADet;
 String BSKP;
 String BSKPAdet;
 String GroundWood;
 String GroundWoodAdet;
 String MpCtmp;
 String MpCtmpAdet;
 String UKP;
 String UKPAdet;
 String Aciklama_Yas;
 String YasMukavemetli;
 String YasMukavemetliAdet;
 String LikidAmbalaj;
 String LikidAmbalajAdet;
 String KartonBardak;
 String KartonBardakAdet;
 String AciklamaGaze;
 String KarisikMix;
 String KarisikMixAdet;
 String Iade;
 String IadeAdet;
 String Toplama;
 String ToplamaAdet;

 PlakaGiris(
     {required this.ekspertizid,
      required this.ekspertizNo,
      required this.IrsaliyeNo,
      required this.malKabulTarihi,
      required this.Gelis_yeri,
      required this.Rutubet,
      required this.Ymadde,
      required this.MekanikHamur,
      required this.Kuse,
      required this.SinifDisi,
      required this.PRE,
      required this.Balya_Sayisi,
      required this.TSE,
      required this.Kabul,
      required this.Kagit_turu,
      required this.AciklamaKAh,
      required this.KARISIK,
      required this.KARISIKAdet,
      required this.KARISIKMIX,
      required this.KARISIKMIXAdet,
      required this.KIRPINTIOLUK,
      required this.KIRPINTIOLUKAdet,
      required this.KRAFTOLUK,
      required this.KRAFTOLUKAdet,
      required this.KramoKarton,
      required this.KramoKartonAdet,
      required this.MARKET,
      required this.MARKETAdet,
      required this.OCCA,
      required this.OCCAAdet,
      required this.OCCB,
      required this.OCCBAdet,
      required this.OCCC,
      required this.OCCCAdet,
      required this.PS11,
      required this.PS11Adet,
      required this.PS12,
      required this.PS12Adet,
      required this.SelulozKraft,
      required this.SelulozKraftAdet,
      required this.SIVAMAOLUKLU,
      required this.SIVAMAOLUKLUAdet,
      required this.AciklamaBey,
      required this.BirinciKAlite,
      required this.BirinciKAliteAdet,
      required this.IkinciKalite,
      required this.IkinciKaliteAdet,
      required this.UcuncuKalite,
      required this.UcuncuKaliteAdet,
      required this.BCKKIKI,
      required this.BCKKIKIAdet,
      required this.CokBaskiliKarisik,
      required this.CokBaskiliKarisikAdet,
      required this.EkstraBeyaz,
      required this.EkstraBeyazAdet,
      required this.AciklamaSel,
      required this.BCTMP,
      required this.BCTMPAdet,
      required this.BHKP,
      required this.BHKPADet,
      required this.BSKP,
      required this.BSKPAdet,
      required this.GroundWood,
      required this.GroundWoodAdet,
      required this.MpCtmp,
      required this.MpCtmpAdet,
      required this.UKP,
      required this.UKPAdet,
      required this.Aciklama_Yas,
      required this.YasMukavemetli,
      required this.YasMukavemetliAdet,
      required this.LikidAmbalaj,
      required this.LikidAmbalajAdet,
      required this.KartonBardak,
      required this.KartonBardakAdet,
      required this.AciklamaGaze,
      required this.KarisikMix,
      required this.KarisikMixAdet,
      required this.Iade,
      required this.IadeAdet,
      required this.Toplama,
      required this.ToplamaAdet});

 factory PlakaGiris.fromJson(Map<dynamic, dynamic> json, String key) {
  return PlakaGiris(
   ekspertizid: key,
   ekspertizNo: json["ekspertizNo"] as String? ?? '',
   IrsaliyeNo: json["IrsaliyeNo"] as String? ?? '',
   malKabulTarihi: json["malKabulTarihi"] as String? ?? '',
   Gelis_yeri: json["Gelis_yeri"] as String? ?? '',
   Rutubet: json["Rutubet"] as String? ?? '',
   Ymadde: json["Ymadde"] as String? ?? '',
   MekanikHamur: json["MekanikHamur"] as String? ?? '',
   Kuse: json["Kuse"] as String? ?? '',
   SinifDisi: json["SinifDisi"] as String? ?? '',
   PRE: json["PRE"] as String? ?? '',
   Balya_Sayisi: json["Balya_Sayisi"] as String? ?? '',
   TSE: json["TSE"] as String? ?? '',
   Kabul: json["Kabul"] as String? ?? '',
   Kagit_turu: json["Kagit_turu"] as String? ?? '',
   AciklamaKAh: json["AciklamaKAh"] as String? ?? '',
   KARISIK: json["KARISIK"] as String? ?? '',
   KARISIKAdet: json["KARISIKAdet"] as String? ?? '',
   KARISIKMIX: json["KARISIKMIX"] as String? ?? '',
   KARISIKMIXAdet: json["KARISIKMIXAdet"] as String? ?? '',
   KIRPINTIOLUK: json["KIRPINTIOLUK"] as String? ?? '',
   KIRPINTIOLUKAdet: json["KIRPINTIOLUKAdet"] as String? ?? '',
   KRAFTOLUK: json["KRAFTOLUK"] as String? ?? '',
   KRAFTOLUKAdet: json["KRAFTOLUKAdet"] as String? ?? '',
   KramoKarton: json["KramoKarton"] as String? ?? '',
   KramoKartonAdet: json["KramoKartonAdet"] as String? ?? '',
   MARKET: json["MARKET"] as String? ?? '',
   MARKETAdet: json["MARKETAdet"] as String? ?? '',
   OCCA: json["OCCA"] as String? ?? '',
   OCCAAdet: json["OCCAAdet"] as String? ?? '',
   OCCB: json["OCCB"] as String? ?? '',
   OCCBAdet: json["OCCBAdet"] as String? ?? '',
   OCCC: json["OCCC"] as String? ?? '',
   OCCCAdet: json["OCCCAdet"] as String? ?? '',
   PS11: json["PS11"] as String? ?? '',
   PS11Adet: json["PS11Adet"] as String? ?? '',
   PS12: json["PS12"] as String? ?? '',
   PS12Adet: json["PS12Adet"] as String? ?? '',
   SelulozKraft: json["SelulozKraft"] as String? ?? '',
   SelulozKraftAdet: json["SelulozKraftAdet"] as String? ?? '',
   SIVAMAOLUKLU: json["SIVAMAOLUKLU"] as String? ?? '',
   SIVAMAOLUKLUAdet: json["SIVAMAOLUKLUAdet"] as String? ?? '',
   AciklamaBey: json["AciklamaBey"] as String? ?? '',
   BirinciKAlite: json["BirinciKAlite"] as String? ?? '',
   BirinciKAliteAdet: json["BirinciKAliteAdet"] as String? ?? '',
   IkinciKalite: json["IkinciKalite"] as String? ?? '',
   IkinciKaliteAdet: json["IkinciKaliteAdet"] as String? ?? '',
   UcuncuKalite: json["UcuncuKalite"] as String? ?? '',
   UcuncuKaliteAdet: json["UcuncuKaliteAdet"] as String? ?? '',
   BCKKIKI: json["BCKKIKI"] as String? ?? '',
   BCKKIKIAdet: json["BCKKIKIAdet"] as String? ?? '',
   CokBaskiliKarisik: json["CokBaskiliKarisik"] as String? ?? '',
   CokBaskiliKarisikAdet: json["CokBaskiliKarisikAdet"] as String? ?? '',
   EkstraBeyaz: json["EkstraBeyaz"] as String? ?? '',
   EkstraBeyazAdet: json["EkstraBeyazAdet"] as String? ?? '',
   AciklamaSel: json["AciklamaSel"] as String? ?? '',
   BCTMP: json["BCTMP"] as String? ?? '',
   BCTMPAdet: json["BCTMPAdet"] as String? ?? '',
   BHKP: json["BHKP"] as String? ?? '',
   BHKPADet: json["BHKPADet"] as String? ?? '',
   BSKP: json["BSKP"] as String? ?? '',
   BSKPAdet: json["BSKPAdet"] as String? ?? '',
   GroundWood: json["GroundWood"] as String? ?? '',
   GroundWoodAdet: json["GroundWoodAdet"] as String? ?? '',
   MpCtmp: json["MpCtmp"] as String? ?? '',
   MpCtmpAdet: json["MpCtmpAdet"] as String? ?? '',
   UKP: json["UKP"] as String? ?? '',
   UKPAdet: json["UKPAdet"] as String? ?? '',
   Aciklama_Yas: json["Aciklama_Yas"] as String? ?? '',
   YasMukavemetli: json["YasMukavemetli"] as String? ?? '',
   YasMukavemetliAdet: json["YasMukavemetliAdet"] as String? ?? '',
   LikidAmbalaj: json["LikidAmbalaj"] as String? ?? '',
   LikidAmbalajAdet: json["LikidAmbalajAdet"] as String? ?? '',
   KartonBardak: json["KartonBardak"] as String? ?? '',
   KartonBardakAdet: json["KartonBardakAdet"] as String? ?? '',
   AciklamaGaze: json["AciklamaGaze"] as String? ?? '',
   KarisikMix: json["KarisikMix"] as String? ?? '',
   KarisikMixAdet: json["KarisikMixAdet"] as String? ?? '',
   Iade: json["Iade"] as String? ?? '',
   IadeAdet: json["IadeAdet"] as String? ?? '',
   Toplama: json["Toplama"] as String? ?? '',
   ToplamaAdet: json["ToplamaAdet"] as String? ?? '',
  );
 }
}
