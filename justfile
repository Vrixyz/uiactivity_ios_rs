[working-directory: 'uiactivity_ios_rs']
check:
	cargo c --target=aarch64-apple-ios
	cargo b
	cargo t
	cargo clippy
	cargo doc --workspace --all-features --document-private-items --no-deps

[working-directory: 'uiactivity_ios_rs']
publish:
	cargo publish
