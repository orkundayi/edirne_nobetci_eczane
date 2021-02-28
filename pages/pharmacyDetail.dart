import 'package:edirne_nobetci_eczaneler/api/pharmacy.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class PharmacyDetail extends StatefulWidget {
  Pharmacy pharmacy;
  PharmacyDetail({this.pharmacy});
  @override
  _PharmacyDetailState createState() => _PharmacyDetailState();
}

class _PharmacyDetailState extends State<PharmacyDetail> {
  String pharmacyName;
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
      body: Center(
        child: Container(
          height: 750,
          width: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: Colors.white,
          ),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset('assets/pharmacyV2.png'),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  height: 300,
                  width: 380,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: Colors.red[800],
                        width: 3,
                      ),
                      color: Colors.white),
                  child: Text(
                    widget.pharmacy.address,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.black),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // ignore: deprecated_member_use
                    RaisedButton(
                      color: Colors.red[900],
                      padding: EdgeInsets.all(20.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red[900]),
                      ),
                      colorBrightness: Brightness.dark,
                      splashColor: Colors.red[800],
                      onPressed: () {
                        launch("tel:0${widget.pharmacy.phone}");
                      },
                      child: Text(
                        'Arayın',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    // ignore: deprecated_member_use
                    RaisedButton(
                      color: Colors.red[900],
                      padding: EdgeInsets.all(20.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red[900]),
                      ),
                      colorBrightness: Brightness.dark,
                      splashColor: Colors.red[800],
                      onPressed: () {
                        // ignore: unnecessary_brace_in_string_interps
                        launch(
                            "https://www.google.com/maps/search/?api=1&query=${lat},${lon}");
                      },
                      child: const Text(
                        'Haritada Göster',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
