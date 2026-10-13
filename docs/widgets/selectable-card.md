# Selectable Card

---

<div class="smartphone-container">
    <iframe src="https://www.eduardomollo.com/projects/bonsui/?screen=selectable-card" class="iframe-device" style="height: 270px !important;"></iframe>
</div>

## Example

```dart
int? selectedCard;

Column(
    children: [
        BonsuiSelectableCard(
            title: 'Selectable Card',
            description: 'Tap to select this card.',
            icon: BonsuiIcons.info,
            selected: selectedCard == 1,
            onPressed: () {
                setState(() {
                    selectedCard = 1;
                });
            },
        ),
        BonsuiSpacing.vertical(),
        BonsuiSelectableCard(
            title: 'Selectable Card',
            description: 'Tap to select this card.',
            icon: BonsuiIcons.heart,
            color: BonsuiDesign.successColor,
            selected: selectedCard == 2,
            onPressed: () {
                setState(() {
                    selectedCard = 2;
                });
            },
        ),
    ],
);
```

## Properties
| Property | Type | Description | Mandatory |
| --------------- | ---------------- | ----------------------------------------------------------------------------------------------------------------------------------- | --------- |
| `child` | `Widget` | Custom widget to show inside the card | ❌ |
| `title` | `String` | Card title | ❌ |
| `description` | `String` | Card description | ❌ |
| `icon` | `Icon` | It shows an icon on the top inside the card | ❌ |
| `color` | `Color` | Custom card background color | ❌ |
| `onPressed` | `Function(void)` | Emits an event when the user taps on the card | ❌ |
| `shape` | `BonsuiShape` | Shape of the card. Regular, rounded, squared. Default is the **BonsuiDesign.defaultElementsShape** (regular) | ❌ |
| `selected` | `bool` | Status of the card | ❌ |
