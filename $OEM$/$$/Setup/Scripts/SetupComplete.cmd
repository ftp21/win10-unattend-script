@echo off
net accounts /maxpwage:unlimited
powercfg /hibernate off
del /q /f "%0"
