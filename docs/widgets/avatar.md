# Avatar

---

<div class="smartphone-container">
    <iframe src="https://www.eduardomollo.com/projects/bonsui/?screen=avatar" class="iframe-device" style="height: 123px !important;"></iframe>
</div>

## Example

```dart
BonsuiAvatar(
    notifications: 3,
    url: 'https://ui-avatars.com/api/?name=John+Doe&format=png',
    size: BonsuiAvatarSize.large,
    isOnline: true,
);
```

## Properties
| Property | Type | Description | Mandatory |
| --------------- | ---------------- | ----------------------------------------------------------------------------------------------------------------------------------- | --------- |
| `url` | `String` | If set it shows the network image from the URL | ❌ |
| `path` | `String` | If set it shows the local image from the path | ❌ |
| `shape` | `BonsuiShape` | Regular, rounded, squared. Default is **rounded** | ❌ |
| `size` | `BonsuiAvatarSize` | extraSmall, small, medium, large, extraLarge. Default is **medium** | ❌ |
| `color` | `Color` | The image color | ❌ |
| `border` | `Border` | Defines the border to show around the avatar | ❌ |
| `child` | `Widget` | Use this property to add a custom widget in the Avatar space with a Positioned | ❌ |
| `shadow` | `BoxShadow` | Shadow to show around the avatar | ❌ |
| `widthHeight` | `double` | Custom width and height size. If set it replaces the **size** property | ❌ |
| `isOnline` | `bool` | If set to true, it shows a green circle on the bottom left of the avatar | ❌ |
| `notifications` | `int` | If set it shows the number of notifications in a red circle on the top right of the avatar | ❌ |
| `fit` | `BoxFit` | If set, it changes the image fit. Default is **BoxFit.cover** | ❌ |
