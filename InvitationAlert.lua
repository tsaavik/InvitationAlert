-- aia = Audio Invitation Alert?
local aiaDebug = false

local lastStatus = false
local function BGEventHandle()
	-- This handles PVP notifications. Still figuring it out
	-- GetBattlefieldPortExpiration - seconds before battlefield port expires
	-- GetMaxBattlefieldID() - Returns max numer of battlefields you can queue
	if PVPReadyDialog:IsShown() then	
		local qStatus = false 
		for i=1, GetMaxBattlefieldID() do
			local ex =GetBattlefieldPortExpiration(i) 
			if ex ~= 0 then
				qStatus = true
			end
		end
		
		if qStatus == true and lastStatus == false then 
			AiaEvent()
		end
		
		lastStatus = qStatus
	end	
end

function AiaInit()
	-- This hooks us into the LFG and PVP ready events
	frmInvitationAlert:RegisterEvent("LFG_PROPOSAL_SHOW");
	PVPReadyDialog:HookScript("OnUpdate", BGEventHandle); 
end

local aiatiks= 0;
local aiatimer = nil
local aiastatus = false;
local aiaSEnableSoundWhenGameIsInBG = true;
local aiaSEnableAllSound = true;
local aiaSEnableSFX = true;
local aiaSMasterVolume = 0.3;
local aiaSSFXVolume = 0.3;
function AiaUpdate()
	-- Entire function only runs when aiastatus has been set true by AiaEvent
    -- Restores enviroment after sound has played via AiaEvent
	if (aiastatus == true) then
		if not aiatimer then
			aiatimer = GetTime() + 2 
		end
		if (GetTime()> aiatimer) then
			if aiaDebug	then
				print ("Restoring user sound settings");
				print ("EnableAllSound: ", aiaSEnableAllSound);
				print ("EnableSFX: ", aiaSEnableSFX);
				print ("MasterVolume: ", aiaSMasterVolume);
				print ("SFXVolume: ", aiaSSFXVolume);
				print ("Sound_EnableSoundWhenGameIsInBG: ", aiaSEnableSoundWhenGameIsInBG)
			end
			SetCVar("Sound_EnableAllSound", aiaSEnableAllSound);
			SetCVar("Sound_EnableSFX", aiaSEnableSFX);
			SetCVar("Sound_MasterVolume", tostring(aiaSMasterVolume));
			SetCVar("Sound_SFXVolume", tostring(aiaSSFXVolume));
			SetCVar("Sound_EnableSoundWhenGameIsInBG", aiaSEnableSoundWhenGameIsInBG);
			aiastatus = false;
			aiatimer = nil
		end
	end
end

function AiaEvent()
   -- We've gotten the signal, save the users current sound settings and fire alert at high volume
   aiastatus = true;  -- so we can trigger AiaUpdate to restore the settings when we are done
   aiatiks = 0; 

   -- Capture user's sound settings for later restoriation
   aiaSEnableSoundWhenGameIsInBG = GetCVar("Sound_EnableSoundWhenGameIsInBG");
   aiaSEnableAllSound = GetCVar("Sound_EnableAllSound");
   aiaSEnableSFX = GetCVar("Sound_EnableSFX");
   aiaSMasterVolume = tonumber(GetCVar("Sound_MasterVolume"));
   aiaSSFXVolume = tonumber(GetCVar("Sound_SFXVolume"));
   if aiaDebug then
   	  print("EnableAllSound: ", aiaSEnableAllSound);
   	  print("EnableSFX: ", aiaSEnableSFX);
   	  print("MasterVolume: ", aiaSMasterVolume);
   	  print("SFXVolume: ", aiaSSFXVolume);
	  print("aiaSEnableSoundWhenGameIsInBG: ", aiaSEnableSoundWhenGameIsInBG);
   end

   if aiaSEnableSoundWhenGameIsInBG == false then
	-- Currently broken, WoW seems to not change the variable when window is not focused :(
      SetCVar("Sound_EnableSoundWhenGameIsInBG", true);
	  if aiaDebug then
      	print("Enabling background sound override");
      	print("aiaSEnableSoundWhenGameIsInBG: (should be true now) ", aiaSEnableSoundWhenGameIsInBG);
	  end
   end

   -- turn on sound and pump up the volume  
   SetCVar("Sound_EnableAllSound", true);
   SetCVar("Sound_EnableSFX", true);

   --Compute Master Volume, not to exceed 1 (100%)
   local Mv = (0.1 +  aiaSMasterVolume) * 2 
   if Mv > 1 then
      Mv = 1;
   end

   --Compute SFX Volume, not to exceed 1 (100%)
   local Sv = (0.1 + aiaSSFXVolume) * 2 
      if Sv > 1 then
      Sv = 1;
   end
   SetCVar("Sound_MasterVolume", tostring(Mv));
   SetCVar("Sound_SFXVolume", tostring(Sv));

   print("|cff0000ff############################################|r");
   print("You have received an invitation through the LFG");
   print("|cff0000ff############################################|r");
   PlaySoundFile("Interface\\AddOns\\InvitationAlert\\mysound.ogg");
end
