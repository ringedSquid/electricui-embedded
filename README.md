# Electric UI Embedded Library

Provides a default binary serial protocol, and the higher level handling functionality for use on embedded microcontrollers or other C/C++ compatible platforms. Intended for use with a ElectricUI compatible UI or device.

See the docs or website for more information.

## Getting Started

### Arduino

1. Ensure the Arduino IDE is installed (version >1.6.X tested ok) and the standard Arduino Blink.ino sketch compiles/flashes to the dev board.

2. Clone or download the electricui-embedded repo onto your computer. Put it whereever you like and use symbolic links, or copy the contents into "*/arduino/libraries/electricui*" folder as typically done with Arduino libraries. 

Symbolic folder links are a nice way to separate the library from the Arduino IDE install if you are planning on editing the libraries.

Unix (your Arduino sketchbook location may vary by OS/install):

```
sudo ln -s ~/projects/electricui-embedded/ ~/Arduino/libraries/electricui
```

Windows/Arduino can demonstrate issues with symbolic links across drives (ExFAT doesn't support them).

If you don't plan on developing electricui-embedded, copy or clone it straight into your libraries folder.

3. In the Arduino IDE, one can simply click *File > Examples > electricui > Examples > Basics > hello-blink* to load an example sketch.

4. If using the ElectricUI helloboard, set the board with *Tools > Board > "Arduino Leonardo"*

5. Test building and flashing the firmware to the board!


### Other Microcontrollers 

1. Just clone the repo and use the electricui files. Import into your project as normal `#include "electricui.h"` and ensure the minimum setup functions are called.

2. The library assumes that you will provide a pointer to the serial tx function which accepts a byte, this could be putc() or similar single byte uart_tx_write(uint8) function.

3. For for more detail, follow the docs or example Arduino code which shows the minimum setup and usage examples.


# Running tests

Testing uses the [Ceedling](http://www.throwtheswitch.org/ceedling/) (Ruby/rake) based testing framework.

I don't provide Ceedling's vendor files inside this repo, so first runs need to 're-initalise' the test structure.

1. Use the provided `test/setup_tests.sh` script to begin with. 
	- You might need to add execution permission first. From `/test`, run `chmod +x setup_tests.sh`.

2. Run the `setup_tests.sh` script. If you don't have ceedling installed, it will prompt to install the ruby gem.

3. Once setup, run `ceedling` or `ceedling test:all`.

There are also a series of small scripts for other various analysis checks.

## Coverage Analysis

Run `ceedling gcov:all` to generate the coverage reports.  
Use `ceedling utils:gcov` to generate a pretty HTML report. It will be located in the `/test/build/artifacts/gcov` folder.

## Lint Checks

`lint_checks.sh` provides a minimalist launch process for the [oclint](http://oclint.org/) static analysis tool.  
It will provide a report detailing the occurances of style violations (code smells) with varying severity levels.

## Arduino Example Script validation

The `arduino-example-test.sh` provides automated batch compile validation for the example suite, across a range of devices.  
Assumes a \*nix shell and the Arduino IDE is installed (arduino-builder is used).

## Fuzzing

Fuzzing is performed using [american fuzzy lop (afl-fuzz)](http://lcamtuf.coredump.cx/afl/).

A minimal program accepts bytes from stdin, and a makefile based fuzzing harness provided in `test/fuzz` which provides helpers to build and start fuzzing.

Uses `afl-gcc` and `afl-fuzz`, and looks in the makefile's `AFL_ROOT` location. You will need to download and make afl, then adjust that path.
Some binary formatted test files are included.

From `/test/fuzz`, run `make all` and it will build an instrumented test program, and start fuzzing.

# Overheads and Benchmarks

The library has a reasonably small footprint, around 280 bytes of RAM and around 2.8k of codespace.  
Using the tracked variable functionality uses 3 bytes and 2 pointers per tracked variable (so 8 bytes on your Arduino Uno).

These numbers will vary based on your target architecture, word alignment and compiler settings.

# Licence

`electricui-embedded` is [MIT licensed](LICENSE.md).