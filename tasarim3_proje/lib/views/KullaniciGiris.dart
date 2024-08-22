import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasarim3_proje/views/anasayfa.dart';

class Kullanicigiris extends StatefulWidget {
  const Kullanicigiris({super.key});

  @override
  State<Kullanicigiris> createState() => _KullanicigirisState();
}

class _KullanicigirisState extends State<Kullanicigiris> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _login() async {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      // Hatalı giriş durumu
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kullanıcı adı veya şifre boş olamaz!')),
      );
      return;
    }

    try {
      // Firestore'dan kullanıcı bilgilerini kontrol et
      final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('KullaniciGiris')
          .where('KullaniciAdi', isEqualTo: username)
          .where('Sifre', isEqualTo: password)
          .get();

      if (snapshot.docs.isNotEmpty) {
        // Giriş başarılı
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Anasayfa()),
        );
      } else {
        // Hatalı giriş durumu
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Kullanıcı adı veya şifre hatalı!')),
        );
      }
    } catch (e) {
      // Hata durumu
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bir hata oluştu!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kullanıcı Girişi'),
      ),
      backgroundColor: Colors.blue.shade100, // Arka plan rengini mavi yapıyoruz
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Kullanıcı Adı',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white, // Arka plan rengini beyaz yapıyoruz
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Şifre',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white, // Arka plan rengini beyaz yapıyoruz
                    ),
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: _login,
                    child: const Text('Gönder'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
