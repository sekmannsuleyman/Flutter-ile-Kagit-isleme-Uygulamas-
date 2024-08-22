class Kullanicigiris{
  String KullaniciId;
   String KullaniciGiris;
   String Sifre;

   Kullanicigiris({required this.KullaniciId,required this.KullaniciGiris, required this.Sifre});


   factory Kullanicigiris.fromJson(Map<dynamic, dynamic> json, String key){
     return Kullanicigiris(KullaniciId: key, KullaniciGiris: json["KullaniciGiris"] as String? ??'', Sifre: json["Sifre"] as String? ??'');



   }
}