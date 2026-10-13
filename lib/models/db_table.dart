import 'package:bonsui/enums/db_column_type.dart';

class BonsuiDatabaseTable {
  final String name;
  final List<BonsuiDatabaseTableColumn> columns;

  BonsuiDatabaseTable({required this.name, required this.columns});
}

class BonsuiDatabaseTableColumn {
  final String name;
  final BonsuiDatabaseColumnType type;
  final bool isPrimaryKey;
  final bool isAutoIncrement;
  final bool isNotNull;
  final dynamic defaultValue;

  BonsuiDatabaseTableColumn({
    required this.name,
    required this.type,
    this.isPrimaryKey = false,
    this.isAutoIncrement = false,
    this.isNotNull = false,
    this.defaultValue,
  });
}
