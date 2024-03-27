import 'package:flutter/material.dart';
import 'package:login_uygulamasi_gelismis/anasayfa.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  Future<bool>oturum_kontrol() async {
    var sp = await SharedPreferences.getInstance();

      String sp_kullanici_adi = sp.getString("kullanici_adi") ?? "kullanıcı adı yok";
      String sp_sifre = sp.getString("sifre") ?? "şifre yok";

      if(sp_kullanici_adi=="admin" && sp_sifre=="123"){
        return true;
      }
      else{
        return false;
      }


  }

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: FutureBuilder<bool>(

        future: oturum_kontrol(),
        builder: (context,snapshot){

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Veri yüklenirken gösterilecek bir yükleme göstergesi
          } else if (snapshot.hasError) {
            return Text('Hata: ${snapshot.error}'); // Hata durumunda gösterilecek bir mesaj
          } else {
            bool? oturumVarMi = snapshot.data;
            return oturumVarMi ?? false ? Anasayfa() : login_ekrani();
          }

        },
      ),
    );
  }
}

class login_ekrani extends StatefulWidget {

  @override
  State<login_ekrani> createState() => _login_ekraniState();
}

class _login_ekraniState extends State<login_ekrani> {

  var tf_kullanici_adi=TextEditingController();
  var tf_kullanici_sifre=TextEditingController();

  var scaffold_key=GlobalKey<ScaffoldState>();

  Future<void>giris_kontrol() async{

    var kull_a=tf_kullanici_adi.text;
    var s=tf_kullanici_sifre.text;

    if(kull_a=="admin" && s=="123" ){

      var sp=await SharedPreferences.getInstance();

      sp.setString("kullanici_adi", kull_a);
      sp.setString("sifre", s);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Anasayfa()));

    }

    else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Giriş Hatalı'),));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold_key,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("LOGİN EKRANI"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              TextField(
                controller: tf_kullanici_adi,
                decoration: InputDecoration(hintText: "Kullanıcı adı:"),

              ),

              TextField(
                obscureText: true,
                controller: tf_kullanici_sifre,
                decoration: InputDecoration(hintText: "Şifre:"),

              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(

                  child: Text("Giriş yap:"),
                  onPressed: (){
                    giris_kontrol();
                  },
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
