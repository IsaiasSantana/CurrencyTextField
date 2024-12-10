import SwiftUI

@MainActor
protocol _CurrencyTextFieldDelegate: AnyObject {
    func currencyTextFieldDidBeginEditing(_ currencyTextField: _CurrencyTextField)
    func currencyTextFieldDidEndEditing(_ currencyTextField: _CurrencyTextField)
}

final class _CurrencyTextField: UITextField {
    init() {
        super.init(frame: .zero)
        setup()
    }

    var displayCaret = true
    weak var currencyDelegate: _CurrencyTextFieldDelegate?

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func closestPosition(to point: CGPoint) -> UITextPosition? {
        if (text ?? "").isEmpty {
            return super.closestPosition(to: point)
        }

        return endOfDocument
    }

    override func caretRect(for position: UITextPosition) -> CGRect {
        return displayCaret ? super.caretRect(for: position) : .null
    }

    private func setup() {
        keyboardType = .numberPad

        setContentHuggingPriority(.required, for: .vertical)
        setContentHuggingPriority(.defaultLow, for: .horizontal)
        setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        addTarget(self, action: #selector(didBeginEditing), for: .editingDidBegin)
        addTarget(self, action: #selector(didEndEditing), for: .editingDidEnd)
    }

    @objc
    private func didBeginEditing() {
        currencyDelegate?.currencyTextFieldDidBeginEditing(self)
    }

    @objc
    private func didEndEditing() {
        currencyDelegate?.currencyTextFieldDidEndEditing(self)
    }

    func updateView(with configuration: CurrencyField.Configuration) {
        if configuration.displayDoneButtonAsAccessory {
            setupInputAssessoryView()
        } else {
            removeInputAssessoryView()
        }

        if displayCaret != configuration.displayCaret {
            displayCaret = configuration.displayCaret
        }

        if textAlignment != configuration.textAligment {
            textAlignment = configuration.textAligment
        }

        if adjustsFontSizeToFitWidth != configuration.adjustsFontSizeToFitWidth {
            adjustsFontSizeToFitWidth = configuration.adjustsFontSizeToFitWidth
        }

        if minimumFontSize != configuration.minimumFontSize {
            minimumFontSize = configuration.minimumFontSize
        }

        if let caretColor = configuration.caretColor, tintColor != caretColor {
            tintColor = caretColor
        }
    }

    private func setupInputAssessoryView() {
        guard inputAccessoryView == nil else {
            return
        }
        let toolbar = UIToolbar()
        let doneButton: UIBarButtonItem

        if #available(iOS 15.0, *) {
            doneButton = UIBarButtonItem(systemItem: .done, primaryAction: .init(handler: { [weak self] _  in
                self?.resignFirstResponder()
            }))

            toolbar.items = [.flexibleSpace(), doneButton]
        } else {
            let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(closeKeyboard))
            toolbar.items = [space, doneButton]
        }
        
        toolbar.sizeToFit()
        inputAccessoryView = toolbar
    }

    @objc
    private func closeKeyboard() {
        resignFirstResponder()
    }

    private func removeInputAssessoryView() {
        guard inputAccessoryView != nil else {
            return
        }
        inputAccessoryView = nil
    }
}
