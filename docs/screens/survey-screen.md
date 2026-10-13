# Sign Up Screen

---

A **ready-to-use**, fully animated and high customizable screen to use to show a survey (list of questions with single/multiple answers).<br>
Try it in the [interactive example](/#/example) under the **screens** section.

!> This and all the screens depend on the package [animate_do](https://pub.dev/packages/animate_do)

<div class="smartphone-container">
    <iframe src="https://www.eduardomollo.com/projects/bonsui/?screen=survey-screen" style="height: 900px !important;"></iframe>
</div>

## Example

```dart
BonsuiSurveyScreen(
    onSkip: () {
        Navigator.of(context).pop();
        // Do something...
    },
    logo: BonsuiUtils.darkModeWrapper('assets/images/logo-dark.png', 'assets/images/logo-white.png')
    onFinish: (answers) {
        // Do something...
    },
    questions: [
        BonsuiSurveyQuestion(
            question: 'How many hours do you spend on your phone?',
            answers: [
                BonsuiSurveyAnswer(text: '😌 1-2 hours', id: 1),
                BonsuiSurveyAnswer(text: '😊 2-4 hours', id: 2),
                BonsuiSurveyAnswer(text: '😅 4-6 hours', id: 3),
                BonsuiSurveyAnswer(text: '😩 6+ hours', id: 4),
            ],
        ),
        BonsuiSurveyQuestion(
            question: 'How many hours do you sleep at night?',
            answers: [
                BonsuiSurveyAnswer(
                    text: '😎 I don\'t sleep',
                    id: 1,
                ),
                BonsuiSurveyAnswer(
                    text: '🥱 Less than 6 hours',
                    id: 2,
                    selected: true,
                ),
                BonsuiSurveyAnswer(text: '😌 6-7 hours', id: 3),
                BonsuiSurveyAnswer(text: '😴 7+ hours', id: 4),
            ],
        ),
        BonsuiSurveyQuestion(
            multipleChoices: true,
            maxChoices: 3,
            question: 'What is your favorite way to relax?',
            answers: [
                BonsuiSurveyAnswer(text: '📖 Reading', id: 1),
                BonsuiSurveyAnswer(text: '🎮 Gaming', id: 2),
                BonsuiSurveyAnswer(
                    text: '🏃‍♂️ Exercising',
                    id: 3,
                ),
                BonsuiSurveyAnswer(
                    text: '🛀 Taking a bath',
                    id: 4,
                ),
            ],
        ),
    ],
);
```

## Properties

| Property          | Type                                           | Description                                                                                                                      | Mandatory |
| ----------------- | ---------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- | --------- |
| `questions`       | `List<BonsuiSurveyQuestion>`                   | The list of questions                                                                                                            | ✅        |
| `onSkip`          | `Function(void)`                               | Emits an event when the user taps on the Skip button                                                                             | ❌        |
| `onFinish`        | `Function(Map<int, List<BonsuiSurveyAnswer>>)` | Emits an event when the user taps on the Finish button. It returns a map with the question id and theh list of the given answers | ❌        |
| `logo`            | `Widget`                                       | Custom widget shown as logo at the top right of the screen                                                                       | ❌        |
| `hideProgressBar` | `bool`                                         | Hides the progress bar on top if set to true                                                                                     | ❌        |
