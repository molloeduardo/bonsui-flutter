# App Bar

---

It automatically shows Material style on an Android devices, and Cupertino style on iOS ones.

## Example

```dart
BonsuiAppBar(
    title: 'Hello',
)
```

## Properties

| Property          | Type     | Description                                                                                                                          | Mandatory |
| ----------------- | -------- | ------------------------------------------------------------------------------------------------------------------------------------ | --------- |
| `title`           | `String` | Shows the title in the app bar                                                                                                       | ❌        |
| `titleChild`      | `Widget` | A custom widget that will be displayed on the title position                                                                         | ❌        |
| `actions`         | `Widget` | A custom widget that will be displayed on the right of the app bar                                                                   | ❌        |
| `backgroundColor` | `Color`  | Custom app bar color. Default is **BonsuiDesign.whiteColor** in light theme mode, and **BonsuiDesign.blackColor** in dark theme mode | ❌        |
