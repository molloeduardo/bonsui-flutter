# Storage

---

The **storage service** reduces the complexity of using the **shared_preferences** plugin in order to speed up the development and simplify the code.

!> This service depends on the package [shared_preferences](https://pub.dev/packages/shared_preferences)

## Save

```dart
BonsuiStorage.save('key', 'value');
```

## Get

```dart
BonsuiStorage.get('key');
```

## Remove

```dart
BonsuiStorage.remove('key');
```
