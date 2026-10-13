# Bottom Navigation Bar

---

<div class="smartphone-container">
    <iframe src="https://www.eduardomollo.com/projects/bonsui/?screen=bottom-navigation-bar" class="iframe-device" style="min-height: 370px; height: 370px !important;"></iframe>
</div>

## Example

```dart
int currentScreenIndex = 0;

BonsuiBottomNavigationBar(
    onTap: (index) {
        setState(() {
            ßcurrentScreenIndex = index;
        });
    },
    currentIndex: currentScreenIndex,
    items: [
        BonsuiBottomNavigationBarItem(
            icon: BonsuiIcons.home,
            label: 'Home',
        ),
        BonsuiBottomNavigationBarItem(
            icon: BonsuiIcons.deviceMobile,
            label: 'Screens',
        ),
        BonsuiBottomNavigationBarItem(
            icon: BonsuiIcons.list,
            label: 'Forms',
        ),
        BonsuiBottomNavigationBarItem(
            icon: BonsuiIcons.starOutlined,
            label: 'Miscellaneous',
        ),
        BonsuiBottomNavigationBarItem(
            icon: BonsuiIcons.downloadOutlined,
            label: 'Buttons',
        ),
    ],
);
```

## Vertical layout

By default the bottom navigation bar uses an **horizontal layout**.

In vertical layout, the bar grows to fit its icons and visible labels, including
custom icons and scaled text, while preserving the bottom safe-area padding.
The additional bottom padding is 4 px in vertical layout and 12 px in horizontal
layout; on iOS with a bottom inset, only the safe-area padding is used.

```dart
int currentScreenIndex = 0;

BonsuiBottomNavigationBar(
    onTap: (index) {
        setState(() {
            ßcurrentScreenIndex = index;
        });
    },
    horizontalLayout: false, // Sets the layout to vertical
    currentIndex: currentScreenIndex,
    items: [
        BonsuiBottomNavigationBarItem(
            icon: BonsuiIcons.home,
            label: 'Home',
        ),
        BonsuiBottomNavigationBarItem(
            icon: BonsuiIcons.deviceMobile,
            label: 'Screens',
        ),
        BonsuiBottomNavigationBarItem(
            icon: BonsuiIcons.list,
            label: 'Forms',
        ),
        BonsuiBottomNavigationBarItem(
            icon: BonsuiIcons.starOutlined,
            label: 'Miscellaneous',
        ),
        BonsuiBottomNavigationBarItem(
            icon: BonsuiIcons.downloadOutlined,
            label: 'Buttons',
        ),
    ],
);
```

## Custom icons

You can change the single items properties in order to use custom icons and colors.

```dart
int currentScreenIndex = 0;

BonsuiBottomNavigationBar(
    onTap: (index) {
        setState(() {
            ßcurrentScreenIndex = index;
        });
    },
    currentIndex: currentScreenIndex,
    items: [
        BonsuiBottomNavigationBarItem(
            label: 'Home',
            widgetIcon: Icon(Icons.abc_rounded, size: 12, color: BonsuiDesign.whiteColor), // Custom icon
            activeWidgetIcon: Icon(Icons.abc, size: 12, color: BonsuiDesign.whiteColor), // Custom selected item icon
        ),
        BonsuiBottomNavigationBarItem(
            icon: BonsuiIcons.deviceMobile,
            label: 'Screens',
        ),
        BonsuiBottomNavigationBarItem(
            icon: BonsuiIcons.list,
            label: 'Forms',
        ),
        BonsuiBottomNavigationBarItem(
            icon: BonsuiIcons.starOutlined,
            label: 'Miscellaneous',
            color: Colors.blue, // Changes the single item color
        ),
        BonsuiBottomNavigationBarItem(
            icon: BonsuiIcons.downloadOutlined,
            label: 'Buttons',
            activeIcon: BonsuiIcons.download, // It shows when the item is selected
        ),
    ],
);
```

## Properties

| Property              | Type                                  | Description                                                                                | Mandatory |
| --------------------- | ------------------------------------- | ------------------------------------------------------------------------------------------ | --------- |
| `items`               | `List<BonsuiBottomNavigationBarItem>` | List of items to show                                                                      | ✅        |
| `currentIndex`        | `int`                                 | The selected item index                                                                    | ✅        |
| `onTap`               | `Function(int)`                       | Emits an event when the user taps on an item. Returns the index                            | ❌        |
| `backgroundColor`     | `Color`                               | Changes the default bottom bar background color                                            | ❌        |
| `selectedColor`       | `Color`                               | Specifies the item selected color (both icon and label)                                    | ❌        |
| `unselectedColor`     | `Color`                               | Specifies the unselected items color (both icon and label)                                 | ❌        |
| `showUnselectedLabel` | `bool`                                | If **true** it shows every items label                                                     | ❌        |
| `showSelectedLabel`   | `bool`                                | If set to **true** shows the selected item label (default is **true** on horizontalLayout) | ❌        |
| `horizontalLayout`    | `bool`                                | If set to **false** the layout becomes vertical or icon only                               | ❌        |
| `shape`               | `BonsuiShape`                         | Shape of the items. Default is **BonsuiShape.rounded**                                     | ❌        |
| `labelSize`           | `double`                              | Set the size of all labels                                                                 | ❌        |
