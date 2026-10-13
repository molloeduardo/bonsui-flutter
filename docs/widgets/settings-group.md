# Settings Group

---

<div class="smartphone-container">
    <iframe src="https://www.eduardomollo.com/projects/bonsui/?screen=settings" class="iframe-device" style="height: 200px !important;"></iframe>
</div>

## Example

```dart
BonsuiSettingsGroup(
    title: 'Theme settings',
    items: [
        BonsuiSettingsItem(
            description: 'Dark mode',
            icon: Icons.dark_mode,
            child: BonsuiSwitch(
                checked: BonsuiDesign.useDarkMode,
                onChanged: (value) {
                    setState(() {
                        BonsuiDesign.useDarkMode = value;
                    });
                },
            ),
        ),
        BonsuiSettingsItem(
            description: 'Light mode',
            icon: Icons.light_mode,
            child: BonsuiSwitch(
            checked: !BonsuiDesign.useDarkMode,
                onChanged: (value) {
                    setState(() {
                        BonsuiDesign.useDarkMode = !value;
                    });
                },
            ),
        ),
    ],
):
```

## Properties
| Property | Type | Description | Mandatory |
| --------------- | ---------------- | ----------------------------------------------------------------------------------------------------------------------------------- | --------- |
| `items` | `List<BonsuiSettingsItem>` | Settings items list | ✅ |
| `title` | `String` | If set it shows a label on the top of the group | ❌ |
| `titleChild` | `Widget` | If set it shows the custom widget on the top of the group | ❌ |
