# Put binaries installed using "cargo install" in path
export PATH="$PATH:$HOME/.cargo/bin"
# Locate rust source for rls
export RUST_SRC_PATH="$HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"
# Add libs in link path for all channels
for channel in stable beta nightly; do
  export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/.rustup/toolchains/$channel-x86_64-unknown-linux-gnu/lib"
done
