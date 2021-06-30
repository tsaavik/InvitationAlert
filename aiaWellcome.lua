function aiawInit()
	frmaiaWellcome:RegisterEvent("PLAYER_LOGIN");
end
faiaMV=0;
function aiawEvent()	
SetCVar("Sound_EnableSoundWhenGameIsInBG", 1);
--SetCVar("Sound_EnableAllSound", 1);
--SetCVar("Sound_EnableSFX", 1);


if tonumber(GetCVar("Sound_MasterVolume")) < 0.05 then
--SetCVar("Sound_MasterVolume", 0.3);
end

if tonumber(GetCVar("Sound_SFXVolume")) < 0.05 then
--SetCVar("Sound_SFXVolume", 0.3);
end

if GetLocale() == "ruRU" then
		--print("Добро пожаловать в игровой мир, вас приветствует аддон |cff00ffffInvitationAlert!|r");
		--print("данный аддон издает громкий звук <Горна> в момент когда вам приходит приглашение в подземелье через систему LFG |cffff0000[звук слышен даже при свернутом игровом клиенте]|r и вы больше не будете пропускать рандомы ожидая 30минут.");
		
else
		--print("Welcome to the game world, you are welcomed addon |cff00ffffInvitationAlert!|r");
		--print("This addon produces a loud sound <Horn> the time comes when you visit the dungeon through LFG |cffff0000[sound is heard even when minimized the game client, or it is in the background]|r and you will no longer miss random dungeon after waiting 30minutes.");

end
end

