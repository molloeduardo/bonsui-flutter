# <div class="new-container">View Slider <div class="new">New</div></div>

---

Used to show scrollable tabs with content.

<div class="smartphone-container">
    <iframe src="https://www.eduardomollo.com/projects/bonsui/?screen=view-slider" class="iframe-device"  style="height: 300px !important;"></iframe>
</div>

## Example

```dart
int selectedPage = 0;

SizedBox(
    height: 200,
    child: BonsuiViewSlider(
        options: [
        BonsuiViewSliderOption(
            content: BonsuiText('Page 1 content'),
            isSelected: selectedPage == 0,
            title: 'Page 1',
        ),
        BonsuiViewSliderOption(
            content: BonsuiText('Page 2 content'),
            isSelected: selectedPage == 1,
            title: 'Page 2',
        ),
        BonsuiViewSliderOption(
            content: BonsuiText('Page 3 content'),
            isSelected: selectedPage == 2,
            title: 'Page 3',
        ),
        ],
        onTabChanged: (index) {
            setState(() {
                selectedPage = index;
            });
        },
    ),
);
```

## Properties

| Property       | Type                           | Description                                                                 | Mandatory |
| -------------- | ------------------------------ | --------------------------------------------------------------------------- | --------- |
| `options`      | `List<BonsuiViewSliderOption>` | List of the views to show                                                   | ✅        |
| `padding`      | `EdgeInsetsGeometry`           | Custom padding for all the component                                        | ❌        |
| `tabsPadding`  | `EdgeInsetsGeometry`           | Custom padding applied only inside the tab views                            | ❌        |
| `onTabChanged` | `Function(int)`                | Emits an event when the user changes tab and returns the selected tab index | ❌        |
