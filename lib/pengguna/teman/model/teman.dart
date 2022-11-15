class VariabelTeman {
  String userID;
  String email;
  String name;
  String fotoProfil;

  VariabelTeman(
      {
        this.userID,
        this.email,
        this.name,
        this.fotoProfil
      }
   );

  factory VariabelTeman.fromJson(Map<String, dynamic> json) {
    return new VariabelTeman(
        userID: json['userID'] as String,
        email: json['email'] as String,
        name: json['name'] as String,
        fotoProfil: json['fotoProfil'] as String
    );
  }

}