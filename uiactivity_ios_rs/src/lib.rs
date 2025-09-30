#![doc = include_str!("../README.md")]

#[cfg(target_os = "ios")]
mod native;

pub fn share(_text: &str) {
    #[cfg(target_os = "ios")]
    {
        use std::ffi::CString;
        let c_string = CString::new(_text).expect("CString::new failed");
        unsafe {
            let html_ptr = native::share_text(
                c_string.as_ptr() as *const u8,
                _text.len() as u64,
                uiactivity_ios_rs_did_end,
            );
        }
    }
}

#[unsafe(no_mangle)]
pub unsafe extern "C" fn uiactivity_ios_rs_did_end() {
    std::println!("Callback from Swift: share activity ended");
}
