# Utils

---

## <div class="new-container">Screen width <div class="new">New</div></div>

Returns the **screen width** from a percentage

```dart
SizedBox(width: BonsuiUtils.dynamicWidth(context, 50)); // 50% of the screen width
```

## <div class="new-container">Screen height <div class="new">New</div></div>

Returns the **screen height** from a percentage

```dart
SizedBox(height: BonsuiUtils.dynamicHeight(context, 60)); // 60% of the screen height
```

## Check iOS

Returns true if the system is using **iOS** or **Mac OS**.

```dart
BonsuiUtils.isIOs();
```

## Navigate to

Navigate to a screen with the system specific animation (iOS, Android).

```dart
BonsuiUtils.navigateTo(context, const NewScreen());
```

## Navigate replace

Replace the current screen with a new one with the system specific animation (iOS, Android).

```dart
BonsuiUtils.navigateReplace(context, const NewScreen());
```

## Navigate back

Pop to the previous screen.

```dart
BonsuiUtils.navigateBack();
```

## Email validity

Returns **true** if the email is valid.

```dart
BonsuiUtils.isEmailValid('john.doe@gmail.com');
```

## <div class="new-container">First letter uppercase <div class="new">New</div></div>

Returns a string with the first letter uppercase.

```dart
BonsuiUtils.upperCaseFirst('hello'); // Returns Hello
```

## Open URL

Method used to open a web URL.

!> This method depends on the [url_launcher](https://pub.dev/packages/url_launcher) package

```dart
BonsuiUtils.openUrl('https://www.eduardomollo.com/', false); // Opens in the internal app browser
BonsuiUtils.openUrl('https://www.eduardomollo.com/', true); // Opens in the external app browser
```

## Darken

A useful function that returns a **darker color** from a starting one.

```dart
BonsuiUtils.darken(Color(0xff0088ff), 0.4); // From 0.1 to 1.0 intensity
```

## Lighten

A useful function that returns a **lighter** Color from a starting one.

```dart
BonsuiUtils.lighten(Color(0xff0088ff), 0.4); // From 0.1 to 1.0 intensity
```

## Dark mode active

Returns **true** if the system has dark mode active.

```dart
BonsuiUtils.isSystemDarkModeActive();
```

## Dark mode wrapper

It is used to display a **dynamic** widget or any kind of data based on the dark mode setting.<br>
It's useful in order to keep the code clean avoiding inline if-else statements and reduntant code.<br>
The **first parameter** indicates the return value if the dark mode is **disabled**, while the second parameter the opposite.

```dart
// Example with a string
Image.asset(BonsuiUtils.darkModeWrapper('images/logo-dark.png', 'images/logo-white.png'));

// Example with a widget
BonsuiUtils.darkModeWrapper(
    Image.asset('assets/images/logo-icon-dark.png', height: 150),
    Image.asset('assets/images/logo-icon-white.png', height: 150),
);
```

## <div class="new-container">Splash factory <div class="new">New</div></div>

A useful function that returns a ripple splash factory on Android and no splash factory on iOS

```dart
BonsuiUtils.getSplashFactory();
```

## Dialog

Opens a dialog with the current system style and animations (iOS, Android).

```dart
// Dialog with custom content (you can use every widget you want)
BonsuiUtils.openDialog(context, 'Title', content: BonsuiText('This is the dialog content'));

// Dialog with actions
BonsuiUtils.openDialog(context, 'Title', content: BonsuiText('This is the dialog content'), actions: [
    BonsuiDialogAction(label: 'Action 1', color: Colors.blue, icon: BonsuiIcons.thumbsUp, onPressed: () {
        // Something to do
    }),
    BonsuiDialogAction(label: 'Action 2', color: Colors.red, onPressed: () {
        // Something to do
    })
]);
```

## Bottom sheet

Opens a bottom sheet with the current system style and animations (iOS, Android).

```dart
// Bottom sheet with custom content (you can use every widget you want)
BonsuiUtils.openBottomSheet(context, 'Title', content: BonsuiText('This is the bottom sheet content'));

// Bottom sheet with actions
BonsuiUtils.openBottomSheet(context, 'Title', content: BonsuiText('This is the bottom sheet content'), actions: [
    BonsuiDialogAction(label: 'Action 1', color: Colors.blue, onPressed: () {
        // Something to do
    }),
    BonsuiDialogAction(label: 'Action 2', color: Colors.red, onPressed: () {
        // Something to do
    })
]);
```

## Debouncer

Method used to delay a certain action.

```dart
final _debouncer = BonsuiDebouncer(milliseconds: 500);
_debouncer.run(() {
    // Activity to run after X milliseconds
});

_debouncer.dispose(); // Cancels the timer
```

## Icon to string

A useful method that converts an **IconData** into a **String**.

```dart
String icon = BonsuiUtils.fromIconToString(Icons.close);
```

## String to icon

A useful method that converts a **String** into an **IconData**.

```dart
IconData icon = BonsuiUtils.fromStringToIcon('icon string');
```

## Dates

Useful methods to retrieve localized months and week days names.

```dart
List<String> months = BonsuiUtils.getMonthsNames();
List<String> weekDays = BonsuiUtils.getWeekDaysNames();
```

!> Available languages: **english, italian, spanish**

## HTML parsing

Method that converts an HTML string in a RichText.

```dart
RichText text = BonsuiUtils.parseHtml('I am a <b>HTML</b> string');
```

!> At the moment it only supports these HTML tags: **b**
