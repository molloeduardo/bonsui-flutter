# Badge

---

<div class="smartphone-container">
    <iframe src="https://www.eduardomollo.com/projects/bonsui/?screen=badge" class="iframe-device" style="min-height: 100px; height: 77px !important;"></iframe>
</div>

## Example

```dart
BonsuiBadge(
    label: 'I am a badge',
    icon: BonsuiIcons.phone,
    color: BonsuiDesign.successColor,
);
```

## Properties
| Property | Type | Description | Mandatory |
| --------------- | ---------------- | ----------------------------------------------------------------------------------------------------------------------------------- | --------- |
| `label` | `String` | The label to show inside the badge | ❌ |
| `icon` | `IconData` | The icon to show inside the badge to the left of the label | ❌ |
| `color` | `Color` | The badge background color (it will apply alpha to 60) and border | ❌ |
| `padding` | `EdgeInsets` | The padding inside the badge | ❌ |
| `shape` | `BonsuiShape` | Shape of the badge. Regular, rounded, squared. Default is the **BonsuiDesign.defaultElementsShape** (regular) | ❌ |
| `fontSize` | `double` | Font size of the label | ❌ |
| `child` | `Widget` | Custom widget to show inside the badge | ❌ |
| `useTransparency` | `bool` | If set to **true** it uses alpha colors insted of lightening the color. Default is **false** | ❌ |
| `width` | `double` | Used to set a custom width for the badge | ❌ |
