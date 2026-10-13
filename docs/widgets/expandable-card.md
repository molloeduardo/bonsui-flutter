# Expandable Card

---

<div class="smartphone-container">
    <iframe src="https://www.eduardomollo.com/projects/bonsui/?screen=expandable-box" class="iframe-device" style="height: 220px !important;"></iframe>
</div>

## Example

```dart
BonsuiExpandableBox(
    title: 'Tap to expand',
    icon: BonsuiIcons.info,
    child: BonsuiText('This is the content'),
);
```

## Properties
| Property | Type | Description | Mandatory |
| --------------- | ---------------- | ----------------------------------------------------------------------------------------------------------------------------------- | --------- |
| `icon` | `IconData` | The icon to show at the top of the empty state. Default is **BonsuiIcons.closeCircle** | ❌ |
| `color` | `Color` | Custom background color | ❌ |
| `title` | `String` | Empty state title | ❌ |
| `child` | `Widget` | Custom widget to show at the end of the empty state | ❌ |
| `padding` | `EdgeInsets` | Empty state padding | ❌ |
| `filled` | `EdgeInsets` | If set to **false**, it removes the card background. Default is **true** | ❌ |
| `shape` | `BonsuiShape` | Shape of the card. Regular, rounded, squared. Default is the **BonsuiDesign.defaultElementsShape** (regular) | ❌ |
| `onTap` | `Function(void)` | Emits an event when the user taps on the card | ❌ |
