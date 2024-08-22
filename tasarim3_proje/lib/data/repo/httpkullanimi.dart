import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

class UploadDirectoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Merkeze Aktarım'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Dosyaları ve klasörleri yüklemek için işlemleri başlatın
            await uploadDirectory();
          },
          child: Text('Dosyaları Yükle'),
        ),
      ),
    );
  }

  Future<void> uploadDirectory() async {
    final directory = await getExternalStorageDirectory(); // Dış depolama dizinini alın
    if (directory == null) return;

    // Android/data/com.example.tasarim3_proje/files dizinini alın
    final dirPath = path.join(directory.path); // Klasör yolu
    final dir = Directory(dirPath);
    if (!await dir.exists()) {
      print('Klasör bulunamadı: $dirPath');
      return;
    }

    // Klasör içindeki dosyaları ve alt klasörleri listeleyin
    final items = dir.listSync(recursive: true);

    // Sadece dosyaları yükleyin, ekstra klasör oluşturmayın
    for (var item in items) {
      if (item is File) {
        // Dosyayı sunucuya yükleyin
        await uploadFile(item, dirPath);
      }
    }
  }

  Future<void> uploadFile(File file, String rootDirPath) async {
    final uploadUrl = 'http://10.0.2.2:3000/upload'; // Sunucu URL'si

    try {
      final relativePath = path.relative(file.path, from: rootDirPath);
      final request = http.MultipartRequest('POST', Uri.parse(uploadUrl))
        ..fields['path'] = relativePath // Sunucuya dosyanın yolu hakkında bilgi gönderin
        ..files.add(await http.MultipartFile.fromPath('file', file.path));

      final response = await request.send();
      if (response.statusCode == 200) {
        print('Dosya başarıyla yüklendi: ${file.path}');
      } else {
        print('Dosya yüklenirken hata oluştu: ${response.statusCode}');
      }
    } catch (e) {
      print('Dosya yüklenirken hata oluştu: $e');
    }
  }
}
