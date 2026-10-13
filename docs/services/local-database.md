# Local database

---

The **sql service** reduces the complexity of using the **sqflite** plugin in order to speed up the development and simplify the code.

!> This service depends on the packages [sqflite](https://pub.dev/packages/sqflite) and [path](https://pub.dev/packages/path)

## Initialize database

```dart
BonsuiSqlService dbService = BonsuiSqlService();
await dbService.initDatabase('test_db', [
    BonsuiDatabaseTable(
        name: 'table_test',
        columns: [
            BonsuiDatabaseTableColumn(
                name: 'id',
                type: BonsuiDatabaseColumnType.integer,
                isAutoIncrement: true,
                isPrimaryKey: true,
            ),
            BonsuiDatabaseTableColumn(
                name: 'name',
                type: BonsuiDatabaseColumnType.text,
                isNotNull: true,
            ),
            BonsuiDatabaseTableColumn(
                name: 'balance',
                type: BonsuiDatabaseColumnType.double,
                isNotNull: true,
            ),
        ],
    ),
]);
```

## Delete database

```dart
BonsuiSqlService dbService = BonsuiSqlService();
await dbService.deleteDatabaseFile('test_db');
```

## Get all data in a table

```dart
BonsuiSqlService dbService = BonsuiSqlService();
final List<Map<String, dynamic>> wallets = await dbService.getAll('wallets');
```

## Get a row by ID

!> You need to have a **fromMap** method in your class in order to use this

```dart
BonsuiSqlService dbService = BonsuiSqlService();
final Wallet wallet = Wallet(id: 1, name: 'Wallet', balance: 20.0);
final List<Map<String, dynamic>> wallets = await dbService.getById('wallets', wallet.id, wallet.fromMap);
```

## Insert a table row

```dart
Map<String, dynamic> data = {
    "id": 1,
    "name": "Wallet",
    "balance": 20.0
};
BonsuiSqlService dbService = BonsuiSqlService();
await dbService.insert('wallets', data);
```

## Update table row

```dart
Map<String, dynamic> data = {
    "id": 1, // The ID used to update the data
    "name": "Wallet updated",
    "balance": 300.0
};
BonsuiSqlService dbService = BonsuiSqlService();
await dbService.update(data['id'], 'wallets', data, (item) => item);
```

## Delete a table row

```dart
BonsuiSqlService dbService = BonsuiSqlService();
final int id = 1;
await dbService.delete('wallets', id);
```
