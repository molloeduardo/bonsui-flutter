# Chip Choice

---

<div class="smartphone-container">
    <iframe src="https://www.eduardomollo.com/projects/bonsui/?screen=chip_choice" class="iframe-device"></iframe>
</div>

## Example

```dart
BonsuiChipChoice(
    items: [
        BonsuiChipChoiceItem(label: 'Option 1', value: 1),
        BonsuiChipChoiceItem(label: 'Option 2', value: 2),
        BonsuiChipChoiceItem(label: 'Option 3', value: 3),
    ],
    onSelect: (value) {
        // Do something...
    },
);
```

## Properties
| Property | Type | Description | Mandatory |
| --------------- | ---------------- | ----------------------------------------------------------------------------------------------------------------------------------- | --------- |
| `items` | `List<BonsuiChipChoiceItem>` | Items list | ✅ |
| `onSelect` | `Function(dynamic)` | Emits an event when the user taps on a chip. Returns the selected value | ✅ |
| `selected` | `dynamic` | The default sselected value | ❌ |
| `shape` | `BonsuiShape` | Shape of the card. Regular, rounded, squared. Default is the **BonsuiDesign.defaultElementsShape** (regular) | ❌ |
| `label` | `String` | If set, it shows a label on the top | ❌ |
| `secondaryLabel` | `String` | If set, it shows another label on the right of the main label | ❌ |
