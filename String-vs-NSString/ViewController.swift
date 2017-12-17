import Cocoa

class WindowController: NSWindowController {
    var viewController: ViewController { return contentViewController as! ViewController }
    
    @IBAction func searchFieldChanged(_ sender: Any) {
        guard let searchField = sender as? NSSearchField else { fatalError() }
        viewController.search(searchField.stringValue)
    }
}

class ViewController: NSViewController {
    var text = "_Hello_ 👩🏼‍🚒 *World* 🇫🇷👨‍👩‍👧"

    @IBOutlet var textView: NSTextView!
    
    @IBOutlet weak var selection: NSTextField!
    @IBOutlet weak var characterCount: NSTextField!
    @IBOutlet weak var nsStringCount: NSTextField!
    @IBOutlet weak var utf16Count: NSTextField!
    @IBOutlet weak var unicodeScalarCount: NSTextField!
    @IBOutlet weak var byteCount: NSTextField!
    
    private let baseFont = NSFont.systemFont(ofSize: 18)
    private var searchTerm: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTextView()
    }
    
    func search(_ searchTerm: String) {
        guard let range = text.range(of: searchTerm) else { return }
        let nsRange = NSRange(range, in: text)
        textView.showFindIndicator(for: nsRange)
    }
    
    func updateTextView() {
        let attributedString = NSMutableAttributedString(string: text, attributes: [.font: baseFont])
        textView.textStorage?.setAttributedString(attributedString)
    }
    
    func updateInfo() {
        let nsRange = textView.selectedRange()
        let range = Range(nsRange, in: textView.string)!
        let value = String(textView.string[range])
        selection.stringValue = value
        characterCount.stringValue = String(value.count)
        nsStringCount.stringValue = String((value as NSString).length)
        utf16Count.stringValue = String(value.utf16.count)
        unicodeScalarCount.stringValue = String(value.unicodeScalars.count)
        byteCount.stringValue = String(value.data(using: .utf8)!.count)
    }
}


extension ViewController: NSTextViewDelegate {
    func textViewDidChangeSelection(_ notification: Notification) {
        updateInfo()
    }
}
