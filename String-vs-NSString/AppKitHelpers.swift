import AppKit

extension NSTextView {
    // Remove the text view's delegate while sending it a message.
    // Used to prevent infinite loops when changing the selection programmatically
    func withDisabledDelegate(_ block: (NSTextView) -> ()) {
        let d = delegate
        delegate = nil
        block(self)
        delegate = d
    }
}

