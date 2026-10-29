# 🎨&nbsp;&nbsp;Design

---

## Colors and variables

These variables are used in all the components to define their appearence.<br>
You can specify your custom values by changing them in your **main.dart** file. The following are the default values:

```dart
// Colors
static Color primaryColor = const Color(0xff3B93F6);
static Color secondaryColor = const Color(0xff20d1d8);
static Color whiteColor = const Color(0xffffffff);
static Color blackColor = const Color(0xff181818);
static Color disabledColor = const Color(0xffC9D0DB);
static Color textColor = const Color(0xff222222);
static Color textColorLight = const Color(0xff666666);
static Color backgroundColor = const Color(0xffffffff);
static Color backgroundColorDark = const Color(0xff121212);
static Color borderColor = Colors.grey.shade300;
static Color dangerColor = const Color(0xffff5733);
static Color successColor = const Color(0xff8bc34a);
static Color warningColor = const Color(0xffff892e);
static Color infoColor = const Color.fromARGB(255, 86, 135, 251);

// Other
static BonsuiShape defaultElementsShape = BonsuiShape.regular; // Available: regular, rounded, squared
static double borderRadius = 12.0;
static double spacing = 8.0;
static Duration animationDuration = const Duration(milliseconds: 200);

// Example of design changing variables
Future<void> main() async {
  BonsuiDesign.primaryColor = const Color(0xff6B61A2);
  BonsuiDesign.defaultElementsShape = BonsuiShape.rounded; // All the components used will have a rounded radius
}
```

## Dark mode

The dark mode automatically **changes the appearence of all the library components**.<br>
You can set the dark mode manually or automatically change it based on the device settings.

```dart
// Manual change
BonsuiDesign.useDarkMode = true;

// Auto dark mode (it automatically changes all the UI elements theme, based on the device setting)
BonsuiDesign.autoDarkMode = true;

// Based on the system
BonsuiDesign.useDarkMode = BonsuiUtils.isSystemDarkModeActive();
```

## Padding sets

A useful collection of **paddings** in order to keep the UI clean and equal. You can use the default ones, or add new ones in your **main**.

```dart
// Default Paddings
'small': const EdgeInsets.all(6.0),
'medium': const EdgeInsets.all(10.0),
'large': const EdgeInsets.all(12.0),
'biggest': const EdgeInsets.all(16.0),
'small-horizontal': const EdgeInsets.symmetric(horizontal: 6.0),
'medium-horizontal': const EdgeInsets.symmetric(horizontal: 10.0),
'large-horizontal': const EdgeInsets.symmetric(horizontal: 12.0),
'biggest-horizontal': const EdgeInsets.symmetric(horizontal: 16.0),
'small-vertical': const EdgeInsets.symmetric(vertical: 6.0),
'medium-vertical': const EdgeInsets.symmetric(vertical: 10.0),
'large-vertical': const EdgeInsets.symmetric(vertical: 12.0),
'biggest-vertical': const EdgeInsets.symmetric(vertical: 16.0),

// Custom paddings (added to the default ones)
BonsuiDesign.paddings = {
  ...BonsuiDesign.paddings,
  'custom': EdgeInsets.all(16.0),
};

// Custom paddings (replace the default ones)
BonsuiDesign.paddings = {
  'custom': EdgeInsets.all(16.0),
};

// Usage example
Container(padding: BonsuiDesign.paddings['small']);
```

## Animations

You can use these **animations durations** in your app in order to have a unified and clean code and coeherent animations.

```dart
// Default animations durations (used in the pre-built screens)
BonsuiAnimationDuration.slow: const Duration(milliseconds: 600),
BonsuiAnimationDuration.medium: const Duration(milliseconds: 400),
BonsuiAnimationDuration.fast: const Duration(milliseconds: 200),

// Custom animation duration
BonsuiDesign.animationDurations[BonsuiAnimationDuration.medium] = const Duration(milliseconds: 1200),

// Usage example
FadeIn(
  duration: BonsuiDesign.animationDurations[BonsuiAnimationDuration.medium],
  child: BonsuiText('Hello!')
);
```

## Spacing

You can use the **BonsuiSpacing** methods to easily create spacing boxes. The spacing unit is the **spacing** variable set in the design. If you specify the **multiplier** parameter it will increase the space.

```dart
// Vertical
BonsuiSpacing.vertical(); // Default is 8
BonsuiSpacing.vertical(2); // 16
BonsuiSpacing.vertical(3); // 24
...

// Horizontal
BonsuiSpacing.horizontal(); // Default is 8
BonsuiSpacing.horizontal(2); // 16
BonsuiSpacing.horizontal(3); // 24
...
```
