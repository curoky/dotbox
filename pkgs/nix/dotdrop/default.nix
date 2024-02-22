{ lib
, buildPythonApplication
, fetchPypi

# build-system
, setuptools

# dependencies
, docopt
, jinja2
, ruamel-yaml
, python_magic
, packaging
, requests
, tomli
, tomli-w
, distro

# tests
, pytestCheckHook
}:

buildPythonApplication rec {
  pname = "dotdrop";
  version = "1.14.0";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-Z3Nhrzeu9XWs1SM946ixs9i3vPHzWHlG0InjRFA6ok0=";
  };

  nativeBuildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    docopt
    jinja2
    ruamel-yaml
    python_magic
    packaging
    requests
    tomli
    tomli-w
    distro
  ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/deadc0de6/dotdrop";
    description = "Save your dotfiles once, deploy them everywhere";
  };
}
