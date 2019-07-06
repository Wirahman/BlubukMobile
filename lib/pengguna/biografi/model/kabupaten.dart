class Kabupaten {
  String id;
  String namaKabupaten;
  String idProvinsi;
  String logoKabupaten;

  Kabupaten({
    this.id,
    this.namaKabupaten,
    this.idProvinsi,
    this.logoKabupaten
  });

  factory Kabupaten.fromJson(Map<String, dynamic> parsedJson) {
    return Kabupaten(
      id: parsedJson["id"] as String,
      namaKabupaten: parsedJson["namaKabupaten"] as String,
      idProvinsi: parsedJson["idProvinsi"] as String,
      logoKabupaten: parsedJson["logoKabupaten"] as String
      );
  }

}
