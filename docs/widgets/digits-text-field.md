# Digits Text Field

---

<div class="smartphone-container">
    <iframe src="https://www.eduardomollo.com/projects/bonsui/?screen=text_field_digits" class="iframe-device" style="height: 200px !important;"></iframe>
</div>

## Example

```dart
BonsuiDigitsTextField(
    onChanged: (value) => {
        // Do something...
    },
    label: 'Digits only',
    digits: 6,
);
```

## Properties
| Property | Type | Description | Mandatory |
| --------------- | ---------------- | ----------------------------------------------------------------------------------------------------------------------------------- | --------- |
| `digits` | `int` | How many digits the user can type in. Default is 6 | ❌ |
| `onChanged` | `Function(String)` | Emits the current value when the user writes inside the fields | ❌ |
| `width` | `double` | Width of the container that contains the fields | ❌ |
| `label` | `String` | If set, it shows a label on the top of the text field | ❌ |
| `placeholder` | `String` | Hints to show inside the text field when it is empty | ❌ |
| `showBorder` | `bool` | If set to true it shows a border around the text field | ❌ |
| `borderRadius` | `double` | Custom text field border radius | ❌ |
| `shape` | `BonsuiShape` | Shape of the text field. Regular, rounded, squared. Default is the **BonsuiDesign.defaultElementsShape** (regular) | ❌ |
| `color` | `Color` | Custom text field background color | ❌ |
| `disabled` | `bool` | If set to true the user can't edit the text field value and the field appears disabled | ❌ |
