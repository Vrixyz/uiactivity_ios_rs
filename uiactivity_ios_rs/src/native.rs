use std::ffi;

unsafe extern "C" {
    pub(crate) fn share_text(code_ptr: *const u8, code_len: u64, callback: unsafe extern "C" fn());
}
