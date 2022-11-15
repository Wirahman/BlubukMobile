class VariabelEmote {
  String id;
  String nama;
  String url;
  String status;

  VariabelEmote(
      {
        this.id,
        this.nama,
        this.url,
        this.status
      }
  );

  factory VariabelEmote.fromJson(Map<String, dynamic> json) {
    return new VariabelEmote(
        id: json['id'] as String,
        nama: json['nama'] as String,
        url: json['url'] as String,
        status: json['status'] as String
    );
  }

}