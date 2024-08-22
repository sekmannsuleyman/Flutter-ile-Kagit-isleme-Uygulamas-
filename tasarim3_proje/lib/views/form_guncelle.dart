import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasarim3_proje/cubit/formguncelle2Cubit.dart';

import 'package:tasarim3_proje/data/entity/plaka_giris.dart';
import 'package:tasarim3_proje/views/anasayfa.dart';

class FormGuncelle extends StatefulWidget {

  PlakaGiris  bilgiler;

  FormGuncelle({required this.bilgiler});

  @override
  State<FormGuncelle> createState() => _FormGuncelleState();
}

class _FormGuncelleState extends State<FormGuncelle> {
  final _formKey = GlobalKey<FormState>();
  // Tüm controller'lar
  final ekpertizNoController = TextEditingController();
  final IrsaliyeNo= TextEditingController();
  final malKabulTarihiController = TextEditingController();
  final gelisYeriController = TextEditingController();
  final rutubetController = TextEditingController();
  final yMaddesiController = TextEditingController();
  final MekanikHamurController= TextEditingController();
  final KuseController=TextEditingController();
  final SinifDisiController= TextEditingController();
  final preController = TextEditingController(text: '0');
  final balyaSayisiController = TextEditingController();
  final tseController = TextEditingController();
  final kabulController = TextEditingController();
  final kagitTuruController = TextEditingController();
  final AciklamaKahController= TextEditingController();
  final karisikOraniController = TextEditingController();
  final karisikOraniAdetController = TextEditingController();
  final KarisikMixKahController = TextEditingController();
  final KarisikMixKahAdetController = TextEditingController();
  final KirpintOlukController= TextEditingController();
  final KirpintOlukAdetController= TextEditingController();
  final KraftOlukController= TextEditingController();
  final KraftOlukControllerAdet= TextEditingController();
  final KromaKartonController= TextEditingController();
  final KromaKartonAdetController= TextEditingController();
  final MarketController= TextEditingController();
  final MarketAdetController= TextEditingController();
  final OccAController= TextEditingController();
  final OccAAdetController= TextEditingController();
  final OccBController= TextEditingController();
  final OccBAdetContController= TextEditingController();
  final OccCController= TextEditingController();
  final OccCAdetController= TextEditingController();
  final Ps11Controller= TextEditingController();
  final Ps11AdetController= TextEditingController();
  final Ps12Controller= TextEditingController();
  final Ps12AdetCOontroller= TextEditingController();
  final SelulozKraftHurController= TextEditingController();
  final SelulozKrafHurAdetController= TextEditingController();
  final SivamaOlkController= TextEditingController();
  final SivamaOlkAdetController= TextEditingController();
  final AciklamaBeyController= TextEditingController();
  final BirinciKaliteController= TextEditingController();
  final BirinciKaliteAdetController= TextEditingController();
  final IkinciKaliteController= TextEditingController();
  final IkinciKaliteAdetController= TextEditingController();
  final UcuncuKaliteController= TextEditingController();
  final UcuncuKaliteAdetController= TextEditingController();
  final Bckk2Controller= TextEditingController();
  final Bckk2AdetController= TextEditingController();
  final CokBaskKarisikController= TextEditingController();
  final CokBaskKarisikAdetController= TextEditingController();
  final EkstraBeyazController= TextEditingController();
  final EkstraBeyazAdetController= TextEditingController();
  final AciklamaSelController= TextEditingController();
  final BctmpController= TextEditingController();
  final BctmpAdetController= TextEditingController();
  final BhkpController= TextEditingController();
  final BhkpAdetController= TextEditingController();
  final BskpController= TextEditingController();
  final BskpAdetController= TextEditingController();
  final GroundWoodController= TextEditingController();
  final GroundWoodAdetController= TextEditingController();
  final MpCtmpController= TextEditingController();
  final MpCtmpAdetController= TextEditingController();
  final UkpController= TextEditingController();
  final UkpAdetController= TextEditingController();
  final AciklamaYasController= TextEditingController();
  final YasMukavemetController= TextEditingController();
  final YasMukavemetAdetController= TextEditingController();
  final LikidController= TextEditingController();
  final LikidAdetController= TextEditingController();
  final KartonBardakController= TextEditingController();
  final KartonBardakAdetController= TextEditingController();
  final AciklamaGazeController= TextEditingController();
  final KarisikMixGazeController= TextEditingController();
  final KarisikMixGazeAdetController= TextEditingController();
  final IAdeController= TextEditingController();
  final IAdeAdetController= TextEditingController();
  final ToplamaController= TextEditingController();
  final ToplamaAdetController= TextEditingController();
  final EkpertizIdController= TextEditingController();
  final EkpertizIdAdeController= TextEditingController();
  List<File> _images = [];


  Future<String?> _getEkspertizDirectory() async {
    final Directory? externalStorageDir = await getExternalStorageDirectory();
    if (externalStorageDir == null) {
      print("External storage directory not found");
      return null;
    }

    final String appPath = externalStorageDir.path;
    final String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final String ekspertizNo = ekpertizNoController.text.trim();

    final Directory ekspertizDir = Directory('$appPath/$todayDate/$ekspertizNo');
    if (!await ekspertizDir.exists()) {
      await ekspertizDir.create(recursive: true);
      print('Ekspertiz klasörü oluşturuldu: ${ekspertizDir.path}');
    }

    return ekspertizDir.path;
  }

  Future<void> _pickImage({ImageSource source = ImageSource.gallery}) async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null) {
        final String? dirPath = await _getEkspertizDirectory();
        if (dirPath == null) return;

        final String filePath = '$dirPath/${pickedFile.name}';
        final File image = File(pickedFile.path);
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
      print("Fotoğraf seçme hatası: $e");
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
      print("Fotoğraf silme hatası: $e");
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
        malKabulTarihiController.text = '${picked.day}.${picked.month}.${picked.year}';
      });
    }
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    var bilgiler=widget.bilgiler;
    ekpertizNoController.text=bilgiler.ekspertizNo;
    IrsaliyeNo.text=bilgiler.IrsaliyeNo;
    malKabulTarihiController.text=bilgiler.malKabulTarihi;
    gelisYeriController.text=bilgiler.Gelis_yeri;
    rutubetController.text=bilgiler.Rutubet;
    yMaddesiController.text=bilgiler.Ymadde;
    MekanikHamurController.text=bilgiler.MekanikHamur;
    KuseController.text=bilgiler.Kuse;
    SinifDisiController.text=bilgiler.SinifDisi;
    balyaSayisiController.text=bilgiler.Balya_Sayisi;
    tseController.text=bilgiler.TSE;
    preController.text=bilgiler.PRE;
    kabulController.text=bilgiler.Kabul;
    kagitTuruController.text=bilgiler.Kagit_turu;
    AciklamaKahController.text=bilgiler.AciklamaKAh;
    karisikOraniController.text=bilgiler.KARISIK;
    karisikOraniAdetController.text=bilgiler.KARISIKAdet;
    KarisikMixKahController.text=bilgiler.KARISIKMIX;
    KarisikMixKahAdetController.text=bilgiler.KARISIKMIXAdet;
    KirpintOlukController.text=bilgiler.KIRPINTIOLUK;
    KirpintOlukAdetController.text=bilgiler.KIRPINTIOLUKAdet;
    KraftOlukController.text = bilgiler.KRAFTOLUK;
    KraftOlukControllerAdet.text = bilgiler.KRAFTOLUKAdet;
    KromaKartonController.text =bilgiler.KramoKarton;
    KromaKartonAdetController.text =bilgiler.KramoKartonAdet;
    MarketController.text =bilgiler.MARKET;
    MarketAdetController.text =bilgiler.MARKETAdet;
    OccAController.text = bilgiler.OCCA;
    OccAAdetController.text = bilgiler.OCCAAdet;
    OccBController.text =bilgiler.OCCB;
    OccBAdetContController.text =bilgiler.OCCBAdet;
    OccCController.text = bilgiler.OCCC;
    OccCAdetController.text = bilgiler.OCCCAdet;
    Ps11Controller.text = bilgiler.PS11;
    Ps11AdetController.text = bilgiler.PS11Adet;
    Ps12Controller.text = bilgiler.PS12;
    Ps12AdetCOontroller.text = bilgiler.PS12Adet;
    SelulozKraftHurController.text =bilgiler.SelulozKraft;
    SelulozKrafHurAdetController.text =bilgiler.SelulozKraftAdet;
    SivamaOlkController.text = bilgiler.SIVAMAOLUKLU;
    SivamaOlkAdetController.text = bilgiler.SIVAMAOLUKLUAdet;
    AciklamaBeyController.text = bilgiler.AciklamaBey;
    BirinciKaliteController.text = bilgiler.BirinciKAlite;
    BirinciKaliteAdetController.text = bilgiler.BirinciKAliteAdet;
    IkinciKaliteController.text = bilgiler.IkinciKalite;
    IkinciKaliteAdetController.text = bilgiler.IkinciKaliteAdet;
    UcuncuKaliteController.text =bilgiler.UcuncuKalite;
    UcuncuKaliteAdetController.text =bilgiler.UcuncuKaliteAdet;
    Bckk2Controller.text =bilgiler.BCKKIKI;
    Bckk2AdetController.text =bilgiler.BCKKIKIAdet;
    CokBaskKarisikController.text =bilgiler.CokBaskiliKarisik;
    CokBaskKarisikAdetController.text =bilgiler.CokBaskiliKarisikAdet;
    EkstraBeyazController.text =bilgiler.EkstraBeyaz;
    EkstraBeyazAdetController.text =bilgiler.EkstraBeyazAdet;
    AciklamaSelController.text =bilgiler.AciklamaSel;
    BctmpController.text =bilgiler.BCTMP;
    BctmpAdetController.text =bilgiler.BCTMPAdet;
    BhkpController.text =bilgiler.BHKP;
    BhkpAdetController.text =bilgiler.BHKPADet;
    BskpController.text =bilgiler.BSKP;
    BskpAdetController.text =bilgiler.BSKPAdet;
    GroundWoodController.text =bilgiler.GroundWood;
    GroundWoodAdetController.text =bilgiler.GroundWoodAdet;
    MpCtmpController.text = bilgiler.MpCtmp;
    MpCtmpAdetController.text = bilgiler.MpCtmpAdet;
    UkpController.text =bilgiler.UKP;
    UkpAdetController.text =bilgiler.UKPAdet;
    AciklamaYasController.text =bilgiler.Aciklama_Yas;
    YasMukavemetController.text =bilgiler.YasMukavemetli;
    YasMukavemetAdetController.text =bilgiler.YasMukavemetliAdet;
    LikidController.text =bilgiler.LikidAmbalaj;
    LikidAdetController.text =bilgiler.LikidAmbalajAdet;
    KartonBardakController.text =bilgiler.KartonBardak;
    KartonBardakAdetController.text =bilgiler.KartonBardakAdet;
    AciklamaGazeController.text =bilgiler.AciklamaGaze;
    KarisikMixGazeController.text =bilgiler.KarisikMix;
    KarisikMixGazeAdetController.text =bilgiler.KarisikMixAdet;
    IAdeController.text =bilgiler.Iade;
    IAdeAdetController.text =bilgiler.IadeAdet;
    ToplamaController.text=bilgiler.Toplama;
    ToplamaAdetController.text=bilgiler.ToplamaAdet;



  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ekpertiz Formu guncelle'),
      ),
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: ekpertizNoController,
                    decoration: const InputDecoration(labelText: 'EkspertizNo',),
                    enabled: false,

                  ),

                ),


                _buildTextFormField(IrsaliyeNo, 'Irsaliye No'),
                _buildDateField(malKabulTarihiController, 'Mal Kabul Tarihi', context),
                _buildTextFormField(gelisYeriController, 'Geliş Yeri'),
                Row(
                  children: [

                    Expanded(

                        child: _buildNumberFormField(rutubetController, 'Rutubet: %')),
                    const SizedBox(width: 16.0,height: 80,),
                    Expanded(
                        child: _buildNumberFormField(yMaddesiController, 'Y. Madde: %')),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(height: 40,),
                    Expanded(
                        child: _buildNumberFormField(MekanikHamurController, 'Mekanik Hanur:%')),
                    const SizedBox(width: 16.0),
                    Expanded(
                        child: _buildNumberFormField(KuseController, 'Kuse:%')),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(height: 80,),
                    Expanded(
                        child: _buildNumberFormField(SinifDisiController, 'Sinif Dışı:%')),
                    const SizedBox(width: 16.0),
                    Expanded(
                        child: _buildNumberFormField(preController, 'PRE')),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildNumberFormField(balyaSayisiController, 'Balya Sayısı'),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: _buildDropdownButtonFormField(tseController, 'TSE', ['AO2', 'AO3', 'AO4','AO5','AO6','AO7','AO8']),
                    ),
                  ],
                ),
                const SizedBox(width: 16.0),
                _buildDropdownButtonFormField(kabulController, 'Kabul', ['Kabul', 'Red']),
                const SizedBox(width: 16.0),
                _buildDropdownButtonFormField(kagitTuruController, 'Kağıt Türü', ['Kahverengi Atık Kağıt', 'Beyaz Atık Kağıt', 'Selüloz', 'Yaş Mukavemetli', 'Gazete']),
                const SizedBox(width: 16.0),
                       Padding( padding: const EdgeInsets.all(1.0),
                         child: Column(
                           children: <Widget>[
                  if (kagitTuruController.text == 'Kahverengi Atık Kağıt')
                  ...[
                          Column(
                           children: [
                             _buildTextFormField(AciklamaKahController, 'Açıklama Kahverengi:'),
                             Row(children: [
                               const SizedBox(width: 10,height: 68,),
                               Expanded(
                                 child: _buildNumberFormField(karisikOraniController, 'Karışık Oranı:%'),
                               ),
                               const SizedBox(width: 10),
                               Expanded(
                                 child: _buildNumberFormField(karisikOraniAdetController,' Adet'), ),
                             ],),
                             const SizedBox(height: 0,),
                             Row(children: [
                               const SizedBox(width: 10,height: 80,),
                               Expanded(
                                 child: _buildNumberFormField(KarisikMixKahController, 'Karışık Mix Kah:%'),
                               ),
                               const SizedBox(width: 10),
                               Expanded(
                                 child: _buildNumberFormField(KarisikMixKahAdetController ,'Adet:'  ), ),
                             ],),

                             Row(children: [
                               const SizedBox(width: 10,height: 40,),
                               Expanded(
                                 child: _buildNumberFormField(KirpintOlukController, 'Kırpıntı Oluk:%'),
                               ),
                               const SizedBox(width: 10,),
                               Expanded(
                                 child: _buildNumberFormField(KirpintOlukAdetController,'Adet:'),)
                             ],),
                             Row(children: [
                               const SizedBox(width: 10,height: 90,),
                               Expanded(
                                 child: _buildNumberFormField(KraftOlukController, 'Kraft Oluk:%'),
                               ),
                               const SizedBox(width: 10),
                               Expanded(
                                 child: _buildNumberFormField(KraftOlukControllerAdet,'Adet:'),)
                             ],),


                             Row(children: [
                               const SizedBox(width: 10,height: 50,),
                               Expanded(
                                 child: _buildNumberFormField(KromaKartonController, 'Kroma Karton:%'),
                               ),
                               const SizedBox(width: 10),
                               Expanded(
                                 child: _buildNumberFormField(KromaKartonAdetController,'Adet:'),
                               )
                             ],),
                             Row(children: [
                               const SizedBox(width: 10,height: 90,),
                               Expanded(
                                 child: _buildNumberFormField(MarketController, 'Market:%'),
                               ),
                               const SizedBox(width: 10),
                               Expanded(
                                 child: _buildNumberFormField(MarketAdetController,'Adet'),
                               )
                             ],),

                             Row(children: [
                               const SizedBox(width: 10,height: 60,),
                               Expanded(
                                 child: _buildNumberFormField(OccAController, 'OCC A:%'),
                               ),
                               const SizedBox(width: 10),
                               Expanded(
                                 child:  _buildNumberFormField(OccAAdetController,'Adet:'),
                               )
                             ],),
                             Row(children: [
                               const SizedBox(width: 10,height: 80,),
                               Expanded(
                                 child: _buildNumberFormField(OccBController, 'OCC B:%'),
                               ),
                               const SizedBox(width: 10),
                               Expanded(
                                 child:  _buildNumberFormField(OccBAdetContController,'Adet:'),
                               )
                             ],),
                             Row(children: [
                               const SizedBox(width: 10,height: 60,),
                               Expanded(
                                 child:  _buildNumberFormField(OccCController, 'OCC C:%'),
                               ),
                               const SizedBox(width: 10),
                               Expanded(
                                 child:    _buildNumberFormField(OccCAdetController,'Adet'),
                               )
                             ],),
                             Row(children: [
                               const SizedBox(width: 10,height: 80,),
                               Expanded(
                                 child:  _buildNumberFormField(Ps11Controller, 'PS 11:%'),
                               ),
                               const SizedBox(width: 10),
                               Expanded(
                                 child:    _buildNumberFormField(Ps11AdetController, 'Adet'),
                               )
                             ],),

                             Row(children: [
                               const SizedBox(width: 10,height: 60,),
                               Expanded(
                                 child:  _buildNumberFormField(Ps12Controller, 'PS 12 C:%'),
                               ),
                               const SizedBox(width: 10),
                               Expanded(
                                 child:   _buildNumberFormField(Ps12AdetCOontroller,'Adet'),
                               )
                             ],),
                             Row(children: [
                               const SizedBox(width: 10,height: 80,),
                               Expanded(
                                 child:  _buildNumberFormField(SelulozKrafHurAdetController, 'Selüloz Kraft Hur:%'),
                               ),
                               const SizedBox(width: 10),
                               Expanded(
                                 child:   _buildNumberFormField(SelulozKrafHurAdetController,'Adet'),
                               )
                             ],),
                             const SizedBox(width: 10,height: 5,),
                             Row(children: [
                               const SizedBox(width: 10,height: 10,),
                               Expanded(
                                 child:   _buildNumberFormField(SivamaOlkController, 'Sıvama Oluk: %'),
                               ),
                               const SizedBox(width: 10),
                               Expanded(
                                 child:   _buildNumberFormField(SivamaOlkAdetController,'Adet'),
                               )
                             ],),
                             const SizedBox(width: 20,height: 12,),




                           ],
            ),


                ],



                if (kagitTuruController.text == 'Beyaz Atık Kağıt')
                  ...[
                        Column(
                  children: [
                    const SizedBox(width: 10,height: 10,),
                    _buildTextFormField(AciklamaBeyController, 'Açıklama Beyaz'),
                    Row(
                      children: [
                        const SizedBox(width: 10,height: 80,),
                        Expanded(
                          child: _buildNumberFormField(BirinciKaliteController, 'Birinci Kalite: %'),
                        ),
                        const SizedBox(width: 10), // İki alan arasında boşluk bırakır
                        Expanded(
                          child: _buildNumberFormField(BirinciKaliteAdetController,'Adet'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 10,height: 60,),
                        Expanded(
                          child: _buildNumberFormField(IkinciKaliteController, 'İkinci Kalite: %'),
                        ),
                        const SizedBox(width: 10), // İki alan arasında boşluk bırakır
                        Expanded(
                          child: _buildNumberFormField(IkinciKaliteAdetController,'Adet'),
                        ),
                      ],
                    ),
                    Row( children: [
                      const SizedBox(width: 10,height: 80,),
                      Expanded(
                        child :_buildNumberFormField(UcuncuKaliteController, 'Üçüncü Kalite: %'),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildNumberFormField(UcuncuKaliteAdetController,'Adet'),

                      )  ],) ,
                    Row( children: [
                      const SizedBox(width: 10,height: 60,),
                      Expanded(
                        child :_buildNumberFormField(Bckk2Controller, 'BCKK 2: %'),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildNumberFormField(Bckk2AdetController,'Adet:'),

                      )  ],) ,
                    Row( children: [
                      const SizedBox(width: 10,height: 80,),
                      Expanded(child: _buildNumberFormField(CokBaskKarisikController, 'Çok Baskılı Karışık: %'),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildNumberFormField(CokBaskKarisikAdetController,'Adet:'),
                      )
                    ], ),
                    Row( children: [
                      const SizedBox(width: 10,height: 60,),
                      Expanded(child: _buildNumberFormField(EkstraBeyazController, 'Ekstra Beyaz: %'),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildNumberFormField(EkstraBeyazAdetController,'Adet:'),
                      )
                    ], )
        ],
            ),
                  ],

                if (kagitTuruController.text == 'Selüloz')
                  ...[
                   Column(
                  children: [
                    _buildTextFormField(AciklamaSelController, 'Açıklama Selüloz'),
                    Row(children: [
                      const SizedBox(width: 10,height: 80,),
                      Expanded(
                        child:   _buildNumberFormField(BctmpController, 'BCTMP: %'),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child:  _buildNumberFormField(BctmpAdetController,'Adet:'),
                      )
                    ],),
                    Row(children: [
                      const SizedBox(width: 10,height: 60,),
                      Expanded(
                        child:   _buildNumberFormField(BhkpController, 'BHKP: %'),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child:  _buildNumberFormField(BhkpAdetController,'Adet:'),
                      )
                    ],),
                    Row(children: [
                      const SizedBox(width: 10,height: 80,),
                      Expanded(
                        child:   _buildNumberFormField(BskpController, 'BSKP: %'),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child:  _buildNumberFormField(BskpAdetController,'Adet:'),
                      )
                    ],),
                    Row(children: [
                      const SizedBox(width: 10,height: 60,),
                      Expanded(
                        child:   _buildNumberFormField(GroundWoodController, 'GROUNDWOOD: %'),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child:  _buildNumberFormField(GroundWoodAdetController,'Adet:'),
                      )
                    ],),
                    Row(children: [
                      const SizedBox(width: 10,height: 80,),
                      Expanded(
                        child:   _buildNumberFormField(MpCtmpController, 'MP-CTMP: %'),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child:  _buildNumberFormField(MpCtmpAdetController,'Adet:'),
                      )
                    ],),
                    Row(children: [
                      const SizedBox(width: 10,height: 60,),
                      Expanded(
                        child:   _buildNumberFormField(UkpController, 'UKP: %'),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child:  _buildNumberFormField(UkpAdetController,'Adet:'),
                      )
                    ],),







            ],
            ),
                  ],

                if (kagitTuruController.text == 'Yaş Mukavemetli')
                 ...[
                Column(

                children: [
                  _buildTextFormField(AciklamaYasController, 'Açıklama Yaş Mukavemetli: %'),
                  const SizedBox(width: 10,height: 10,),
                  Row(children: [
                    const SizedBox(width: 10,height: 60,),
                    Expanded(
                      child:  _buildNumberFormField(YasMukavemetController, 'Yaş Mukavemet %'),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child:  _buildNumberFormField(YasMukavemetAdetController,'Adet:'),
                    )
                  ],),
                  Row(children: [
                    const SizedBox(width: 10,height: 75,),
                    Expanded(
                      child: _buildNumberFormField(LikidController, 'Likid: %'),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child:  _buildNumberFormField(LikidAdetController,'Adet:'),
                    )
                  ],),
                  Row(children: [
                    const SizedBox(width: 10,height: 60,),
                    Expanded(
                      child:  _buildNumberFormField(KartonBardakController, 'Karton Bardak: %'),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child:  _buildNumberFormField(KartonBardakAdetController,'Adet:'),
                    )
                  ],),

                  const SizedBox(width: 10,height: 10,),

                ],
                   ),
                                ],
                    if (kagitTuruController.text == 'Gazete')
                  ...[
                    _buildTextFormField(AciklamaGazeController, 'Açıklama Gazete'),
                    const SizedBox(width: 10,height: 10,),
                    Row(children: [
                      const SizedBox(width: 10,height: 60,),
                      Expanded(
                        child:    _buildNumberFormField(KarisikMixGazeController, 'Karışık Mix Gazete: %'),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child:  _buildNumberFormField(KarisikMixGazeAdetController,'Adet:'),
                      )
                    ],),
                    Row(children: [
                      const SizedBox(width: 10,height: 80,),
                      Expanded(
                        child:         _buildNumberFormField(IAdeController, 'IADE: %'),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child:  _buildNumberFormField(IAdeAdetController,'Adet:'),
                      )
                    ],),
                    Row(children: [
                      const SizedBox(width: 10,height: 65,),
                      Expanded(
                        child:    _buildNumberFormField(ToplamaController, 'Toplama: %'),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child:  _buildNumberFormField(ToplamaAdetController,'Adet:'),
                      )
                    ],),
                  ],
                           ], )),
                const SizedBox(height: 16.0),
                _buildImagePickerButtons(),

                if (_images.isNotEmpty) _buildImageGrid(),

                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    void showAlert(String message) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Uyarı'),
                            content: Text(message),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Tamam'),
                              ),
                            ],
                          );
                        },
                      );
                    }

                    // Verilerin geçerliliğini kontrol et
                    bool isValid = true;
                    String errorMessage = '';
                    double totalPercentage = 0;

                    // Form alanlarını kontrol et ve toplamı hesapla
                    List<TextEditingController> controllers = [
                      karisikOraniController,
                      KarisikMixKahController,
                      KirpintOlukController,
                      KraftOlukController,
                      KromaKartonController,
                      MarketController,
                      OccAController,
                      OccBController,
                      OccCController,
                      Ps11Controller,
                      Ps12Controller,
                      SelulozKraftHurController,
                      SivamaOlkController,
                    ];

                    for (var controller in controllers) {
                      final value = double.tryParse(controller.text);
                      if (value != null) {
                        if (value < 0 || value > 100) {
                          isValid = false;
                          errorMessage = 'Kahverengi kağıt türlerinin oranı 0 ile 100 arasında olmalıdır.';
                          break;
                        }
                        totalPercentage += value;
                      }
                    }

                    if (totalPercentage < 0 || totalPercentage > 100) {
                      isValid = false;
                      errorMessage = 'Kahverengi atık kağıt türlerinin toplam oranı 0 ile 100 arasında olmalıdır.';
                    }

                    // Eğer geçerli değilse, uyarı mesajını göster
                    if (!isValid) {
                      showAlert(errorMessage);
                      return;
                    }

                    // Beyaz Kağıt Değerlerini Kontrol Et
                    double beyazTotal = _calculateBeyazTotal();

                    // Eğer toplam 0 ile 100 arasında değilse uyarı göster
                    if (beyazTotal < 0 || beyazTotal > 100) {
                      _showAlertDialog(context, "Beyaz atık kağıt değerleri toplamı 0 ile 100 arasında olmalıdır.");
                      return;
                    }

                    // Eğer geçerli değilse, uyarı mesajını göster
                    if (!isValid) {
                      showAlert(errorMessage);
                      return;
                    }

                    // Seluloz Kağıt Değerlerini Kontrol Et
                    double SelulozTotal = _calculateSelulozTotal();

                    // Eğer toplam 0 ile 100 arasında değilse uyarı göster
                    if (SelulozTotal < 0 || SelulozTotal > 100) {
                      _showAlertDialogs(context, "Seluloz atık kağıt değerleri toplamı 0 ile 100 arasında olmalıdır.");
                      return;
                    }

                    // Eğer geçerli değilse, uyarı mesajını göster
                    if (!isValid) {
                      showAlert(errorMessage);
                      return;
                    }

                    // Seluloz Kağıt Değerlerini Kontrol Et
                    double Yasmukavemet = _calculateYasTotal();

                    // Eğer toplam 0 ile 100 arasında değilse uyarı göster
                    if (Yasmukavemet < 0 || Yasmukavemet > 100) {
                      _showAlertDialogss(context, "Yaş Mukavemetli atık kağıt değerleri toplamı 0 ile 100 arasında olmalıdır.");
                      return;
                    }

                    if (!isValid) {
                      showAlert(errorMessage);
                      return;
                    }

                    // Seluloz Kağıt Değerlerini Kontrol Et
                    double Gazete = _calculateGazeteTotal();

                    // Eğer toplam 0 ile 100 arasında değilse uyarı göster
                    if ( Gazete < 0 || Gazete > 100) {
                      _showAlertDialogsss(context, " Gazete atık kağıt değerleri toplamı 0 ile 100 arasında olmalıdır.");
                      return;
                    }
                    int balyaSayisi = int.parse(balyaSayisiController.text);

                    int toplamKahverengiAdet = 0;
                    int toplamYasMukavemetAdet = 0;
                    int toplamBeyazAdet = 0;
                    int toplamSelulozAdet=0;
                    int toplamGazeteAdet=0;


                    // Kahverengi Atık Kağıt Türleri için adet toplamı
                    if (karisikOraniAdetController.text.isNotEmpty) {
                      toplamKahverengiAdet += int.parse(karisikOraniAdetController.text);
                    }
                    if (KarisikMixKahAdetController.text.isNotEmpty) {
                      toplamKahverengiAdet += int.parse(KarisikMixKahAdetController.text);
                    }
                    if (KirpintOlukAdetController.text.isNotEmpty) {
                      toplamKahverengiAdet += int.parse(KirpintOlukAdetController.text);
                    }
                    if (KraftOlukControllerAdet.text.isNotEmpty) {
                      toplamKahverengiAdet += int.parse(KraftOlukControllerAdet.text);
                    }
                    if (KromaKartonAdetController.text.isNotEmpty) {
                      toplamKahverengiAdet += int.parse(KromaKartonAdetController.text);
                    }
                    if (MarketAdetController.text.isNotEmpty) {
                      toplamKahverengiAdet += int.parse(MarketAdetController.text);
                    }
                    if (OccAAdetController.text.isNotEmpty) {
                      toplamKahverengiAdet += int.parse(OccAAdetController.text);
                    }
                    if (OccBAdetContController.text.isNotEmpty) {
                      toplamKahverengiAdet += int.parse(OccBAdetContController.text);
                    }
                    if (OccCAdetController.text.isNotEmpty) {
                      toplamKahverengiAdet += int.parse(OccCAdetController.text);
                    }
                    if (Ps11AdetController.text.isNotEmpty) {
                      toplamKahverengiAdet += int.parse(Ps11AdetController.text);
                    }
                    if (Ps12AdetCOontroller.text.isNotEmpty) {
                      toplamKahverengiAdet += int.parse(Ps12AdetCOontroller.text);
                    }
                    if (SelulozKrafHurAdetController.text.isNotEmpty) {
                      toplamKahverengiAdet += int.parse(SelulozKrafHurAdetController.text);
                    }
                    if (SivamaOlkAdetController.text.isNotEmpty) {
                      toplamKahverengiAdet += int.parse(SivamaOlkAdetController.text);
                    }

                    // Yaş Mukavemetli Kağıt Türleri için adet toplamı
                    if (YasMukavemetAdetController.text.isNotEmpty) {
                      toplamYasMukavemetAdet += int.parse(YasMukavemetAdetController.text);
                    }
                    if (LikidAdetController.text.isNotEmpty) {
                      toplamYasMukavemetAdet += int.parse(LikidAdetController.text);
                    }
                    if (KartonBardakAdetController.text.isNotEmpty) {
                      toplamYasMukavemetAdet += int.parse(KartonBardakAdetController.text);
                    }

                    // Kahverengi Atık Kağıt Türleri kontrolü
                    if (toplamKahverengiAdet > 0 && toplamKahverengiAdet != balyaSayisi) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Hata'),
                            content: Text('Balya sayısı ile kahverengi atık türlerinin adetleri eşit olmalıdır!'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Tamam'),
                              ),
                            ],
                          );
                        },
                      );
                      return; // İşlemi sonlandır
                    }

                    // Yaş Mukavemetli Kağıt Türleri kontrolü
                    if (toplamYasMukavemetAdet > 0 && toplamYasMukavemetAdet != balyaSayisi) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Hata'),
                            content: Text('Balya sayısı ile yaş mukavemetli kağıt türlerinin adetleri eşit olmalıdır!'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Tamam'),
                              ),
                            ],
                          );
                        },
                      );
                      return; // İşlemi sonlandır
                    }
                    if (BirinciKaliteAdetController.text.isNotEmpty) {
                      toplamBeyazAdet += int.parse(BirinciKaliteAdetController.text);
                    }
                    if (IkinciKaliteAdetController.text.isNotEmpty) {
                      toplamBeyazAdet += int.parse(IkinciKaliteAdetController.text);
                    }
                    if (UcuncuKaliteAdetController.text.isNotEmpty) {
                      toplamBeyazAdet += int.parse(UcuncuKaliteAdetController.text);
                    }
                    if (Bckk2AdetController.text.isNotEmpty) {
                      toplamBeyazAdet += int.parse(Bckk2AdetController.text);
                    }
                    if (CokBaskKarisikAdetController.text.isNotEmpty) {
                      toplamBeyazAdet += int.parse(CokBaskKarisikAdetController.text);
                    }
                    if (EkstraBeyazAdetController.text.isNotEmpty) {
                      toplamBeyazAdet += int.parse(EkstraBeyazAdetController.text);
                    }

                    // Kahverengi Atık Kağıt Türleri kontrolü (önceki kodda belirtilmişti)

                    // Yaş Mukavemetli Kağıt Türleri kontrolü (önceki kodda belirtilmişti)

                    // Beyaz Kağıt Türleri kontrolü
                    if (toplamBeyazAdet > 0 && toplamBeyazAdet != balyaSayisi) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Hata'),
                            content: Text('Balya sayısı ile beyaz kağıt türlerinin adetleri eşit olmalıdır!'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Tamam'),
                              ),
                            ],
                          );
                        },
                      );
                      return; // İşlemi sonlandır
                    }
                    if (BctmpAdetController.text.isNotEmpty) {
                      toplamSelulozAdet += int.parse(BctmpAdetController.text);
                    }
                    if (BhkpAdetController.text.isNotEmpty) {
                      toplamSelulozAdet += int.parse(BhkpAdetController.text);
                    }
                    if (BskpAdetController.text.isNotEmpty) {
                      toplamSelulozAdet += int.parse(BskpAdetController.text);
                    }
                    if (GroundWoodAdetController.text.isNotEmpty) {
                      toplamSelulozAdet += int.parse(GroundWoodAdetController.text);
                    }
                    if (MpCtmpAdetController.text.isNotEmpty) {
                      toplamSelulozAdet += int.parse(MpCtmpAdetController.text);
                    }
                    if (UkpController.text.isNotEmpty) {
                      toplamSelulozAdet += int.parse(UkpController.text);
                    }


                    // Beyaz Kağıt Türleri kontrolü
                    if (toplamSelulozAdet > 0 && toplamSelulozAdet != balyaSayisi) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Hata'),
                            content: Text('Balya sayısı ile Seluloz kağıt türlerinin adetleri eşit olmalıdır!'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Tamam'),
                              ),
                            ],
                          );
                        },
                      );
                      return; // İşlemi sonlandır
                    }
                    if (KarisikMixGazeAdetController.text.isNotEmpty) {
                      toplamGazeteAdet += int.parse(KarisikMixGazeAdetController.text);
                    }
                    if (IAdeAdetController.text.isNotEmpty) {
                      toplamGazeteAdet += int.parse(IAdeAdetController.text);
                    }
                    if (ToplamaAdetController.text.isNotEmpty) {
                      toplamGazeteAdet += int.parse(ToplamaAdetController.text);
                    }


                    // Beyaz Kağıt Türleri kontrolü
                    if (toplamGazeteAdet > 0 && toplamGazeteAdet != balyaSayisi) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Hata'),
                            content: Text('Balya sayısı ile Gazete kağıt türlerinin adetleri eşit olmalıdır!'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Tamam'),
                              ),
                            ],
                          );
                        },
                      );
                      return; // İşlemi sonlandır
                    }


                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Anasayfa(),
                      ),
                    );
                    context.read<Formguncelle2Cubit>().guncelle(
                        widget.bilgiler.ekspertizid,
                      ekpertizNoController.text,
                      IrsaliyeNo.text,
                      malKabulTarihiController.text,
                      gelisYeriController.text,
                      rutubetController.text,
                      yMaddesiController.text,
                      MekanikHamurController.text,
                      KuseController.text,
                      SinifDisiController.text,
                      preController.text,
                      balyaSayisiController.text,
                      tseController.text,
                      kabulController.text,
                      kagitTuruController.text,
                      AciklamaKahController.text,
                      karisikOraniController.text,
                      karisikOraniAdetController.text,
                      KarisikMixKahController.text,
                      KarisikMixKahAdetController.text,
                      KirpintOlukController.text,
                      KirpintOlukAdetController.text,
                      KraftOlukController.text,
                      KraftOlukControllerAdet.text,
                      KromaKartonController.text,
                      KromaKartonAdetController.text,
                      MarketController.text,
                      MarketAdetController.text,
                      OccAController.text,
                      OccCAdetController.text,
                      OccBController.text,
                      OccBAdetContController.text,
                      OccCController.text,
                      OccCAdetController.text,
                      Ps11Controller.text,
                      Ps11AdetController.text,
                      Ps12Controller.text,
                      Ps12AdetCOontroller.text,
                      SelulozKraftHurController.text,
                      SelulozKrafHurAdetController.text,
                      SivamaOlkController.text,
                      SivamaOlkAdetController.text,
                      AciklamaBeyController.text,
                      BirinciKaliteController.text,
                      BirinciKaliteAdetController.text,
                      IkinciKaliteController.text,
                      IkinciKaliteAdetController.text,
                      UcuncuKaliteController.text,
                      UcuncuKaliteAdetController.text,
                      Bckk2Controller.text,
                      Bckk2AdetController.text,
                      CokBaskKarisikController.text,
                      CokBaskKarisikAdetController.text,
                      EkstraBeyazController.text,
                      EkstraBeyazAdetController.text,
                      AciklamaSelController.text,
                      BctmpController.text,
                      BctmpAdetController.text,
                      BhkpController.text,
                      BhkpAdetController.text,
                      BskpController.text,
                      BskpAdetController.text,
                      GroundWoodController.text,
                      GroundWoodAdetController.text,
                      MpCtmpController.text,
                      MpCtmpAdetController.text,
                      UkpController.text,
                      UkpAdetController.text,
                      AciklamaYasController.text,
                      YasMukavemetController.text,
                      YasMukavemetAdetController.text,
                      LikidController.text,
                      LikidAdetController.text,
                      KartonBardakController.text,
                      KartonBardakAdetController.text,
                      AciklamaGazeController.text,
                      KarisikMixGazeController.text,
                      KarisikMixGazeAdetController.text,
                      IAdeController.text,
                      IAdeAdetController.text,
                      ToplamaController.text,
                      ToplamaAdetController.text,
                    );
                  },
                  child: const Text('Guncelle'),
                ),
              ],
            ),
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

    // Mevcut değeri kontrol et, listedeki bir değerle eşleşmiyorsa null yap
    String? currentValue;
    if (items.contains(controller.text)) {
      currentValue = controller.text;
    } else {
      currentValue = null;
      controller.text = ''; // Eğer eşleşmiyorsa TextController'ı sıfırla
    }

    return DropdownButtonFormField<String>(
      value: currentValue,
      onChanged: (newValue) {
        setState(() {
          controller.text = newValue ?? '';
        });
      },
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      decoration: InputDecoration(labelText: labelText),
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
          child: const Text(' Fotoğraf Seç'),
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
  // _buildNumberFormField metodunu buraya ekleyin
  Widget _buildNumberFormField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly, // Sadece sayı girişine izin verir
      ],
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$label boş olamaz';
        }
        return null;
      },
    );
  }
  double _calculateBeyazTotal() {
    double total = 0;
    List<TextEditingController> controllers = [
      BirinciKaliteController,
      IkinciKaliteController,
      UcuncuKaliteController,
      Bckk2Controller,
      CokBaskKarisikController,
      EkstraBeyazController
    ];

    for (var controller in controllers) {
      if (controller.text.isNotEmpty) {
        total += double.tryParse(controller.text) ?? 0;
      }
    }

    return total;
  }
  void _showAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Hata"),
          content: Text(message),
          actions: [
            ElevatedButton(
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
  double _calculateSelulozTotal() {
    double total = 0;
    List<TextEditingController> controllers = [
      BctmpController,
      BhkpController,
      BskpController,
      GroundWoodController,
      MpCtmpController,
      UkpController,
    ];

    for (var controller in controllers) {
      if (controller.text.isNotEmpty) {
        total += double.tryParse(controller.text) ?? 0;
      }
    }

    return total;
  }
  void _showAlertDialogs(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Hata"),
          content: Text(message),
          actions: [
            ElevatedButton(
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
  double _calculateYasTotal() {
    double total = 0;
    List<TextEditingController> controllers = [
      YasMukavemetController,
      LikidController,
      KartonBardakController,

    ];

    for (var controller in controllers) {
      if (controller.text.isNotEmpty) {
        total += double.tryParse(controller.text) ?? 0;
      }
    }

    return total;
  }
  void _showAlertDialogss(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Hata"),
          content: Text(message),
          actions: [
            ElevatedButton(
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
  double _calculateGazeteTotal() {
    double total = 0;
    List<TextEditingController> controllers = [
      KarisikMixGazeController,
      IAdeController,
      ToplamaController,

    ];

    for (var controller in controllers) {
      if (controller.text.isNotEmpty) {
        total += double.tryParse(controller.text) ?? 0;
      }
    }

    return total;
  }
  void _showAlertDialogsss(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Hata"),
          content: Text(message),
          actions: [
            ElevatedButton(
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
  Future<bool> _onWillPop() async {
    final bool? shouldPop = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Uyarı'),
          content: Text('Bilgiler kaydedilmedi. Çıkmak istediğinizden emin misiniz?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), // Hayır seçeneği
              child: Text('Hayır'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true), // Evet seçeneği
              child: Text('Evet'),
            ),
          ],
        );
      },
    );
    return shouldPop ?? false; // Kullanıcının yanıtına göre geri döner
  }




}
