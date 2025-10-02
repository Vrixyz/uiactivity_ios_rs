# uiactivity_ios_rs
<!-- 
[![crates.io](https://img.shields.io/crates/v/uiactivity_ios_rs.svg)](https://crates.io/crates/uiactivity_ios_rs)
[![docs.rs](https://docs.rs/uiactivity_ios_rs/badge.svg)](https://docs.rs/uiactivity_ios_rs)
-->

Rust crate and Swift Package Module to open an [UIActivity](https://developer.apple.com/documentation/uikit/uiactivity) on iOS.

<!-- TODO: Demo -->

## Features

* Opens an [UIActivity](https://developer.apple.com/documentation/uikit/uiactivity) to share some text

## Instructions

1. Add to XCode: Add SPM (Swift Package Manager) dependency
2. Add Rust dependency

### 1. Add to XCode

* Go to `File` -> `Add Package Dependencies` and paste `https://github.com/ThierryBerger/uiactivity_ios_rs.git` into the search bar on the top right.

### 2. Add Rust dependency

```sh
cargo add uiactivity_ios_rs
```

or

```toml
# always pin to the same exact version you also of the Swift package
uiactivity_ios_rs = { version = "=0.1.0" }
```

## Troubleshooting

* File an issue!

## Dev notes

### Resources

- <https://developer.apple.com/documentation/uikit/uiactivity>
- <https://shadowfacts.net/2023/rust-swift/>

## License

All code in this repository is dual-licensed under either:

* MIT License (LICENSE-MIT or <http://opensource.org/licenses/MIT>)
* Apache License, Version 2.0 (LICENSE-APACHE or <http://www.apache.org/licenses/LICENSE-2.0>)

at your option. This means you can select the license you prefer.

## Your contributions

Unless you explicitly state otherwise, any contribution intentionally submitted for inclusion in the work by you, as defined in the Apache-2.0 license, shall be dual licensed as above, without any additional terms or conditions.
