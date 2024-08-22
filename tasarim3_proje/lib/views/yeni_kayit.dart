import 'package:flutter/material.dart';
import 'package:tasarim3_proje/views/ekpertiz_form.dart';
import 'package:tasarim3_proje/data/repo/plakalardao_repository.dart';

class YeniKayit extends StatefulWidget {
  const YeniKayit({super.key});

  @override
  State<YeniKayit> createState() => _YeniKayitState();
}

class _YeniKayitState extends State<YeniKayit> {
  final TextEditingController tfplakaNo = TextEditingController();
  List<String> kaydedilenPlakalar = []; // Başlangıçta boş liste

  @override
  void initState() {
    super.initState();
    _loadPlakalar();
  }

  // Veritabanından plakaları yükleyen metod
  Future<void> _loadPlakalar() async {
    try {
      final plakalar = await PlakalardaoRepository().getPlakalar();
      setState(() {
        kaydedilenPlakalar = plakalar.toSet().toList(); // Tekrarlanan plakaları filtrele
      });
    } catch (e) {
      print("Plakalar yüklenirken hata oluştu: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Yeni Kayıt",
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
            TextField(
              controller: tfplakaNo,
              style: const TextStyle(
                fontSize: 20,
                fontFamily: 'Roboto',
              ),
              decoration: InputDecoration(
                labelText: 'Plaka No',
                labelStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontFamily: 'Roboto',
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.search, size: 28),
                      onPressed: () {
                        // Arama işlevini burada gerçekleştirin
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.clear, size: 28),
                      onPressed: () {
                        setState(() {
                          tfplakaNo.clear(); // TextField'ı temizler
                        });
                      },
                    ),
                  ],
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Kayıtlı Plakalar:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            DropdownButton<String>(
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    tfplakaNo.text = newValue;
                  });
                }
              },
              items: kaydedilenPlakalar.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(value),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _confirmDelete(value);
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (tfplakaNo.text.isNotEmpty) {
                    String plakaNo = tfplakaNo.text;

                    // Mevcut plakaya yeni ekspertiz numarası ekle
                    try {
                      String? yeniEkpertizNo = await PlakalardaoRepository().kaydet(plakaNo);

                      if (yeniEkpertizNo != null) {
                        // Plakayı listeye ekle, eğer listede yoksa
                        if (!kaydedilenPlakalar.contains(plakaNo)) {
                          setState(() {
                            kaydedilenPlakalar.add(plakaNo);
                          });
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EkpertizForm(eksperitNo: yeniEkpertizNo),
                          ),
                        );
                      } else {
                        _showErrorDialog("Ekspertiz numarası oluşturulamadı.");
                      }
                    } catch (e) {
                      _showErrorDialog("Bir hata oluştu: $e");
                    }
                  } else {
                    _showErrorDialog("Lütfen bir plaka numarası girin.");
                  }
                },
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
          ],
        ),
      ),
    );
  }

  void _confirmDelete(String plaka) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Silme Onayı"),
          content: const Text("Bu plakayı silmek istiyor musunuz?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Onayı iptal et
              },
              child: const Text("İptal"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  kaydedilenPlakalar.remove(plaka); // Plakayı listeden sil
                });
                Navigator.of(context).pop(); // Onayı kapat
              },
              child: const Text("Sil"),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Hata"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Tamam"),
            ),
          ],
        );
      },
    );
  }
}
