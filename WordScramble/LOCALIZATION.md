# Локализация приложения WordScramble

## Структура файлов локализации

### Файлы строк
- `en.lproj/Localizable.strings` - английские строки
- `ru.lproj/Localizable.strings` - русские строки

### Файлы Info.plist
- `en.lproj/InfoPlist.strings` - английские названия приложения
- `ru.lproj/InfoPlist.strings` - русские названия приложения

### Файлы слов
- `start.txt` - английские слова для игры
- `start_ru.txt` - русские слова для игры

## Как добавить новый язык

1. Создайте папку `[код_языка].lproj` (например, `fr.lproj` для французского)
2. Скопируйте файлы `Localizable.strings` и `InfoPlist.strings`
3. Переведите все строки на новый язык
4. Создайте файл `start_[код_языка].txt` со словами для игры
5. Добавьте поддержку нового языка в `ContentView.swift`

## Коды языков
- `en` - английский
- `ru` - русский
- `fr` - французский
- `de` - немецкий
- `es` - испанский
- `it` - итальянский

## Использование в коде

```swift
// Простая строка
NSLocalizedString("key", comment: "Comment")

// Строка с параметрами
String(format: NSLocalizedString("key_with_param", comment: "Comment"), parameter)

// Получение текущего языка
Locale.current.language.languageCode?.identifier
```

## Проверка локализации в Xcode

1. Откройте проект в Xcode
2. Выберите Product → Scheme → Edit Scheme
3. В разделе Run → Options → Application Language выберите нужный язык
4. Запустите приложение для проверки локализации 