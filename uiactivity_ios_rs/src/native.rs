use std::ffi;

unsafe extern "C" {
    pub(crate) fn share_text(
        message_ptr: *const u8,
        message_len: u64,
        callback: unsafe extern "C" fn(activity_type_ptr: *const u8, activity_type_len: u64),
    );
}
