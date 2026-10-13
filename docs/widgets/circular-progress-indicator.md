# Circular Progress Indicator

---

It replaces the default **CircularProgressIndicator** widget in order to implement custom logic and different UI based on the OS.

<div class="smartphone-container">
    <iframe src="https://www.eduardomollo.com/projects/bonsui/?screen=circular-progress-indicator" class="iframe-device" style="height: 100px !important;"></iframe>
</div>

## Example

```dart
BonsuiCircularProgressIndicator(
    color: BonsuiDesign.dangerColor,
    size: BonsuiProgressIndicatorSize.large,
);
```

## Properties
| Property | Type | Description | Mandatory |
| --------------- | ---------------- | ----------------------------------------------------------------------------------------------------------------------------------- | --------- |
| `color` | `Color` | Custom indicator color. Default is **BonsuiDesign.primaryColor** | ❌ |
| `size` | `BonsuiProgressIndicatorSize` | Custom indicator size. Default is **BonsuiProgressIndicatorSize.small** | ❌ |
