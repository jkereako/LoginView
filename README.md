# LoginView
This is a simple example of how to build a login view in Swift. It comes
complete with credential storage in the keychain and animations to indicate a
bad login. You can use this as a starting point for your authenticated app.

<img
src="https://raw.githubusercontent.com/jkereako/LoginView/master/Images/screen-shot.png"
width="320" height="568" />

The view is a static table view. Table views will automatically scroll when the
keyboard appears to avoid hiding a text field under the keyboard. It's surprisingly
difficult to handle this on your own. It's a lot easier to let UIKit do the work.
In short, always use a table view when displaying text fields. This is more true
than ever before considering the varying sizes of iPhones.

# Credit
This project uses designs from Jake Lin's [IBAnimatable][iba],
credential storage from Hyper's [Keychain][keychain] and animations from XMartLabs'
[XLSwiftKit][shake].

[iba]: https://github.com/JakeLin/IBAnimatable
[keychain]: https://github.com/hyperoslo/Keychain
[shake]: https://github.com/xmartlabs/XLSwiftKit

