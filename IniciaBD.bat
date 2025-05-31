@echo off
REM para ejecutar con doble click 
cls
REM levanta el servicio Oracle (NO importa si ya está arriba) SI ES DOCKER deben levantarlo aparte! o buscar el servicio
echo ============================================
echo Levantando Oracle espere un momento....
net start OracleServiceXE 1>nul
echo ============================================
REM corre el Script (pausa, para revisar y luego sale)
sqlplus system/root @IniciaBD.sql

exit