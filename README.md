# Tool-configs-scripts

Scripts and Configurations for tools I use.

## valgrind-program-tester

[TODO add screenshots]

For zsh (shell).

Is meant to make testing for memory leaks with Valgrind easier by:
- running a program as many times as there are argument sets
- highlighting when there are leaks or no leaks, while not printing any extra info
- generating a report of how many leaking tests there were
- writing the logs to a file for each test for later revision


Inside the script there things that should be edited for your needs:
- an executable variable name to set as the program name
- arguments to set that the script should run the program with

## vim

![image](https://github.com/user-attachments/assets/74b38fea-b98f-4a22-be04-da31b8702291)

Make vim more enjoyable to use (for me) by donfiguring various settings.

## extranorm (work in progress)

![image](https://github.com/user-attachments/assets/6da761f1-cffb-40a0-9785-fdee6f49dfeb)

For zsh (shell).

A simple script that greps for various strings that often are left in files, but should probably/often also be deleted before code evaluation.
