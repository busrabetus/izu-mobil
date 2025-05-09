class Student_Info {
  final int userId;
  final String name;
  final String surname;
  final String tc;
  final String username;
  final String email;
  final String registered;
  final String facName;
  final String progName;
  final String level;
  final String regType;
  final String sshipType;
  final String advisorName;
  final String office;
  final String advTel;
  final String advEmail;
  final String siralama;
  final double agno;

  Student_Info({
    required this.userId,
    required this.name,
    required this.surname,
    required this.tc,
    required this.username,
    required this.email,
    required this.registered,
    required this.facName,
    required this.progName,
    required this.level,
    required this.regType,
    required this.sshipType,
    required this.advisorName,
    required this.office,
    required this.advTel,
    required this.advEmail,
    required this.siralama,
    required this.agno,
  });

  factory Student_Info.fromJson(Map<String, dynamic> json) {
    return Student_Info(
      userId: json['user_id'] ?? 0,
      name: json['name'],
      surname: json['surname'],
      tc: json['tc'],
      username: json['username'],
      email: json['email'],
      registered: json['registered'],
      facName: json['fac_name'],
      progName: json['prog_name'],
      level: json['level'],
      regType: json['reg_type'],
      sshipType: json['sship_type'],
      advisorName: json['advisor_name'],
      office: json['office'],
      advTel: json['adv_tel'],
      advEmail: json['adv_email'],
      siralama: json['siralama'],
      agno: double.parse(json['agno'].toString()),
    );
  }
}
