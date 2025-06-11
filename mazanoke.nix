{
  pkgs ? import <nixpkgs> { },
}:
let
  version = "1.1.5";
in
pkgs.stdenv.mkDerivation {
  inherit version;
  pname = "mazanoke";
  src = pkgs.fetchFromGitHub {
    owner = "civilblur";
    repo = "mazanoke";
    rev = "v${version}";
    hash = "sha256-B/AF4diMNxN94BzpZP/C+K8kNj9q+4SDKWa/qd4LrVU=";
  };
  buildPhase = ''
    runHook preBuild

    mkdir $out
    cp ./index.html ./favicon.ico ./manifest.json ./service-worker.js $out
    cp -r ./assets $out/assets

    runHook postBuild
  '';
}
