import 'dart:io';
import 'package:edirne_nobetci_eczaneler/api/pharmacy.dart';
import 'package:edirne_nobetci_eczaneler/api/pharmacyAnswer.dart';
import 'package:edirne_nobetci_eczaneler/pages/pharmacyDetail.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Pharmacy> parsePharmacyAnswer(String answer) {
    return PharmacyAnswer.fromJson(json.decode(answer)).PharmacyList;
  }

  Future<List<Pharmacy>> showAllPharmacies() async {
    var response = await http.get(
      'https://api.collectapi.com/health/dutyPharmacy?il=Edirne',
      headers: {
        HttpHeaders.authorizationHeader:
            "apikey 7gKXyik04uNYoxAxBOXW4s:429Z0d5NtuZ3bt2H8Ohmre"
      },
    );
    return parsePharmacyAnswer(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edirne Nöbetçi Eczane"),
        backgroundColor: Colors.red[900],
      ),
      body: FutureBuilder<List<Pharmacy>>(
        future: showAllPharmacies(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var pharmacyList = snapshot.data;
            return ListView.builder(
              itemCount: pharmacyList.length,
              itemBuilder: (context, index) {
                var pharmacy = pharmacyList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PharmacyDetail(
                                  pharmacy: pharmacy,
                                )));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 90,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red[100],
                              borderRadius: BorderRadius.circular(150),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    height: 70,
                                    width: 210,
                                    child: Container(
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.red[800],
                                          width: 1,
                                        ),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(28),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            "${(pharmacy.name)} ECZANESİ",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            pharmacy.dist,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 70,
                                    width: 150,
                                    child: Container(
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.red[800],
                                          width: 1,
                                        ),
                                        color: Colors.red[800],
                                        borderRadius: BorderRadius.circular(28),
                                      ),
                                      child: Text(
                                        "Eczane Bilgileri",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: SizedBox(
                child: Text("Lütfen Bekleyiniz ..."),
              ),
            );
          }
        },
      ),
    );
  }
}
