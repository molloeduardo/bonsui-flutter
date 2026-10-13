# Toggle Buttons

---

<div class="smartphone-container">
    <iframe src="https://www.eduardomollo.com/projects/bonsui/?screen=toggle_buttons" class="iframe-device"  style="height: 200px !important;"></iframe>
</div>

## Example

```dart
List<BonsuiToggleButtonsItem> toggleOptions = [
    BonsuiToggleButtonsItem(icon: BonsuiIcons.home),
    BonsuiToggleButtonsItem(icon: BonsuiIcons.settings),
    BonsuiToggleButtonsItem(icon: BonsuiIcons.person),
];

Column(
    children: [
        BonsuiToggleButtons(
            options: toggleOptions,
            allowJustOne: true,
        ),
    ],
);
```

## Properties
| Property | Type | Description | Mandatory |
| --------------- | ---------------- | ----------------------------------------------------------------------------------------------------------------------------------- | --------- |
| `options` | `List<BonsuiToggleButtonsItem>` | List of options | ✅ |
| `onToggle` | `BonsuiToggleButtonsItem` | Emits an event when the user select a toggle. Returns the selected item | ❌ |
| `shape` | `BonsuiShape` | Shape of the buttons. Regular, rounded, squared. Default is the **BonsuiDesign.defaultElementsShape** (regular) | ❌ |
| `allowJustOne` | `bool` | If set to true the user can only select one item | ❌ |
| `size` | `double` | Defines padding, icon and text size. Default is 16 | ❌ |
| `textColor` | `Color` | Defines icon and text color | ❌ |
| `width` | `double` | Defines the option width | ❌ |
| `height` | `double` | Defines the option height | ❌ |
| `showBorders` | `bool` | If set to **false** it hides the borders. Default is **true** | ❌ |
| `backgroundColor` | `Color` | Custom color for all the unselected options | ❌ |
