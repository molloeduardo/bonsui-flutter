# Scaffold

---

It replaces the default **Scaffold** widget in order to implement custom logic and different UI based on the OS.

## Example

```dart
BonsuiScaffold(
    body: Center(child: BonsuiText('Hello world')),
    safeArea: true,
    scrollable: true,
)
```

## Properties

| Property                       | Type                                     | Description                                                                                                                                                                                 | Mandatory |
| ------------------------------ | ---------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------- |
| `appBar`                       | [BonsuiAppBar](widgets/app-bar)          | Replaces the default **AppBar** in order to implement custom logic and different UI based on the OS.                                                                                        | ❌        |
| `body`                         | `Widget`                                 | Custom content to show as screen body                                                                                                                                                       | ❌        |
| `resizeToAvoidBottomInset`     | `bool`                                   | Standard behaviour as the default **Scaffold** Flutter widget                                                                                                                               | ❌        |
| `bottomNavigationBar`          | `Widget`                                 | You can use the **BottomNavigationBar** Flutter widget or the **BonsuiBottomNavigationBar**                                                                                                 | ❌        |
| `extendedBody`                 | `bool`                                   | Standard behaviour as the default **Scaffold** Flutter widget                                                                                                                               | ❌        |
| `floatingActionButton`         | `Widget`                                 | Standard behaviour as the default **Scaffold** Flutter widget                                                                                                                               | ❌        |
| `floatingActionButtonLocation` | `FloatingActionButtonLocation`           | Standard behaviour as the default **Scaffold** Flutter widget                                                                                                                               | ❌        |
| `backgroundColor`              | `Color`                                  | Standard behaviour as the default **Scaffold** Flutter widget. If not specified it will be used the **BonsuiDesign dark color** if in dark mode, otherwise the **BonsuiDesign white color** | ❌        |
| `safeArea`                     | `bool`                                   | If set to true it incapsulates the **body** inside a **SafeArea** widget                                                                                                                    | ❌        |
| `scrollable `                  | `bool`                                   | If set to true it incapsulates the **body** inside a **SingleChildSrollView** widget                                                                                                        | ❌        |
| `padding `                     | `EdgeInsets`                             | Sets the padding of the body                                                                                                                                                                | ❌        |
| `onPop `                       | `PopInvokedWithResultCallback<dynamic>?` | Function triggered when the user goes back                                                                                                                                                  | ❌        |
| `canPop `                      | `bool`                                   | If set to false the user can't pop the current screen                                                                                                                                       | ❌        |
