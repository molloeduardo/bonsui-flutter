# Color picker

---

Used to show a selection of custom colors to choose from.<br>
You can select a color from a **dialog** or directly from the **screen**.

<div class="smartphone-container">
    <iframe src="https://www.eduardomollo.com/projects/bonsui/?screen=color_picker" class="iframe-device" style="height: 400px !important;"></iframe>
</div>

## Picker with dialog

```dart
final List<Color> colors = [
    Colors.red,
    Colors.green
    Colors.blue,
];

BonsuiColorPicker(
    colors: colors,
    label: "Select a color",
    onSelected((color) {
        // Something to do
    }),
);
```

## Picker without dialog

```dart
final List<Color> colors = [
    Colors.red,
    Colors.green
    Colors.blue,
];

BonsuiColorPicker(
    colors: colors,
    label: "Select a color",
    withoutDialog: true,
    onSelected((color) {
        // Something to do
    }),
);
```

## Properties

| Property        | Type              | Description                                                                                             | Mandatory |
| --------------- | ----------------- | ------------------------------------------------------------------------------------------------------- | --------- |
| `colors`        | `List<Color>`     | List of colors to choose from                                                                           | ✅        |
| `selectedColor` | `Color`           | Default selected color                                                                                  | ❌        |
| `label`         | `String`          | Description label                                                                                       | ❌        |
| `spaceBetween`  | `bool`            | Moves the description label from top to the left and adds space between the selected color and the      | ❌        |
| `onSelected`    | `Function(Color)` | Emits an event that returns the selected color                                                          | ❌        |
| `withoutDialog` | `bool`            | If set to **true** it shows the picker directly on the screen, without the dialog. Default is **false** | ❌        |
