class member_data{
  int id;
  int studentId;
  int Session_id;
  String name;
  bool presence;
  member_data({
    required this.studentId,
    required this.presence,
    required this.id,
    required this.name,
    required this.Session_id,
});



  factory member_data.fromMap(Map<String, dynamic> map) {
    return member_data(
      studentId: map['studentId'],
      Session_id: map["Session_id"],
      id: map['id'],
      name: map['name'],
      presence: map['presence'] == 1,

    );
  }

}