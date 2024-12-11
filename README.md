# CurrencyTextField
 
A `CurrencyField` is a TextField designed for currency input in SwiftUI.

## Example

```swift
struct ContentView: View {
    @State private var value: Decimal = 0
    @State private var isFocused = false

    var body: some View {
        VStack {
            CurrencyField(value: $value, configuration: CurrencyField.Configuration(
                placeholder: NSAttributedString(string: "R$ 0,00", attributes: [
                    .font: UIFont.systemFont(ofSize: 30),
                    .foregroundColor: UIColor.systemGray3,
                    .paragraphStyle: NSParagraphStyle.defaultCenter,
                ]),
                locale: Locale(identifier: "pt_BR"),
                currencyCode: "BRL",
                decimalPlaces: 2,
                displayCaret: true,
                allowClearFieldWhenValueIsZero: false,
                adjustsFontSizeToFitWidth: true,
                minimumFontSize: 0.1,
                readOnly: false,
                onFocusChanged: { focus in
                    isFocused = focus
                })
            )
            .border(isFocused ? Color.primary : Color.gray.opacity(0.4))
        }
    }
}
```
