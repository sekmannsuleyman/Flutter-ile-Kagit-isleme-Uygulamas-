import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:tasarim3_proje/cubit/ekpertiz_form_cubit.dart';
import 'package:tasarim3_proje/views/anasayfa.dart'; // Medya tarayıcısını güncellemek için
import 'dart:math';
import 'package:flutter/material.dart';


class EkpertizForm extends StatefulWidget {
  final String eksperitNo;

  const EkpertizForm({Key? key, required this.eksperitNo}) : super(key: key);

  @override
  State<EkpertizForm> createState() => _EkpertizFormState();
}

class _EkpertizFormState extends State<EkpertizForm> {
  final _formKey = GlobalKey<FormState>();

  // Tüm controller'lar
  final ekpertizNoController = TextEditingController();
  final IrsaliyeNo= TextEditingController();
  final malKabulTarihiController = TextEditingController();
  final gelisYeriController = TextEditingController();
  final rutubetController = TextEditingController();
  final yMaddesiController = TextEditingController();
  final MekanikHamurController= TextEditingController(text: '0');
  final KuseController=TextEditingController(text: '0');
  final SinifDisiController= TextEditingController(text: '0');
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
  final Ps12COontroller= TextEditingController();
  final Ps12AdetCOontroller= TextEditingController();
  final SelulozKrafHurController= TextEditingController();
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
  final Aciklama_yasController= TextEditingController();
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
  final TextEditingController _irsaliyeNoController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<File> _images = [];
  String? selectedKagitTuru;

  void resetAllFields() {
    // Beyaz Atık Kağıt
    AciklamaBeyController.clear();
    BirinciKaliteController.clear();
    BirinciKaliteAdetController.clear();
    IkinciKaliteController.clear();
    IkinciKaliteAdetController.clear();
    UcuncuKaliteController.clear();
    UcuncuKaliteAdetController.clear();
    Bckk2Controller.clear();
    Bckk2AdetController.clear();
    CokBaskKarisikController.clear();
    CokBaskKarisikAdetController.clear();
    EkstraBeyazController.clear();
    EkstraBeyazAdetController.clear();
     selectedKagitTuru;
    // Kahverengi Atık Kağıt
    AciklamaKahController.clear();
    karisikOraniController.clear();
    karisikOraniAdetController.clear();
    KarisikMixKahController.clear();
    KarisikMixKahAdetController.clear();
    KirpintOlukController.clear();
    KirpintOlukAdetController.clear();
    KraftOlukController.clear();
    KraftOlukControllerAdet.clear();
    KromaKartonController.clear();
    KromaKartonAdetController.clear();
    MarketController.clear();
    MarketAdetController.clear();
    OccAController.clear();
    OccAAdetController.clear();
    OccBController.clear();
    OccBAdetContController.clear();
    OccCController.clear();
    OccCAdetController.clear();
    Ps11Controller.clear();
    Ps11AdetController.clear();
    Ps12COontroller.clear();
    Ps12AdetCOontroller.clear();
    SelulozKrafHurController.clear();
    SelulozKrafHurAdetController.clear();
    SivamaOlkController.clear();
    SivamaOlkAdetController.clear();

    // Selüloz
    AciklamaSelController.clear();
    BctmpController.clear();
    BctmpAdetController.clear();
    BhkpController.clear();
    BhkpAdetController.clear();
    BskpController.clear();
    BskpAdetController.clear();
    GroundWoodController.clear();
    GroundWoodAdetController.clear();
    MpCtmpController.clear();
    MpCtmpAdetController.clear();
    UkpController.clear();
    UkpAdetController.clear();

    // Yaş Mukavemetli
    Aciklama_yasController.clear();
    YasMukavemetController.clear();
    YasMukavemetAdetController.clear();
    LikidController.clear();
    LikidAdetController.clear();
    KartonBardakController.clear();
    KartonBardakAdetController.clear();

    // Gazete
    AciklamaGazeController.clear();
    KarisikMixGazeController.clear();
    KarisikMixGazeAdetController.clear();
    IAdeController.clear();
    IAdeAdetController.clear();
    ToplamaController.clear();
    ToplamaAdetController.clear();
  }



  void _fetchData() async {
    try {
      // Firestore'dan veriyi alın
      DocumentSnapshot document = await _firestore.collection('KullaniciGiris').doc('someDocumentId').get();

      if (document.exists) {
        // Veriyi al ve TextEditingController'a ata
        String irsaliyeNo = document.get('IrsaliyeNo'); // Alan adını Firestore'daki alan adıyla uyumlu hale getirin
        _irsaliyeNoController.text = irsaliyeNo;
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
  // 5 haneli rastgele bir sayı üretir
  String _generateRandomNumber() {
    final Random random = Random();
    return random.nextInt(90000).toString().padLeft(5, '0'); // 00000 ile 99999 arasında rastgele sayı
  }



  Future<void> _createDirectories() async {
    final Directory? externalStorageDir = await getExternalStorageDirectory();
    if (externalStorageDir == null) {
      print("External storage directory not found");
      return;
    }

    final String appPath = externalStorageDir.path;
    final String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final String eksperitNoFolder = widget.eksperitNo;

    final Directory dateDir = Directory('$appPath/$todayDate');
    if (!await dateDir.exists()) {
      await dateDir.create(recursive: true);
      print('Tarih klasörü oluşturuldu: ${dateDir.path}');
    }

    final Directory eksperitNoDir = Directory('${dateDir.path}/$eksperitNoFolder');
    if (!await eksperitNoDir.exists()) {
      await eksperitNoDir.create(recursive: true);
      print('Ekspertiz No klasörü oluşturuldu: ${eksperitNoDir.path}');
    }
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
        final String eksperitNoFolder = widget.eksperitNo;

        final String filePath = '${appPath}/${todayDate}/${eksperitNoFolder}/${pickedFile.name}';

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

  void _setInitialDate() {
    // Bugünün tarihini al
    DateTime now = DateTime.now();
    String formattedDate = "${now.day}/${now.month}/${now.year}";
    malKabulTarihiController.text = formattedDate; // Controller'a tarih ekle
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
    var eksperitNo =widget.eksperitNo;
    ekpertizNoController.text=eksperitNo;
    _setInitialDate();
  }

  Future<void> _loadEkspertizNo() async {
    // Veritabanından ekspertizNo'yu alın ve widget.eksperitNo'yu güncelleyin
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ekpertiz Formu'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0, top: 32.0),
                  child: _buildTextFormField(ekpertizNoController,
                    'Ekspertiz No',
                    readonly: true,
                  ),
                ),
                _buildTextFormField(_irsaliyeNoController, 'Irsaliye No'),
                _buildDateField(malKabulTarihiController, 'Mal Kabul Tarihi', context),
                _buildTextFormField(gelisYeriController, 'Geliş Yeri'),
                Row(
                  children: [

                    Expanded(

                        child: _buildNumberFormField(rutubetController, 'xxx: %')),
                    const SizedBox(width: 16.0,height: 80,),
                    Expanded(
                        child: _buildNumberFormField(yMaddesiController, 'xxx: %')),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(height: 40,),
                    Expanded(
                        child: _buildNumberFormField(MekanikHamurController, 'xxx:%')),
                    const SizedBox(width: 16.0),
                    Expanded(
                        child: _buildNumberFormField(KuseController, 'xxx:%')),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(height: 80,),
                    Expanded(
                        child: _buildNumberFormField(SinifDisiController, 'xx%')),
                    const SizedBox(width: 16.0),
                    Expanded(
                        child: _buildNumberFormField(preController, 'xxx')),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildNumberFormField(balyaSayisiController, 'z'),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: _buildDropdownButtonFormField(tseController, 'TSE', ['AO2', 'AO3', 'AO4','AO5','AO6','AO7','AO8']),
                    ),
                  ],
                ),
                _buildDropdownButtonFormField(kabulController, 'Kabul', ['Kabul', 'Red']),
                DropdownButtonFormField<String>(
                  value: selectedKagitTuru,
                  items: ['x', 'y', 'z', 't', 'f']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      resetAllFields();  // Form alanlarını sıfırlamak için resetAllFields() çağrısı
                      selectedKagitTuru = newValue;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Kağıt Türü',
                  ),
                ),
                if (selectedKagitTuru == 'x')
                  _buildKahverengiFields(),
                if (selectedKagitTuru == 'y')
                  _buildBeyazFields(),
                if (selectedKagitTuru == 'z')
                  _buildSelulozFields(),
                if (selectedKagitTuru == 't')
                  _buildYasMukavemetliFields(),
                if (selectedKagitTuru == 'f')
                  _buildGazeteFields(),

                const SizedBox(height: 16.0),
                _buildImagePickerButtons(),

                if (_images.isNotEmpty) _buildImageGrid(),

                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {// Uyarı mesajı için gösterilecek fonksiyon
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
                      Ps12COontroller,
                      SelulozKrafHurController,
                      SivamaOlkController,
                    ];

                    for (var controller in controllers) {
                      final value = double.tryParse(controller.text);
                      if (value != null) {
                        if (value < 0 || value > 100) {
                          isValid = false;
                          errorMessage = 'x kağıt türlerinin oranı 0 ile 100 arasında olmalıdır.';
                          break;
                        }
                        totalPercentage += value;
                      }
                    }

                    if (totalPercentage < 0 || totalPercentage > 100) {
                      isValid = false;
                      errorMessage = 'x atık kağıt türlerinin toplam oranı 0 ile 100 arasında olmalıdır.';
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
                      _showAlertDialog(context, "y atık kağıt değerleri toplamı 0 ile 100 arasında olmalıdır.");
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
                      _showAlertDialogs(context, "z atık kağıt değerleri toplamı 0 ile 100 arasında olmalıdır.");
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
                      _showAlertDialogss(context, "t atık kağıt değerleri toplamı 0 ile 100 arasında olmalıdır.");
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
                      _showAlertDialogsss(context, " f atık kağıt değerleri toplamı 0 ile 100 arasında olmalıdır.");
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
                            content: Text('Balya sayısı ile x atık türlerinin adetleri eşit olmalıdır!'),
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
                            content: Text('Balya sayısı ile t kağıt türlerinin adetleri eşit olmalıdır!'),
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
                            content: Text('Balya sayısı ile y kağıt türlerinin adetleri eşit olmalıdır!'),
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
                            content: Text('Balya sayısı ile z kağıt türlerinin adetleri eşit olmalıdır!'),
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
                            content: Text('Balya sayısı ile f kağıt türlerinin adetleri eşit olmalıdır!'),
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
                    context.read<EkpertizFormCubit>().kaydets(

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
                      selectedKagitTuru!,
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
                      Ps12COontroller.text,
                      Ps12AdetCOontroller.text,
                      SelulozKrafHurController.text,
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
                      Aciklama_yasController.text,
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
                  child: const Text('Kaydet'),
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

        _buildTextFormField(AciklamaKahController, 'Açıklama x:'),
        Row(children: [
          const SizedBox(width: 10,height: 68,),
          Expanded(
            child: _buildNumberFormField(karisikOraniController, 'a:%'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildNumberFormField(karisikOraniAdetController,' Adet'), ),
        ],),
        const SizedBox(height: 0,),
        Row(children: [
          const SizedBox(width: 10,height: 80,),
          Expanded(
            child: _buildNumberFormField(KarisikMixKahController, 'b:%'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildNumberFormField(KarisikMixKahAdetController ,'Adet:'  ), ),
        ],),

        Row(children: [
          const SizedBox(width: 10,height: 40,),
          Expanded(
            child: _buildNumberFormField(KirpintOlukController, 'c:%'),
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: _buildNumberFormField(KirpintOlukAdetController,'Adet:'),)
        ],),
        Row(children: [
          const SizedBox(width: 10,height: 90,),
          Expanded(
            child: _buildNumberFormField(KraftOlukController, 'ç:%'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildNumberFormField(KraftOlukControllerAdet,'Adet:'),)
        ],),


        Row(children: [
          const SizedBox(width: 10,height: 50,),
          Expanded(
            child: _buildNumberFormField(KromaKartonController, 'd:%'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildNumberFormField(KromaKartonAdetController,'Adet:'),
          )
        ],),
        Row(children: [
          const SizedBox(width: 10,height: 90,),
          Expanded(
            child: _buildNumberFormField(MarketController, 'e:%'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildNumberFormField(MarketAdetController,'Adet'),
          )
        ],),

        Row(children: [
          const SizedBox(width: 10,height: 60,),
          Expanded(
            child: _buildNumberFormField(OccAController, 'f:%'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child:  _buildNumberFormField(OccAAdetController,'Adet:'),
          )
        ],),
        Row(children: [
          const SizedBox(width: 10,height: 80,),
          Expanded(
            child: _buildNumberFormField(OccBController, 'g%'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child:  _buildNumberFormField(OccBAdetContController,'Adet:'),
          )
        ],),
        Row(children: [
          const SizedBox(width: 10,height: 60,),
          Expanded(
            child:  _buildNumberFormField(OccCController, 'ğ:%'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child:    _buildNumberFormField(OccCAdetController,'Adet'),
          )
        ],),
        Row(children: [
          const SizedBox(width: 10,height: 80,),
          Expanded(
            child:  _buildNumberFormField(Ps11Controller, 'h:%'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child:    _buildNumberFormField(Ps11AdetController, 'Adet'),
          )
        ],),

        Row(children: [
          const SizedBox(width: 10,height: 60,),
          Expanded(
            child:  _buildNumberFormField(Ps12COontroller, 'ı:%'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child:   _buildNumberFormField(Ps12AdetCOontroller,'Adet'),
          )
        ],),
        Row(children: [
          const SizedBox(width: 10,height: 80,),
          Expanded(
            child:  _buildNumberFormField(SelulozKrafHurController, 'i :%'),
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
            child:   _buildNumberFormField(SivamaOlkController, 'j: %'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child:   _buildNumberFormField(SivamaOlkAdetController,'Adet'),
          )
        ],),
        const SizedBox(width: 20,height: 12,),



      ],
    );
  }

  Widget _buildBeyazFields() {
    return Column(
      children: [
        const SizedBox(width: 10,height: 10,),
        _buildTextFormField(AciklamaBeyController, 'Açıklama y'),
        Row(
          children: [
            const SizedBox(width: 10,height: 80,),
            Expanded(
              child: _buildNumberFormField(BirinciKaliteController, 'k: %'),
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
              child: _buildNumberFormField(IkinciKaliteController, 'l: %'),
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
            child :_buildNumberFormField(UcuncuKaliteController, 'm %'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildNumberFormField(UcuncuKaliteAdetController,'Adet'),

          )  ],) ,
        Row( children: [
          const SizedBox(width: 10,height: 60,),
          Expanded(
            child :_buildNumberFormField(Bckk2Controller, ' n%'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildNumberFormField(Bckk2AdetController,'Adet:'),

          )  ],) ,
        Row( children: [
          const SizedBox(width: 10,height: 80,),
          Expanded(child: _buildNumberFormField(CokBaskKarisikController, 'o: %'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildNumberFormField(CokBaskKarisikAdetController,'Adet:'),
          )
        ], ),
        Row( children: [
          const SizedBox(width: 10,height: 60,),
          Expanded(child: _buildNumberFormField(EkstraBeyazController, 'ö %'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildNumberFormField(EkstraBeyazAdetController,'Adet:'),
          )
        ], )
      ],
    );
  }


  Widget _buildSelulozFields() {
    return Column(
      children: [
        _buildTextFormField(AciklamaSelController, 'Açıklama z'),
        Row(children: [
          const SizedBox(width: 10,height: 80,),
          Expanded(
            child:   _buildNumberFormField(BctmpController, 'p: %'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child:  _buildNumberFormField(BctmpAdetController,'Adet:'),
          )
        ],),
        Row(children: [
          const SizedBox(width: 10,height: 60,),
          Expanded(
            child:   _buildNumberFormField(BhkpController, 'r: %'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child:  _buildNumberFormField(BhkpAdetController,'Adet:'),
          )
        ],),
        Row(children: [
          const SizedBox(width: 10,height: 80,),
          Expanded(
            child:   _buildNumberFormField(BskpController, 's: %'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child:  _buildNumberFormField(BskpAdetController,'Adet:'),
          )
        ],),
        Row(children: [
          const SizedBox(width: 10,height: 60,),
          Expanded(
            child:   _buildNumberFormField(GroundWoodController, 'ş: %'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child:  _buildNumberFormField(GroundWoodAdetController,'Adet:'),
          )
        ],),
        Row(children: [
          const SizedBox(width: 10,height: 80,),
          Expanded(
            child:   _buildNumberFormField(MpCtmpController, 't: %'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child:  _buildNumberFormField(MpCtmpAdetController,'Adet:'),
          )
        ],),
        Row(children: [
          const SizedBox(width: 10,height: 60,),
          Expanded(
            child:   _buildNumberFormField(UkpController, 'u: %'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child:  _buildNumberFormField(UkpAdetController,'Adet:'),
          )
        ],),

      ],
    );
  }

  Widget _buildYasMukavemetliFields() {
    return Column(

      children: [
        _buildTextFormField(Aciklama_yasController, 't: %'),
        const SizedBox(width: 10,height: 10,),
        Row(children: [
          const SizedBox(width: 10,height: 60,),
          Expanded(
            child:  _buildNumberFormField(YasMukavemetController, 'ü %'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child:  _buildNumberFormField(YasMukavemetAdetController,'Adet:'),
          )
        ],),
        Row(children: [
          const SizedBox(width: 10,height: 75,),
          Expanded(
            child: _buildNumberFormField(LikidController, 'v: %'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child:  _buildNumberFormField(LikidAdetController,'Adet:'),
          )
        ],),
        Row(children: [
          const SizedBox(width: 10,height: 60,),
          Expanded(
            child:  _buildNumberFormField(KartonBardakController, 'y: %'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child:  _buildNumberFormField(KartonBardakAdetController,'Adet:'),
          )
        ],),

        const SizedBox(width: 10,height: 10,),

      ],
    );
  }

  Widget _buildGazeteFields() {
    return Column(
      children: [
        _buildTextFormField(AciklamaGazeController, 'Açıklama t'),
        const SizedBox(width: 10,height: 10,),
        Row(children: [
          const SizedBox(width: 10,height: 60,),
          Expanded(
            child:    _buildNumberFormField(KarisikMixGazeController, ' z: %'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child:  _buildNumberFormField(KarisikMixGazeAdetController,'Adet:'),
          )
        ],),
        Row(children: [
          const SizedBox(width: 10,height: 80,),
          Expanded(
            child:         _buildNumberFormField(IAdeController, 't: %'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child:  _buildNumberFormField(IAdeAdetController,'Adet:'),
          )
        ],),
        Row(children: [
          const SizedBox(width: 10,height: 65,),
          Expanded(
            child:    _buildNumberFormField(ToplamaController, 'w: %'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child:  _buildNumberFormField(ToplamaAdetController,'Adet:'),
          )
        ],),


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
          child: const Text('Cihazdan Görsel Seç'),
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
  void _validateForm() {
    int balyaSayisi = int.parse(balyaSayisiController.text);

    int toplamKahverengiAdet = 0;
    int toplamYasMukavemetAdet = 0;

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


  }





}
