BASE_DIR:=$(shell pwd)
INSTALL_DIR_DEBUG:=${BASE_DIR}/llvm-install-debug
JOBS?=32

CONFIG_LLVM_DEBUG = -G "Unix Makefiles" 														\
					-DCMAKE_BUILD_TYPE="Debug" 													\
					-DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;compiler-rt;openmp;polly" 	\
					-DLLVM_TARGETS_TO_BUILD="X86" 												\
					-DLLVM_ENABLE_ASSERTIONS=ON 												\
					-DLLVM_ABI_BREAKING_CHECKS=FORCE_OFF 										\
					-DCMAKE_INSTALL_PREFIX=${INSTALL_DIR_DEBUG} 								\
					-DCMAKE_CXX_STANDARD="17"


all: llvm-objects-debug
.PHONY: llvm-objects-debug clean

clean:
	rm -rf llvm-install-debug
	rm -rf llvm-objects-debug

llvm-objects-debug: 
	#git clone -b release/9.x https://github.com/llvm/llvm-project.git
	cd llvm-project 													&& \
	git apply ${BASE_DIR}/fcc-install/bootstrap/llvm.patch
	mkdir -p llvm-install-debug
	mkdir -p llvm-objects-debug
	cd llvm-objects-debug												&& \
	cmake ${CONFIG_LLVM_DEBUG} ${BASE_DIR}/llvm-project/llvm/			&& \
	make -j${JOBS}														&& \
	make install
