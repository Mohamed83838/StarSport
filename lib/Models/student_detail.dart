
class StudentDetail {
  int id;
  int phoneNumber;
  String name;
  String parentName;
  String grade;

  StudentDetail({
    required this.id,
    required this.phoneNumber,
    required this.name,
    required this.parentName,
    required this.grade,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
      'name': name,
      'parentName': parentName,
      'grade': grade,
    };
  }

  factory StudentDetail.fromJson(Map<String, dynamic> json) {
    return StudentDetail(
      id: json['id'] as int,
      phoneNumber: json['phoneNumber'] as int,
      name: json['name'] as String,
      parentName: json['parentName'] as String,
      grade: json['grade'] as String,
    );
  }
}
