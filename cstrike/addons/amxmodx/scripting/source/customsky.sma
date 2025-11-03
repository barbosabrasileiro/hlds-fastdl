#include <amxmod>
#include <amxmisc>

#define PLUGIN  "Custom Sky"
#define VERSION "1.1"
#define AUTHOR  "cheap_suit"

#define max_suffix 6
new const g_suffix[max_suffix][3] = { "up", "dn", "ft", "bk", "lf", "rt" }

new g_maxskies = 19
#define default_skies_num 47
new const g_defaultSkies[default_skies_num][] = {
	// Half-Life
	"2desert","alien1","alien2","alien3","black","city","cliff","desert",
	"dusk","morning","neb1","neb2b","neb6","neb7","night","space",
	"xen8","xen9","xen10",
	// Counter-Strike
	"backalley","badlands","blue","city1","cx","de_storm","Des","doom1",
	"DrkG","forest","green","grnplsnt","hav","morningdew","office","snow",
	"snowlake_","tornsky","TrainYard","tsccity_",
	// Condition Zero
	"dust",/*"green",*/"inferno","jungle","london","night2","sienna",
	"vostok","winter_xbox"
}

public plugin_precache() {
	register_plugin(PLUGIN, VERSION, AUTHOR)
	register_cvar(PLUGIN, VERSION, FCVAR_SPONLY|FCVAR_SERVER)

	register_cvar("sv_customsky", "1")
	register_cvar("sv_customskyname", "test_")

	if(is_running("czero"))
		g_maxskies = default_skies_num
	else if(is_running("cstrike"))
		g_maxskies = 39

	switch(get_cvar_num("sv_customsky")) {
		case 1: {
			new configdir[32], file[48]
			get_localinfo("amx_configdir", configdir, charsmax(configdir))

			if(!configdir[0]) {
				build_path(file, charsmax(file), "$configdir/custom_sky.cfg")
			}
			else {
				formatex(file, charsmax(file), "%s/custom_sky.cfg", configdir)
			}

			if(!file_exists(file)) {
				write_file(file, "; Custom map sky config^n; Format: <mapname>  <skyname>^n")
				return
			}

			new mapname[32]
			new maplength = get_mapname(mapname, charsmax(mapname))

			new line = 0, length = 0
			new text[64], maptext[32], tgatext[32]
			while(read_file(file, line++, text, charsmax(text), length)) {
				if(length < (maplength + 2) || text[0] == ';' || text[0] == '/' || text[0] == '#')
					continue

				parse(text, maptext, charsmax(maptext), tgatext, charsmax(tgatext))
				if(equali(maptext, mapname)) {
					precache_sky(tgatext)
					break
				}
			}
		}
		case 2: {
			new cvar_skyname[32]
			get_cvar_string("sv_customskyname", cvar_skyname, charsmax(cvar_skyname))

			if(cvar_skyname[0] != 0)
				precache_sky(cvar_skyname)
		}
	}
}

precache_sky(const skyname[]) {
	new i
	for(i = 0; i < g_maxskies; i++) {
		if(equali(skyname, g_defaultSkies[i])) {
			set_cvar_string("sv_skyname", skyname)
			return
		}
	}

	new bool:found = true
	new tgafile[35]

	for(i = 0; i < max_suffix; ++i) {
		formatex(tgafile, charsmax(tgafile), "gfx/env/%s%s.tga", skyname, g_suffix[i])
		if(file_exists(tgafile))
			precache_generic(tgafile)
		else	{
			log_amx("Cannot locate file ^"%s^"", tgafile)
			found = false
			break
		}
	}

	if(found)
		set_cvar_string("sv_skyname", skyname)
}
