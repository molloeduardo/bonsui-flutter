# <div class="new-container">Charts <div class="new">New</div></div>

---

Used to create stunning and customizable charts. Supports **line**, **pie** and **donut** charts.

<div class="smartphone-container">
    <iframe src="https://www.eduardomollo.com/projects/bonsui/?screen=chart" class="iframe-device" style="height: 890px !important;"></iframe>
</div>

## Line chart

```dart
BonsuiChart(
    height: 200,
    xValues: ['Jan', 'Feb', 'Mar', 'Apr', 'May'],
    yValues: [[10.0, 20.0, 30.0, 40.0, 50.0]],
    colors: [BonsuiDesign.successColor],
);
```

## Pie chart

```dart
BonsuiChart(
    type: BonsuiChartType.pie,
    height: 240,
    xValues: ['Food', 'Transport', 'Other'],
    yValues: [
        [50, 30, 20],
        [40, 35, 25],
    ],
    colors: [Colors.orange, Colors.blue, Colors.green],
    suffix: ' EUR',
);
```

## Donut chart

```dart
BonsuiChart(
    type: BonsuiChartType.donut,
    xValues: ['Food', 'Transport', 'Other'],
    yValues: [[50, 30, 20]],
    centerChild: Text('Total: 100'),
    hideLegend: false,
    hideValues: false,
);
```

## Properties

| Property             | Type              | Description                                                                                                                                            | Mandatory |
| -------------------- | ----------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ | --------- |
| `xValues`            | `List<dynamic>`   | X-axis labels for lines; legend and tooltip labels for pies                                                                                            | ✅        |
| `yValues`            | `List<dynamic>`   | Nested numeric lists, one per series                                                                                                                   | ✅        |
| `type`               | `BonsuiChartType` | `line` (default), `pie` or `donut`                                                                                                                     | ❌        |
| `height`             | `double`          | Chart height; defaults to `220.0`                                                                                                                      | ❌        |
| `colors`             | `List<Color>?`    | Line colors or pie category colors, repeated as needed. Must not be empty. Defaults to **BonsuiDesign.primaryColor** and **BonsuiDesign.successColor** | ❌        |
| `suffix`             | `String`          | Text appended directly to numeric values in all chart types. Defaults to `''`                                                                          | ❌        |
| `yUnitOnlyInTooltip` | `bool`            | Show `suffix` only in tooltips, hiding it on the Y axis and internal pie/donut values. Defaults to `false`                                             | ❌        |
| `hideLegend`         | `bool`            | Hide the pie/donut legend. Defaults to `false`                                                                                                         | ❌        |
| `hideValues`         | `bool`            | Hide values inside pie/donut slices. Defaults to `false`                                                                                               | ❌        |
| `centerChild`        | `Widget?`         | Custom widget in the donut hole; ignored for other types                                                                                               | ❌        |
