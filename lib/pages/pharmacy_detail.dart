import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api/pharmacy.dart';

// ignore: must_be_immutable
class PharmacyDetail extends StatefulWidget {
  Pharmacy pharmacy;
  PharmacyDetail({super.key, required this.pharmacy});
  @override
  PharmacyDetailState createState() => PharmacyDetailState();
}

class PharmacyDetailState extends State<PharmacyDetail> {
  late String pharmacyName;
  var locations;
  var lat, lon;
  @override
  void initState() {
    super.initState();
    pharmacyName = widget.pharmacy.name;
    locations = widget.pharmacy.loc.split(",");
    lat = lat = locations[0];
    lon = locations[1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[100],
      appBar: AppBar(
        title: Text("${(pharmacyName)} ECZANESİ"),
        backgroundColor: Colors.red[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Adres: ${widget.pharmacy.address}",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Telefon: ${widget.pharmacy.phone}",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                launch("https://www.google.com/maps/search/?api=1&query=$lat,$lon");
              },
              child: const Text("Haritada Gör"),
            ),
          ],
        ),
      ),
    );
  }
}
