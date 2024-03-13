{ lib
, python3
, fetchFromGitHub
}:

python3.pkgs.buildPythonApplication rec {
  pname = "dotdrop";
  version = "1.14.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "deadc0de6";
    repo = "dotdrop";
    rev = "v${version}";
    hash = "sha256-l7FBiyrQJJieeYNdpE1MGWs3X8wXbTKfEo7meAxqNWc=";
  };

  nativeBuildInputs = [
    python3.pkgs.setuptools
    python3.pkgs.wheel
  ];

  propagatedBuildInputs = with python3.pkgs; [
    distro
    docopt
    jinja2
    packaging
    python-magic
    requests
    ruamel-yaml
    tomli
    tomli-w
  ];

  pythonImportsCheck = [ "dotdrop" ];

  meta = with lib; {
    description = "Save your dotfiles once, deploy them everywhere";
    homepage = "https://github.com/deadc0de6/dotdrop";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ ];
    mainProgram = "dotdrop";
  };
}
