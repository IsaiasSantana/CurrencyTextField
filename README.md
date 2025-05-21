# CurrencyTextField
 
A `CurrencyField` is a TextField designed for currency input in SwiftUI.

## Example

```swift
struct ContentView: View {
    @State private var value: Decimal = 0

    var body: some View {
        CurrencyField(
            value: $value
        )
        .placeholder(
            NSAttributedString(
                string: "R$ 0,00",
                attributes: [
                    .font: UIFont.systemFont(ofSize: 30),
                    .foregroundColor: UIColor.systemGray3,
                    .paragraphStyle: NSParagraphStyle.default
                ]
            )
        )
        .textColor(.systemGray)
        .textAlignment(.center)
        .font(
            .systemFont(ofSize: 30)
        )
        .locale(
            Locale(identifier: "pt_BR")
        )
        .currencyCode("BRL")
        .maximumValue(10_000)
        .decimalPlaces(2)
        .displayCaret(true)
        .caretColor(.green)
        .displayDoneButtonAsAccessory(true)
        .allowClearFieldWhenValueIsZero(true)
        .adjustsFontSizeToFitWidth(true)
        .minimumFontSize(1.0)
        .readOnly(false)
        .onFocusChanged { isFocused in
            print("Is focused \(isFocused)")
        }
    }
}
```
