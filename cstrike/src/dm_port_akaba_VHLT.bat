@echo off
set mapname=dm_port_akaba.map

hlcsg_VHLT.exe -nowadtextures -wadautodetect -cliptype precise "%mapname%"
hlbsp_VHLT.exe -subdivide 240 "%mapname%" 
hlvis_VHLT.exe -low -full "%mapname%"
hlrad_VHLT.exe -low -chart -extra -ambient 0.125 0.100 0.085 -gamma 0.85 -bounce 8 -blur 4 "%mapname%"

del *.p0
del *.p1
del *.p2
del *.p3
del *.b0
del *.b1
del *.b2
del *.b3
del *.hsz
del *.pln
del *.vdt
del *.wic
del *.wa_
del *.ext

//ZHLT v3.4 VL34 (Aug 17 2015)