# Icon picker

---

Used to show a selection of custom icons to choose from, divided by groups.

<div class="smartphone-container">
    <iframe src="https://www.eduardomollo.com/projects/bonsui/?screen=icon_picker" class="iframe-device" style="height: 400px !important;"></iframe>
</div>

## Example

```dart
final List<BonsuiIconPickerList> icons = [
    BonsuiIconPickerList(label: 'Group 1', icons: [BonsuiIcons.close, BonsuiIcons.arrowBack]),
    BonsuiIconPickerList(label: 'Group 2', icons: [BonsuiIcons.folder, BonsuiIcons.phone]),
];

BonsuiIconPicker(
    label: 'Select an icon',
    icons: icons,
    onSelected(icon) {
        // Something to do
    }
);
```

## Properties

| Property       | Type                         | Description                                                                                       | Mandatory |
| -------------- | ---------------------------- | ------------------------------------------------------------------------------------------------- | --------- |
| `icons`        | `List<BonsuiIconPickerList>` | List of icons to choose from                                                                      | ✅        |
| `selectedIcon` | `IconData`                   | Default selected icon                                                                             | ❌        |
| `size`         | `double`                     | Selected icon size                                                                                | ❌        |
| `label`        | `String`                     | Description label                                                                                 | ❌        |
| `spaceBetween` | `bool`                       | Moves the description label from top to the left and adds space between the selected icon and the | ❌        |
| `color`        | `Color`                      | Color of the selected icon and all the possible icons in lists                                    | ❌        |
| `onSelected`   | `Function(IconData)`         | Emits an event that returns the selected icon                                                     | ❌        |
