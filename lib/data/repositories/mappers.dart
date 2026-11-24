import 'package:drift/drift.dart';

import '../../domain/drink.dart';
import '../../domain/drink_category.dart';
import '../../domain/log_entry.dart';
import '../db/app_database.dart';

extension DrinkCategoryRowMapper on DrinkCategoryRow {
  DrinkCategory toDomain() => DrinkCategory(
    id: id,
    name: name,
    colorValue: colorValue,
    hydrationFactor: hydrationFactor,
    sortOrder: sortOrder,
    updatedAt: updatedAt,
    deviceId: deviceId,
    deleted: deleted,
  );
}

extension DrinkCategoryMapper on DrinkCategory {
  DrinkCategoriesCompanion toCompanion() => DrinkCategoriesCompanion.insert(
    id: id,
    name: name,
    colorValue: colorValue,
    hydrationFactor: hydrationFactor,
    sortOrder: sortOrder,
    updatedAt: updatedAt,
    deviceId: deviceId,
    deleted: Value(deleted),
  );
}

extension DrinkRowMapper on DrinkRow {
  Drink toDomain() => Drink(
    id: id,
    categoryId: categoryId,
    name: name,
    volumeMl: volumeMl,
    starred: starred,
    updatedAt: updatedAt,
    deviceId: deviceId,
    deleted: deleted,
  );
}

extension DrinkMapper on Drink {
  DrinksCompanion toCompanion() => DrinksCompanion.insert(
    id: id,
    categoryId: categoryId,
    name: name,
    volumeMl: volumeMl,
    starred: Value(starred),
    updatedAt: updatedAt,
    deviceId: deviceId,
    deleted: Value(deleted),
  );
}

extension LogEntryRowMapper on LogEntryRow {
  LogEntry toDomain() => LogEntry(
    id: id,
    categoryId: categoryId,
    volumeMl: volumeMl,
    loggedAt: loggedAt,
    updatedAt: updatedAt,
    deviceId: deviceId,
    deleted: deleted,
  );
}

extension LogEntryMapper on LogEntry {
  LogEntriesCompanion toCompanion() => LogEntriesCompanion.insert(
    id: id,
    categoryId: categoryId,
    volumeMl: volumeMl,
    loggedAt: loggedAt,
    updatedAt: updatedAt,
    deviceId: deviceId,
    deleted: Value(deleted),
  );
}
