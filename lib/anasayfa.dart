import 'package:flutter/material.dart';
import 'package:login_uygulamasi_gelismis/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  late String sp_kullanici_adi;
  late String sp_sifre;

  Future<void>oturum_bilgisi_oku() async {
    var sp = await SharedPreferences.getInstance();

    setState(() {
      sp_kullanici_adi = sp.getString("kullanici_adi") ?? "kullanıcı adı yok";
      sp_sifre = sp.getString("sifre") ?? "şifre yok";
    });
  }

    Future<void> cikis_yap() async {
      var sp = await SharedPreferences.getInstance();
      sp.remove("kullanici_adi");
      sp.remove("sifre");

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => login_ekrani()));
    }

    @override
    void initState() {
      super.initState();
      oturum_bilgisi_oku();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,
          title: Text("ANASAYFA"),
          actions: [

            IconButton(

              icon: Icon(Icons.exit_to_app_outlined),
              onPressed: () {
              cikis_yap();

              },
            ),

          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text("Kullanıcı adı: $sp_kullanici_adi ",
                  style: TextStyle(fontSize: 30),),
                Text("Şifre: $sp_sifre", style: TextStyle(fontSize: 30),),


              ],
            ),
          ),
        ),

      );
    }
  }

