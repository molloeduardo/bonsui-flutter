<div align="center" class="main-logo">
  <img src="_media/logo.png" width="450">
</div>
<br>
<hr>

<div class="flex-center main-buttons-container">
    <a class="button-outline" href="#/services/README">⚙️&nbsp;&nbsp;Services</a>
    <a class="button-outline" href="#/widgets/README">🧩&nbsp;&nbsp;Widgets</a>
    <a class="button-outline" href="#/screens/README">📱&nbsp;&nbsp;Screens</a>
</div>

<br>

# What is this for?

<p style="font-size:20px; line-height: 2rem;">
A Flutter library that speeds up development with ready-to-use UI components, screens, and services to build high-quality iOS and Android apps from a single codebase.
</p>

The **Bonsui Flutter Library** is designed to accelerate your app development workflow.<br>
It provides a rich collection of efficient and visually appealing **UI components**, **ready-to-use screens**, and practical **services**, including powerful tools for **forms validation**.<br>
<br>
Its core mission is to **reduce boilerplate code and simplify common development tasks**, allowing you to deliver **high-quality applications more quickly**.<br>
While focusing on productivity, the library also emphasizes **design consistency** and **user experience**, helping you create apps that are not only functional but also beautifully crafted.

<br>

# Example: before and after

A multiplatform button created without and with the library.

<div class="flex-center">
    <div class="laptop-container">
        <iframe src="https://www.eduardomollo.com/projects/bonsui/before-after.html" style="height: 1000px; border: solid 6px #111; border-radius: 36px; box-shadow: 0px 15px 15px #b0b0b0"></iframe>
    </div>
</div>

<br>

# Interactive sample

Navigate this interactive example with all the components.<br>
Keep in mind that this is the representation of the Android UI. The style and the animations will be different when running on iOS.

---

<div class="flex-center">
    <div class="smartphone-container">
        <iframe src="https://www.eduardomollo.com/projects/bonsui/" style="height: 900px; border: solid 6px #111; border-radius: 36px; box-shadow: 0px 15px 15px #b0b0b0"></iframe>
    </div>
</div>
<br><br><br>

# How to use

---

## Install

Run this command in your Flutter project to install the library

```
flutter pub add bonsui
```

## Import

Import the global library file, or the single ones.

```dart
import 'package:bonsui/bonsui.dart'; // Global
import 'package:bonsui/services/storage.dart'; // Specific service
import 'package:bonsui/widgets/button.dart'; // Specific widget
...
```

## Dependencies

Some **components**, **screens** and **services** have external packages dependencies. This is the full list:

| Components / Screens / Services                                                                     | Dependencies                                                                                                                                                                                |
| --------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `All the ready-to-use screens`                                                                      | [animate_do](https://pub.dev/packages/animate_do)                                                                                                                                           |
| `BonsuiUtils.openUrl, BonsuiLink, BonsuiPaywallScreen, BonsuiRegistrationScreen, BonsuiLoginScreen` | [url_launcher](https://pub.dev/packages/url_launcher)                                                                                                                                       |
| `BonsuiPaywallScreen`                                                                               | [intl](https://pub.dev/packages/intl)                                                                                                                                                       |
| `BonsuiSupabaseService`                                                                             | [supabase_flutter](https://pub.dev/packages/supabase_flutter), [google_sign_in](https://pub.dev/packages/google_sign_in), [sign_in_with_apple](https://pub.dev/packages/sign_in_with_apple) |
| `BonsuiSqlService`                                                                                  | [sqflite](https://pub.dev/packages/sqflite), [path](https://pub.dev/packages/path)                                                                                                          |

<hr>

# Future Developments

I am just getting started – here’s what’s coming next for **Bonsui Flutter Library**:

**🛠 Refactoring**<br>
• Cleaner, faster, and more maintainable codebase.<br>
• Consistent patterns to make contributions and usage easier.<br>
• Less external dependencies.

**🧩 New Widgets**<br>
• Fresh reusable UI widgets to cover more use cases.<br>
• Focus on flexibility, customization, and accessibility.

**📱 New Screens**<br>
• Ready-to-use screens and flows for common app scenarios.<br>
• Designed to save time and keep your apps beautiful out of the box.

**✨ Polished Details & Animations**<br>
• Smoother transitions and delightful micro-interactions.<br>
• Pixel-perfect refinements for an even more professional look.

**📝 Improve the Docs**<br>
• Clear docs = happy developers.<br>
• Fix typos, add and improve examples, or explain things in a simpler way.

⸻

🚀 My mission is to keep evolving and making app development with Flutter faster, simpler, and more fun, while never compromising on design quality.

<hr>

# How to Contribute

I'd love your help to make **Bonsui** grow and get even better ❤️

Here’s how you can join the journey:

**🐞 Report Issues**<br>
Spotted a bug? Open an issue and let me know<br>
The more details (steps, screenshots, expected vs. actual behavior), the better!

**💡 Suggest Features**<br>
• Have an idea that could improve the library?<br>
• Share it in the issues section, I'm always open to new ideas!

**⭐ Support the Project**<br>
Give the repo a star ⭐ to spread the word.<br>
This helps me keep building new features and improving the library.

**💰 Support with a small donation**<br>
Bonsui is built and maintained by a solo developer, with a lot of care and attention to detail. The library is completely free and open source, and I intend to keep it that way.<br>
If you find Bonsui useful, consider supporting its development. Even the smallest contribution means a lot and helps me keep improving the library, building new features, and making it better for everyone. Thank you for being part of this journey 💙
<br><br>
<a class="coffee-link active" href="https://www.buymeacoffee.com/eduardo_codes" target="_blank" rel="noreferrer" data-coffee-button="" aria-label="Buy me a coffee">
<img src="https://img.buymeacoffee.com/button-api/?text=Buy%20me%20a%20coffee&amp;emoji=&amp;slug=eduardo_codes&amp;button_colour=FFDD00&amp;font_colour=000000&amp;font_family=Cookie&amp;outline_colour=000000&amp;coffee_colour=ffffff&amp;t=1791872079" data-src-it="https://img.buymeacoffee.com/button-api/?text=Offrimi%20un%20caff%C3%A8&amp;emoji=&amp;slug=eduardo_codes&amp;button_colour=FFDD00&amp;font_colour=000000&amp;font_family=Cookie&amp;outline_colour=000000&amp;coffee_colour=ffffff&amp;t=1791872079" data-src-en="https://img.buymeacoffee.com/button-api/?text=Buy%20me%20a%20coffee&amp;emoji=&amp;slug=eduardo_codes&amp;button_colour=FFDD00&amp;font_colour=000000&amp;font_family=Cookie&amp;outline_colour=000000&amp;coffee_colour=ffffff&amp;t=1791872079" data-alt-it="Offrimi un caffè" data-alt-en="Buy me a coffee" alt="Buy me a coffee" draggable="false">
</a>
<br><br><br>

<hr>

# Creator

This is an open source project created by an italian solo developer, [Eduardo Mollo](https://www.eduardomollo.com/).
