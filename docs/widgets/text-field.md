# Text Fields

---

The **BonsuiTextField** component provides simple and unique validation methods combined with UI elements in order to create powerful forms in no-time.

<div class="smartphone-container">
    <iframe src="https://www.eduardomollo.com/projects/bonsui/?screen=text_fields" class="iframe-device" style="height: 600px !important;"></iframe>
</div>

## Basic usage

```dart
final TextEditingController _controller = TextEditingController();

BonsuiTextField(
    controller: _controller,
    placeholder: "123",
    label: "Phone number",
    prefixIcon: BonsuiIcons.phone,
);
```

## Number field

```dart
final TextEditingController _controller = TextEditingController();

BonsuiTextField(
    controller: _controller,
    label: 'Number field with validation',
    placeholder: 'Your height',
    type: BonsuiTextFieldType.number,
    suffixLabel: 'cm',
    validator: BonsuiTextFieldValidator(min: 100, max: 230),
    shape: shape,
);
```

## Email field

```dart
final TextEditingController _controller = TextEditingController();

BonsuiTextField(
    controller: _controller,
    label: 'Email field with validation',
    placeholder: 'Your email',
    type: BonsuiTextFieldType.email,
    shape: shape,
);
```

## Date field

```dart
final TextEditingController _controller = TextEditingController();

BonsuiTextField(
    controller: _controller,
    label: 'Date field with validation',
    placeholder: 'Your birth date',
    type: BonsuiTextFieldType.date,
    validator: BonsuiTextFieldValidator(
        minDate: DateTime(1900, 1, 1),
        maxDate: DateTime.now(),
    ),
    shape: shape,
);
```

## Time field

```dart
final TextEditingController _controller = TextEditingController();

BonsuiTextField(
    controller: _controller,
    label: 'Time field with validation',
    placeholder: 'Task time',
    type: BonsuiTextFieldType.time,
    validator: BonsuiTextFieldValidator(
        minDate: DateTime(1900, 1, 1),
        maxDate: DateTime.now(),
    ),
);
```

## Options field

It shows a text field that can be tapped to show a dialog with selectable options

```dart
final TextEditingController _controller = TextEditingController();

BonsuiTextField(
    controller: _controller,
    label: 'Options field',
    placeholder: 'Select an option',
    options: [
        BonsuiDropdownItem(value: '1', label: 'Option 1'),
        BonsuiDropdownItem(value: '2', label: 'Option 2'),
        BonsuiDropdownItem(
            value: '3',
            label: 'Option 3',
            icon: BonsuiIcons.celebration,
        ),
    ],
);
```

## Types

| Enum                  | Value      | Description                                                                                     |
| --------------------- | ---------- | ----------------------------------------------------------------------------------------------- |
| `BonsuiTextFieldType` | `text`     | Default                                                                                         |
| `BonsuiTextFieldType` | `number`   | It shows an only numbers keyboard                                                               |
| `BonsuiTextFieldType` | `datetime` | It shows a date time picker                                                                     |
| `BonsuiTextFieldType` | `date`     | It shows a date picker                                                                          |
| `BonsuiTextFieldType` | `time`     | It shows a time picker                                                                          |
| `BonsuiTextFieldType` | `email`    | It automatically checks if the field contains a valid email                                     |
| `BonsuiTextFieldType` | `password` | It makes the field characters not visible, and shows an eye icon on the right to show/hide them |

## Validators

Providing a **validator (BonsuiTextFieldValidator)** property automatically checks for errors in the field.<br>
These are the possible values:

| Class                      | Property           | Type       | Description                                                                                                                                                                       |
| -------------------------- | ------------------ | ---------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `BonsuiTextFieldValidator` | `errorText`        | `String`   | The error message is automatically translated by the internal service. If you want to use a custom message provide this property                                                  |
| `BonsuiTextFieldValidator` | `required`         | `bool`     | If set to true the field must be filled in                                                                                                                                        |
| `BonsuiTextFieldValidator` | `noSpaces`         | `bool`     | If set to true it checks for empty spaces in the field                                                                                                                            |
| `BonsuiTextFieldValidator` | `min`              | `int`      | Specifies a minimum number                                                                                                                                                        |
| `BonsuiTextFieldValidator` | `max`              | `int`      | Specifies a maximum number                                                                                                                                                        |
| `BonsuiTextFieldValidator` | `minDate`          | `DateTime` | Specifies a minimum date                                                                                                                                                          |
| `BonsuiTextFieldValidator` | `maxDate`          | `DateTime` | Specifies a maximum date                                                                                                                                                          |
| `BonsuiTextFieldValidator` | `minAge`           | `int`      | Specifies a minimum age to set in the date type field                                                                                                                             |
| `BonsuiTextFieldValidator` | `maxAge`           | `int`      | Specifies a maximum age to set in the date type field                                                                                                                             |
| `BonsuiTextFieldValidator` | `seBonsuiPassword` | `bool`     | If set to true and the field is type password, it checks if the password contains at least 8 characters, 1 uppercase letter, 1 lowercase letter, 1 number and 1 special character |
| `BonsuiTextFieldValidator` | `regex`            | `RegExp`   | Custom Regular Expression                                                                                                                                                         |

## Properties

| Property         | Type                       | Description                                                                                                           | Mandatory |
| ---------------- | -------------------------- | --------------------------------------------------------------------------------------------------------------------- | --------- |
| `controller`     | `TextEditingController`    | Field controller                                                                                                      | ✅        |
| `placeholder`    | `String`                   | Hints to show inside the text field when it is empty                                                                  | ❌        |
| `label`          | `String`                   | If set, it shows a label on the top of the text field                                                                 | ❌        |
| `secondaryLabel` | `String`                   | If set, it shows another label on the right of the main label                                                         | ❌        |
| `textAlign`      | `TextAlign`                | Alignment of the label and the inner field text                                                                       | ❌        |
| `prefixIcon`     | `IconData`                 | If set it shows an icon inside the text field, before the input                                                       | ❌        |
| `suffixIcon`     | `IconData`                 | If set it shows an icon inside the text field, after the input                                                        | ❌        |
| `suffixLabel`    | `String`                   | If set it shows a label inside the text field, after the input                                                        | ❌        |
| `suffix`         | `Widget`                   | If set it shows a custom widget inside the text field, after the input                                                | ❌        |
| `fontSize`       | `double`                   | Text field font size                                                                                                  | ❌        |
| `fontWeight`     | `FontWeight`               | Text field font weight                                                                                                | ❌        |
| `showBorder`     | `bool`                     | If set to true it shows a border around the text field                                                                | ❌        |
| `borderRadius`   | `double`                   | Custom text field border radius                                                                                       | ❌        |
| `shape`          | `BonsuiShape`              | Shape of the text field. Regular, rounded, squared. Default is the **BonsuiDesign.defaultElementsShape** (regular)    | ❌        |
| `color`          | `Color`                    | Custom text field background color                                                                                    | ❌        |
| `textColor`      | `Color`                    | Custom text field text color                                                                                          | ❌        |
| `showCounter`    | `bool`                     | If set to true it shows a counter on the bottom right of the text field with the current text field characters length | ❌        |
| `multiline`      | `bool`                     | If set to true the user can insert multiple lines                                                                     | ❌        |
| `maxLines`       | `int`                      | The maximum lines the user can insert                                                                                 | ❌        |
| `readonly`       | `bool`                     | If set to true the user can't edit the text field value                                                               | ❌        |
| `disabled`       | `bool`                     | If set to true the user can't edit the text field value and the field appears disabled                                | ❌        |
| `type`           | `BonsuiTextFieldType`      | Specifies the text field type                                                                                         | ❌        |
| `validator`      | `BonsuiTextFieldValidator` | Specifies the text field validations                                                                                  | ❌        |
| `options`        | `List<BonsuiDropdownItem>` | If set it shows a text field that can be tapped to show a dialog with selectable options                              | ❌        |
| `onValidation`   | `Function(bool)`           | Emits an event after the validator finished checking the field. Returns false if the field is not valid               | ❌        |
| `onChanged`      | `Function(String)`         | Emits an event when the user changes the value of the field. Returns the current value                                | ❌        |
| `onSubmitted`    | `Function(String)`         | Emits an event when the user presses submit on the field. Returns the current value                                   | ❌        |
| `focusNode`      | `FocusNode`                | Adds a custom focusNode                                                                                               | ❌        |
| `padding`        | `EdgeInsets`               | Sets a custom padding for the text field                                                                              | ❌        |
| `filled`         | `bool`                     | If set to true, the text field uses a background color. Default is **false**                                          | ❌        |
| `hideFocusState` | `bool`                     | If set to true, it hides the borders when focused                                                                     | ❌        |
