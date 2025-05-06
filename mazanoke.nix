{
  pkgs ? import <nixpkgs> { },
}:
let
  version = "1.1.4";
in
pkgs.stdenv.mkDerivation {
  inherit version;
  pname = "mazanoke";
  src = pkgs.fetchFromGitHub {
    owner = "civilblur";
    repo = "mazanoke";
    rev = "v${version}";
    hash = "sha256-8VFYjrXC6rmTDE28p1F4DSIZVhRlSXXXf/qlgAkpQGY=";
  };
  buildPhase = ''
    runHook preBuild

    mkdir $out
    cp ./index.html ./favicon.ico ./manifest.json ./service-worker.js $out
    cp -r ./assets $out/assets

    runHook postBuild
  '';
}
