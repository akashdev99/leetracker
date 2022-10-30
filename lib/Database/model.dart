import 'package:mongo_dart/mongo_dart.dart';

class User {
  final ObjectId? id;
  final String? name;
  final int? age;
  final int? phone;

  const User({this.id, this.name, this.age, this.phone});
}
