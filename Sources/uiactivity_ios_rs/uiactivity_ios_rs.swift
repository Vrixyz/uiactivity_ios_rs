import UIKit

// Define a typealias for the Rust callback
public typealias RustCallback = @convention(c) (UnsafePointer<UInt8>?, UInt64) -> Void

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
            uiactivity_ios_rs_did_end(nil, 0);
            return
        }
        
        // Create and present the UIActivityViewController
        let activityViewController = UIActivityViewController(activityItems: [swiftText], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = { activityType, completed, _, error in
            // Convert activityType to C string, handling nil case
            if let activityType = activityType?.rawValue, let data = activityType.data(using: .utf8) {
                data.withUnsafeBytes { buffer in
                    let ptr = buffer.baseAddress?.assumingMemoryBound(to: UInt8.self)
                    let len = UInt64(buffer.count)
                    uiactivity_ios_rs_did_end(ptr, len)
                }
            } else {
                uiactivity_ios_rs_did_end(nil, 0)
            }
        }
        rootViewController.present(activityViewController, animated: true, completion: {
            // TODO: callback when presented
        })
    //}
}
