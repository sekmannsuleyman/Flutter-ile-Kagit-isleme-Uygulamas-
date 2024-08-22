import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasarim3_proje/cubit/ekpertiz_form_cubit.dart';
import 'package:tasarim3_proje/cubit/ekpertiz_guncelle_cubit.dart';
import 'package:tasarim3_proje/cubit/formguncelle2Cubit.dart';

import 'package:tasarim3_proje/cubit/formguncelleCubit.dart';


import 'package:tasarim3_proje/cubit/yeni_kayit_cubit.dart';
import 'package:tasarim3_proje/views/KullaniciGiris.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid ? await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyD6o5KLuYr1ttX8v58pEytq9dOCc0da-SQ',
      appId: "1:910257832932:android:88eba7ce8de9ac156c3df1",
      messagingSenderId: '910257832932',
      projectId: 'tasarimproje3-8c1d1',)
  ) :  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return  MultiBlocProvider(
      providers: [

        BlocProvider(create: (context) => YeniKayitCubit()),
        BlocProvider(create: (context) => EkpertizFormCubit()),
        BlocProvider(create: (context) => EkpertizGuncelleCubit()),
        BlocProvider(create: (context) => FormGuncelleCubit()),
        BlocProvider(create: (context) => Formguncelle2Cubit()),







      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Kullanicigiris(),
      ),
    );
  }
}

