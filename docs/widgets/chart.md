# <div class="new-container">Chart <div class="new">New</div></div>

---

Used to create a stunning and customizable chart.

!>At the moment it's only supported a **line chart**. In the future I more types will be added

<div class="smartphone-container">
    <iframe src="https://www.eduardomollo.com/projects/bonsui/?screen=chart" class="iframe-device" style="height: 310px !important;"></iframe>
</div>

## Example

```dart
BonsuiChart(
    height: 200,
    xValues: ['Jan', 'Feb', 'Mar', 'Apr', 'May'],
    yValues: [[10.0, 20.0, 30.0, 40.0, 50.0]],
    lineColor: BonsuiDesign.successColor,
);
```

## Properties

| Property     | Type                  | Description                                                                                             | Mandatory |
| ------------ | --------------------- | ------------------------------------------------------------------------------------------------------- | --------- |
| `xValues`    | `List<dynamic>`       | List of values to show on the X axis. Can be strings or numbers                                         | ✅        |
| `yValues`    | `List<List<dynamic>>` | List of values to show on the Y axis. You can show multiple values using multiple lists                 | ✅        |
| `height`     | `Widget`              | Height of the chart                                                                                     | ✅        |
| `lineColors` | `List<Color>`         | Colors of the chart lines. Defaults are **BonsuiDesign.primaryColor** and **BonsuiDesign.successColor** | ❌        |
