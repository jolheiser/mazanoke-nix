# MAZANOKE nix

A nix flake/package for [MAZANOKE](https://github.com/civilblur/mazanoke).

MAZANOKE is a simple single-page app, all the derivation does is copy the files to `$out`.

Likely best served by a simple file server. The included module leverages [darkhttpd](https://github.com/emikulic/darkhttpd) as the server, but in practice you can use whatever you want. It's a pretty simple module.


## Usage

* Use it in your flake: `mazanoke-nix` exposes an overlay with the package and a module.
* Run it directly: `nix run github:jolheiser/mazanoke-nix` (or on another port `nix run github:jolheiser/mazanoke-nix -- 5555`)


## License

[GPLv3](LICENSE), same as MAZANOKE.
