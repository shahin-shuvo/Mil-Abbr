
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mil_abbr/all_abbr.dart';
import 'package:mil_abbr/CustomShape_Image.dart';
import 'package:mil_abbr/landing_page.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual);
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => const LandingPage()
          ));
    });
  }

  // @override
  // void dispose() {
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: SystemUiOverlay.values);
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/milbg-3.png"), fit: BoxFit.cover,
          )
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Card( // with Card
              elevation: 30.0,
              shape: CircleBorder(),

              clipBehavior: Clip.antiAlias, // with Card
              child: Image(image: AssetImage("assets/images/logo_army.png"), width: 80,),
            ),

            SizedBox(height: 20,),
            Text("In War, In Peace,\n We are everywhere for our Nation", textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 400,),
            Image(image: AssetImage("assets/images/splash_lower_1.jpg"),
                alignment: Alignment.topRight)
          ],

        ),
      ),
    );
  }
}

