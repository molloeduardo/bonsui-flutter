# Localization

---

## Set language

This method is used to set the preferred language. <br/>
Available languages: **english (en)**, **italian (it)**, **spanish (es)**.<br>
The default fallback language is **English (en)**

```dart
BonsuiLocalization.load(locale: 'it'); // Manually set a language
BonsuiLocalization.load(); // Uses the system language
```

Call this method inside your **main function**.

## Get used language

It returns the used language.

```dart
BonsuiLocalization.getSystemLanguage();
```

## Set values

To specify the labels for your language you have to create the **i18n** folder inside your **assets folder** and then a **.json file** with the locale name. Then import the dependency inside your **pubspec.yaml**. For example: assets/i18n/it.json. Then you can set your labels inside the json file.

```dart
{
    'common': {'close': 'Close'},
    'screens': {
        'welcome': {'finish_button': 'Start now'},
        'welcome_name': 'Hello {name}',
    }
},
```

## Get value

With this method you can get the localized value.

```dart
BonsuiLocalization.get('common.close');

// Example in a text widget
BonsuiText(
    BonsuiLocalization.get('common.close')
);
```

## <div class="new-container">Get value with params <div class="new">New</div></div>

You can pass params to dynamically change a localized label.

```dart
BonsuiLocalization.get('screens.welcome_name', params: {'name': 'John'});
```
