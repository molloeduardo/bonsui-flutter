# Info Alert

---

<div class="smartphone-container">
    <iframe src="https://www.eduardomollo.com/projects/bonsui/?screen=info" class="iframe-device" style="height: 540px !important;"></iframe>
</div>

## Example

```dart
BonsuiInfo(
    title: 'Success Alert',
    description:
        'Description for the success alert goes here.',
    type: BonsuiInfoType.success,
);
```

## Properties
| Property | Type | Description | Mandatory |
| --------------- | ---------------- | ----------------------------------------------------------------------------------------------------------------------------------- | --------- |
| `type` | `BonsuiInfoType` | Info alert type (info, warning, success, danger). It automatically changes the background color and sets the icon based on the type | ❌ |
| `title` | `String` | Info alert title | ❌ |
| `description` | `String` | Info alert description | ❌ |
| `icon` | `IconData` | Info alert custom icon | ❌ |
| `iconColor` | `Color` | Info alert custom icon color | ❌ |
| `fontSize` | `double` | It changes the font size for the icon, title and description automatically | ❌ |
| `color` | `Color` | Info alert custom background color | ❌ |
| `shape` | `BonsuiShape` | Shape of the info alert. Regular, rounded, squared. Default is the **BonsuiDesign.defaultElementsShape** (regular) | ❌ |
| `padding` | `EdgeInsets` | Custom info alert padding | ❌ |
| `child` | `Widget` | Custom widget to show inside the info alert | ❌ |
