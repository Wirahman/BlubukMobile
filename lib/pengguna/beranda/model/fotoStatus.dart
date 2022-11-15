class VariabelFotoStatus {
  String idStatus;
  String namaFile;

  VariabelFotoStatus(
      {
        this.idStatus,
        this.namaFile,
      }
      );

  factory VariabelFotoStatus.fromJson(Map<String, dynamic> json) {
    return new VariabelFotoStatus(
        idStatus: json['idStatus'] as String,
        namaFile: json['namaFile'] as String,
    );
  }

}