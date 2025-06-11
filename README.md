# MAZANOKE nix

A nix flake/package for [MAZANOKE](https://github.com/civilblur/mazanoke).

MAZANOKE is a simple single-page app, all the derivation does is copy the files to `$out`.

Likely best served by a simple file server. The included module leverages [miniserve](https://github.com/svenstaro/miniserve) as the server, but in practice you can use whatever you want. It's a pretty simple module.

## License

[GPLv3](LICENSE), same as MAZANOKE.
