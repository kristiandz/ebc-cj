init()
{
	level.stringHolo = getDvar("holographic");
	level.aHoloText = [];
    level.aHoloPosition = [];
	level.spawnMins = ( 0, 0, 0 );
	level.spawnMaxs = ( 0, 0, 0 );
	maps\mp\gametypes\_spawnlogic::addSpawnPoints( "allies", "mp_dm_spawn" );

	level.aHoloPosition["angles"] = (0,180,0);
	level.aHoloPosition["origin"] = (0,0,200);
	level.HOLOFX = loadFX("misc/emz_fx");

	loadFonts();
	drawHolographicText();
	thread checkDvar();
}
checkDvar()
{
	for(;;)
	{
		dvar = getDvar("holographic");
		wait 2;
		if(dvar != getDvar("holographic"))
		{
			level.stringHolo = getDvar("holographic");
			removeHolographicText();
			drawHolographicText();
		}
	}
}
VectorMultiply( vec, dif )
{
    vec = ( vec[ 0 ] * dif, vec[ 1 ] * dif, vec[ 2 ] * dif );
    return vec;
}
removeHolographicText() 
{
	for(i = 0; i < level.aHoloText.size; i ++) 
		level.aHoloText[i] delete();
		
	level.aHoloText = [];
}
drawHolographicText() 
{
	if(isDefined(level.aHoloPosition) && isDefined(level.stringHolo)) 
	{
		angles = level.aHoloPosition["angles"] + (0,180,0);
		origin = level.aHoloPosition["origin"];

		vecx = AnglesToRight(angles);
		vecy = AnglesToUp(angles);
		vecz = AnglesToForward(angles);

		str = level.stringHolo;

		len = 0;
		for(i = 0;i < str.size;i++) 
		{
			letter = getSubStr(str,i,i+1);
			len += level.aFontSize[letter] + 2;
		}
		m = 4.5;
		x = (len / 2) * -1 * m;

		for(i = 0;i < str.size;i++) 
		{
			letter = getSubStr(str,i,i+1);
			arr = level.aFont[letter];
			for(d = 0; d < arr.size; d++) 
			{
				ox = VectorMultiply(vecx, arr[d][0] * m + x);
				oy = VectorMultiply(vecy, (16 - arr[d][1]) * m);
				oz = VectorMultiply(vecz, 1);
				position = origin + ox + oy + oz;
				fx = SpawnFX(level.HOLOFX, position);
				TriggerFX(fx, 1);
				level.aHoloText[level.aHoloText.size] = fx;
			}
			x += (level.aFontSize[letter] + 2) * m;
		}
	}
}

LoadFonts() 
{
	level.aFont = [];
	level.aFontSize = [];

	font_letters = "abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!#^&*()-=+[]{}\\\/,.'\"?$:;_";
	font = [];
	font[font.size] = "....x....x....x....x...x...x....x....x...x...x....x...x.....x....x.....x....x.....x....x...x...x....x...x.....x...x...x...x...x....x....x....x....x...x...x....x....x...x...x....x...x.....x....x.....x....x.....x....x...x...x....x...x.....x...x...x...x..x...x...x....x...x...x...x...x...x...x.x.....x...x.....x...x..x..x...x...x...x..x..x...x...x...x...x..x.x#x#.#x...x...x.x..x...";
	font[font.size] = ".... .... .... .... ... ... .... .... ... ... .... ... ..... .... ..... .... ..... .... ... ... .... ... ..... ... ... ... ... .... .... .... .... ... ... .... .... ... ... .... ... ..... .... ..... .... ..... .... ... ... .... ... ..... ... ... ... .. ... ... .... ... ... ... ... ... ... . ..... ... ..... ... .# #. ... ... ... ## ## ..# #.. #.. ..# .. . # #.# ... .#. . .. ...";
	font[font.size] = ".##. ###. .##. ###. ### ### .##. #..# ### ### #..# #.. .#.#. #..# .###. ###. .###. ###. ### ### #..# #.# #.#.# #.# #.# ### ... .##. ###. .##. ###. ### ### .##. #..# ### ### #..# #.. .#.#. #..# .###. ###. .###. ###. ### ### #..# #.# #.#.# #.# #.# ### .# ##. ### ..#. ### ### ### ### ### ### # .#.#. .#. .##.. .#. #. .# ... ... ... #. .# .#. .#. #.. ..# .. . . ... ### ### . .. ...";
	font[font.size] = "#..# #..# #..# #..# #.. #.. #... #..# .#. .#. #.#. #.. #.#.# ##.# #...# #..# #...# #..# #.. .#. #..# #.# #.#.# #.# #.# ..# ... #..# #..# #..# #..# #.. #.. #... #..# .#. .#. #.#. #.. #.#.# ##.# #...# #..# #...# #..# #.. .#. #..# #.# #.#.# #.# #.# ..# ## ..# ..# .##. #.. #.. ..# #.# #.# #.# # ##### #.# #..#. ### #. .# ... ### .#. #. .# .#. .#. .#. .#. .. . . ... ..# #.. # .# ...";
	font[font.size] = "#### ###. #... #..# ##. ##. #.## #### .#. .#. ###. #.. #.#.# #.## #...# #..# #.#.# #..# ### .#. #..# #.# #.#.# .#. .#. .#. ... #### ###. #... #..# ##. ##. #.## #### .#. .#. ###. #.. #.#.# #.## #...# #..# #.#.# #..# ### .#. #..# #.# #.#.# .#. .#. .#. .# .#. ### #.#. ##. ### ..# ### ### #.# # .#.#. ... .##.. .#. #. .# ### ... ### #. .# #.. ..# .#. .#. .. . . ... .## ### . .. ...";
	font[font.size] = "#..# #..# #..# #..# #.. #.. #..# #..# .#. .#. #.#. #.. #.#.# #..# #...# ###. #..#. ###. ..# .#. #..# #.# #.#.# #.# .#. #.. ... #..# #..# #..# #..# #.. #.. #..# #..# .#. .#. #.#. #.. #.#.# #..# #...# ###. #..#. ###. ..# .#. #..# #.# #.#.# #.# .#. #.. .# #.. ..# #### ..# #.# .#. #.# ..# #.# . ##### ... #..#. #.# #. .# ... ### .#. #. .# .#. .#. .#. .#. .. . . ... ... ..# # .# ...";
	font[font.size] = "#..# ###. .##. ###. ### #.. .##. #..# ### #.. #..# ### #.#.# #..# .###. #... .##.# #..# ### .#. .### .#. .#.#. #.# #.. ### ... #..# ###. .##. ###. ### #.. .##. #..# ### #.. #..# ### #.#.# #..# .###. #... .##.# #..# ### .#. .### .#. .#.#. #.# #.. ### .# ### ### ..#. ##. ### .#. ### ### ### # .#.#. ... .##.# ... #. .# ... ... ... #. .# .#. .#. ..# #.. .# # . ... .#. ### . #. ###";
	font[font.size] = ".... .... .... .... ... ... .... .... ... ... .... ... ..... .... ..... .... ..... .... ... ... .... ... ..... ... ... ... ... .... .... .... .... ... ... .... .... ... ... .... ... ..... .... ..... .... ..... .... ... ... .... ... ..... ... ... ... .. ... ... .... ... ... ... ... ... ... . ..... ... ..... ... .# #. ... ... ... ## ## ..# #.. ..# #.. #. . . ... ... .#. . .. ...";

	pos1 = 0;
	index = 0;
	for(i = 0;i < font[0].size;i++) 
	{
		if(getSubStr(font[0], i, i+1) == "x") 
		{
			pos2 = i;
			letter = getSubStr(font_letters, index, index+1);
			level.aFont[letter] = [];
			level.aFontSize[letter] = pos2 - pos1;
			for(x = pos1;x < pos2; x++) 
			{
				for(y = 0;y < font.size;y++) 
				{
					if(getSubStr(font[y], x, x+1) == "#") 
						level.aFont[letter][level.aFont[letter].size] = (x - pos1, y, 0);
				}
			}
			index++;
			pos1 = pos2+1;
		}
	}
}