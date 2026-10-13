# Card

---

<div class="smartphone-container">
    <iframe src="https://www.eduardomollo.com/projects/bonsui/?screen=card" class="iframe-device" style="height: 420px !important;"></iframe>
</div>

## Example

```dart
BonsuiCard(
    title: 'Card title',
    description: 'Look how amazing this card is!',
    icon: BonsuiIcons.phone,
    onPressed: () {
        // Do something...
    }
);
```

## Properties
| Property | Type | Description | Mandatory |
| --------------- | ---------------- | ----------------------------------------------------------------------------------------------------------------------------------- | --------- |
| `child` | `Widget` | Custom widget to show inside the card | ❌ |
| `title` | `String` | Card title | ❌ |
| `description` | `String` | Card description | ❌ |
| `icon` | `Icon` | It shows an icon on the top inside the card | ❌ |
| `color` | `Color` | Icon color. Default is **BonsuiDesign.primaryColor** | ❌ |
| `backgroundColor` | `Color` | Custom card background color | ❌ |
| `onPressed` | `Function(void)` | Emits an event when the user taps on the card | ❌ |
| `onLongPress` | `Function(void)` | Emits an event when the user long presses on the card | ❌ |
| `padding` | `EdgeInsets` | Card inner padding | ❌ |
| `border` | `Border` | Card border | ❌ |
| `width` | `double` | Custom card width. By default it applies the needed space to contain the children inside | ❌ |
| `height` | `double` | Custom card height. By default it applies the needed space to contain the children inside | ❌ |
| `shape` | `BonsuiShape` | Shape of the card. Regular, rounded, squared. Default is the **BonsuiDesign.defaultElementsShape** (regular) | ❌ |
| `shadow` | `BoxShadow` | Apply a custom shadow under the card | ❌ |
