#include < amxmodx >
#include < reapi >

public plugin_init(){
	register_plugin	(
		"Team Score",
		"0.1",
		"Flymic24"
	);
	
	RegisterHookChain(RG_CSGameRules_RestartRound, "@OnRestartRound", .post = false);
	RegisterHookChain(RG_CSGameRules_OnRoundFreezeEnd, "@OnRoundFreezeEnd", .post = false);
}

public plugin_precache()	{
	precache_generic("gfx/career/round_corner_nw.tga");
	precache_generic("resource/TutorScheme.res");
	precache_generic("resource/UI/TutorTextWindow.res");
}

@OnRestartRound()	{
	for(new pPlayer = 1; pPlayer <= MaxClients; pPlayer++)    {
		if (!is_user_connected(pPlayer))	continue;
		@TutorText(pPlayer, fmt("^n%d                                       %d", get_member_game(m_iNumTerroristWins), get_member_game(m_iNumCTWins)));
    }
}

@OnRoundFreezeEnd()	{
	@TutorClose();
}

@TutorText(pPlayer, szText[])	{
	static g_iMsgID_TutorText;
	if( g_iMsgID_TutorText || (g_iMsgID_TutorText = get_user_msgid("TutorText")) )
	{
		message_begin(MSG_ONE_UNRELIABLE, g_iMsgID_TutorText, _, pPlayer);
		write_string(szText);
		write_byte(0);
		write_short(0);
		write_short(0);
		message_end();
	}
}

@TutorClose()	{
	static g_iMsgID_TutorClose;
	if( g_iMsgID_TutorClose || (g_iMsgID_TutorClose = get_user_msgid("TutorClose")) )
	{
		message_begin(MSG_BROADCAST, g_iMsgID_TutorClose);
		message_end();
	}
}
