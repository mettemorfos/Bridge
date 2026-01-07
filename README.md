# Mobile Developer Challenge: Native-WebView Communication

Webviews (The WebView/WebPage combination in a SwiftUI context) are a potential risk because they are basically little browsers running within the app. If someone manages to load something malicious into them, everything accessible within the app sandbox (such as files, tokens or sensitive user data) could be accessed by the attacker.

The following things can be done to mitigate these risks:

 - Don’t make any alterations to the app’s ATS (App Transport Security) configuration. If no exceptions are added, all connections made by the app will require HTTPS.
 - Carefully evaluate all user input before passing it along to the WebView to prevent injection of harmful scripts that way. In addition to testing the validation code itself, it can be a good idea to add automated UI tests to verify that malicious input is caught in the view layer. No validation checks will help if they have been turned off to speed up a debugging session and you forget to put them back in again.
 - Make use of the NavigationDeciding protocol and the policy deciding functions within to control the navigations done within the WebView. This can prevent some attacks by only allowing certain whitelisted urls to be loaded. Example code: 

```
        let trusted = "trustedHost"
        func decidePolicy(for action: WebPage.NavigationAction, preferences: inout WebPage.NavigationPreferences) async -> WKNavigationActionPolicy {
            let url = action.request.url
                    if url?.host() == trusted {
                        return .allow
                    }
            return .cancel
        }
```

 - When javascript calls the native code through the postMessage function, that is another vulnerability that could expose the app to risks. It can be mitigated by keeping the bridge back to the native code as narrow as possible. If the message posted needs to adhere to a very specific format and is only given access to a small subset of functionality it will be harder to exploit. As an extra measure, you can check the hasOnlySecureContent property of the WebPage before dealing with the message, to verify that all content of the page has been loaded through secure connections.
 - Limit what an attacker could get their hands on by only requesting what permissions and user data is absolutely necessary for the app to function, and store sensitive items such as user credentials and tokens in KeyChain or other secured storage.
 - Always try to use the latest version of everything, and stay away from old, deprecated classes like UIWebView. The lower you can keep technical debt, the faster and easier a sudden and urgent security update can be implemented and deployed.
