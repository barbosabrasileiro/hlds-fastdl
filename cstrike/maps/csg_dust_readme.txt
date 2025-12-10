					CSG_Dust Readme File

		Before playing the map, you might want to check out this file first. It contains some information that can help you improve your gaming experience.

		Please note that this map is NOT an exact port of de_dust from CSGO. Some structures are somewhat different from the original to fit with the 1.6 environment. Also, not all the objects were added to preserve game performance. Lights are the only entity that is exactly ported in this map. Textures were resized to lower values to prevent high wpoly and improve FPS.


		CSG_DUST Update Changes:
		
		- Ground textures changed
		- Texture corrections
		- FPS Improvement
		- High-polygon cars were replaced by a Low-poly lada model
		- Added global shake effect when the bomb explodes
		- Fixed some weird visible brushes appearing from some areas
		- New decalled textures
		- Simplified almost all the things for optimal performance
		- Added animated smoke sprites :)
		- Fixed helicopter bugs
		- Fixed common map glitches
		- Transparent Overview Image to eliminate scene blocking
		- Raised slope on T Spawn's Market Area to avoid falldown damage
		- Added Uninstaller batch file to automate uninstall


		Here are some tips for better gaming experience on this map:

		- If you've seen some textures look blurry, try raising the gl_max_size value to 512 or 768 (as i've seen some models that uses texture larger than 512 pixels) To make this work, bring down the console window then type 'gl_max_size 512' then restart. If it doesn't work, go to your cstrike directory and edit your autoexec.cfg file. If you don't have one, then create it and add gl_max_size 512 in the text field. Play again then you'll see the difference ;)
	
		- Try lowering the gamma value for better lighting. I suggest you alter this value to 1.8 then 	restart the game. Default value is 3

		- To improve fps rate, try altering the cl_corpsestay value to 0. Default is 600
		- DON'T Drop your items/weapons on some stairs area. Why? because you may never be able to retrieve your items there. It's because some stairs doesn't have an item collision. It's intended for clipnode budgetting.

If you want a custom footsteps/shotsounds FX on this map, add this text into your materials.txt located at 'cstrike\sound\materials.txt':

//CSG_DUST
D bmbstA
D bmbstB
T csgodust115
T csgodust117
D csgodust150
D dustconcgrnd
D dustgrndsand
D dusttilegrnd
W aidcrtbk
W aidcrtft
W aidcrttp
W crt128x128
W crt64x64
W crt64x64h
W crt96x96
W csgodust105
M csgodust106
M csgodust107
W csgodust108
W csgodust111
W csgodust114
M csgodust119
W csgodust12
W csgodust142
D csgodust150
Y csgodust125
Y csgodust126
Y csgodust17
W csgodust2
Y csgodust55
W csgodust7
W csgodust71
W csgodust72
W csgodust76
W csgodust87
M csgodust90
W csgodust91
M csgodust92
W door02
M door03
W door04
M door05
M door06
W door07
W duCrtLrgSd
W duCrtLrgTp
W ducrtwd
W ducrtwd2
W dulargedoor
M duMltryCrSd2
M duMltryCrTp
W dustcrt32ft
W dustcrt32sd
W dustcrt32tp
W dustcrt64ft
W dustcrt64sd
W dustcrt64tp
W foodcrates
W foodcratest
M gate01
M genlight
M genlightsd
M hmmwvft
M hmmwvgls
M hmmwvside
M hmmwvtp
W palletside
W pallettop
W picrate
W picrate2
W scaffoldlog_tex
Y subway_lights
M tin_roof
M trrm_pan6
Y wdw02
Y wdw03
Y wdw04
W wood2

		And that's it! :) Thanks for reading. Don't hesitate to post a comment or pm me on Gamebanana.com if you've seen a bug in this map. Also include a screenshot to help me find it.


									- m3owth_47
									- Pushing GoldSrc's Limits