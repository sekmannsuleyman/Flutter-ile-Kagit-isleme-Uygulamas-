import 'package:flutter/material.dart';
import 'package:tasarim3_proje/data/repo/plakalardao_repository.dart';
import 'package:tasarim3_proje/views/anasayfa.dart';

class Ekpertiziguncelle extends StatefulWidget {
  const Ekpertiziguncelle({super.key});

  @override
  State<Ekpertiziguncelle> createState() => _EkpertiziguncelleState();
}

class _EkpertiziguncelleState extends State<Ekpertiziguncelle> {
  final TextEditingController ekpertizNoController = TextEditingController();
  List<String> ekpertizNumaralari = [];
  String? selectedEkpertizNo;

  @override
  void initState() {
    super.initState();
    _loadEkpertizNumaralari();
  }

  Future<void> _loadEkpertizNumaralari() async {
    try {
      final plakalar = await PlakalardaoRepository().getEkpertizNumaralari();
      setState(() {
        ekpertizNumaralari = plakalar;
      });
    } catch (e) {
      print("Ekspertiz numaraları yüklenirken hata oluştu: $e");
    }
  }

  Future<void> _navigateToFormGuncelle2() async {
    if (selectedEkpertizNo != null) {
      try {
        // Firestore'dan veriyi çekme
        final plakaGiris = await PlakalardaoRepository().getPlakaGirisByEkpertizNo(selectedEkpertizNo!);

        // Eğer veri mevcutsa
        if (plakaGiris != null) {
          // FormGuncelle2 sayfasına veri ile geçiş yapma
          Navigator.push(
            context,
            MaterialPageRoute(

           // var Bilgis= PlakaGiris(Ekpertizid: "1", ekspertizNo: "99", Mal_Kabul_tarihi: "Mal_Kabul_tarihi", Gelis_yeri: "Gelis_yeri", Rutubet: "Rutubet", Ymadde: "Ymadde", Balya_Sayisi: "Balya_Sayisi", PRE: "PRE", TSE: "TSE", Kabul: "Kabul", Kagit_turu: "Kahhverengi Atık Kağıt", AciklamaKAh: "AciklamaKAh", KARISIK: "KARISIK", KARISIKMIX: "KARISIKMIX", KIRPINTIOLUK: "KIRPINTIOLUK", KRAFTOLUK: "KRAFTOLUK", KramoKarton: "KramoKarton", MARKET: "MARKET", OCCA: "OCCA", OCCB: "OCCB", OCCC: "OCCC", PS11: "PS11", PS12: "PS12", SelulozKraft: "SelulozKraft", SIVAMAOLUKLU: "SIVAMAOLUKLU", AciklamaBey: "AciklamaBey", BirinciKAlite: "BirinciKAlite", IkinciKalite: "IkinciKalite", UcuncuKalite: "UcuncuKalite", BCKKIKI: "BCKKIKI", CokBaskiliKarisik: "CokBaskiliKarisik", EkstraBeyaz: "EkstraBeyaz", AciklamaSel: "AciklamaSel", BCTMP: "BCTMP", BHKP: "BHKP", BSKP: "BSKP", GroundWood: "GroundWood", MpCtmp: "MpCtmp", UKP: "UKP", Aciklama_Yas: "Aciklama_Yas", YasMukavemetli: "YasMukavemetli", LikidAmbalaj: "LikidAmbalaj", KartonBardak: "KartonBardak", AciklamaGaze: "AciklamaGaze", KarisikMix: "KarisikMix", Iade: "Iade", Toplama: "Toplama");

              builder: (context) => Anasayfa()// Seçilen ekspertiz numarasını geçin
            ),
          );
        } else {
          // Veri bulunamadıysa uyarı gösterme
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Seçilen ekspertiz numarası için veri bulunamadı.")),
          );
        }
      } catch (e) {
        // Hata durumunda uyarı gösterme
        print("Form güncelleme hatası: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Bir hata oluştu. Lütfen tekrar deneyin.")),
        );
      }
    } else {
      // Ekspertiz numarası seçilmemişse uyarı gösterme
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lütfen bir ekspertiz numarası seçin.")),
      );
    }
  }

  Future<void> kaydet(String ekpertizNo) async {
    print("Kaydedilen ekspertiz numarası: $ekpertizNo");
    // Burada kaydetme işlemini gerçekleştirin.
  }

  Future<void> sil(String ekpertizNo) async {
    try {
      await PlakalardaoRepository().silEkpertizNo(ekpertizNo);
      setState(() {
        ekpertizNumaralari.remove(ekpertizNo);
        selectedEkpertizNo = null;
        ekpertizNoController.clear();
      });
    } catch (e) {
      print("Ekspertiz numarası silinirken hata oluştu: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Form Güncelle",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: 'Arial',
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            DropdownButton<String>(
              isExpanded: true,
              value: selectedEkpertizNo,
              hint: const Text('Ekpertiz No'),
              items: ekpertizNumaralari.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedEkpertizNo = newValue;
                  ekpertizNoController.text = newValue ?? "";
                });
              },
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _navigateToFormGuncelle2,
                child: const Text(
                  'Devam',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    letterSpacing: 1.1,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedEkpertizNo != null) {
                    sil(selectedEkpertizNo!);
                  }
                },
                child: const Text(
                  'Sil',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    letterSpacing: 1.1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
