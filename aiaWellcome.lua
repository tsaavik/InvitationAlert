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

end

