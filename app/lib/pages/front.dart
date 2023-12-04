import 'dart:convert';
import 'package:he_fish/pages/login.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:he_fish/components/fish_typeslist.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class FrontPage extends StatefulWidget {
  static String tag = 'front-page';
  const FrontPage({super.key});

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  int uid = 0;

  @override
  void initState() {
    super.initState();
    getPref();
  }

  void getPref() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final int? id = prefs.getInt('id');
    setState(() {
      uid == id;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    showAlertDialog(BuildContext context) {
      // set up the buttons
      Widget cancelButton = TextButton(
        child: Text("Cancel"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      Widget continueButton = TextButton(
        child: Text("Continue"),
        onPressed: () async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ));
        },
      );

      AlertDialog alert = AlertDialog(
        title: Text("Confirmation"),
        content: Text("Are your sure want to logout ?"),
        actions: [
          cancelButton,
          continueButton,
        ],
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    final List<String> imgList = [
      'https://cdn.mos.cms.futurecdn.net/BgZFhT7piMqXpyzfWrdKyP.jpg',
      'https://cdn.mos.cms.futurecdn.net/4UdEs7tTKwLJbxZPUYR3hF.jpg',
      'https://3.bp.blogspot.com/-i841sdRFdGg/V82dQKUTJeI/AAAAAAAAEqs/i2QB0H29GOMQfbKZBjy7C_gKtrScaFnOQCK4B/s400/Ikan%2BCatfish.jpg',
      'https://img.inews.co.id/media/822/files/inews_new/2022/07/12/fakta_unik_tentang_ikan_piranha.jpg',
      'https://cf.ltkcdn.net/aquariums/fish-names/images/orig/324592-1600x1066-goldfish-swimming-in-fish-tank.jpg'
    ];
    return Builder(builder: (context) {
      return Scaffold(
          backgroundColor: Color.fromARGB(255, 247, 222, 114),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.topLeft,
                        width: 200.0,
                        height: 150.0,
                        decoration: new BoxDecoration(
                            image: new DecorationImage(
                                image: AssetImage("assets/images/logo.png")))),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        color: Colors.red,
                        Icons.exit_to_app,
                        // color: Colors.white,
                      ),
                      onPressed: () {
                        showAlertDialog(context);
                      },
                    )
                  ],
                ),
                Stack(
                  children: <Widget>[
                    Container(
                        // color: Colors.amber,
                        width: size.width,
                        height: 250,
                        margin: EdgeInsets.only(top: 0),
                        child: CarouselSlider(
                          options: CarouselOptions(
                              height: 200.0,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 3)),
                          items: imgList.map((item) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                    width: size.width,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color.fromARGB(255, 243, 243, 241),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5.0),
                                      child: Image.network(
                                        item,
                                        fit: BoxFit.cover,
                                        height: 150.0,
                                        width: 100.0,
                                      ),
                                    ));
                              },
                            );
                          }).toList(),
                        )),
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    width: size.width,
                    child: Column(children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text("About HE FISH",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                      ),
                      Text('${about}',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 70, 73, 75),
                          )),
                    ])),
                FishTypeList(),
                SizedBox(height: 40)
              ],
            ),
          ));
    });
  }
}
