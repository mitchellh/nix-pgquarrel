{ lib, fetchFromGitHub, cmake, postgresql, stdenv }:
stdenv.mkDerivation rec {
  pname = "pgquarrel";
  version = "0.7.0";

  src = fetchFromGitHub {
    owner = "eulerto";
    repo = "pgquarrel";
    rev = "pgquarrel_0_7_0";
    sha256 = "sha256-v3JDPA0y1/QYIbCJYpxapO8QuIqKoL6uzlepbWgiPNs=";
    # sha256 = lib.fakeSha256;
  };

  buildInputs = [ cmake postgresql ];

  # This patch sets the correct path to lookup the statically linked libs.
  patchPhase = ''
    sed -i '/set(PostgreSQL_LIBRARY_DIRS "''${pgpath}")/a set(pgpath "${postgresql}/lib")' CMakeLists.txt
  '';

  meta = {
    description = "Tool to compare PostgreSQL database schemas (DDL)";
    homepage = "https://github.com/eulerto/pgquarrel";
    license = lib.licenses.bsd3;
    platforms = [ "x86_64-linux" "aarch64-linux" ];
  };
}
