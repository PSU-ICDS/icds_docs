[ load "motor.am" ] setLabel "motor.am"
create boxfilter "Box Filter"
"Box Filter" inputImage connect "motor.am"
"Box Filter" kernelSizeX setValue 0 13
"Box Filter" kernelSizeY setValue 0 9
"Box Filter" fire
[ {Box Filter} create ImgOut ] setLabel "motor.filtered"
"motor.filtered" save "Avizo binary" "motor.filtered.am"
