import SwiftUI

@MainActor
protocol _CurrencyTextFieldDelegate: AnyObject {
    func currencyTextFieldDidBeginEditing(_ currencyTextField: _CurrencyTextField)
    func currencyTextFieldDidEndEditing(_ currencyTextField: _CurrencyTextField)
}

final class _CurrencyTextField: UITextField {
    override var selectedTextRange: UITextRange? {
        didSet {
            if let selectedTextRange, readOnly {
                tintColor = selectedTextRange.isEmpty ? .clear : caretColor
            }
        }
    }

    private lazy var doneButtonToolbar: UIToolbar = {
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

        return toolbar
    }()

    var displayCaret = true
    var readOnly = false
    var caretColor: UIColor = .clear

    weak var currencyDelegate: _CurrencyTextFieldDelegate?

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        keyboardType = .numberPad

        setContentHuggingPriority(.required, for: .vertical)
        setContentHuggingPriority(.defaultLow, for: .horizontal)
        setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        addTarget(self, action: #selector(didBeginEditing), for: .editingDidBegin)
        addTarget(self, action: #selector(didEndEditing), for: .editingDidEnd)
        caretColor = tintColor
    }

    override func closestPosition(to point: CGPoint) -> UITextPosition? {
        if (text ?? "").isEmpty {
            return super.closestPosition(to: point)
        }

        return endOfDocument
    }

    override func caretRect(for position: UITextPosition) -> CGRect {
        if readOnly {
            return super.caretRect(for: position)
        }
        return displayCaret ? super.caretRect(for: position) : .null
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if readOnly {
            if action == #selector(UIResponderStandardEditActions.select(_:)) ||
                action == #selector(UIResponderStandardEditActions.selectAll(_:)) ||
                action == #selector(UIResponderStandardEditActions.copy(_:)) {
                return true
            }
            return false
        }

        return super.canPerformAction(action, withSender: sender)
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
        readOnly = configuration.readOnly
        setupInputViewIfNeeded()

        if configuration.displayDoneButtonAsAccessory {
            setupInputAssessoryView(displayDoneButtonAsAccessory: true)
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
            self.caretColor = caretColor
            tintColor = caretColor
        }

        if readOnly {
            tintColor = .clear
        }
    }

    private func setupInputAssessoryView(displayDoneButtonAsAccessory: Bool) {
        if readOnly {
            removeInputAssessoryView()
        } else {
            if inputAccessoryView == nil, displayDoneButtonAsAccessory {
                inputAccessoryView = doneButtonToolbar
            }
        }
    }

    private func setupInputViewIfNeeded() {
        if readOnly {
            if inputView == nil {
                inputView = UIView()
            }
        } else {
            if inputView != nil {
                inputView = nil
            }
        }
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
