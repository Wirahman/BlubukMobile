class Agama {
  String id;
  String namaAgama;

  Agama({
    this.id,
    this.namaAgama,
  });

  factory Agama.fromJson(Map<String, dynamic> parsedJson) {
    return Agama(
      id: parsedJson["id"] as String,
      namaAgama: parsedJson["namaAgama"] as String,
      );
  }

}
