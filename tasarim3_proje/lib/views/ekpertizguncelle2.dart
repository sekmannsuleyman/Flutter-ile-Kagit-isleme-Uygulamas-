
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasarim3_proje/cubit/ekpertiz_guncelle_cubit.dart';

import 'package:tasarim3_proje/data/entity/plaka_giris.dart';


import 'package:tasarim3_proje/views/form_guncelle.dart';


class Ekpertizguncelle2 extends StatefulWidget {
  const Ekpertizguncelle2({super.key});

  @override
  State<Ekpertizguncelle2> createState() => _Ekpertizguncelle2State();
}

class _Ekpertizguncelle2State extends State<Ekpertizguncelle2> {
  bool aramayapiliyorMu=false;


@override
  void initState() {
    // TODO: implement initState
    super.initState();
   context.read<EkpertizGuncelleCubit>().BilgileriYukle();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: aramayapiliyorMu?
        TextField(
          decoration: const InputDecoration(hintText: "Ara"),
          onChanged: (aramSonucu){

          },
        ):
        const Text("Ekpertiz İdler"),
        actions: [
          aramayapiliyorMu ?
          IconButton(onPressed: (){
            setState(() {
              aramayapiliyorMu=false;
            });

          }, icon: const Icon(Icons.clear)):
          IconButton(onPressed: (){

            setState(() {
              aramayapiliyorMu=true;
            });
          }, icon: const Icon(Icons.search))
        ],

      ),


      body: BlocBuilder<EkpertizGuncelleCubit,List<PlakaGiris>>(


        builder:(context,bilgi){
          if(bilgi.isNotEmpty){

            return ListView.builder(
              itemCount: bilgi.length,
              itemBuilder: (context,indeks){
                var bilgiler= bilgi[indeks];

                return GestureDetector(
                  onTap: (){

                    Navigator.push(context,MaterialPageRoute(builder: (context)=> FormGuncelle(bilgiler: bilgiler)));
                  },
                  child: Card(
                    child: SizedBox( height: 70,
                      child: Row(
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(left:8),
                            child: Column( mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                              children: [
                                Text(bilgiler.ekspertizNo,style: TextStyle(fontSize: 18),),




                              ],


                            ),
                          ),
                          const Spacer(),
                          IconButton(onPressed: (){
                            setState(() {

                            });
                          }, icon: const Icon(Icons.clear,color: Colors.black54,))



                        ],



                      ),
                    ),

                  ),
                );


              },

            );

          }
          else{
            return const Center();

          }


        },



      ),
























    );
  }

}
