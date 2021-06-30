

local lastStatus = false

local function BGEvetHandle()
	if PVPReadyDialog:IsShown() then	
		local qStatus = false --текущий статус наличия приглашения по признаку таймера очереди
		for i=1, GetMaxBattlefieldID() do
			local ex =GetBattlefieldPortExpiration(i) --таймер очереди
			if ex ~= 0 then
				qStatus = true
			end
		end
		
		if qStatus == true and lastStatus == false then --активация на моменте перехода из статуса фолс в тру
			aiaEvent()
		end
		
		lastStatus = qStatus --присвоение предыдущего статуса
		
	end	
end


function aiaInit()
	frmInvitationAlert:RegisterEvent("LFG_PROPOSAL_SHOW");
	
	PVPReadyDialog:HookScript("OnUpdate", BGEvetHandle); --подписка функции пвп диалока на скрипт
end



local aiatiks= 0;
local aiatimer = nil
local aiastatus = false;
 aiaSEnableSoundWhenGameIsInBG = 1;
 aiaSEnableAllSound = 1;
 aiaSEnableSFX = 1;
 aiaSMasterVolume = 0.3;
 aiaSSFXVolume = 0.3;

function aiaUpdate()
	if (aiastatus == true) then
		if not aiatimer then
			aiatimer = GetTime() + 2 -- задержка возврата настроек при эвенте
			
			local weekday2, month2, day2, year2 = CalendarGetDate();
			if (month2 == 4 and day2 == 1) then
				aiatimer = GetTime() + 15
			end
		
		end
		
		
		
		
		
		if (GetTime()> aiatimer) then	--180	
		
			--вариант впилить 2й таймер что бы настройки вливались наверняка
			
			
			--print ("back settings");
			--print (aiaSEnableAllSound);
			--print (aiaSEnableSFX);
			--print (aiaSMasterVolume);
			--print (aiaSSFXVolume);
			SetCVar("Sound_EnableAllSound", aiaSEnableAllSound);
			SetCVar("Sound_EnableSFX", aiaSEnableSFX);
			SetCVar("Sound_MasterVolume", aiaSMasterVolume);
			SetCVar("Sound_SFXVolume", aiaSSFXVolume);
			
			aiastatus = false;
			aiatimer = nil
			
		end
	end
end

function aiaEvent()
aiastatus = true; --активирован таймер возврата настроек
aiatiks = 0; --сброс настроек таймера

--запомнить старые значения настроек
--aiaSEnableSoundWhenGameIsInBG = GetCVar("Sound_EnableSoundWhenGameIsInBG");
aiaSEnableAllSound = GetCVar("Sound_EnableAllSound");
aiaSEnableSFX = GetCVar("Sound_EnableSFX");
aiaSMasterVolume = GetCVar("Sound_MasterVolume");
aiaSSFXVolume = GetCVar("Sound_SFXVolume");
--print (aiaSEnableAllSound);
--print (aiaSEnableSFX);
--print (aiaSMasterVolume);
--print (aiaSSFXVolume);
--здесь впилить настройки новые
SetCVar("Sound_EnableSoundWhenGameIsInBG", 1);
SetCVar("Sound_EnableAllSound", 1);
SetCVar("Sound_EnableSFX", 1);

local Mv = (0.1 +  aiaSMasterVolume) * 2 
if Mv > 1 then
Mv = 1;
end
local Sv = (0.1 + aiaSSFXVolume) * 2 
if Sv > 1 then
Sv = 1;
end
SetCVar("Sound_MasterVolume", Mv);
SetCVar("Sound_SFXVolume", Sv);




print("|cff0000ff############################################|r");
if GetLocale() == "ruRU" then
print("Вы получили приглашение в подземелье через LFG");
else
print("You have received an invitation through the LFG");
end
print("|cff0000ff############################################|r");
--local weekday, month, day, year = CalendarGetDate();
--if (month == 4 and day == 1) then
--PlaySoundFile("Interface\\AddOns\\InvitationAlert\\sound2.ogg");
--else
PlaySoundFile("Interface\\AddOns\\InvitationAlert\\mysound.ogg");
--end
end
