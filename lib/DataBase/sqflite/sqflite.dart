import 'package:sqflite/sqflite.dart';
import 'package:starsport/Models/Group.dart';
import 'package:starsport/Models/Member.dart';
import 'package:starsport/Models/Session.dart';
import 'package:starsport/Models/session_data.dart';
import 'package:starsport/Models/student_detail.dart';


class sqflite{

  //initialize the data base and createthe tables
  Future<Database> init_database() async {
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + 'StarSport.db';
    Database database = await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Groupes (id INTEGER PRIMARY KEY, name TEXT)');
      await db.execute('CREATE TABLE Members (id INTEGER PRIMARY KEY, name TEXT, GroupId INTEGER)');
      await db.execute('CREATE TABLE session (id INTEGER PRIMARY KEY, Date TEXT, GroupId INTEGER)');
      await db.execute('CREATE TABLE presence (id INTEGER PRIMARY KEY, Session_id INTEGER , presence Integer, name TEXT,studentId Integer)');
      await db.execute('CREATE TABLE studentdetail (id INTEGER, PhoneNumber INTEGER , name TEXT ,parentName TEXT, grade TEXT)');

    });
    return database;
  }
  Future<void> addStudentDetail(StudentDetail studentDetail) async {
    Database db = await init_database();
    await db.insert("studentdetail", studentDetail.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
  //get all students detail
    Future<List<StudentDetail>> getStudentsDetails() async {
    Database database = await init_database();
    List<Map<String, dynamic>> results = await database.query('studentdetail');
    return results.map((map) => StudentDetail.fromJson(map)).toList();
  }

  Future<StudentDetail?> getStudentDetailById(int id) async {
    Database db = await init_database();
    List<Map<String, dynamic>> results = await db.query(
      "studentdetail",
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return StudentDetail.fromJson(results.first);
    } else {
      return null;
    }
  }

  Future<void> updateStudentDetail(StudentDetail studentDetail) async {
    Database db = await init_database();
    await db.update(
      "studentdetail",
      studentDetail.toJson(),
      where: 'id = ?',
      whereArgs: [studentDetail.id],
    );
  }

  Future<void> deleteStudentDetail(int id) async {
    Database db = await init_database();
    await db.delete(
      "studentdetail",
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // insert a session detail
  Future<void> insertSessionDetail(int sessionId, int presence, String name) async {
    Database database = await init_database();
    await database.rawInsert('INSERT INTO presence (Session_id, presence, name) VALUES (?,?,?)', [sessionId, presence, name]);
  }
  //update a session detail
  Future<void> updateSessionDetail(int sessionDetailId, int presence, String name) async {
    Database database = await init_database();

    await database.update(
      'presence',
      {'presence': presence, 'name': name},
      where: 'id = ?',
      whereArgs: [sessionDetailId],
    );
  }

// Delete a session detail
  Future<void> deleteSessionDetail(int detailId) async {
    Database database = await init_database();
    await database.delete('presence', where: 'id = ?', whereArgs: [detailId]);
  }

  // insert a Group
  Future<void> insertGroup(String name) async {
    Database database = await init_database();
    await database.rawInsert('INSERT INTO Groupes (name) VALUES (?)', [name]);
  }
  // insert a Session
  Future<int> insertSession(int groupId,String date) async {
    Database database = await init_database();
     return await database.rawInsert('INSERT INTO session (Date,GroupId) VALUES (?,?)', [date,groupId]);
  }

// insert a student
  Future<int> insertStudent(String name, int groupId) async {
    Database database = await init_database();
    return await database.rawInsert('INSERT INTO Members (name, GroupId) VALUES (?, ?)', [name, groupId]);
  }

  // Delete a student from a group
  Future<void> deleteStudent(int studentId) async {
    Database database = await init_database();
    await database.delete('Members', where: 'id = ?', whereArgs: [studentId]);
  }
  // Delete a a group
  Future<void> deleteGroup(int groupID) async {
    Database database = await init_database();
    await database.delete('Groupes', where: 'id = ?', whereArgs: [groupID]);
  }
  // Delete a a session
  Future<void> deleteSession(int sessionID) async {
    Database database = await init_database();
    await database.delete('session', where: 'id = ?', whereArgs: [sessionID]);
    await database.delete('presence', where: 'Session_id = ?', whereArgs: [sessionID]);

  }


  //get all groups
  Future<List<Group>> getGroups() async {
    Database database = await init_database();
    List<Map<String, dynamic>> results = await database.query('Groupes');
    return results.map((map) => Group(id: map['id'], name: map['name'])).toList();
  }
//get all students of a group
  Future<List<Member>> getStudentsForGroup(int groupId) async {
    Database database = await init_database();
    List<Map<String, dynamic>> results = await database.query('Members', where: 'GroupId = ?', whereArgs: [groupId]);
    return results.map((map) => Member(group_id: map["GroupId"], name: map["name"], id: map["id"])).toList();
  }
// get all sessions for a group
  Future<List<Session>> getSessionsForGroup(int groupId) async {
    Database database = await init_database();
    List<Map<String, dynamic>> results = await database.query('session', where: 'GroupId = ?', whereArgs: [groupId]);
    return results.map((map) => Session(group_id: map["GroupId"], id: map["id"], date: map["Date"])).toList();
  }

  // get all DETAILS OF sessions
  Future<List<member_data>> get_session_details(int sessionID) async {
    Database database = await init_database();
    List<Map<String, dynamic>> results = await database.query('presence', where: 'Session_id = ?', whereArgs: [sessionID]);
    return results.map((map) => member_data.fromMap(map)).toList();
  }

}