echo "reading ~/.bash_profile"

# DIRS
export POOL=~/pool
export TESTPOOL=~/test_pool
export SRC=~/src
export SCRIPTS=~/projects/scripts
export SCRATCH=/aia/r020.2/scratch/gonzalo

# DEFAULT COMPILERS: gcc
export CC=clang
export CXX=clang++
# export CC=$POOL/bin/gcc-4.8
# export CXX=$POOL/bin/g++-4.8
export FC=gfortran

# DEFAULT COMPILER FLAGS: 64bit
export MACOSX_DEPLOYMENT_TARGET=10.8
export SDKROOT='/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk/'
export CMAKE_OSX_SYSROOT=$SDKROOT
export ARCHFLAGS='-arch x86_64'
# export CXXFLAGS='-arch x86_64'
# export CFLAGS='-arch x86_64'
# export LDFLAGS='-arch x86_64'
# export FCFLAGS='-arch x86_64'

# PATH AND LD_LIB_PATH
export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/texbin:/usr/local/share/python
export LIBCXX=~/src/libcxx/libcxx

# mpich: for open mpi include /usr/local/include/open-mpi
export CPLUS_INCLUDE_PATH=/usr/local/include:/Users/gnzlbg/pool/mpllibs:/Users/gnzlbg/src/glm/glm-0.9.4.2
export C_INCLUDE_PATH=$CPLUS_INCLUDE_PATH

# ENV VARS
export ZFS_HOSTCONFIG_FILE=~/projects/PhD/ZFS/HostConfigs/clang
export ZFS_TESTCASES_HOSTCONFIG_FILE=~/projects/PhD/ZFS/HostConfigs/tclang

# PROGRAMS
export EDITOR='/Applications/Emacs.app/Contents/MacOS/Emacs -nw'

# ALIASES
#alias aq='/Applications/Aquamacs.app/Contents/MacOS/Aquamacs -nw'
alias ll='ls -Glah'
alias aia059='ssh gonzalo@aia059 -X'
alias fe1='ssh gonzalo@fe1 -X'
alias clang++-3.2='/usr/local/bin/clang++'
alias clang11='clang++ -Wall -Werror -std=c++11 -stdlib=libc++ -I/$LIBCXX/include -L$LIBCXX/lib ' 
function ng() {
ncgen -o "$@" "$@".cdl
}

# MPIRUN ALIES (required by mpich)
alias mpirun='mpirun -host localhost'

# RBENV
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# SHELL COLORS
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
PS1='[\[\e[1;33m\]\u\[\e[1;36m\]@\[\e[1;32m\]\h\[\e[1;37m\]:\W/]$ '
