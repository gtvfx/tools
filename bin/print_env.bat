:: Looks for a dircectory named py at the root of the bat file
:: Executes print_env.py from that directory
@echo off
python %~dp0..\py\print_env.py
