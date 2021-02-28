class Pharmacy {
  String name;
  String dist;
  String address;
  String phone;
  String loc;

  Pharmacy(this.name, this.dist, this.address, this.phone, this.loc);

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
        json["name"] as String,
        json["dist"] as String,
        json["address"] as String,
        json["phone"] as String,
        json["loc"] as String);
  }
}
