import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasarim3_proje/data/entity/plaka_giris.dart';
import 'package:tasarim3_proje/views/anasayfa.dart';

class Formguncelle2 extends StatefulWidget {
  PlakaGiris Bilgis;

  Formguncelle2({required this.Bilgis});

  @override
  State<Formguncelle2> createState() => _Formguncelle2State();
}

class _Formguncelle2State extends State<Formguncelle2> {
  final ekpertizNoController = TextEditingController();
  final malKabulTarihiController = TextEditingController();
  final gelisYeriController = TextEditingController();
  final rutubetController = TextEditingController();
  final yMaddesiController = TextEditingController();
  final balyaSayisiController = TextEditingController();
  final preController = TextEditingController();
  final tseController = TextEditingController();
  final kabulController = TextEditingController();
  final kagitTuruController = TextEditingController();

  final AciklamaKahController= TextEditingController();
  final karisikOraniController = TextEditingController();
  final KarisikMixKahController = TextEditingController();
  final KirpintOlukController= TextEditingController();
  final KraftOlukController= TextEditingController();
  final KromaKartonController= TextEditingController();
  final MarketController= TextEditingController();
  final OccAController= TextEditingController();
  final OccBController= TextEditingController();
  final OccCController= TextEditingController();
  final Ps11Controller= TextEditingController();
  final Ps12COontroller= TextEditingController();
  final SelulozKrafHurController= TextEditingController();
  final SivamaOlkController= TextEditingController();
  final AciklamaBeyController= TextEditingController();
  final BirinciKaliteController= TextEditingController();
  final IkinciKaliteController= TextEditingController();
  final UcuncuKaliteController= TextEditingController();
  final Bckk2Controller= TextEditingController();
  final CokBaskKarisikController= TextEditingController();
  final EkstraBeyazController= TextEditingController();
  final AciklamaSelController= TextEditingController();
  final BctmpController= TextEditingController();
  final BhkpController= TextEditingController();
  final BskpController= TextEditingController();
  final GroundWoodController= TextEditingController();
  final MpCtmpController= TextEditingController();
  final UkpController= TextEditingController();
  final Aciklama_yasController= TextEditingController();
  final YasMukavemetController= TextEditingController();
  final LikidController= TextEditingController();
  final KartonBardakController= TextEditingController();
  final AciklamaGazeController= TextEditingController();
  final KarisikMixGazeController= TextEditingController();
  final IAdeController= TextEditingController();
  final ToplamaController= TextEditingController();
  final EkpertizIdController= TextEditingController();

  List<File> _images = [];
  Future<void> guncelle(
    String ekspertizid, String malKabulTarihi, String gelisYeri, String rutubet, String yMaddesi, String balyaSayisi, String pre, String tse, String kabul, String kagitTuru, String aciklamaKah, String karisik, String karisikMix, String kirpintOluk, String kraftOluk, String kromaKarton, String market, String occA, String occB, String occC, String ps11, String ps12, String selulozKraft, String sivamaOluklu,
      String aciklamaBey, String birinciKalite, String ikinciKalite, String ucuncuKalite, String bckk2, String cokBaskKarisik, String ekstraBeyaz, String aciklamaSel, String bctmp, String bhkp, String bskp, String groundWood, String mpCtmp, String ukp, String aciklamaYas, String yasMukavemet, String likid, String kartonBardak, String aciklamaGaze, String karisikMixGaze, String iade, String toplama,
      ) async {

  }


  Future<void> _createDirectories() async {
    final Directory? externalStorageDir = await getExternalStorageDirectory();
    if (externalStorageDir == null) {
      print("External storage directory not found");
      return;
    }

    final String appPath = externalStorageDir.path;
    final String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());


    final Directory dateDir = Directory('$appPath/$todayDate');
    if (!await dateDir.exists()) {
      await dateDir.create(recursive: true);
      print('Tarih klasörü oluşturuldu: ${dateDir.path}');
    }


  }

  Future<void> _pickImage({ImageSource source = ImageSource.gallery}) async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null) {
        final File image = File(pickedFile.path);

        await _createDirectories();

        final Directory? externalStorageDir = await getExternalStorageDirectory();
        if (externalStorageDir == null) {
          print("External storage directory not found");
          return;
        }

        final String appPath = externalStorageDir.path;
        final String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());


        final String filePath = '${appPath}/${todayDate}/${pickedFile.name}';

        final File savedImage = await image.copy(filePath);

        if (await savedImage.exists()) {
          print("Fotoğraf başarıyla kaydedildi: $filePath");
          setState(() {
            _images.add(savedImage);
          });

          await _updateMediaScanner(filePath);
        } else {
          print("Fotoğraf kaydedilemedi: $filePath");
        }
      }
    } catch (e) {
      print("Image picking error: $e");
    }
  }
  Future<void> _updateMediaScanner(String filePath) async {
    try {
      await SystemChannels.platform.invokeMethod('mediaScan', {'path': filePath});
      print("Medya tarayıcı güncellendi");
    } catch (e) {
      print("Medya tarayıcı güncelleme hatası: $e");
    }
  }

  Future<void> _deleteImage(int index) async {
    try {
      final file = _images[index];
      await file.delete();
      setState(() {
        _images.removeAt(index);
      });
    } catch (e) {
      print("Error deleting image: $e");
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        malKabulTarihiController.text =
        '${picked.day}.${picked.month}.${picked.year}';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    var Bilgis=widget.Bilgis;
    ekpertizNoController.text =Bilgis.ekspertizNo;
    malKabulTarihiController.text=Bilgis.malKabulTarihi;
    gelisYeriController.text=Bilgis.Gelis_yeri;
    rutubetController.text=Bilgis.Rutubet;
    yMaddesiController.text=Bilgis.Ymadde;
    balyaSayisiController.text=Bilgis.Balya_Sayisi;
    preController.text=Bilgis.PRE;
    tseController.text=Bilgis.TSE;
    kabulController.text=Bilgis.Kabul;
    kagitTuruController.text=Bilgis.Kagit_turu;
    AciklamaKahController.text=Bilgis.AciklamaKAh;
    karisikOraniController.text=Bilgis.KARISIK;
    KarisikMixKahController.text=Bilgis.KarisikMix;
    KirpintOlukController.text=Bilgis.KIRPINTIOLUK;
    KraftOlukController.text=Bilgis.KRAFTOLUK;
    KromaKartonController.text=Bilgis.KramoKarton;
    MarketController.text=Bilgis.MARKET;
    OccAController.text=Bilgis.OCCA;
    OccBController.text=Bilgis.OCCB;
    OccCController.text=Bilgis.OCCC;
    Ps11Controller.text=Bilgis.PS11;
    Ps12COontroller.text=Bilgis.PS12;
    SelulozKrafHurController.text=Bilgis.SelulozKraft;
    SivamaOlkController.text=Bilgis.SIVAMAOLUKLU;
    AciklamaBeyController.text=Bilgis.AciklamaBey;
    BirinciKaliteController.text=Bilgis.BirinciKAlite;
    IkinciKaliteController.text=Bilgis.IkinciKalite;
    UcuncuKaliteController.text=Bilgis.UcuncuKalite;
    Bckk2Controller.text=Bilgis.BCKKIKI;
    CokBaskKarisikController.text=Bilgis.CokBaskiliKarisik;
    EkstraBeyazController.text=Bilgis.EkstraBeyaz;
    AciklamaSelController.text=Bilgis.AciklamaSel;
    BctmpController.text=Bilgis.BCTMP;
    BhkpController.text=Bilgis.BHKP;
    BskpController.text=Bilgis.BSKP;
    GroundWoodController.text=Bilgis.GroundWood;
    MpCtmpController.text=Bilgis.MpCtmp;
    UkpController.text=Bilgis.UKP;
    Aciklama_yasController.text=Bilgis.Aciklama_Yas;
    YasMukavemetController.text=Bilgis.YasMukavemetli;
    LikidController.text=Bilgis.LikidAmbalaj;
    KartonBardakController.text=Bilgis.KartonBardak;
    AciklamaGazeController.text=Bilgis.AciklamaGaze;
    KarisikMixGazeController.text=Bilgis.KarisikMix;
    IAdeController.text=Bilgis.Iade;
    ToplamaController.text=Bilgis.Toplama;



  }

  Future<void> _loadEkspertizNo() async {
    // Veritabanından ekspertizNo'yu alın ve widget.eksperitNo'yu güncelleyin
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ekpertiz Formu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(

          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0, top: 32.0),
                child: _buildTextFormField(
                  TextEditingController( ),
                  'Guncelle',
                  readonly: true,
                ),
              ),
              _buildDateField(malKabulTarihiController, 'Mal Kabul Tarihi', context),
              _buildTextFormField(gelisYeriController, 'Geliş Yeri'),
              Row(
                children: [
                  Expanded(
                      child: _buildTextFormField(rutubetController, 'Rutubet %')),
                  const SizedBox(width: 16.0),
                  Expanded(
                      child: _buildTextFormField(yMaddesiController, 'Y. Madde %')),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: _buildTextFormField(balyaSayisiController, 'Balya Sayısı')),
                  const SizedBox(width: 16.0),
                  Expanded(
                      child: _buildTextFormField(preController, 'PRE')),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownButtonFormField(tseController, 'TSE', ['TSE1', 'TSE2', 'TSE3']),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: _buildDropdownButtonFormField(kabulController, 'Kabul', ['Kabul', 'Red']),
                  ),
                ],
              ),
              _buildDropdownButtonFormField(kagitTuruController, 'Kağıt Türü', ['Kahverengi Atık Kağıt', 'Beyaz Atık Kağıt', 'Selüloz', 'Yaş Mukavemetli', 'Gazete']),

              if (kagitTuruController.text == 'Kahverengi Atık Kağıt')
                _buildKahverengiFields(),
              if (kagitTuruController.text == 'Beyaz Atık Kağıt')
                _buildBeyazFields(),
              if (kagitTuruController.text == 'Selüloz')
                _buildSelulozFields(),
              if (kagitTuruController.text == 'Yaş Mukavemetli')
                _buildYasMukavemetliFields(),
              if (kagitTuruController.text == 'Gazete')
                _buildGazeteFields(),

              const SizedBox(height: 16.0),
              _buildImagePickerButtons(),

              if (_images.isNotEmpty) _buildImageGrid(),

              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Anasayfa(),
                    ),
                  );
                  guncelle(
                    widget.Bilgis.ekspertizid,
                    malKabulTarihiController.text,
                    gelisYeriController.text,
                    rutubetController.text,
                    yMaddesiController.text,
                    balyaSayisiController.text,
                    preController.text,
                    tseController.text,
                    kabulController.text,
                    kagitTuruController.text,
                    AciklamaKahController.text,
                    karisikOraniController.text,
                    KarisikMixKahController.text,
                    KirpintOlukController.text,
                    KraftOlukController.text,
                    KromaKartonController.text,
                    MarketController.text,
                    OccAController.text,
                    OccBController.text,
                    OccCController.text,
                    Ps11Controller.text,
                    Ps12COontroller.text,
                    SelulozKrafHurController.text,
                    SivamaOlkController.text,
                    AciklamaBeyController.text,
                    BirinciKaliteController.text,
                    IkinciKaliteController.text,
                    UcuncuKaliteController.text,
                    Bckk2Controller.text,
                    CokBaskKarisikController.text,
                    EkstraBeyazController.text,
                    AciklamaSelController.text,
                    BctmpController.text,
                    BhkpController.text,
                    BskpController.text,
                    GroundWoodController.text,
                    MpCtmpController.text,
                    UkpController.text,
                    Aciklama_yasController.text,
                    YasMukavemetController.text,
                    LikidController.text,
                    KartonBardakController.text,
                    AciklamaGazeController.text,
                    KarisikMixGazeController.text,
                    IAdeController.text,
                    ToplamaController.text,
                  );

                },
                child: const Text('Guncelle'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(
      TextEditingController controller,
      String labelText,
      {bool readonly = false}) {
    return TextFormField(
      controller: controller,
      readOnly: readonly,
      decoration: InputDecoration(labelText: labelText),
      // Zorunluluk kaldırıldığı için validator kullanılmıyor
    );
  }

  Widget _buildDateField(
      TextEditingController controller,
      String labelText,
      BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(labelText: labelText),
          // Zorunluluk kaldırıldığı için validator kullanılmıyor
        ),
      ),
    );
  }

  Widget _buildDropdownButtonFormField(
      TextEditingController controller,
      String labelText,
      List<String> items) {
    return DropdownButtonFormField<String>(
      value: controller.text.isEmpty ? null : controller.text,
      onChanged: (newValue) {
        setState(() {
          controller.text = newValue!;
        });
      },
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      decoration: InputDecoration(labelText: labelText),
      // Zorunluluk kaldırıldığı için validator kullanılmıyor
    );
  }

  Widget _buildKahverengiFields() {
    return Column(
      children: [
        _buildTextFormField(AciklamaKahController, 'Açıklama Kahverengi'),
        _buildTextFormField(karisikOraniController, 'Karışık Oranı'),
        _buildTextFormField(KarisikMixKahController, 'Karışık Mix Kah'),
        _buildTextFormField(KirpintOlukController, 'Kırpıntı Oluk'),
        _buildTextFormField(KraftOlukController, 'Kraft Oluk'),
        _buildTextFormField(KromaKartonController, 'Kroma Karton'),
        _buildTextFormField(MarketController, 'Market'),
        _buildTextFormField(OccAController, 'Occ A'),
        _buildTextFormField(OccBController, 'Occ B'),
        _buildTextFormField(OccCController, 'Occ C'),
        _buildTextFormField(Ps11Controller, 'Ps 11'),
        _buildTextFormField(Ps12COontroller, 'Ps 12 C'),
        _buildTextFormField(SelulozKrafHurController, 'Selüloz Kraft Hur'),
        _buildTextFormField(SivamaOlkController, 'Sıvama Oluk'),
      ],
    );
  }

  Widget _buildBeyazFields() {
    return Column(
      children: [
        _buildTextFormField(AciklamaBeyController, 'Açıklama Beyaz'),
        _buildTextFormField(BirinciKaliteController, 'Birinci Kalite'),
        _buildTextFormField(IkinciKaliteController, 'İkinci Kalite'),
        _buildTextFormField(UcuncuKaliteController, 'Üçüncü Kalite'),
        _buildTextFormField(Bckk2Controller, 'Bckk 2'),
        _buildTextFormField(CokBaskKarisikController, 'Çok Baskılı Karışık'),
        _buildTextFormField(EkstraBeyazController, 'Ekstra Beyaz'),
      ],
    );
  }

  Widget _buildSelulozFields() {
    return Column(
      children: [
        _buildTextFormField(AciklamaSelController, 'Açıklama Selüloz'),
        _buildTextFormField(BctmpController, 'Bctmp'),
        _buildTextFormField(BhkpController, 'Bhkp'),
        _buildTextFormField(BskpController, 'Bskp'),
        _buildTextFormField(GroundWoodController, 'GroundWood'),
        _buildTextFormField(MpCtmpController, 'MpCtmp'),
        _buildTextFormField(UkpController, 'Ukp'),
      ],
    );
  }

  Widget _buildYasMukavemetliFields() {
    return Column(
      children: [
        _buildTextFormField(Aciklama_yasController, 'Açıklama Yaş Mukavemetli'),
        _buildTextFormField(YasMukavemetController, 'Yaş Mukavemet %'),
        _buildTextFormField(LikidController, 'Likid'),
        _buildTextFormField(KartonBardakController, 'Karton Bardak'),
      ],
    );
  }

  Widget _buildGazeteFields() {
    return Column(
      children: [
        _buildTextFormField(AciklamaGazeController, 'Açıklama Gazete'),
        _buildTextFormField(KarisikMixGazeController, 'Karışık Mix Gazete'),
        _buildTextFormField(IAdeController, 'IAde'),
        _buildTextFormField(ToplamaController, 'Toplama'),
      ],
    );
  }

  Widget _buildImagePickerButtons() {
    return  Row(
      children: [
        ElevatedButton(
          onPressed: () => _pickImage(source: ImageSource.camera),
          child: const Text('Fotoğraf Çek         '),
        ),
        const SizedBox(width: 16.0),
        ElevatedButton(
          onPressed: () => _pickImage(source: ImageSource.gallery),
          child: const Text('Galeriden Fotoğraf Seç'),
        ),
      ],
    );
  }

  Widget _buildImageGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemCount: _images.length,
      itemBuilder: (context, index) {
        return Stack(
          fit: StackFit.expand,
          children: [
            Image.file(_images[index], fit: BoxFit.cover),
            Positioned(
              right: 4,
              top: 4,
              child: GestureDetector(
                onTap: () => _deleteImage(index),
                child: const Icon(Icons.delete, color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}

