import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasarim3_proje/data/repo/httpkullanimi.dart';

import 'package:tasarim3_proje/views/ekpertizguncelle2.dart';


import 'package:tasarim3_proje/views/yeni_kayit.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(title: const Text("Ana Menü",style: TextStyle(fontSize: 35),),
        backgroundColor: Colors.cyan,


      ),

      body: Padding(
        padding: const EdgeInsets.only(top: 55),
        child: Center(

          child: Column(
            children: [

              SizedBox(
                width:300,
                height: 100,
                child: ElevatedButton(onPressed: (){

                  Navigator.push(context, MaterialPageRoute(builder: (context) => const YeniKayit()))
                      .then((value){
                    print("Ana Sayfaya Dönüldü");
                  });
                }, child:

                Text("Ekspertiz Girişi",style: TextStyle(fontSize: 25,color: Colors.black),)

                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top:40),
                child: SizedBox(
                  width:300,
                  height: 100,
                  child: ElevatedButton(onPressed: (){

                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  Ekpertizguncelle2()))  .then((value){
                      print("Ana Sayfaya Dönüldü");
                    });
                  }, child:

                  Text("Ekspertiz Güncelle",style: TextStyle(fontSize: 25,color: Colors.black),)

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:40),
                child: SizedBox(
                  width:300,
                  height: 100,
                  child: ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>UploadDirectoryPage()));
                  }, child:

                  Text("Merkeze Aktarım",style: TextStyle(fontSize: 25,color: Colors.black),)

                  ),
                ),
              ),















            ],



















          ),
        ),
      ),


























    );
  }
}
