import UIKit

// Define a typealias for the Rust callback
public typealias RustCallback = @convention(c) () -> Void

@_cdecl("share_text")
public func share_text(strPtr: UnsafePointer<UInt8>, strLen: UInt64, uiactivity_ios_rs_did_end: @escaping RustCallback) {
    // Convert C string to Swift String
    let buf = UnsafeBufferPointer(start: strPtr, count: Int(strLen))
    let data = Data(buffer: buf)
    let swiftText = String(data: data, encoding: .utf8)!

    //DispatchQueue.main.async {
        // Get the current active window's root view controller
        guard let windowScene = UIApplication.shared.connectedScenes .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene, let rootViewController = windowScene.windows .first(where: { $0.isKeyWindow })?.rootViewController else {
            print("TextSharer: No active window or root view controller found");
            // TODO: callback error
            uiactivity_ios_rs_did_end();
            return
        }
        
        // Create and present the UIActivityViewController
        let activityViewController = UIActivityViewController(activityItems: [swiftText], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = { activityType, completed, _, error in
            // Convert activityType to C string, handling nil case
            let activityTypeCStr = activityType?.rawValue.utf8CString.withUnsafeBufferPointer { $0.baseAddress } ?? nil
            print("Activity Type: \(activityType?.rawValue ?? "nil")")
            // TODO: pass the activity type.
            uiactivity_ios_rs_did_end()
        }
        rootViewController.present(activityViewController, animated: true, completion: {
            // TODO: callback when presented
        })
    //}
}
