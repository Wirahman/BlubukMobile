class Provinsi {
  String id;
  String namaProvinsi;
  String logoProvinsi;

  Provinsi({
    this.id,
    this.namaProvinsi,
    this.logoProvinsi
  });

  factory Provinsi.fromJson(Map<String, dynamic> parsedJson) {
    return Provinsi(
      id: parsedJson["id"] as String,
      namaProvinsi: parsedJson["namaProvinsi"] as String,
      logoProvinsi: parsedJson["logoProvinsi"] as String
      );
  }

}
