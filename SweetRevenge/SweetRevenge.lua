-- Author      : Bloodlips
-- Create Date : 1/6/2018 12:39:05 AM

SweetRev = {};
isOptionsVisible = false; -- Window hidden to start
    

-- Hooking Functions to Override SetPoint 
-- for each Blizzard Default UI w/ default positions (Because Refresh/Update Bars)

--[[
function wait(waitTime)
    timer = os.time()
    repeat until os.time() > timer + waitTime
end



]]
local function SetPointBlizzOverride(bar, ...)
    setting = true
    local containerScale = 0.8;


    if bar ==  'MainMenuBar' then

	  --  _G["MainMenuBar"]:SetMovable(true)  -- This is to allow next intruction "SetUserPlaced(true)"
	  -- _G["MainMenuBar"]:SetUserPlaced(true) -- This is to keep the bar in right place (to not look like a but) https://www.wowinterface.com/forums/showthread.php?t=56369
      --  _G["MainMenuBar"]:SetMovable(false)  -- This is to allow previous intruction only "SetUserPlaced(true)"
		
		-- 	_G["MainMenuBar"]:SetMovable(true)
        -- _G["MainMenuBar"]:SetUserPlaced(true);
        -- _G["MainMenuBar"]:SetDontSavePosition(true);
        -- _G["MainMenuBar"].ignoreFramePositionManager = true;
		
		_G["MainMenuBar"]:SetScale(0.5);
	end
    
    setting = nil
end
    
--#############################################
-- Hook to keep same positions after refresh/update (ex. bars)
 --[[ hooksecurefunc(MainMenuBar, "SetPoint", 
					function(bar, ...)
						if not setting then
							bar = "MainMenuBar";
							SetPointBlizzOverride(bar, ...)
						end
				end)    ]]
	
-- Sweet Revenge (On Load Event)    




function SweetRev:FramePositionDelegateUIParentManageFramePositions()
-- Changed from UIParent FramePositionDelegateUIParentManageFramePositions()
						
	local UIPARENT_VARIABLE_OFFSETS = {
		["rightActionBarsX"] = 0,
	};

	UIPARENT_VARIABLE_OFFSETS["rightActionBarsX"] = VerticalMultiBarsContainer:GetWidth();

	-- Update the variable with the happy magic number.
	UpdateMenuBarTop();

	-- Frames that affect offsets in y axis
	local yOffsetFrames = {};
	-- Frames that affect offsets in x axis
	local xOffsetFrames = {};

	-- Set up flags
	local hasBottomLeft, hasBottomRight, hasPetBar;

	if ( not PlayerPowerBarAlt:IsUserPlaced() ) then
		local barInfo = GetUnitPowerBarInfo(PlayerPowerBarAlt.unit);
		if ( PlayerPowerBarAlt:IsShown() and barInfo and barInfo.anchorTop ) then
			PlayerPowerBarAlt:ClearAllPoints();
			UIPARENT_MANAGED_FRAME_POSITIONS["PlayerPowerBarAlt"] = UIPARENT_ALTERNATE_FRAME_POSITIONS["PlayerPowerBarAlt_Top"];
		else
			PlayerPowerBarAlt:ClearAllPoints();
			UIPARENT_MANAGED_FRAME_POSITIONS["PlayerPowerBarAlt"] = UIPARENT_ALTERNATE_FRAME_POSITIONS["PlayerPowerBarAlt_Bottom"];
		end
	end

	if ( OverrideActionBar and OverrideActionBar:IsShown() ) then
		tinsert(yOffsetFrames, "overrideActionBar");
	elseif ( PetBattleFrame and PetBattleFrame:IsShown() ) then
		tinsert(yOffsetFrames, "petBattleFrame");
	else
		if ( MultiBarBottomLeft:IsShown() or MultiBarBottomRight:IsShown() ) then
			tinsert(yOffsetFrames, "bottomEither");
		end
		if ( MultiBarBottomRight:IsShown() ) then
			tinsert(yOffsetFrames, "bottomRight");
			hasBottomRight = 1;
		end
		if ( MultiBarBottomLeft:IsShown() ) then
			tinsert(yOffsetFrames, "bottomLeft");
			hasBottomLeft = 1;
		end
		-- TODO: Leaving this here for now since ChatFrame2 references it. Do we still need ChatFrame2 to be managed?
		if ( MultiBarRight:IsShown() ) then
			tinsert(xOffsetFrames, "rightRight");
		end
		if ( MultiBarRight:IsShown() ) then
			tinsert(xOffsetFrames, "rightActionBarsX");
		end
		if (PetActionBarFrame_IsAboveStance and PetActionBarFrame_IsAboveStance()) then
			tinsert(yOffsetFrames, "justBottomRightAndStance");
		end
		if ( ( PetActionBarFrame and PetActionBarFrame:IsShown() ) or ( StanceBarFrame and StanceBarFrame:IsShown() ) or
			 ( MultiCastActionBarFrame and MultiCastActionBarFrame:IsShown() ) or ( PossessBarFrame and PossessBarFrame:IsShown() ) or
			 ( MainMenuBarVehicleLeaveButton and MainMenuBarVehicleLeaveButton:IsShown() ) ) then
			tinsert(yOffsetFrames, "pet");
			hasPetBar = 1;
		end

		if ( TutorialFrameAlertButton:IsShown() ) then
			tinsert(yOffsetFrames, "tutorialAlert");
		end
		if ( PlayerPowerBarAlt:IsShown() and not PlayerPowerBarAlt:IsUserPlaced() ) then
			local barInfo = GetUnitPowerBarInfo(PlayerPowerBarAlt.unit);
			if ( not barInfo or not barInfo.anchorTop ) then
				tinsert(yOffsetFrames, "playerPowerBarAlt");
			end
		end
		if UIWidgetPowerBarContainerFrame and UIWidgetPowerBarContainerFrame:GetNumWidgetsShowing() > 0 then
			tinsert(yOffsetFrames, "powerBarWidgets");
		end
		if ( ExtraAbilityContainer and ExtraAbilityContainer:IsShown() ) then
			tinsert(yOffsetFrames, "extraAbilityContainer");
		end
		if ( TalkingHeadFrame and TalkingHeadFrame:IsShown() ) then
			tinsert(yOffsetFrames, "talkingHeadFrame");
		end
		if ( ClassResourceOverlayParentFrame and ClassResourceOverlayParentFrame:IsShown() ) then
			tinsert(yOffsetFrames, "classResourceOverlayFrame");
			tinsert(yOffsetFrames, "classResourceOverlayOffset");
		end
		if ( CastingBarFrame and not CastingBarFrame:GetAttribute("ignoreFramePositionManager") ) then
			tinsert(yOffsetFrames, "castingBar");
		end
	end

	if ( menuBarTop == 55 ) then
		UIPARENT_MANAGED_FRAME_POSITIONS["TutorialFrameAlertButton"].yOffset = -10;
	else
		UIPARENT_MANAGED_FRAME_POSITIONS["TutorialFrameAlertButton"].yOffset = -30;
	end

	-- Iterate through frames and set anchors according to the flags set
	for index, value in pairs(UIPARENT_MANAGED_FRAME_POSITIONS) do
		if ( value.playerPowerBarAlt and PlayerPowerBarAlt and not PlayerPowerBarAlt:IsUserPlaced()) then
			value.playerPowerBarAlt = PlayerPowerBarAlt:GetHeight() + 10;
		end
		if ( value.powerBarWidgets and UIWidgetPowerBarContainerFrame ) then
			value.powerBarWidgets = UIWidgetPowerBarContainerFrame:GetHeight() + 10;
		end
		if ( value.extraAbilityContainer ) then
			value.extraAbilityContainer = ExtraAbilityContainer:GetHeight() + 10;
		end
		if ( value.bonusActionBar and BonusActionBarFrame ) then
			value.bonusActionBar = BonusActionBarFrame:GetHeight() - MainMenuBar:GetHeight();
		end
		if ( value.castingBar ) then
			value.castingBar = CastingBarFrame:GetHeight() + 14;
		end
		if ( value.talkingHeadFrame and TalkingHeadFrame and TalkingHeadFrame:IsShown() ) then
			value.talkingHeadFrame = TalkingHeadFrame:GetHeight() - 10;
		end
		if ( ClassResourceOverlayParentFrame and ClassResourceOverlayParentFrame:IsShown() ) then
			if ( value.classResourceOverlayFrame ) then
				value.classResourceOverlayFrame = ClassResourceOverlayParentFrame:GetHeight() + 10;
			end
			if ( value.classResourceOverlayOffset ) then
				value.classResourceOverlayOffset = -20;
			end
		end
		securecall("UIParent_ManageFramePosition", index, value, yOffsetFrames, xOffsetFrames, hasBottomLeft, hasBottomRight, hasPetBar);
	end

	-- Custom positioning not handled by the loop

	-- MainMenuBar
	if not MainMenuBar:IsUserPlaced() and not MicroButtonAndBagsBar:IsUserPlaced() then
		local screenWidth = UIParent:GetWidth();
		local barScale = 0.9;
		local barWidth = MainMenuBar:GetWidth();
		local barMargin = MAIN_MENU_BAR_MARGIN;
		local bagsWidth = MicroButtonAndBagsBar:GetWidth();
		local contentsWidth = barWidth + bagsWidth;
		if contentsWidth > screenWidth then
			barScale = screenWidth / contentsWidth;
			barWidth = barWidth * barScale;
			bagsWidth = bagsWidth * barScale;
			barMargin = barMargin * barScale;
		end
		MainMenuBar:SetYOffset(60) -- Added
		MainMenuBar:SetScale(barScale);
		MainMenuBar:ClearAllPoints();
		-- if there's no overlap with between action bar and bag bar while it's in the center, use center anchor
		local roomLeft = screenWidth - barWidth - barMargin * 2;
		if roomLeft >= bagsWidth * 2 then
			MainMenuBar:SetPoint("BOTTOM", UIParent, 0, MainMenuBar:GetYOffset());
		else
			local xOffset = 0;
			-- if both bars can fit without overlap, move the action bar to the left
			-- otherwise sacrifice the art for more room
			if roomLeft >= bagsWidth then
				xOffset = roomLeft - bagsWidth + barMargin;
			else
				xOffset = math.max((roomLeft - bagsWidth) / 2 + barMargin, 0);
			end
			MainMenuBar:SetPoint("BOTTOMLEFT", UIParent, xOffset / barScale, MainMenuBar:GetYOffset());
		end
	end

	-- Update Stance bar appearance
	if ( MultiBarBottomLeft:IsShown() ) then
		SlidingActionBarTexture0:Hide();
		SlidingActionBarTexture1:Hide();
		if ( StanceBarFrame ) then
			StanceBarLeft:Hide();
			StanceBarRight:Hide();
			StanceBarMiddle:Hide();
			for i=1, NUM_STANCE_SLOTS do
				_G["StanceButton"..i]:GetNormalTexture():SetWidth(52);
				_G["StanceButton"..i]:GetNormalTexture():SetHeight(52);
			end
		end
	else
		if (PetActionBarFrame_IsAboveStance and PetActionBarFrame_IsAboveStance()) then
			SlidingActionBarTexture0:Hide();
			SlidingActionBarTexture1:Hide();
		else
			SlidingActionBarTexture0:Show();
			SlidingActionBarTexture1:Show();
		end
		if ( StanceBarFrame ) then
			if ( GetNumShapeshiftForms() > 2 ) then
				StanceBarMiddle:Show();
			end
			StanceBarLeft:Show();
			StanceBarRight:Show();
			for i=1, NUM_STANCE_SLOTS do
				_G["StanceButton"..i]:GetNormalTexture():SetWidth(64);
				_G["StanceButton"..i]:GetNormalTexture():SetHeight(64);
			end
		end
	end

	-- HACK: we have too many bars in this game now...
	-- if the Stance bar is shown then hide the multi-cast bar
	-- we'll have to figure out what we should do in this case if it ever really becomes a problem
	-- HACK 2: if the possession bar is shown then hide the multi-cast bar
	-- yeah, way too many bars...
	if ( ( StanceBarFrame and StanceBarFrame:IsShown() ) or
		 ( PossessBarFrame and PossessBarFrame:IsShown() ) ) then
		HideMultiCastActionBar();
	elseif ( HasMultiCastActionBar and HasMultiCastActionBar() ) then
		ShowMultiCastActionBar();
	end

	-- If petactionbar is already shown, set its point in addition to changing its y target
	if ( PetActionBarFrame:IsShown() ) then
		PetActionBar_UpdatePositionValues();
		PetActionBarFrame:SetPoint("TOPLEFT", MainMenuBar, "BOTTOMLEFT", PETACTIONBAR_XPOS, PETACTIONBAR_YPOS);
	end

	-- Set battlefield minimap position
	if ( BattlefieldMapTab and not BattlefieldMapTab:IsUserPlaced() ) then
		BattlefieldMapTab:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMRIGHT", -BATTLEFIELD_MAP_WIDTH-CONTAINER_OFFSET_X, BATTLEFIELD_TAB_OFFSET_Y);
	end

	-- Setup y anchors
	local anchorY = 0
	local buffsAnchorY = min(0, (MINIMAP_BOTTOM_EDGE_EXTENT or 0) - BuffFrame.bottomEdgeExtent);
	-- Count right action bars
	local rightActionBars = 0;
	if ( IsNormalActionBarState() ) then
		if ( SHOW_MULTI_ACTIONBAR_3 ) then
			rightActionBars = 1;
			if ( SHOW_MULTI_ACTIONBAR_4 ) then
				rightActionBars = 2;
			end
		end
	end

	-- BelowMinimap Widgets - need to move below buffs/debuffs if at least 1 right action bar is showing
	if UIWidgetBelowMinimapContainerFrame and UIWidgetBelowMinimapContainerFrame:GetNumWidgetsShowing() > 0 then
		if rightActionBars > 0 then
			anchorY = min(anchorY, buffsAnchorY);
		end

		UIWidgetBelowMinimapContainerFrame:ClearAllPoints();
		UIWidgetBelowMinimapContainerFrame:SetPoint("TOPRIGHT", MinimapCluster, "BOTTOMRIGHT", -CONTAINER_OFFSET_X, anchorY);

		anchorY = anchorY - UIWidgetBelowMinimapContainerFrame:GetHeight() - 4;
	end

	--Setup Vehicle seat indicator offset - needs to move below buffs/debuffs if both right action bars are showing
	if ( VehicleSeatIndicator and VehicleSeatIndicator:IsShown() ) then
		if ( rightActionBars == 2 ) then
			anchorY = min(anchorY, buffsAnchorY);
			VehicleSeatIndicator:SetPoint("TOPRIGHT", MinimapCluster, "BOTTOMRIGHT", -100, anchorY);
		elseif ( rightActionBars == 1 ) then
			VehicleSeatIndicator:SetPoint("TOPRIGHT", MinimapCluster, "BOTTOMRIGHT", -62, anchorY);
		else
			VehicleSeatIndicator:SetPoint("TOPRIGHT", MinimapCluster, "BOTTOMRIGHT", 0, anchorY);
		end
		anchorY = anchorY - VehicleSeatIndicator:GetHeight() - 4;	--The -4 is there to give a small buffer for things like the QuestTimeFrame below the Seat Indicator
	end

	-- Boss frames - need to move below buffs/debuffs if both right action bars are showing
	local numBossFrames = 0;
	for i = 1, MAX_BOSS_FRAMES do
		if ( _G["Boss"..i.."TargetFrame"]:IsShown() ) then
			numBossFrames = i;
		end
	end
	if ( numBossFrames > 0 ) then
		if ( rightActionBars > 1 ) then
			anchorY = min(anchorY, buffsAnchorY);
		end
		Boss1TargetFrame:SetPoint("TOPRIGHT", "MinimapCluster", "BOTTOMRIGHT", -(CONTAINER_OFFSET_X * 1.3) + 60, anchorY * 1.333);	-- by 1.333 because it's 0.75 scale
		anchorY = anchorY - (numBossFrames * (68 + BOSS_FRAME_CASTBAR_HEIGHT) + BOSS_FRAME_CASTBAR_HEIGHT);
	end

	-- Setup durability offset
	if ( DurabilityFrame ) then
		DurabilityFrame:SetPoint("TOPRIGHT", "MinimapCluster", "BOTTOMRIGHT", -CONTAINER_OFFSET_X, anchorY);
		if ( DurabilityFrame:IsShown() ) then
			anchorY = anchorY - DurabilityFrame:GetHeight();
		end
	end

	if ( ArenaEnemyFrames ) then
		ArenaEnemyFrames:ClearAllPoints();
		ArenaEnemyFrames:SetPoint("TOPRIGHT", MinimapCluster, "BOTTOMRIGHT", -CONTAINER_OFFSET_X, anchorY);
	end

	if ( ArenaPrepFrames ) then
		ArenaPrepFrames:ClearAllPoints();
		ArenaPrepFrames:SetPoint("TOPRIGHT", MinimapCluster, "BOTTOMRIGHT", -CONTAINER_OFFSET_X, anchorY);
	end

	-- ObjectiveTracker - needs to move below buffs/debuffs if at least 1 right action bar is showing
	if ( rightActionBars > 0 ) then
		anchorY = min(anchorY, buffsAnchorY);
	end
	if ( ObjectiveTrackerFrame and not ObjectiveTrackerFrame:IsUserPlaced() ) then
		local numArenaOpponents = GetNumArenaOpponents();
		if ( ArenaEnemyFrames and ArenaEnemyFrames:IsShown() and (numArenaOpponents > 0) ) then
			ObjectiveTrackerFrame:ClearAllPoints();
			ObjectiveTrackerFrame:SetPoint("TOPRIGHT", ArenaEnemyFrames_GetBestAnchorUnitFrameForOppponent(numArenaOpponents), "BOTTOMRIGHT", 2, -35);
		elseif ( ArenaPrepFrames and ArenaPrepFrames:IsShown() and (numArenaOpponents > 0) ) then
			ObjectiveTrackerFrame:ClearAllPoints();
			ObjectiveTrackerFrame:SetPoint("TOPRIGHT", ArenaPrepFrames_GetBestAnchorUnitFrameForOppponent(numArenaOpponents), "BOTTOMRIGHT", 2, -35);
		else
			-- We're using Simple Quest Tracking, automagically size and position!
			ObjectiveTrackerFrame:ClearAllPoints();
			-- move up if only the minimap cluster is above, move down a little otherwise
			ObjectiveTrackerFrame:SetPoint("TOPRIGHT", "MinimapCluster", "BOTTOMRIGHT", -OBJTRACKER_OFFSET_X, anchorY);
		end
		ObjectiveTrackerFrame:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", -OBJTRACKER_OFFSET_X, CONTAINER_OFFSET_Y);
	end

	-- Update chat dock since the dock could have moved
	FCF_DockUpdate();
	UpdateContainerFrameAnchors();
end



 hooksecurefunc(MainMenuBar,"SetPositionForStatusBars", function()
      
	   if ( IsPlayerInWorld() ) then
			SweetRev:FramePositionDelegateUIParentManageFramePositions();
		end
    end)
				

function SweetRevUiOptions_OnLoad()
    SweetRevUiOptions:RegisterForDrag("LeftButton");
	SweetRevUiOptions.name = "Sweet Revenge Old";
	
	--#######################################
	-- Set Graphical settings
--SetCVar("portal", "test");
--SetCVar("textLocale", "enUS");
--SetCVar("audioLocale", "enUS");
--SetCVar("agentUID", "wow_ptr_enus");
SetCVar("hwDetect", "0");
SetCVar("videoOptionsVersion", "28");
SetCVar("gxApi", "D3D12");
SetCVar("gxAdapter", "AMD FirePro (TM) W4190M");
SetCVar("gxMaximize", "1");
SetCVar("RAIDgraphicsQuality", "2");
SetCVar("farclip", "10000");
SetCVar("horizonClip", "10000");
SetCVar("horizonStart", "4000");
SetCVar("particleDensity", "50");
SetCVar("particleMTDensity", "70");
SetCVar("waterDetail", "1");
SetCVar("rippleDetail", "0");
SetCVar("reflectionMode", "0");
SetCVar("sunShafts", "1");
SetCVar("groundEffectDensity", "40");
SetCVar("groundEffectDist", "110");
SetCVar("volumeFogLevel", "1");
SetCVar("projectedTextures", "1");
SetCVar("spellClutter", "25");
SetCVar("shadowMode", "1");
SetCVar("SSAO", "1");
SetCVar("textureFilteringMode", "2");
SetCVar("terrainLodDist", "650");
SetCVar("wmoLodDist", "400");
SetCVar("doodadLodScale", "75");
SetCVar("terrainMipLevel", "1");
SetCVar("worldBaseMip", "1");
SetCVar("OutlineEngineMode", "1");
SetCVar("ResampleQuality", "1");
SetCVar("MSAAQuality", "1,0");
SetCVar("lodObjectCullSize", "22");
SetCVar("lodObjectMinSize", "0");
SetCVar("lodObjectFadeScale", "80");
SetCVar("RAIDfarclip", "2000");
SetCVar("RAIDDepthBasedOpacity", "0");
SetCVar("RAIDgroundEffectDist", "55");
SetCVar("RAIDterrainLodDist", "225");
SetCVar("RAIDTerrainLodDiv", "384");
SetCVar("RAIDwmoLodDist", "250");
SetCVar("RAIDhorizonStart", "600");
SetCVar("RAIDhorizonClip", "2000");
SetCVar("RAIDdoodadLodScale", "50");
SetCVar("RAIDentityLodDist", "5");
SetCVar("RAIDterrainMipLevel", "1");
SetCVar("RAIDworldBaseMip", "1");
SetCVar("RAIDprojectedTextures", "1");
SetCVar("RAIDspellClutter", "75");
SetCVar("RAIDreflectionMode", "0");
SetCVar("RAIDrippleDetail", "0");
SetCVar("RAIDparticleDensity", "10");
SetCVar("RAIDparticleMTDensity", "20");
SetCVar("RAIDVolumeFogLevel", "0");
SetCVar("RAIDParticulatesEnabled", "0");
SetCVar("RAIDlodObjectCullSize", "30");
SetCVar("RAIDlodObjectMinSize", "0");
SetCVar("RAIDlodObjectFadeScale", "50");
SetCVar("componentTextureLevel", "1");
SetCVar("RAIDcomponentTextureLevel", "1");
SetCVar("weatherDensity", "1");
SetCVar("RAIDweatherDensity", "0");
SetCVar("graphicsTextureResolution", "2");
SetCVar("graphicsSpellDensity", "4");
SetCVar("graphicsViewDistance", "10");
SetCVar("graphicsEnvironmentDetail", "4");
SetCVar("graphicsGroundClutter", "4");
SetCVar("graphicsShadowQuality", "2");
SetCVar("graphicsLiquidDetail", "2");
SetCVar("graphicsSunshafts", "2");
SetCVar("graphicsParticleDensity", "4");
SetCVar("graphicsSSAO", "2");
SetCVar("graphicsDepthEffects", "2");
SetCVar("graphicsOutlineMode", "2");
SetCVar("raidGraphicsTextureResolution", "2.000000");
SetCVar("raidGraphicsSpellDensity", "2.000000");
SetCVar("raidGraphicsProjectedTextures", "2.000000");
SetCVar("raidGraphicsViewDistance", "2");
SetCVar("raidGraphicsEnvironmentDetail","2");
SetCVar("raidGraphicsGroundClutter","2");
SetCVar("raidGraphicsShadowQuality","1.000000");
SetCVar("raidGraphicsLiquidDetail","1.000000");
SetCVar("raidGraphicsSunshafts","1.000000");
SetCVar("raidGraphicsParticleDensity","2.000000");
SetCVar("raidGraphicsSSAO","1.000000");
SetCVar("raidGraphicsDepthEffects","1.000000");
SetCVar("raidGraphicsOutlineMode","1.000000");
SetCVar("ffxAntiAliasingMode","2");
SetCVar("Brightness","55");
SetCVar("Gamma","1.5");
SetCVar("playIntroMovie","9");
--SetCVar("debugLog0","120220_014858 14:  1 2 3 4 5 7 8 9 10 11");
--SetCVar("debugLog1","120220_014925 Shutdown");
SetCVar("Sound_EnableMusic","0");
--SetCVar("Sound_MusicVolume","0.40000000596046");
--SetCVar("Sound_AmbienceVolume","0.60000002384186");
--SetCVar("KioskCanSessionExpire","1");
--SetCVar("KioskLobbyKickSeconds","30");
--SetCVar("KioskCharacterTemplateSet","0");
	--#######################################
	
	
	----------------------------
	InterfaceOptions_AddCategory(SweetRevUiOptions); --SweetRevUiOptions is a panel
	-- outro modo ---
	-- For more detail about how to add a Panel, please check comments of the source file "InterfaceOptionsFrame.lua"
	local panel = CreateFrame("FRAME", "ExamplePanel");
	panel.name = "Sweet Revenge";
	panel.parent = "Sweet Revenge Old";
	
	-- [[ When the player clicks okay, set the original value to the current setting ]] --
	panel.okay =
		function (self)
			self.originalValue = MY_VARIABLE;
		end

	-- [[ When the player clicks cancel, set the current setting to the original value ]] --
	panel.cancel =
		function (self)
			MY_VARIABLE = self.originalValue;
		end
		
	panel.default =
		function (self)
			MY_VARIABLE = self.originalValue;
		end
--	This method will run when the player clicks "defaults".
--	Use this to revert their changes to your defaults.
--
    panel.refresh =
		function (self)
			MY_VARIABLE = self.originalValue;
		end	
--  This method will run when the Interface Options frame calls its OnShow function and after defaults
--  have been applied via the panel.default method described above.
--  Use this to refresh your panel's UI in case settings were changed without player interaction.

-- [[ Add the panel to the Interface Options ]] --
	InterfaceOptions_AddCategory(panel);

--			InterfaceOptions_AddCategory(panel);
	print("Sweet Revenge - Addon Loaded!")

    -- Action Bars Change Positions
   -- SetPointBlizzOverride("MainMenuBar");
 
end
    
-- Close the main frame.
function SweetRevUiOptions_Close()
    SweetRevUiOptions:Hide();
    isOptionsVisible = false;
end

-- Ask_Invoke is called when the user types "/sweetrev" or "/sweetrevenge"
function SweetRevUiOptions_Invoke()
    SweetRevUiOptions:Show();
    isOptionsVisible = true;
end

 
SLASH_SWEETREV1 = "/sweetrev";
SLASH_SWEETREV2 = "/sweetrevenge";
-- SweetRevUiOptions_Invoke as function reference (without parentices)
SlashCmdList["SWEETREV"] = SweetRevUiOptions_Invoke;

function SweetRev_SlashCmdHandler( msg )
  DEFAULT_CHAT_FRAME:AddMessage( "Command: " .. msg ); -- Output the message to the default chat window
  SweetRevUiOptions:Show();
  isOptionsVisible = true;  
 end
SlashCmdList["SWEETREV"] = SweetRev_SlashCmdHandler;



SetCVar("autoLootDefault",1);
--findYourselfMode - Highlight your character. 0 = circle, 1 = circle & outline, 2 = outline

SetCVar("RaidOutlineEngineMode",1)
--[[	
_G["MainMenuBar"]:SetScript("OnEvent", 
	function(__, event, ...)
		if (event == "PLAYER_ENTERING_WORLD") then
			_G["MainMenuBar"]:UnregisterEvent("PLAYER_ENTERING_WORLD");
        
			_G["MainMenuBar"]:SetMovable(true)
			_G["MainMenuBar"]:SetUserPlaced(true);
			_G["MainMenuBar"]:SetMovable(false)
			_G["MainMenuBar"].ignoreFramePositionManager = true;
		end
	end)
;]]--


