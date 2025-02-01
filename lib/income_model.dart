import 'package:hive/hive.dart';

part 'income_model.g.dart'; // Required for code generation

@HiveType(typeId: 1) // Define a unique typeId for this model
class Income extends HiveObject {
  @HiveField(0)
  String incomeType;

  @HiveField(1)
  double rate;

  @HiveField(2)
  int quantity;

  @HiveField(3)
  String employerName;

  Income({
    required this.incomeType,
    required this.rate,
    required this.quantity,
    required this.employerName,
  });
}