# Heathkit ET-18 Hero-1 Programs

This repository contains Motorola 6800 assembly language programs for the Heathkit Hero-1 Robot.

## Getting Started

### Dependencies

* [Motorola 6800 Assembler](https://github.com/JimInCA/motorola-6800-assembler)
* Linux or MacOS with GNU make
* Optional [Serial/USB connection](https://www.robotworkshop.com/robotweb/?page_id=401https:/) from Robot Workshop.

### Installing

* Download and install the Motorola 6800 Assembler from the above link.
* Git clone this repository.
* Check the Makefile to see if you need to modify the Motorola 6800 assembler path.
* Modify the serial device in upload.py if you are using a Serial/USB connection for upload.

### Executing programs

* Run `make <program_name>.s19`.
* Put the robot into download mode by entering `3` `A` on the robot keypad.
* Run `upload.py --file=<program_name>.s19`.
* After programs are uploaded, you may need to enter `A` `D` on the robot keypad followed by the program start address, which is found in the `orig` line of the assembly language program listing.

Version History

* Jan 13, 2025: Initial release

  * Programs translated from machine language to assembly language from the Heathkit Hero-1 User's Guide.

## License

This project is licensed under the MIT License.
