# Welcome Screen

---

A **ready-to-use**, fully animated and high customizable screen to use as a brief app introduction to show the user what is it about.<br>
Try it in the [interactive example](/#/example) under the **screens** section.

!> This and all the screens depend on the package [animate_do](https://pub.dev/packages/animate_do)

<div class="smartphone-container">
    <iframe src="https://www.eduardomollo.com/projects/bonsui/?screen=welcome-screen" style="height: 900px !important;"></iframe>
</div>

## Example

```dart
BonsuiWelcomeScreen(
    background: Image.asset(
        'assets/images/background.png',
    ),
    onFinish: () {
        Navigator.of(context).pop();
        // Do something...
    },
    logo: Image.asset(
        BonsuiUtils.darkModeWrapper(
            'assets/images/logo-icon-dark.png',
            'assets/images/logo-icon-white.png',
        ),
        width: 100,
    ),
    sections: [
        BonsuiWelcomeScreenSection(
            title: 'Welcome aboard ❤️',
            description:
                "Are you ready to speed up and improve your development process with the Bonsui Library?",
            content: Image.asset(
            'assets/images/welcome/1.png',
            ),
        ),
        BonsuiWelcomeScreenSection(
            title: 'UI Components 🎨',
            description:
                'Stunning and ready to use UI components to speed up your development process.',
            content: Image.asset(
            'assets/images/welcome/2.png',
            ),
        ),
        BonsuiWelcomeScreenSection(
            title: 'Screens 📱',
            description:
                'Pre-built screens to get you started in no time.',
            content: Image.asset(
            'assets/images/welcome/3.png',
            ),
        ),
        BonsuiWelcomeScreenSection(
            title: 'Services ⚙️',
            description:
                'Ready to use services like localization, authentication and more to enhance your app development.',
            content: Image.asset(
            'assets/images/welcome/4.png',
            ),
        ),
    ],
);
```

## Properties

| Property            | Type                               | Description                                             | Mandatory |
| ------------------- | ---------------------------------- | ------------------------------------------------------- | --------- |
| `sections`          | `List<BonsuiWelcomeScreenSection>` | The list of sections                                    | ✅        |
| `finishButtonLabel` | `String`                           | The label showed inside the finish button               | ❌        |
| `onFinish`          | `Function(void)`                   | Emits an event when the user taps on the Finish button  | ❌        |
| `logo`              | `Widget`                           | Custom widget to show on the top of the pages           | ❌        |
| `background`        | `Image`                            | Adds a custom image background at the top of the screen | ❌        |
