import 'package:drift/drift.dart';

@DataClassName('DrinkCategoryRow')
class DrinkCategories extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get colorValue => integer()();
  RealColumn get hydrationFactor => real()();
  IntColumn get sortOrder => integer()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get deviceId => text()();
  BoolColumn get deleted => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('DrinkRow')
class Drinks extends Table {
  TextColumn get id => text()();
  TextColumn get categoryId => text().references(DrinkCategories, #id)();
  TextColumn get name => text()();
  IntColumn get volumeMl => integer()();
  BoolColumn get starred => boolean().withDefault(const Constant(false))();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get deviceId => text()();
  BoolColumn get deleted => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('LogEntryRow')
class LogEntries extends Table {
  TextColumn get id => text()();
  TextColumn get categoryId => text().references(DrinkCategories, #id)();
  IntColumn get volumeMl => integer()();
  DateTimeColumn get loggedAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get deviceId => text()();
  BoolColumn get deleted => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('SettingRow')
class Settings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}
