# Text

---

## Example

```dart
BonsuiText('Hello world', color: Colors.red);

// Gradient example
BonsuiText('Text with gradient!', gradient: BonsuiGradient(colors: [Colors.blue, Colors.purple]),)
```

## Properties

| Property        | Type             | Description                                                                                                                             | Mandatory |
| --------------- | ---------------- | --------------------------------------------------------------------------------------------------------------------------------------- | --------- |
| `color`         | `Color`          | Custom text color. Default one is the **BonsuiDesign text color** if dark mode is active, and **BonsuiDesign white color** if it is not | ❌        |
| `align`         | `TextAlign`      | Text alignment                                                                                                                          | ❌        |
| `maxLines`      | `int`            | How many max lines the text can reach                                                                                                   | ❌        |
| `size`          | `double`         | Text size. Default is 16                                                                                                                | ❌        |
| `lineHeight`    | `double`         | Text line height. Default is 1.5                                                                                                        | ❌        |
| `shadows`       | `List<Shadow>`   | List of shadows to apply to the text                                                                                                    | ❌        |
| `weight`        | `FontWeight`     | Text weight. Default is FontWeight.w600                                                                                                 | ❌        |
| `padding`       | `EdgeInsets`     | Custom padding to apply around the text                                                                                                 | ❌        |
| `letterSpacing` | `double`         | Space between letters                                                                                                                   | ❌        |
| `fontFamily`    | `String`         | Custom font family                                                                                                                      | ❌        |
| `fontStyle`     | `FontStyle`      | Custom font style                                                                                                                       | ❌        |
| `decoration`    | `TextDecoration` | Custom text decoration                                                                                                                  | ❌        |
| `overflow`      | `TextOverflow`   | Text overflow                                                                                                                           | ❌        |
| `gradient`      | `BonsuiGradient` | Applies a custom gradient on the text                                                                                                   | ❌        |
