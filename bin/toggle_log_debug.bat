@echo off

if [%LOG_DEBUG%] == [1] (
    setx LOG_DEBUG 0
    set LOG_DEBUG=0
) else (
    setx LOG_DEBUG 1
    set LOG_DEBUG=1
)
echo "LOG_DEBUG=%LOG_DEBUG%"
