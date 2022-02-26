### FCC testing suite

This test suite contains the FCC itself and all other libraries it requires to compile a benchmark

### Installation
Place the folder to any directory and simply run the 'source shrc' command should setup all environment required.
This test suite requires gcc and g++ being installed in the host machine.

### Testing
Go to the tests/scripts directory, and run:
'python3 GetResults.py -p <benchmark directory> -b <bmark_list_reg.json> -r 0 -s All'

This will start the compilation process and the script will generate two binaries:
1. benchmark.plain.o3.exe: This is the binary compiled using the baseline compiler, in this case, llvm
2. benchmark.collaborative.exe: This is the optimized binary compiled using fcc.

Then run:
'python3 GetResults.py -p <benchmark directory> -b <bmark_list_reg.json> -r 2 -s All'

This will run two binaries for 3 times and compare the final output results to make sure that both binaries generates the same output. Any disagreement in output will be printed in red and this should be investigated further.
This command also print the real speedup of when running the optimized binary using 10 cores. (The number of cores could be configured by changing the default_num_workers at line 238 in GetResults.py)

Using '-r 4' in the previous command will test how speedup scales with increasing number of cores. Change the list range at line 242 in GetResults.py and run the command. It will print the speedup when using different number of cores compared to sequential execution. 

### Adding new benchmarks
Simply add new benchmarks in the tests/benchmark directory and create an execInfo file to specify the commandline arguments.
Make sure to add the benchmark description in the bmark_list_reg.json file so that the script can recognize the new benchmarks. 
