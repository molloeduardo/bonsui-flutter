# Buttons

---

<div class="smartphone-container">
    <iframe src="https://www.eduardomollo.com/projects/bonsui/?screen=buttons" class="iframe-device" style="height: 600px !important;"></iframe>
</div>

## Example

```dart
// Primary button with label and icon
BonsuiButton(icon: BonsuiIcons.close, onPressed: () {
    // Something to do
});

// Outlined button with label and icon
BonsuiButton(icon: BonsuiIcons.close, type: BonsuiButtonType.outlined, onPressed: () {
    // Something to do
});

// Text button with label and icon
BonsuiButton(icon: BonsuiIcons.close, type: BonsuiButtonType.text, onPressed: () {
    // Something to do
});

// Secondary button with label and icon
BonsuiButton(icon: BonsuiIcons.close, type: BonsuiButtonType.secondary, onPressed: () {
    // Something to do
});

// Disabled button
BonsuiButton(label: 'Text', disabled: true);
```

## Properties
| Property | Type | Description | Mandatory |
| --------------- | ---------------- | ----------------------------------------------------------------------------------------------------------------------------------- | --------- |
| `type` | `BonsuiButtonType` | Primary, outlined, text, secondary. Default is primary | ❌ |
| `shape` | `BonsuiShape` | Regular, rounded, squared. Default is the **BonsuiDesign.defaultElementsShape** (regular) | ❌ |
| `label` | `String` | Defines a label for the button| ❌ |
| `labelColor` | `Color` | Defines the color of the label| ❌ |
| `icon` | `IconData` | Set an icon to display inside the button | ❌ |
| `iconPosition` | `BonsuiIconPosition` | Set the icon position inside the button. Default is **left (prefix)** | ❌ |
| `onPressed` | `Function(void)` | Emits an event when the button is pressed | ❌ |
| `isLoading` | `bool` | If set to true it disables the button and shows a loading spinner inside it | ❌ |
| `minSize` | `Size` | Set the button minimum size | ❌ |
| `child` | `Widget` | Set a custom content inside the button | ❌ |
| `color` | `Color` | Set the button color. Default is **BonsuiDesign.primaryColor** or **BonsuiDesign.disabledColor** if disabled | ❌ |
| `disabled` | `bool` | If set to true the button is disabled and can't be tapped | ❌ |
| `customPrefix` | `Widget` | A custom widget to show before the label | ❌ |
| `iconSize` | `double` | Set the icon size of the icon set | ❌ |
| `padding` | `EdgeInsets` | Custom padding inside the button | ❌ |
| `margin` | `EdgeInsets` | Custom padding outside the button | ❌ |
| `size` | `BonsuiButtonSize` | Define a fixed size for the button. Small, medium, large. Default is **medium** | ❌ |
| `borderColor` | `Color` | Defines the color of the border | ❌ |
| `useHapticFeedback` | `bool` | If true emits a lightImpact vibration when the user taps on the button | ❌ |
