import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:he_fish/pages/fish_category.dart';
import 'package:http/http.dart' as http;
import 'package:he_fish/constants.dart';

class FishTypeList extends StatelessWidget {
  Future<List<dynamic>> _fetchFishTypes() async {
    final String apiUrl = "${httpUrl}fishtypes/types/";
    var result = await http.get(Uri.parse(apiUrl));
    var data = jsonDecode(result.body.toString());
    return json.decode(result.body)['types'];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        child: FutureBuilder<List<dynamic>>(
      future: _fetchFishTypes(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20, top: 30, bottom: 20),
                  child: Text("Fish Types",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20))),
              Container(
                height: 150,
                width: size.width / 1.07,
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 110,
                            childAspectRatio: 5 / 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 2),
                                  blurRadius: 4,
                                  color: Color.fromARGB(255, 156, 156, 156)
                                      .withOpacity(0.4))
                            ],
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(5)),
                        child: GestureDetector(
                          onTap: () => {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => FishCategoryPage(
                                    categories: snapshot.data,
                                    categoryID: snapshot.data[index]["id"],
                                    categoryName: snapshot.data[index]
                                        ["name"])))
                          },
                          child: Container(
                              height: 60,
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.center,
                              child: Text(
                                snapshot.data[index]["name"],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.green[700],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              )),
                        ),
                      );
                    }),
              )
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    ));
  }
}
