class VariabelFotoKomentarStatus {
  String idStatus;
  String idKomentarStatus;
  String namaFile;

  VariabelFotoKomentarStatus(
      {
        this.idStatus,
        this.idKomentarStatus,
        this.namaFile,
      }
      );

  factory VariabelFotoKomentarStatus.fromJson(Map<String, dynamic> json) {
    return new VariabelFotoKomentarStatus(
      idStatus: json['idStatus'] as String,
      idKomentarStatus: json['idKomentarStatus'] as String,
      namaFile: json['namaFile'] as String,
    );
  }

}