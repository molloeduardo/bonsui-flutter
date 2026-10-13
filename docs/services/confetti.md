# <div class="new-container">Confetti <div class="new">New</div></div>

---

The **confetti service** is used to show confetti animations.

!> You need a **BonsuiScaffold** with the **BonsuiConfett.key** key attached in order to use this animation

<div class="smartphone-container">
    <iframe src="https://www.eduardomollo.com/projects/bonsui/?screen=confetti" class="iframe-device" style="height: 400px !important;"></iframe>
</div>

## Explosion

```dart
BonsuiConfetti.show(); // Shows an explosion of confetti from the top center of the screen
```

## Waterfall

```dart
BonsuiConfetti.show(explosion: false); // Shows a waterfall of confetti from the top center of the screen
```

## Customization

| Property            | Type                             | Description                                                                    | Mandatory |
| ------------------- | -------------------------------- | ------------------------------------------------------------------------------ | --------- |
| `count`             | `int`                            | The number of confetti to show. Default is 150                                 | ❌        |
| `explosion`         | `bool`                           | If set to false it shows a waterfall effect. Default is true                   | ❌        |
| `useHapticFeedback` | `bool`                           | If set to true the device vibrates when the confetti animation starts          | ❌        |
| `position`          | `Alignment`                      | It sets the position where the confetti animation starts. Default is topCenter | ❌        |
| `duration`          | `Duration`                       | Duration of the animation. Default is 3 seconds                                | ❌        |
| `scaffoldKey`       | `GlobalKey<BonsuiScaffoldState>` | Scaffold key reference                                                         | ❌        |
