# Circular Progress Bar

---

<div class="smartphone-container">
    <iframe src="https://www.eduardomollo.com/projects/bonsui/?screen=circular-progress-bar" class="iframe-device" style="height: 135px !important;"></iframe>
</div>

## Example

```dart
BonsuiCircularProgressBar(
    percentage: 70,
    size: 70,
    showPercentage: true,
    color: BonsuiDesign.successColor,
);
```

## Properties
| Property | Type | Description | Mandatory |
| --------------- | ---------------- | ----------------------------------------------------------------------------------------------------------------------------------- | --------- |
| `percentage` | `double` | Defines how full the circular progress bar is | ✅ |
| `color` | `Color` | Defines the color of circular progress bar. Default is **BonsuiDesign.primaryColor** | ❌ |
| `size` | `double` | Defines the circular progress bar stroke width and the label size | ❌ |
| `showPercentage` | `bool` | If true it shows the percentage label inside the circular progress bar | ❌ |
| `child` | `Widget` | If set it shows the custom widget inside the circular progress bar | ❌ |
