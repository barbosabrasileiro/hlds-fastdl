#include <amxmodx>
#include <amxmisc>
#include <cstrike>
#include <cromchat>
#include <fvault>

#define SOM_DE_SELECIONAR_OPCAO "sound/events/enemy_died.wav"

#define PREFIXO_CHAT_AND_HUD_AWP    "&x01[ &x04IDF &x01- &x04SkinsDeAarma &x01- &x03AWP &x01]"
#define PREFIXO_CHAT_AND_HUD_FACA   "&x01[ &x04IDF &x01- &x04SkinsDeAarma &x01- &x03FACA &x01]"
#define PREFIXO_CHAT_AND_HUD_DEAGLE "&x01[ &x04IDF &x01- &x04SkinsDeAarma &x01- &x03DEAGLE &x01]"
#define PREFIXO_CHAT_AND_HUD_M4A1   "&x01[ &x04IDF &x01- &x04SkinsDeAarma &x01- &x03M4A1 &x01]"
#define PREFIXO_CHAT_AND_HUD_AK47   "&x01[ &x04IDF &x01- &x04SkinsDeAarma &x01- &x03AK47 &x01]"

#define CC_CHAT_ESCOLHOU_MENU_AWP    "&x01[ &x04IDF &x01- &x04SkinsDeAarma &x01- &x03AWP &x01]"
#define CC_CHAT_ESCOLHOU_MENU_FACA   "&x01[ &x04IDF &x01- &x04SkinsDeAarma &x01- &x03FACA &x01]"
#define CC_CHAT_ESCOLHOU_MENU_DEAGLE "&x01[ &x04IDF &x01- &x04SkinsDeAarma &x01- &x03DEAGLE &x01]"
#define CC_CHAT_ESCOLHOU_MENU_M4A1   "&x01[ &x04IDF &x01- &x04SkinsDeAarma &x01- &x03M4A1 &x01]"
#define CC_CHAT_ESCOLHOU_MENU_AK47   "&x01[ &x04IDF &x01  &x04SkinsDeAarma &x01- &x03AK47 &x01]"

#define WEAPONS_TO_SKINS ( (1<<CSW_AWP) | (1<<CSW_M4A1) | (1<<CSW_AK47) | (1<<CSW_DEAGLE) | (1<<CSW_KNIFE) )

#pragma tabsize 0
new nightvisionOverrideActive[33];

// Variáveis para armazenar as skins escolhidas
new g_skinKnife[33];
new g_skinAwp[33];
new g_skinAk47[33];
new g_skinM4a1[33];
new g_skinDeagle[33];

// Nome do arquivo fvault
new const VAULT_NAME[] = "skins_menu";

#define DEFAULT_MODEL_V_KNIFE "models/v_knife.mdl"
#define DEFAULT_MODEL_V_AWP "models/v_awp.mdl"
#define DEFAULT_MODEL_V_AK47 "models/v_ak47.mdl"
#define DEFAULT_MODEL_V_M4A1 "models/v_m4a1.mdl"
#define DEFAULT_MODEL_V_DEAGLE "models/v_deagle.mdl"

//////////////// - FACAS - ////////////
new const KNFModels_ToPrecache[][] =
{
	"models/idf/knife/v_knife_crimsonbrother.mdl",
	"models/idf/knife/v_knife_frosty.mdl",
	"models/idf/knife/v_knife_gamma.mdl",
	"models/idf/knife/v_knife_glace.mdl",
	"models/idf/knife/v_knife_junglestripes.mdl",
	"models/idf/knife/v_knife_luminousedge.mdl",
	"models/idf/knife/v_knife_slice.mdl",
	"models/idf/knife/v_knife_tattos.mdl"
};
new const KNFMenuNames_ToUse[][] =
{
	"Faca Original",
	"Crimson Brother",
	"Frosty",
	"Gamma",
	"Glace",
	"Jungle Stripes",
	"Luminous Edge",
	"Slice",
	"Tatto's"
};
//////////////// - AK47 - ////////////
new const AKModels_ToPrecache[][] =
{
	"models/idf/ak47/v_ak47_apocalipse.mdl",
	"models/idf/ak47/v_ak47_crimsonbrother.mdl",
	"models/idf/ak47/v_ak47_crystal.mdl",
	"models/idf/ak47/v_ak47_darksnake.mdl",
	"models/idf/ak47/v_ak47_decimator.mdl",
	"models/idf/ak47/v_ak47_effect.mdl",
	"models/idf/ak47/v_ak47_frosty.mdl",
	"models/idf/ak47/v_ak47_honeycomb.mdl",
	"models/idf/ak47/v_ak47_hyperbeast.mdl",
	"models/idf/ak47/v_ak47_light.mdl",
	"models/idf/ak47/v_ak47_neonrider.mdl",
	"models/idf/ak47/v_ak47_orangefront.mdl",
	"models/idf/ak47/v_ak47_pawpaw.mdl",
	"models/idf/ak47/v_ak47_spells.mdl"
};
new const AKMenuNames_ToUse[][] =
{
	"AK47 Original",
	"Apocalipse",
	"Crimson Brother",
	"Crystal",
	"Dark Snake",
	"Decimator",
	"Effect",
	"Frosty",
	"Honeycomb",
	"Hyper Beast",
	"Light",
	"Neon Rider",
	"Orange Front",
	"Paw Paw",
	"Spells"
};
//////////////// - M4A1 - ////////////
new const M4Models_ToPrecache[][] =
{
	"models/idf/m4a1/v_m4a1_apocalipse.mdl",
	"models/idf/m4a1/v_m4a1_crimsonbrother.mdl",
	"models/idf/m4a1/v_m4a1_crystal.mdl",
	"models/idf/m4a1/v_m4a1_darksnake.mdl",
	"models/idf/m4a1/v_m4a1_decimator.mdl",
	"models/idf/m4a1/v_m4a1_effect.mdl",
	"models/idf/m4a1/v_m4a1_frosty.mdl",
	"models/idf/m4a1/v_m4a1_honeycomb.mdl",
	"models/idf/m4a1/v_m4a1_hyperbeast.mdl",
	"models/idf/m4a1/v_m4a1_light.mdl",
	"models/idf/m4a1/v_m4a1_neonrider.mdl",
	"models/idf/m4a1/v_m4a1_orangefront.mdl",
	"models/idf/m4a1/v_m4a1_pawpaw.mdl",
	"models/idf/m4a1/v_m4a1_spells.mdl"
};

new const M4MenuNames_ToUse[][] =
{
	"M4 Original",
	"Apocalipse",
	"Crimson Brother",
	"Crystal",
	"Dark Snake",
	"Decimator",
	"Effect",
	"Frosty",
	"Honeycomb",
	"Hyper Beast",
	"Light",
	"Neon Rider",
	"Orange Front",
	"Paw Paw",
	"Spells"
};

//////////////// - AWP - ////////////
new const AWPModels_ToPrecache[][] =
{
	"models/idf/awp/v_awp_apocalipse.mdl",
	"models/idf/awp/v_awp_crimsonbrother.mdl",
	"models/idf/awp/v_awp_crystal.mdl",
	"models/idf/awp/v_awp_darksnake.mdl",
	"models/idf/awp/v_awp_decimator.mdl",
	"models/idf/awp/v_awp_effect.mdl",
	"models/idf/awp/v_awp_frosty.mdl",
	"models/idf/awp/v_awp_honeycomb.mdl",
	"models/idf/awp/v_awp_hyperbeast.mdl",
	"models/idf/awp/v_awp_light.mdl",
	"models/idf/awp/v_awp_neonrider.mdl",
	"models/idf/awp/v_awp_orangefront.mdl",
	"models/idf/awp/v_awp_pawpaw.mdl",
	"models/idf/awp/v_awp_spells.mdl"
};

new const AWPMenuNames_ToUse[][] =
{
	"AWP Original",
	"Apocalipse",
	"Crimson Brother",
	"Crystal",
	"Dark Snake",
	"Decimator",
	"Effect",
	"Frosty",
	"Honeycomb",
	"Hyper Beast",
	"Light",
	"Neon Rider",
	"Orange Front",
	"Paw Paw",
	"Spells"
};
//////////////// - DEAGLE - ////////////
new const DGLModels_ToPrecache[][] =
{
	"models/idf/deagle/v_deagle_apocalipse.mdl",
	"models/idf/deagle/v_deagle_crimsonbrother.mdl",
	"models/idf/deagle/v_deagle_crystal.mdl",
	"models/idf/deagle/v_deagle_darksnake.mdl",
	"models/idf/deagle/v_deagle_decimator.mdl",
	"models/idf/deagle/v_deagle_forangefront.mdl",
	"models/idf/deagle/v_deagle_frosty.mdl",
	"models/idf/deagle/v_deagle_honeycomb.mdl",
	"models/idf/deagle/v_deagle_hyperbeast.mdl",
	"models/idf/deagle/v_deagle_light.mdl",
	"models/idf/deagle/v_deagle_neonrider.mdl",
	"models/idf/deagle/v_deagle_pawpaw.mdl",
	"models/idf/deagle/v_deagle_spells.mdl"
};

new const DGLMenuNames_ToUse[][] =
{
	"Deagle Original",
	"Apocalipse",
	"Crimson Brother",
	"Crystal",
	"Dark Snake",
	"Decimator",
	"Forange Front",
	"Frosty",
	"Honeycomb",
	"Hyper Beast",
	"Light",
	"Neon Rider",
	"Paw Paw",
	"Spells"
};

public plugin_init()
{
    register_plugin("Menu de Skins", "1.0", "Angelo")
    register_clcmd("say /menu", "GameMenu")
    register_clcmd("nightvision", "nightvision") // se tiver outro plugin que usa tecla N vai bugar...
    register_event("CurWeapon", "CurrentWeapon", "be", "1=1")
}

public plugin_precache()
{
    // Precache de todas as facas
    for(new i = 0; i < sizeof(KNFModels_ToPrecache); i++)
        precache_model(KNFModels_ToPrecache[i])
    
    // Precache de todas as AK47
    for(new i = 0; i < sizeof(AKModels_ToPrecache); i++)
        precache_model(AKModels_ToPrecache[i])
    
    // Precache de todas as M4A1
    for(new i = 0; i < sizeof(M4Models_ToPrecache); i++)
        precache_model(M4Models_ToPrecache[i])
    
    // Precache de todas as AWP
    for(new i = 0; i < sizeof(AWPModels_ToPrecache); i++)
        precache_model(AWPModels_ToPrecache[i])
    
    // Precache de todas as DEAGLE
    for(new i = 0; i < sizeof(DGLModels_ToPrecache); i++)
        precache_model(DGLModels_ToPrecache[i])
    
    // Precache do som
    precache_sound(SOM_DE_SELECIONAR_OPCAO)
}

public nightvision(id)
{
    if (nightvisionOverrideActive[id])
    {
        client_cmd(id, "spk %s", SOM_DE_SELECIONAR_OPCAO)
        GameMenu(id)
        return PLUGIN_HANDLED
    }
    nightvisionOverrideActive[id] = true
    return PLUGIN_CONTINUE
}

public client_putinserver(id)
{
    nightvisionOverrideActive[id] = true
    
    // Resetar as skins do jogador
    g_skinKnife[id] = 0
    g_skinAwp[id] = 0
    g_skinAk47[id] = 0
    g_skinM4a1[id] = 0
    g_skinDeagle[id] = 0
    
    // Carregar as skins salvas após um pequeno delay
    set_task(1.0, "LoadPlayerSkins", id)
}

public client_disconnected(id)
{
    nightvisionOverrideActive[id] = true
    
    // Resetar as skins do jogador
    g_skinKnife[id] = 0
    g_skinAwp[id] = 0
    g_skinAk47[id] = 0
    g_skinM4a1[id] = 0
    g_skinDeagle[id] = 0
}

// Função para criar chave de SteamID/UserID
CreatePlayerKey(id, key[], len)
{
    new authid[32];
    get_user_authid(id, authid, charsmax(authid));
    
    // Se SteamID estiver disponível, usar SteamID
    if(!equal(authid, "STEAM_ID_PENDING") && !equal(authid, "STEAM_ID_LAN") && !equal(authid, ""))
    {
        format(key, len, "%s", authid);
    }
    else // Se não, usar userid como fallback
    {
        format(key, len, "USERID_%d", get_user_userid(id));
    }
}

// Função para salvar skins no fvault (salvamento IMEDIATO)
SavePlayerSkins(id)
{
    if(!is_user_connected(id))
        return 0;
    
    new key[64], data[256];
    CreatePlayerKey(id, key, charsmax(key));
    
    format(data, charsmax(data), "%d %d %d %d %d", 
        g_skinKnife[id], 
        g_skinAwp[id], 
        g_skinAk47[id], 
        g_skinM4a1[id], 
        g_skinDeagle[id]);
    
    // SALVAMENTO IMEDIATO NO DISCO com fvault
    fvault_set_data(VAULT_NAME, key, data);
    
    return 1;
}

// Função para carregar skins do fvault
public LoadPlayerSkins(id)
{
    if(!is_user_connected(id))
        return 0;

    new key[64], data[256];
    CreatePlayerKey(id, key, charsmax(key));

    if(fvault_get_data(VAULT_NAME, key, data, charsmax(data)))
    {
        new knife[8], awp[8], ak47[8], m4a1[8], deagle[8];
        parse(data, knife, 7, awp, 7, ak47, 7, m4a1, 7, deagle, 7);

        g_skinKnife[id]  = str_to_num(knife);
        g_skinAwp[id]    = str_to_num(awp);
        g_skinAk47[id]   = str_to_num(ak47);
        g_skinM4a1[id]   = str_to_num(m4a1);
        g_skinDeagle[id] = str_to_num(deagle);
        
        return 1;
    }
    
    return 0;
}

public GameMenu(id)
{
    new menu = menu_create("\y>>>>> \r[ IDF - SkinsDeAarma ] \y<<<<<", "menu_case")

    menu_additem(menu, "\yKnife \wMenu", "1", 0)
    menu_additem(menu, "\yAwp \wMenu", "2", 0)
    menu_additem(menu, "\yAk47 \wMenu", "3", 0)
    menu_additem(menu, "\yM4A1 \wMenu", "4", 0)
    menu_additem(menu, "\yDeagle \wMenu", "5", 0)

    menu_setprop(menu, MPROP_EXIT, MEXIT_ALL)
    menu_display(id, menu, 0)
}

public menu_case(id, menu, item)
{
    if (item == MENU_EXIT)
    {
        menu_destroy(menu)
        return PLUGIN_HANDLED
    }

    new data[6], name[64]
    new access, callback
    menu_item_getinfo(menu, item, access, data, charsmax(data), name, charsmax(name), callback)

    new key = str_to_num(data)

    menu_destroy(menu)

    switch (key)
    {
        case 1:
        {
            client_cmd(id, "spk %s", SOM_DE_SELECIONAR_OPCAO)
            CC_SendMessage(id, CC_CHAT_ESCOLHOU_MENU_FACA)
            OpenMenuFACA(id)
        }
        case 2:
        {
            client_cmd(id, "spk %s", SOM_DE_SELECIONAR_OPCAO)
            CC_SendMessage(id, CC_CHAT_ESCOLHOU_MENU_AWP)
            OpenMenuAWP(id)
        }
        case 3:
        {
            client_cmd(id, "spk %s", SOM_DE_SELECIONAR_OPCAO)
            CC_SendMessage(id, CC_CHAT_ESCOLHOU_MENU_AK47)
            OpenMenuAK47(id)
        }
        case 4:
        {
            client_cmd(id, "spk %s", SOM_DE_SELECIONAR_OPCAO)
            CC_SendMessage(id, CC_CHAT_ESCOLHOU_MENU_M4A1)
            OpenMenuM4A1(id)
        }
        case 5:
        {
            client_cmd(id, "spk %s", SOM_DE_SELECIONAR_OPCAO)
            CC_SendMessage(id, CC_CHAT_ESCOLHOU_MENU_DEAGLE)
            OpenMenuDEAGLE(id)
        }
    }

    return PLUGIN_HANDLED
}

/// MENU DE FACAS
public OpenMenuFACA(id)
{
    new menu = menu_create("\y>>>>> \r[ IDF - FACAS ] \y<<<<<", "menu_faca_case")

    for(new i = 0; i < sizeof(KNFMenuNames_ToUse); i++)
    {
        new buffer[10], info[64]
        num_to_str(i, buffer, charsmax(buffer))
        format(info, charsmax(info), "%s", KNFMenuNames_ToUse[i])
        menu_additem(menu, info, buffer, 0)
    }

    menu_setprop(menu, MPROP_EXIT, MEXIT_ALL)
    menu_display(id, menu, 0)
}

public menu_faca_case(id, menu, item)
{
    if (item == MENU_EXIT)
	{
        menu_destroy(menu)
        return PLUGIN_HANDLED
	}
    
    new data[6], name[64]
    new access, callback
    menu_item_getinfo(menu, item, access, data, charsmax(data), name, charsmax(name), callback)
    
    g_skinKnife[id] = str_to_num(data)
    
    // SALVAR AUTOMATICAMENTE após escolher uma skin
    SavePlayerSkins(id)
    
    // Aplicar skin imediatamente se o jogador estiver com uma faca
    new weapon = get_user_weapon(id)
    if(weapon == CSW_KNIFE)
    {
        ApplyKnifeModel(id)
    }
    
    CC_SendMessage(id, "%s Skin selecionada: %s", PREFIXO_CHAT_AND_HUD_FACA, KNFMenuNames_ToUse[g_skinKnife[id]])
    CC_SendMessage(id, "&x01[&x04IDF&x01] &x03Skin salva automaticamente!&x01 Ela será carregada na próxima conexão.")
    
    // Reabre o menu antes de destruí-lo
    OpenMenuFACA(id)
    
    menu_destroy(menu)
    return PLUGIN_HANDLED
}

/// MENU DE AWP
public OpenMenuAWP(id)
{
    new menu = menu_create("\y>>>>> \r[ IDF - AWP ] \y<<<<<", "menu_awp_case")

    for(new i = 0; i < sizeof(AWPMenuNames_ToUse); i++)
    {
        new buffer[10], info[64]
        num_to_str(i, buffer, charsmax(buffer))
        format(info, charsmax(info), "%s", AWPMenuNames_ToUse[i])
        menu_additem(menu, info, buffer, 0)
    }

    menu_setprop(menu, MPROP_EXIT, MEXIT_ALL)
    menu_display(id, menu, 0)
}

public menu_awp_case(id, menu, item)
{
    if (item == MENU_EXIT)
	{
        menu_destroy(menu)
        return PLUGIN_HANDLED
	}
    
    new data[6], name[64]
    new access, callback
    menu_item_getinfo(menu, item, access, data, charsmax(data), name, charsmax(name), callback)
    
    g_skinAwp[id] = str_to_num(data)
    
    // SALVAR AUTOMATICAMENTE após escolher uma skin
    SavePlayerSkins(id)
    
    // Aplicar skin imediatamente se o jogador estiver com uma AWP
    new weapon = get_user_weapon(id)
    if(weapon == CSW_AWP)
    {
        ApplyAwpModel(id)
    }
    
    CC_SendMessage(id, "%s Skin selecionada: %s", PREFIXO_CHAT_AND_HUD_AWP, AWPMenuNames_ToUse[g_skinAwp[id]])
    CC_SendMessage(id, "&x01[&x04IDF&x01] &x03Skin salva automaticamente!&x01 Ela será carregada na próxima conexão.")
    
    // Reabre o menu antes de destruí-lo
    OpenMenuAWP(id)
    
    menu_destroy(menu)
    return PLUGIN_HANDLED
}

/// MENU DE AK47
public OpenMenuAK47(id)
{
    new menu = menu_create("\y>>>>> \r[ IDF - AK47 ] \y<<<<<", "menu_ak47_case")

    for(new i = 0; i < sizeof(AKMenuNames_ToUse); i++)
    {
        new buffer[10], info[64]
        num_to_str(i, buffer, charsmax(buffer))
        format(info, charsmax(info), "%s", AKMenuNames_ToUse[i])
        menu_additem(menu, info, buffer, 0)
    }

    menu_setprop(menu, MPROP_EXIT, MEXIT_ALL)
    menu_display(id, menu, 0)
}

public menu_ak47_case(id, menu, item)
{
    if (item == MENU_EXIT)
	{
        menu_destroy(menu)
        return PLUGIN_HANDLED
	}
    
    new data[6], name[64]
    new access, callback
    menu_item_getinfo(menu, item, access, data, charsmax(data), name, charsmax(name), callback)
    
    g_skinAk47[id] = str_to_num(data)
    
    // SALVAR AUTOMATICAMENTE após escolher uma skin
    SavePlayerSkins(id)
    
    // Aplicar skin imediatamente se o jogador estiver com uma AK47
    new weapon = get_user_weapon(id)
    if(weapon == CSW_AK47)
    {
        ApplyAk47Model(id)
    }
    
    CC_SendMessage(id, "%s Skin selecionada: %s", PREFIXO_CHAT_AND_HUD_AK47, AKMenuNames_ToUse[g_skinAk47[id]])
    CC_SendMessage(id, "&x01[&x04IDF&x01] &x03Skin salva automaticamente!&x01 Ela será carregada na próxima conexão.")
    
    // Reabre o menu antes de destruí-lo
    OpenMenuAK47(id)
    
    menu_destroy(menu)
    return PLUGIN_HANDLED
}

/// MENU DE M4A1
public OpenMenuM4A1(id)
{
    new menu = menu_create("\y>>>>> \r[ IDF - M4A1 ] \y<<<<<", "menu_m4a1_case")

    for(new i = 0; i < sizeof(M4MenuNames_ToUse); i++)
    {
        new buffer[10], info[64]
        num_to_str(i, buffer, charsmax(buffer))
        format(info, charsmax(info), "%s", M4MenuNames_ToUse[i])
        menu_additem(menu, info, buffer, 0)
    }

    menu_setprop(menu, MPROP_EXIT, MEXIT_ALL)
    menu_display(id, menu, 0)
}

public menu_m4a1_case(id, menu, item)
{
    if (item == MENU_EXIT)
	{
        menu_destroy(menu)
        return PLUGIN_HANDLED
	}
    
    new data[6], name[64]
    new access, callback
    menu_item_getinfo(menu, item, access, data, charsmax(data), name, charsmax(name), callback)
    
    g_skinM4a1[id] = str_to_num(data)
    
    // SALVAR AUTOMATICAMENTE após escolher uma skin
    SavePlayerSkins(id)
    
    // Aplicar skin imediatamente se o jogador estiver com uma M4A1
    new weapon = get_user_weapon(id)
    if(weapon == CSW_M4A1)
    {
        ApplyM4a1Model(id)
    }
    
    CC_SendMessage(id, "%s Skin selecionada: %s", PREFIXO_CHAT_AND_HUD_M4A1, M4MenuNames_ToUse[g_skinM4a1[id]])
    CC_SendMessage(id, "&x01[&x04IDF&x01] &x03Skin salva automaticamente!&x01 Ela será carregada na próxima conexão.")
    
    // Reabre o menu antes de destruí-lo
    OpenMenuM4A1(id)
    
    menu_destroy(menu)
    return PLUGIN_HANDLED
}

/// MENU DE DEAGLE
public OpenMenuDEAGLE(id)
{
    new menu = menu_create("\y>>>>> \r[ IDF - DEAGLE ] \y<<<<<", "menu_deagle_case")

    for(new i = 0; i < sizeof(DGLMenuNames_ToUse); i++)
    {
        new buffer[10], info[64]
        num_to_str(i, buffer, charsmax(buffer))
        format(info, charsmax(info), "%s", DGLMenuNames_ToUse[i])
        menu_additem(menu, info, buffer, 0)
    }

    menu_setprop(menu, MPROP_EXIT, MEXIT_ALL)
    menu_display(id, menu, 0)
}

public menu_deagle_case(id, menu, item)
{
    if (item == MENU_EXIT)
	{
        menu_destroy(menu)
        return PLUGIN_HANDLED
	}
    
    new data[6], name[64]
    new access, callback
    menu_item_getinfo(menu, item, access, data, charsmax(data), name, charsmax(name), callback)
    
    g_skinDeagle[id] = str_to_num(data)
    
    // SALVAR AUTOMATICAMENTE após escolher uma skin
    SavePlayerSkins(id)
    
    // Aplicar skin imediatamente se o jogador estiver com uma DEAGLE
    new weapon = get_user_weapon(id)
    if(weapon == CSW_DEAGLE)
    {
        ApplyDeagleModel(id)
    }
    
    CC_SendMessage(id, "%s Skin selecionada: %s", PREFIXO_CHAT_AND_HUD_DEAGLE, DGLMenuNames_ToUse[g_skinDeagle[id]])
    CC_SendMessage(id, "&x01[&x04IDF&x01] &x03Skin salva automaticamente!&x01 Ela será carregada na próxima conexão.")
    
    // Reabre o menu antes de destruí-lo
    OpenMenuDEAGLE(id)
    
    menu_destroy(menu)
    return PLUGIN_HANDLED
}

// FUNÇÕES PARA APLICAR OS MODELOS
ApplyKnifeModel(id)
{
    if(g_skinKnife[id] == 0)
    {
        set_pev(id, pev_viewmodel2, DEFAULT_MODEL_V_KNIFE)
    }
    else if(g_skinKnife[id] >= 1 && g_skinKnife[id] <= sizeof(KNFModels_ToPrecache))
    {
        set_pev(id, pev_viewmodel2, KNFModels_ToPrecache[g_skinKnife[id] - 1])
    }
}

ApplyAwpModel(id)
{
    if(g_skinAwp[id] == 0)
    {
        set_pev(id, pev_viewmodel2, DEFAULT_MODEL_V_AWP)
    }
    else if(g_skinAwp[id] >= 1 && g_skinAwp[id] <= sizeof(AWPModels_ToPrecache))
    {
        set_pev(id, pev_viewmodel2, AWPModels_ToPrecache[g_skinAwp[id] - 1])
    }
}

ApplyAk47Model(id)
{
    if(g_skinAk47[id] == 0)
    {
        set_pev(id, pev_viewmodel2, DEFAULT_MODEL_V_AK47)
    }
    else if(g_skinAk47[id] >= 1 && g_skinAk47[id] <= sizeof(AKModels_ToPrecache))
    {
        set_pev(id, pev_viewmodel2, AKModels_ToPrecache[g_skinAk47[id] - 1])
    }
}

ApplyM4a1Model(id)
{
    if(g_skinM4a1[id] == 0)
    {
        set_pev(id, pev_viewmodel2, DEFAULT_MODEL_V_M4A1)
    }
    else if(g_skinM4a1[id] >= 1 && g_skinM4a1[id] <= sizeof(M4Models_ToPrecache))
    {
        set_pev(id, pev_viewmodel2, M4Models_ToPrecache[g_skinM4a1[id] - 1])
    }
}

ApplyDeagleModel(id)
{
    if(g_skinDeagle[id] == 0)
    {
        set_pev(id, pev_viewmodel2, DEFAULT_MODEL_V_DEAGLE)
    }
    else if(g_skinDeagle[id] >= 1 && g_skinDeagle[id] <= sizeof(DGLModels_ToPrecache))
    {
        set_pev(id, pev_viewmodel2, DGLModels_ToPrecache[g_skinDeagle[id] - 1])
    }
}

// CURRENT WEAPON PARA ATUALIZAÇÃO IMEDIATA DE MODELS
public CurrentWeapon(id)
{
    if(!is_user_alive(id))
        return PLUGIN_CONTINUE
    
    new weapon = read_data(2)
    
    switch(weapon)
    {
        case CSW_KNIFE: ApplyKnifeModel(id)
        case CSW_AWP: ApplyAwpModel(id)
        case CSW_AK47: ApplyAk47Model(id)
        case CSW_M4A1: ApplyM4a1Model(id)
        case CSW_DEAGLE: ApplyDeagleModel(id)
    }
    
    return PLUGIN_CONTINUE
}