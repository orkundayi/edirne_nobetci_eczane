import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../api/pharmacy.dart';
import '../api/pharmacy_answer.dart';
import 'pharmacy_detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Pharmacy> parsePharmacyAnswer(String answer) {
    return PharmacyAnswer.fromJson(json.decode(answer)).PharmacyList;
  }

  Future<List<Pharmacy>> showAllPharmacies() async {
    var response = await http.get(
      Uri.parse('https://api.collectapi.com/health/dutyPharmacy?il=Edirne'),
      headers: {HttpHeaders.authorizationHeader: "apikey 2DhvEv2tfCrS4LTF1JxYqY:1MW38QwekeNGsCDnTzRk3Z"},
    );
    return parsePharmacyAnswer(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edirne Nöbetçi Eczane"),
        backgroundColor: Colors.red[900],
      ),
      body: FutureBuilder<List<Pharmacy>>(
        future: showAllPharmacies(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var pharmacyList = snapshot.data;
            return ListView.builder(
              itemCount: pharmacyList!.length,
              itemBuilder: (context, index) {
                var pharmacy = pharmacyList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PharmacyDetail(
                          pharmacy: pharmacy,
                        ),
                      ),
                    );
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
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    height: 100,
                                    width: 210,
                                    child: Container(
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.red,
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
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            pharmacy.dist,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
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
                                          color: Colors.red,
                                          width: 1,
                                        ),
                                        color: Colors.red[800],
                                        borderRadius: BorderRadius.circular(28),
                                      ),
                                      child: const Text(
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
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
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
