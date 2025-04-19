This is a quick hack to get emacs working on Sequoia 15.4.

This code contains the emacs patches + nix hacks to make this happen.

This depends on something like this in `~/.emacs.d/early-init.el` to
fill in some necessary paths for linking (the nix store path will be
different for you):

```lisp
(setq-default native-comp-driver-options
              '("-Wl,-w"
                "-Wl,-L/nix/store/zl3aslw7dhrk6wb5nv960hnc2v27l3j5-libgccjit-14-20241116/lib/gcc/aarch64-apple-darwin/14.2.1"
                "-Wl,-L/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/lib"))
```

After this `nix build` and `./result/bin/emacs` should produce a
working emacs.
