#![doc = include_str!("../README.md")]

#[cfg(target_os = "ios")]
mod native;

/// Stores the callback to be called when the share activity ends.
static mut END_CALLBACK: Option<fn(Option<String>)> = None;

/// Opens a share dialog on iOS with the given text.
pub fn share(_text: &str, _callback: fn(Option<String>)) {
    #[cfg(target_os = "ios")]
    {
        unsafe {
            END_CALLBACK = Some(_callback);
        }
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
    #[cfg(not(target_os = "ios"))]
    _callback(None);
}

#[unsafe(no_mangle)]
pub unsafe extern "C" fn uiactivity_ios_rs_did_end(
    activity_type_ptr: *const u8,
    activity_type_len: u64,
) {
    unsafe {
        if let Some(callback) = END_CALLBACK {
            callback(if activity_type_ptr.is_null() {
                None
            } else {
                let slice =
                    std::slice::from_raw_parts(activity_type_ptr, activity_type_len as usize);
                Some(String::from_utf8_lossy(slice).to_string())
            });
        }
    }
}
