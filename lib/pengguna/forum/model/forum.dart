class VariabelSemuaForum {
  String idForum;
  String idGroupForum;
  String userIdPembuat;
  String judulForum;
  String isiForum;
  String fotoForum;
  String waktu;
  String statusSuka;
  String statusBenci;
  String jumlahPenonton;
  String jumlahKomentar;
  String emailPembuat;
  String namaPembuat;
  String fotoPembuat;

  VariabelSemuaForum(
      {
        this.idForum,
        this.idGroupForum,
        this.userIdPembuat,
        this.judulForum,
        this.isiForum,
        this.fotoForum,
        this.waktu,
        this.statusSuka,
        this.statusBenci,
        this.jumlahPenonton,
        this.jumlahKomentar,
        this.emailPembuat,
        this.namaPembuat,
        this.fotoPembuat
      });

  factory VariabelSemuaForum.fromJson(Map<String, dynamic> json) {
    return new VariabelSemuaForum(
        idForum: json['idForum'] as String,
        idGroupForum: json['idGroupForum'] as String,
        userIdPembuat: json['userIdPembuat'] as String,
        judulForum: json['judulForum'] as String,
        isiForum: json['isiForum'] as String,
        fotoForum: json['fotoForum'] as String,
        waktu: json['hariBuat'] as String,
        statusSuka: json['statusSuka'] as String,
        statusBenci: json['statusBenci'] as String,
        jumlahPenonton: json['jumlahPenonton'] as String,
        jumlahKomentar: json['jumlahKomentar'] as String,
        emailPembuat: json['emailPembuat'] as String,
        namaPembuat: json['namaPembuat'] as String,
        fotoPembuat: json['fotoPembuat'] as String
    );
  }

}

