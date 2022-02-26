This file describes the simplified scripts and changes to be done during the compilation process.

### Changes to be done
The execInfo file of each benchmark needs to be modified as "bash sourceable". The examples of 2mm and 3mm are given in this directory. Modify the execInfo files of other benchmarks accordingly. (Only preserving the PROFILEARGS and TESTARGS variable should be fine for polybench)

### Compilation process
1. cd to the src directory of each benchmark
2. source the corresponding execInfo using "source execInfo"
3. link all the source code file to a single bc file using "fcc-link <src_file> -o <destination_bc>. Users can specify all source files (.c/.cc/.cpp) and the destination bc file. For example, executing "fcc-link 2mm.c -o benchmark.plain.bc". If unspecified, the script will search for all source files in the current directory and output the bc file with the default name of "benchmark.plain.bc". That is to say, users can simply run "fcc-link" alone without passing any argument.
4. optimize the linked bc file using "fcc-opt -p <linked_bc_file>". If the linked bc file is unspecified, the script will automatically look for the benchmark.plain.bc in the current directory for input. After executing, this script will generate binaries named benchmark.collaborative.exe. This is the parallelized binary.

### Run the binary
Executing "time NUM_WORKERS=<thread_number> ./benchmark.collaborative.exe ${TESTARGS}". Users need to set the number of threads they wish to run. 
