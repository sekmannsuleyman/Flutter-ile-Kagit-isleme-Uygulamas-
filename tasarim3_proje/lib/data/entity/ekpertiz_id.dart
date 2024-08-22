class EkpertizId{
  String Ekpertizid;
  String ekspertizNo;
  String plaka_no;

  EkpertizId({required this.Ekpertizid, required this.ekspertizNo, required this.plaka_no});

  factory EkpertizId.fromJson(Map<dynamic,dynamic> json, String key){

    return EkpertizId(Ekpertizid: key,
        ekspertizNo: json["ekpertiz_no"]as String,
        plaka_no: json["plaka_no"]as String);
  }
}
