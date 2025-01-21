#!/bin/bash
: << 'COMMENT'
Build clangd;clang from source
|------------------------------|------------------------------|
|         🎃 item              |        👇 explanation        |
|------------------------------|------------------------------|
|    needs root permission?    |              Yes             |
|------------------------------|------------------------------|
|          dependencies        |              No              |
|------------------------------|------------------------------|
|          args                |     version  install_dir     |
|------------------------------|------------------------------|
COMMENT
set -euo pipefail

num_args=$#
[[ $num_args -lt 2 ]] && echo "Wrong arguments. Please provide: version install_dir as arguments" && exit 1

temp_dir=$(mktemp -d)
trap "rm -rf ${temp_dir}" EXIT

clangd_version=llvmorg-$1
clangd_link="https://github.com/llvm/llvm-project.git"
clangd_dir="/usr/local"

install_prefix="$2"

pushd ${temp_dir} &> /dev/null
sudo apt install ninja-build

# DEBUG
mkdir -p "${install_prefix}"
mkdir -p "${install_prefix}/bin"
mkdir -p "${install_prefix}/lib/clang"
touch "${install_prefix}/bin/clangd"
touch "${install_prefix}/bin/clang-19"
touch "${install_prefix}/bin/clang"
touch "${install_prefix}/lib/clang/t"


# git clone --depth=1 --branch ${clangd_version} https://github.com/llvm/llvm-project.git
# cd llvm-project
# mkdir build && cd build
# cmake ../llvm/ -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra" -GNinja  -DCMAKE_INSTALL_PREFIX="${install_prefix}"
# ninja -j`nproc` install

popd &> /dev/null
# "${install_prefix}"/bin/clangd --version


