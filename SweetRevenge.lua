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
		
        _G["MainMenuBar"]:ClearAllPoints(); 
        _G["MainMenuBar"]:SetPoint("BOTTOM",UIParent,"BOTTOM",0,44); 
		_G["MainMenuBar"]:SetScale(0.9);
        _G["MainMenuBar"].ignoreFramePositionManager = true;
		
		
        -- /run MainMenuBar:ClearAllPoints(); MainMenuBar:SetPoint("BOTTOM",UIParent,"BOTTOM",0,55); 
        
       --* MainMenuBarPageNumber:ClearAllPoints();
       --* MainMenuBarPageNumber:SetPoint("RIGHT",MainMenuBar, "LEFT",-6,-5);

        --/run MainMenuBarPageNumber:ClearAllPoints();MainMenuBarPageNumber:SetPoint("RIGHT",MainMenuBar, "LEFT",-6,-5);
      --* ActionBarUpButton:ClearAllPoints();
      --* ActionBarUpButton:SetPoint("BOTTOM",MainMenuBarPageNumber, "TOP",0,-9);
        --/run ActionBarUpButton:ClearAllPoints();ActionBarUpButton:SetPoint("BOTTOM",MainMenuBarPageNumber, "TOP",0,-9);
      --* ActionBarDownButton:ClearAllPoints();
      --* ActionBarDownButton:SetPoint("TOP",MainMenuBarPageNumber, "BOTTOM",0,8);
        --/run ActionBarDownButton:ClearAllPoints();ActionBarDownButton:SetPoint("TOP",MainMenuBarPageNumber, "BOTTOM",0,8);

        
    elseif bar ==  'MultiBarBottomLeft' then
        MultiBarBottomLeft:ClearAllPoints(); 
        MultiBarBottomLeft:SetPoint("TOPLEFT",MainMenuBar,"BOTTOMLEFT",0,-6);
            
    elseif  bar ==  'MultiBarLeft' then 
        _G["MultiBarLeft"]:SetWidth(500); 
        _G["MultiBarLeft"]:SetHeight(38);
        _G["MultiBarLeft"]:ClearAllPoints(); 
       --* _G["MultiBarLeft"]:SetPoint("BOTTOMRIGHT",UIParent,"BOTTOM",-6, 0);
		_G["MultiBarLeft"]:SetPoint("TOPLEFT",MainMenuBar,"BOTTOMLEFT");
        
		MultiBarLeftButton1:ClearAllPoints(); 
        MultiBarLeftButton1:SetPoint("LEFT", MultiBarLeft, "LEFT", 5, -4);
        
        for i = 2, 12 do 
            local n = "MultiBarLeftButton" 
            local btn = _G[n..i]
            btn:ClearAllPoints()
            btn:SetPoint("LEFT", n..i - 1, "RIGHT", 2, 0)
        end 

        _G["MultiBarLeft"].ignoreFramePositionManager = true;

    elseif  bar ==  'MultiBarRight' then 

        _G["MultiBarRight"]:SetWidth(500); 
        _G["MultiBarRight"]:SetHeight(38);
        _G["MultiBarRight"]:ClearAllPoints(); 
       --*  _G["MultiBarRight"]:SetPoint("TOPLEFT",MainMenuBar,"BOTTOMRIGHT");
		_G["MultiBarRight"]:SetPoint("TOP",MainMenuBar,"BOTTOMRIGHT",-15,0);

        MultiBarRightButton1:ClearAllPoints(); 
        MultiBarRightButton1:SetPoint("LEFT", MultiBarRight, "LEFT", 5, -4);

        for i = 2, 12 do 
            local n = "MultiBarRightButton" 
            local btn = _G[n..i]
            btn:ClearAllPoints()
            btn:SetPoint("LEFT", n..i - 1, "RIGHT", 2, 0)
        end 

        _G["MultiBarRight"].ignoreFramePositionManager = true;

    elseif bar == 'ChatFrame1EditBox' then
        _G["ChatFrame1EditBox"]:ClearAllPoints();
        _G["ChatFrame1EditBox"]:SetPoint("TOPLEFT",ChatFrame1,"TOPLEFT",0,0); 
        _G["ChatFrame1EditBox"]:SetPoint("TOPRIGHT",ChatFrame1,"TOPRIGHT",0,0);

    elseif bar == 'PlayerFrame' then
        _G["PlayerFrame"]:SetScale(0.9);
        _G["PlayerFrame"]:ClearAllPoints();  
        -- _G["PlayerFrame"]:SetPoint("RIGHT",UIParent,"CENTER",-86,-134);
        _G["PlayerFrame"]:SetPoint("RIGHT",UIParent,"CENTER",-184,-90);

    elseif bar == 'PetFrame' then
        _G["PetFrame"]:ClearAllPoints();  
        _G["PetFrame"]:SetPoint("BOTTOMLEFT",PlayerFrame,"BOTTOMRIGHT",70,0);
		--_G["PetFrame"]:SetPoint("CENTER",UIParent,"CENTER",-50,-112); 
        --    --/run _G["PetFrame"]:ClearAllPoints();  _G["PetFrame"]:SetPoint("CENTER",UIParent,"CENTER",-50,-100);
        --_G["PetFrame"]:SetUserPlaced(true);

    elseif bar == 'TargetFrame' then
        _G["TargetFrame"]:SetScale(0.9);
        _G["TargetFrame"]:ClearAllPoints();  
        -- _G["TargetFrame"]:SetPoint("LEFT",UIParent,"CENTER",86,-134);
        _G["TargetFrame"]:SetPoint("LEFT",PlayerFrame,"RIGHT",368,0);

        TARGET_FRAME_BUFFS_ON_TOP = true; 
        TargetFrame_UpdateBuffsOnTop();
        
        _G["TargetFrame"]:SetUserPlaced(true);

    elseif bar == 'TargetFrameToT' then
        --G["TargetFrameToT"]:SetScale(0.9);
        _G["TargetFrameToT"]:ClearAllPoints();  
        -- _G["TargetFrame"]:SetPoint("LEFT",UIParent,"CENTER",86,-134);
        _G["TargetFrameToT"]:SetPoint("BOTTOMRIGHT",TargetFrame,"BOTTOMLEFT",0,0);
        
        -- /run _G["TargetFrameToT"]:SetScale(0.9); _G["TargetFrameToT"]:ClearAllPoints();  _G["TargetFrameToT"]:SetPoint("BOTTOMRIGHT",TargetFrame,"BOTTOMLEFT",0,0);

        _G["TargetFrameToT"]:SetUserPlaced(true);

    elseif bar == 'FocusFrame' then
        _G["FocusFrame"]:SetScale(0.7);
        _G["FocusFrame"]:ClearAllPoints();  
        _G["FocusFrame"]:SetPoint("TOPRIGHT",TargetFrame,"BOTTOMRIGHT",40,46);
        
        --/run  _G["FocusFrame"]:SetScale(0.7); _G["FocusFrame"]:ClearAllPoints();    _G["FocusFrame"]:SetPoint("CENTER",TargetFrame,"BOTTOM",20,-50); 
        --/run  _G["FocusFrame"]:SetScale(0.9); _G["FocusFrame"]:ClearAllPoints();    _G["FocusFrame"]:SetPoint("BOTTORIGHT",TargetFrame,"TOPRIGHT",0,0); 

        _G["FocusFrame"]:SetUserPlaced(true);

    elseif bar == 'ExtraActionBarFrame' then
        _G["ExtraActionBarFrame"]:ClearAllPoints();  
        _G["ExtraActionBarFrame"]:SetPoint("BOTTOM",UIParent,"BOTTOM",0,163);
        _G["ExtraActionBarFrame"].ignoreFramePositionManager = true;
        --/run ExtraActionBarFrame:ClearAllPoints(); _G["ExtraActionBarFrame"]:SetPoint("BOTTOM",UIParent,"BOTTOM",0,163);

    elseif bar == 'CastingBarFrame' then
        -- _G["CastingBarFrame"]:SetScale(0.8);
        _G["CastingBarFrame"]:ClearAllPoints();  
        _G["CastingBarFrame"]:SetPoint("BOTTOM",UIParent,"BOTTOM",0,204);
        _G["CastingBarFrame"].ignoreFramePositionManager = true;
        --/run CastingBarFrame:SetScale(0.7); CastingBarFrame:ClearAllPoints(); CastingBarFrame:SetPoint("BOTTOM",UIParent,"BOTTOM",0,204); 

    elseif bar == 'ZoneAbilityFrame' then
        _G["ZoneAbilityFrame"]:ClearAllPoints();  
        _G["ZoneAbilityFrame"]:SetPoint("BOTOM",UIParent,"BOTTOM",0,264);
        _G["ZoneAbilityFrame"]:SetUserPlaced(true);
        _G["ZoneAbilityFrame"].ignoreFramePositionManager = true;
        --/run ZoneAbilityFrame:ClearAllPoints(); ZoneAbilityFrame:SetPoint("BOTOM",UIParent,"BOTTOM",0,264);

        --/run PetFrame:ClearAllPoints(); PetFrame:SetPoint("RIGHT",NamePlate1UnitFrame,"LEFT",0,0); 
        --/run TargetFrame:ClearAllPoints(); TargetFrame:SetPoint("LEFT",NamePlate1UnitFrame,"RIGHT",0,0); 
        --/run FocusFrame:ClearAllPoints(); FocusFrame:SetPoint("TOP",NamePlate1UnitFrame,"BOTTOM",0,0); 

        -- Estava a testar (apagar) -- UIPARENT_MANAGED_FRAME_POSITIONS["MultiBarRight"] = {baseY = true, watchBar = 1, anchorTo = "MultiBarRight", point = "LEFT", rpoint = "RIGHT"};

    elseif  bar == 'TimeManagerClockButton' then

        _G["TimeManagerClockButton"]:ClearAllPoints();
        _G["TimeManagerClockButton"]:SetPoint("RIGHT",MiniMapWorldMapButton,"LEFT",12,0);

        _G["TimeManagerFrame"]:ClearAllPoints();
        _G["TimeManagerFrame"]:SetPoint("BOTTOMRIGHT",TimeManagerClockButton,"TOPRIGHT",-16, 6);

        _G["StopwatchFrame"]:ClearAllPoints();
        _G["StopwatchFrame"]:SetPoint("TOP",UIParent,"TOP",0, 0);

    elseif  bar ==  'MainMenuBarBackpackButton' then    
        
		--[[ local bagscale = 0.5;
        MainMenuBarBackpackButton:SetScale(bagscale);
        MainMenuBarBackpackButton:ClearAllPoints(); 
        MainMenuBarBackpackButton:SetPoint("BOTTOMRIGHT",TimeManagerClockButton,"TOPRIGHT",0, 6);
        CharacterBag0Slot:SetScale(bagscale);
        CharacterBag0Slot:ClearAllPoints(); 
        CharacterBag0Slot:SetPoint("BOTTOM",MainMenuBarBackpackButton,"TOP",0, 2);
        CharacterBag1Slot:SetScale(bagscale);
        CharacterBag1Slot:ClearAllPoints();
        CharacterBag1Slot:SetPoint("BOTTOM", CharacterBag0Slot, "TOP", 0, 2);
        CharacterBag2Slot:SetScale(bagscale);
        CharacterBag2Slot:ClearAllPoints();
        CharacterBag2Slot:SetPoint("BOTTOM", CharacterBag1Slot, "TOP", 0, 2);
        CharacterBag3Slot:SetScale(bagscale);
        CharacterBag3Slot:ClearAllPoints();
        CharacterBag3Slot:SetPoint("BOTTOM", CharacterBag2Slot, "TOP", 0, 2);
		]]--RG-- OLD VERSION .. Now is obsolete
		
	    local bagscale = 0.5;
		MicroButtonAndBagsBar:SetScale(bagscale);
		
		MicroButtonAndBagsBar.MicroBagBar:ClearAllPoints();
		MicroButtonAndBagsBar.MicroBagBar:SetPoint("TOPRIGHT",CharacterMicroButton,"TOPLEFT",-4,20);

		MainMenuBarBackpackButton:ClearAllPoints();
		MainMenuBarBackpackButton:SetPoint("TOPRIGHT",MicroButtonAndBagsBar.MicroBagBar,"TOPRIGHT",-4,-4);
		
        --CharacterBag1Slot:SetScale(bagscale);
        --CharacterBag1Slot:ClearAllPoints(); 
        --CharacterBag1Slot:SetPoint("BOTTOM",CharacterBag0Slot,"TOP",0, 2);
        --CharacterBag2Slot:SetScale(bagscale);
        --CharacterBag2Slot:ClearAllPoints(); 
        --CharacterBag2Slot:SetPoint("BOTTOM",CharacterBag1Slot,"TOP",0, 2);
        --CharacterBag3Slot:SetScale(bagscale);
        --CharacterBag3Slot:ClearAllPoints(); 
        --CharacterBag3Slot:SetPoint("BOTTOM",CharacterBag2Slot,"TOP",0, 2);

        --/run MainMenuBarBackpackButton:ClearAllPoints();MainMenuBarBackpackButton:SetPoint("RIGHT",CharacterMicroButton,"LEFT",-6, -10); CharacterBag0Slot:ClearAllPoints();

        --/run MainMenuBarBackpackButton:ClearAllPoints();MainMenuBarBackpackButton:SetPoint("RIGHT",MainMenuMicroButton,"LEFT",-6, -10);
        
    elseif  bar ==  'CharacterMicroButton' then  
        local microBtnScale = 0.5; 

        --[[ CharacterMicroButton:SetScale(microBtnScale);
        CharacterMicroButton:ClearAllPoints(); 
        CharacterMicroButton:SetPoint("BOTTOMRIGHT",TimeManagerClockButton,"BOTTOMLEFT",-250,0);

        --CharacterMicroButton:ClearAllPoints(); 
        --CharacterMicroButton:SetPoint("BOTTOMLEFT",MainMenuBarBackpackButton,"BOTTOMRIGHT",6,0);
        MainMenuMicroButton:SetScale(microBtnScale);
        --MainMenuMicroButton:ClearAllPoints(); 
        --MainMenuMicroButton:SetPoint("BOTTOMRIGHT",MainMenuBarBackpackButton,"BOTTOMLEFT",-200,0);

        StoreMicroButton:SetScale(microBtnScale);
        --StoreMicroButton:ClearAllPoints(); 
        --StoreMicroButton:SetPoint("RIGHT",MainMenuMicroButton,"LEFT",2,0);

        EJMicroButton:SetScale(microBtnScale);
        --EJMicroButton:ClearAllPoints(); 
        --EJMicroButton:SetPoint("RIGHT",StoreMicroButton,"LEFT",2,0);

        CollectionsMicroButton:SetScale(microBtnScale);
        --CollectionsMicroButton:ClearAllPoints(); 
        --CollectionsMicroButton:SetPoint("RIGHT",EJMicroButton,"LEFT",2,0);
        
        LFDMicroButton:SetScale(microBtnScale);
        --LFDMicroButton:ClearAllPoints(); 
        --LFDMicroButton:SetPoint("RIGHT",CollectionsMicroButton,"LEFT",2,0);

        GuildMicroButton:SetScale(microBtnScale);
        --GuildMicroButton:ClearAllPoints(); 
        --GuildMicroButton:SetPoint("RIGHT",LFDMicroButton,"LEFT",2,0);
        
        QuestLogMicroButton:SetScale(microBtnScale);
        --QuestLogMicroButton:ClearAllPoints(); 
        --QuestLogMicroButton:SetPoint("RIGHT",GuildMicroButton,"LEFT",2,0);

        AchievementMicroButton:SetScale(microBtnScale);
        --AchievementMicroButton:ClearAllPoints(); 
        --AchievementMicroButton:SetPoint("RIGHT",QuestLogMicroButton,"LEFT",2,0);

        TalentMicroButton:SetScale(microBtnScale);
        --TalentMicroButton:ClearAllPoints(); 
        --TalentMicroButton:SetPoint("RIGHT",AchievementMicroButton,"LEFT",2,0);

        SpellbookMicroButton:SetScale(microBtnScale);
        --SpellbookMicroButton:ClearAllPoints(); 
        --SpellbookMicroButton:SetPoint("RIGHT",TalentMicroButton,"LEFT",2,0);

        CharacterMicroButton:SetScale(microBtnScale);
        -- CharacterMicroButton:ClearAllPoints(); 
        -- CharacterMicroButton:SetPoint("RIGHT",SpellbookMicroButton,"LEFT",2,0);
		
		]]--RG-- OLD VERSION .. Now is obsolete		
		
		--* MicroButtonAndBagsBar:SetScale(microBtnScale)
		MainMenuMicroButton:SetScale(microBtnScale);
		StoreMicroButton:SetScale(microBtnScale);
		EJMicroButton:SetScale(microBtnScale);
		CollectionsMicroButton:SetScale(microBtnScale);
		LFDMicroButton:SetScale(microBtnScale);
		GuildMicroButton:SetScale(microBtnScale);
		QuestLogMicroButton:SetScale(microBtnScale);
		AchievementMicroButton:SetScale(microBtnScale);
		TalentMicroButton:SetScale(microBtnScale);
		SpellbookMicroButton:SetScale(microBtnScale);
		CharacterMicroButton:SetScale(microBtnScale);
        --/run CharacterMicroButton:ClearAllPoints();CharacterMicroButton:SetPoint("BOTTOMLEFT",MultiBarRightButton12,"BOTTOMRIGHT",60,0);

		--[[
        MainMenuMicroButton:ClearAllPoints();
        MainMenuMicroButton:SetPoint("BOTTOMRIGHT",StoreMicroButton,"TOPRIGHT",0,-20)
		]]--RG-- OLD VERSION .. Now is obsolete		
		--* MicroButtonAndBagsBar.MicroBagBar:ClearAllPoints();
		--* MicroButtonAndBagsBar.MicroBagBar:SetPoint("TOPRIGHT",CharacterMicroButton,"TOPLEFT",-4,20);
         
        elseif  bar ==  'StanceBarFrame' then 
        StanceBarFrame:ClearAllPoints(); 
        StanceBarFrame:SetPoint("BOTTOMLEFT",MainMenuBar,"TOPLEFT",30, 6); 

        elseif  bar ==  'PetActionBarFrame' then  
        PetActionBarFrame:ClearAllPoints(); 
        PetActionBarFrame:SetPoint("RIGHT",MainMenuBar,"RIGHT",6, 0);  
        
        elseif  bar == 'ArtifactWatchBar.StatusBar' then
        ArtifactWatchBar.StatusBar:ClearAllPoints(); 
        ArtifactWatchBar.StatusBar:SetPoint("TOP",UIParent,"TOP",0,0); 
        elseif  bar == 'ReputationWatchBar.StatusBar' then
        ReputationWatchBar.StatusBar:ClearAllPoints(); 
        ReputationWatchBar.StatusBar:SetPoint("TOP",UIParent,"TOP",0,-6);   


    elseif  bar ==  'MinimapCluster' then
        
        MinimapBackdrop:ClearAllPoints();
        MinimapBackdrop:SetPoint("RIGHT",MainMenuBar,"LEFT",-38, -18);
        --MinimapBorder:Hide();

		--[[
        local bordersize = 5;
        Minimap:SetMaskTexture('Interface\\Buttons\\WHITE8x8');
        Minimap:SetBackdrop({bgFile = 'Interface\\Buttons\\WHITE8x8',
                            edgeFile = 'Interface\\Buttons\\WHITE8x8',
                            edgeSize = bordersize,
                            insets = {left = bordersize
                                     , right = bordersize
                                    ,top = bordersize
                                    , bottom = bordersize}}); 
        ]]
		--/run MinimapBackdrop:ClearAllPoints();MinimapBackdrop:SetPoint("RIGHT",MainMenuBar,"LEFT",0, 0);
        Minimap:ClearAllPoints();
        Minimap:SetPoint("TOP",MinimapBackdrop,"TOP",8, -2); 
        -- Minimap:SetBackdropBorderColor(0, 0, 0, .7);
        
        --Minimap buttons
        MinimapZoomOut:ClearAllPoints();
        --MinimapZoomOut:SetPoint("BOTTOMRIGHT",Minimap,"BOTTOMLEFT",0, 0);
		MinimapZoomOut:SetPoint("BOTTOMLEFT",MinimapBorderTop,"BOTTOMRIGHT",-2, 4);
        MinimapZoomIn:ClearAllPoints();
        MinimapZoomIn:SetPoint("BOTTOM",MinimapZoomOut,"TOP",0, 0); 

        MiniMapTracking:ClearAllPoints();
        -- MiniMapTracking:SetPoint("TOPRIGHT",Minimap,"TOPLEFT",0,0);
		MiniMapTracking:SetPoint("BOTTOMLEFT",MinimapBorderTop,"TOPLEFT",20,-2); 
        --        /run MiniMapTracking:ClearAllPoints();MiniMapTracking:SetPoint("BOTTOMLEFT",UIParent,"BOTTOMLEFT",0,0);
	--[[		
		if (IsAddOnLoaded("MinimapButtonBag")) then -- test if MBB addon is loaded https://www.curseforge.com/wow/addons/mbb 
			
			MBB_DefaultOptions = {
				["ButtonPos"] = {0, 0},
				["AttachToMinimap"] = 1,
				["DetachedButtonPos"] = "CENTER",
				["CollapseTimeout"] = 1,
				["ExpandDirection"] = 2,
				["MaxButtonsPerLine"] = 5,
				["AltExpandDirection"] = 2
			};
			
			MBB_Options = MBB_DefaultOptions;
			MBB_ResetButtonPosition();
		
		if( MBB_Options.AttachToMinimap == 1 ) then
				MBB_Options.AttachToMinimap = 0;
							MBB_Options.ButtonPos = {0, 0};	--{(xpos/scale)-10, (ypos/scale)-10};
				MBB_Options.DetachedButtonPos = MBB_DefaultOptions.DetachedButtonPos;
				
				MBB_MinimapButtonFrame:ClearAllPoints();
				MBB_MinimapButtonFrame:SetPoint(MBB_Options.DetachedButtonPos, UIParent, MBB_Options.DetachedButtonPos, MBB_Options.ButtonPos[1], MBB_Options.ButtonPos[2]);
			else
				MBB_MinimapButtonFrame:ClearAllPoints();
				MBB_MinimapButtonFrame:SetPoint("BOTTOMLEFT",MiniMapTracking,"TOPLEFT"); 
			end
			
		end 
			]]
		
        --/run Minimap:ClearAllPoints();Minimap:SetPoint("TOP",MinimapBackdrop,"TOP",8, -2); 
        MinimapBorderTop:ClearAllPoints();
		MinimapBorderTop:SetPoint("BOTTOMLEFT",UIParent,"BOTTOMLEFT",-20, -8); 
		
		MiniMapWorldMapButton:ClearAllPoints();
		MiniMapWorldMapButton:SetPoint("BOTTOMRIGHT",MinimapBorderTop,"TOPRIGHT",0,-6); 
		
		MinimapZoneTextButton:ClearAllPoints();
		MinimapZoneTextButton:SetPoint("CENTER",MinimapBorderTop,"CENTER",0,4);
		
        --/run MiniMapWorldMapButton:ClearAllPoints();MiniMapWorldMapButton:SetPoint("TOPRIGHT",MinimapBorderTop,"TOPRIGHT",0, 2); 

        QueueStatusMinimapButton:ClearAllPoints();
        --QueueStatusMinimapButton:SetPoint("TOPLEFT",Minimap,"TOPRIGHT",0, 0);
        QueueStatusMinimapButton:SetPoint("BOTTOM",MiniMapTracking,"TOP"); 
		
		QueueStatusFrame:ClearAllPoints();
		QueueStatusFrame:SetPoint("BOTTOMLEFT",QueueStatusMinimapButton,"TOPRIGHT",0, 0);
		
		--/run QueueStatusMinimapButton:ClearAllPoints();QueueStatusMinimapButton:SetPoint("LEFT",GuildInstanceDifficulty,"RIGHT",4, 0);
        MiniMapMailFrame:ClearAllPoints();
        --MiniMapMailFrame:SetPoint("LEFT",MiniMapTracking,"RIGHT",0, 0);
        MiniMapMailFrame:SetPoint("TOPLEFT",Minimap,"TOPRIGHT",0, 0);
		--/run MiniMapMailFrame:ClearAllPoints();MiniMapMailFrame:SetPoint("LEFT",QueueStatusMinimapButton,"RIGHT",0, 0);
		
        GameTimeFrame:SetScale(0.8);GameTimeFrame:ClearAllPoints();
        --GameTimeFrame:SetPoint("BOTTOMLEFT",Minimap,"BOTTOMRIGHT",0, 0); 
		GameTimeFrame:SetPoint("RIGHT",TimeManagerClockButton,"LEFT",12, 4); 
        --        /run GameTimeFrame:SetScale(0.8);GameTimeFrame:ClearAllPoints();GameTimeFrame:SetPoint("LEFT",GarrisonLandingPageMinimapButton,"RIGHT",-2, 0); 
        GarrisonLandingPageMinimapButton:SetScale(0.70);
        GarrisonLandingPageMinimapButton:ClearAllPoints();
        GarrisonLandingPageMinimapButton:SetScale(0.70);GarrisonLandingPageMinimapButton:ClearAllPoints();GarrisonLandingPageMinimapButton:SetPoint("BOTTOM",GameTimeFrame,"TOP",0, 0);
        --        /run GarrisonLandingPageMinimapButton:SetScale(0.70);GarrisonLandingPageMinimapButton:ClearAllPoints();GarrisonLandingPageMinimapButton:SetPoint("LEFT",MiniMapMailFrame,"RIGHT",-8, 0);
      
        
        MiniMapInstanceDifficulty:ClearAllPoints();
        MiniMapInstanceDifficulty:SetPoint("TOPLEFT",ChatFrame1, "BOTTOMLEFT",0,0);
        --/run MiniMapInstanceDifficulty:ClearAllPoints();MiniMapInstanceDifficulty:SetPoint("TOPLEFT",ChatFrame1, "BOTTOMLEFT",0,0);
        GuildInstanceDifficulty:ClearAllPoints();
        GuildInstanceDifficulty:SetPoint("TOPLEFT",ChatFrame1, "BOTTOMLEFT",0,0);
        --/run GuildInstanceDifficulty:ClearAllPoints();GuildInstanceDifficulty:SetPoint("TOPLEFT",ChatFrame1, "BOTTOMLEFT",0,0);
        MiniMapChallengeMode:ClearAllPoints();
        MiniMapChallengeMode:SetPoint("TOPLEFT",ChatFrame1, "BOTTOMLEFT",4,-6);
        --/run MiniMapChallengeMode:ClearAllPoints();MiniMapChallengeMode:SetPoint("TOPLEFT",ChatFrame1, "BOTTOMLEFT",4,-6);


        Minimap:EnableMouseWheel(true)
        Minimap:SetScript('OnMouseWheel', function(self, delta)
            if delta > 0 then
                Minimap_ZoomIn()
            else
                Minimap_ZoomOut()
            end
        end)

    elseif  bar ==  'DurabilityFrame' then
        _G["DurabilityFrame"]:SetScale(0.9);
        _G["DurabilityFrame"]:ClearAllPoints();
        _G["DurabilityFrame"]:SetPoint("BOTTOMLEFT",UIParent,"BOTTOMLEFT",0, 0); 
        --        /run DurabilityFrame:SetScale(0.9);DurabilityFrame:ClearAllPoints();DurabilityFrame:SetPoint("TOPRIGHT",GameTimeFrame,"BOTTOMRIGHT",0, 0); 
        --_G["DurabilityFrame"]:SetUserPlaced(true);
        _G["DurabilityFrame"].ignoreFramePositionManager = true;

  --[[  
	elseif  bar ==  'ObjectiveTrackerFrame' then          
        _G["ObjectiveTrackerFrame"]:ClearAllPoints();
        _G["ObjectiveTrackerFrame"]:SetPoint("TOPRIGHT",MinimapCluster,"BOTTOMRIGHT",-6, 0); 
        --        /run ObjectiveTrackerFrame:ClearAllPoints();ObjectiveTrackerFrame:SetPoint("TOPRIGHT",MinimapCluster,"BOTTOMRIGHT",0, 0); 
        --_G["ObjectiveTrackerFrame"]:SetUserPlaced(true);
        _G["ObjectiveTrackerFrame"].ignoreFramePositionManager = true;

]]


--[[  ------------- NOT NEEDED, Because now we do this on event "PLAYER_ENTERING_WORLD" (after Blizzard_BattlefieldMap addon is loaded)
    elseif  bar ==  'BattlefieldMapFrame' then
        local defaultOptions = {
			opacity = 1,
			locked = true,
			showPlayers = true,
		};
		
		_G.BattlefieldMapOptions = defaultOptions;
		
		--_G["BattlefieldMapFrame"]:SetScale(1.28);
		
		--local alpha = 1.0 - BattlefieldMapOptions.opacity;
		--BattlefieldMapMixin:SetGlobalAlpha(alpha);
		--_G["BattlefieldMapMixin"].BorderFrame:SetAlpha(alpha);
	
		--_G["BattlefieldMapMixin"]:RefreshAlpha();
		--_G["BattlefieldMapFrame"]:SetScale(1.28); 
		
		]]--
		--[[
        _G["BattlefieldMinimap"]:SetScale(1.2); 
        _G["BattlefieldMinimap"]:ClearAllPoints();
        _G["BattlefieldMinimap"]:SetPoint("BOTTOMRIGHT",MainMenuBarBackpackButton,"BOTTOMLEFT",-2,0);
        --/run BattlefieldMinimap:SetScale(1.2); BattlefieldMinimap:ClearAllPoints();BattlefieldMinimap:SetPoint("BOTTOMRIGHT",MainMenuBarBackpackButton,"BOTTOMLEFT",-2,0);
        _G["BattlefieldMapFrame"]:SetScale(1.2); 
        _G["BattlefieldMapFrame"]:ClearAllPoints();
        _G["BattlefieldMapFrame"]:SetPoint("BOTTOMLEFT",BattlefieldMinimap,"TOPLEFT",0,5);
        --/run BattlefieldMapFrame:SetScale(1.2); BattlefieldMapFrame:ClearAllPoints();BattlefieldMapFrame:SetPoint("BOTTOMLEFT",BattlefieldMinimap,"TOPLEFT",0,5);
        BattlefieldMinimap_UpdateOpacity(0.4);
        --/run BattlefieldMinimap_UpdateOpacity(0.4);
        
        BattlefieldMapFrame:SetUserPlaced(true);
        --/run BattlefieldMapFrame:SetUserPlaced(true);

        --BattlefieldMinimapUnitPositionFrame:SetScale(1.5);
        --/run BattlefieldMinimapUnitPositionFrame:SetScale(1.5)
		]]-- Old code

    elseif  bar ==  'GameTooltip' then
       GameTooltip:ClearAllPoints();
       GameTooltip:SetPoint("RIGHT",BattlefieldMapFrame, "RIGHT",0,4);
       GameTooltip:SetPoint("BOTTOM",BattlefieldMapFrame, "TOP",0,4);
       --GameTooltip:SetUserPlaced(true);
       GameTooltip.ignoreFramePositionManager = true;

    --/run GameTooltip:ClearAllPoints();GameTooltip:SetPoint("RIGHT",BattlefieldMinimap, "RIGHT",0,0);GameTooltip:SetPoint("BOTTOM",BattlefieldMapFrame, "TOP",0,0);
--
	
	--[[
    elseif  bar ==  'ContainerFrame1' then
           ContainerFrame1:SetScale(containerScale); 
           ContainerFrame1:ClearAllPoints();
           ContainerFrame1:SetPoint("BOTTOMRIGHT",UIParent,"BOTTOMRIGHT",-2,280);
           ContainerFrame1:SetUserPlaced(true);
    elseif  bar ==  'ContainerFrame2' then
           ContainerFrame2:SetScale(containerScale); 
           ContainerFrame2:ClearAllPoints();
           ContainerFrame2:SetPoint("BOTTOMRIGHT",ContainerFrame1,"TOPRIGHT",-2,0);
           ContainerFrame2:SetUserPlaced(true);
    elseif  bar ==  'ContainerFrame3' then
        ContainerFrame3:SetScale(containerScale); 
        ContainerFrame3:ClearAllPoints();
        ContainerFrame3:SetPoint("BOTTOMRIGHT",ContainerFrame1,"BOTTOMLEFT",-2,0);
        ContainerFrame3:SetUserPlaced(true);
    elseif  bar ==  'ContainerFrame4' then
        ContainerFrame4:SetScale(containerScale); 
        ContainerFrame4:ClearAllPoints();
        ContainerFrame4:SetPoint("BOTTOMRIGHT",ContainerFrame3,"TOPRIGHT",-2,0);
        ContainerFrame4:SetUserPlaced(true);
    elseif  bar ==  'ContainerFrame5' then
        ContainerFrame5:SetScale(containerScale); 
        ContainerFrame5:ClearAllPoints();
        ContainerFrame5:SetPoint("BOTTOMRIGHT",ContainerFrame3,"BOTTOMLEFT",-2,0);
        ContainerFrame5:SetUserPlaced(true);
    elseif  bar ==  'ContainerFrame6' then
        ContainerFrame6:SetScale(containerScale); 
        ContainerFrame6:ClearAllPoints();
        ContainerFrame6:SetPoint("BOTTOMRIGHT",ContainerFrame5,"TOPRIGHT",-2,0);   
        ContainerFrame6:SetUserPlaced(true);
    elseif  bar ==  'ContainerFrame7' then
        ContainerFrame7:SetScale(containerScale); 
        ContainerFrame7:ClearAllPoints();
        ContainerFrame7:SetPoint("BOTTOMRIGHT",ContainerFrame5,"BOTTOMLEFT",-2,0);
        ContainerFrame7:SetUserPlaced(true);
    elseif  bar ==  'ContainerFrame8' then
        ContainerFrame8:SetScale(containerScale); 
        ContainerFrame8:ClearAllPoints();
        ContainerFrame8:SetPoint("BOTTOMRIGHT",ContainerFrame7,"TOPRIGHT",-2,0);
        ContainerFrame8:SetUserPlaced(true);
    elseif  bar ==  'ContainerFrame9' then
        ContainerFrame9:SetScale(containerScale); 
        ContainerFrame9:ClearAllPoints();
        ContainerFrame9:SetPoint("BOTTOMRIGHT",ContainerFrame7,"BOTTOMLEFT",-2,0);
        ContainerFrame9:SetUserPlaced(true);
    elseif  bar ==  'ContainerFrame10' then
        ContainerFrame10:SetScale(containerScale); 
        ContainerFrame10:ClearAllPoints();
        ContainerFrame10:SetPoint("BOTTOMRIGHT",ContainerFrame9,"TOPRIGHT",-2,0);
        ContainerFrame10:SetUserPlaced(true);
    elseif  bar ==  'ContainerFrame11' then
        ContainerFrame11:SetScale(containerScale); 
        ContainerFrame11:ClearAllPoints();
        ContainerFrame11:SetPoint("BOTTOMRIGHT",ContainerFrame9,"BOTTOMLEFT",-2,0);    
        ContainerFrame11:SetUserPlaced(true);
    elseif  bar ==  'ContainerFrame12' then
        ContainerFrame12:SetScale(containerScale); 
        ContainerFrame12:ClearAllPoints();
        ContainerFrame12:SetPoint("BOTTOMRIGHT",ContainerFrame11,"TOPRIGHT",-2,0);   
        ContainerFrame12:SetUserPlaced(true);
	]]--
    elseif bar == 'BuffFrame' then
        BuffFrame:ClearAllPoints();
        BuffFrame:SetPoint("TOPRIGHT",PlayerFrame,"TOPLEFT",0, 80);
        --BuffFrame:SetUserPlaced(true);
        BuffFrame.ignoreFramePositionManager = true;

    end      
    
    setting = nil
end
    
--#############################################
-- Hook to keep same positions after refresh/update (ex. bars)
    hooksecurefunc(MainMenuBar, "SetPoint", function(bar, ...)
        if not setting then
            bar = "MainMenuBar";
            SetPointBlizzOverride(bar, ...)
        end
    end)

  --[[  hooksecurefunc(MultiBarBottomLeft, "SetPoint", function(bar, ...)
        if not setting then            
            bar = "MultiBarBottomLeft";
            SetPointBlizzOverride(bar, ...)
        end
    end)
    ]]
    
    hooksecurefunc(MultiBarLeft, "SetPoint", function(bar, ...)
        if not setting then
            bar = "MultiBarLeft";
            SetPointBlizzOverride(bar, ...)
        end
    end)
    
    hooksecurefunc(MultiBarRight, "SetPoint", function(bar, ...)
        if not setting then
            bar = "MultiBarRight";
            SetPointBlizzOverride(bar, ...)
        end
    end)
    
    hooksecurefunc(ChatFrame1EditBox, "SetPoint", function(bar, ...)
        if not setting then
            bar = "ChatFrame1EditBox";
            SetPointBlizzOverride(bar, ...)
        end
    end)
    
     hooksecurefunc(PlayerFrame, "SetPoint", function(bar, ...)
         if not setting then
             bar = "PlayerFrame";
             SetPointBlizzOverride(bar, ...)
         end
     end)
     
     hooksecurefunc(PetFrame, "SetPoint", function(bar, ...)
         if not setting then
             bar = "PetFrame";
             SetPointBlizzOverride(bar, ...)
         end
     end)
    
     hooksecurefunc(TargetFrame, "SetPoint", function(bar, ...)
         if not setting then
             bar = "TargetFrame";
             SetPointBlizzOverride(bar, ...)
         end
     end)
          --[[This is for Target Spell Bar Reposition ]]
             
         Target_Spellbar_AdjustPosition = (function() 
             _G["TargetFrameSpellBar"]:SetParent(UIParent);
             --_G["UIParent"].auraRows = 0;
             _G["TargetFrameSpellBar"]:SetScale(1.5);
             _G["TargetFrameSpellBar"]:ClearAllPoints();
             _G["TargetFrameSpellBar"]:SetPoint("BOTTOM", "CastingBarFrame", "TOP",0,6);
             _G["TargetFrameSpellBar"]:SetScript("OnShow", nil)
         end)

         --[[This is for Target Spell Bar Reposition ]]
    hooksecurefunc(TargetFrameToT, "SetPoint", function(bar, ...)
        if not setting then
            bar = "TargetFrameToT";
            SetPointBlizzOverride(bar, ...)
        end
    end)   
        
    
     hooksecurefunc(FocusFrame, "SetPoint", function(bar, ...)
         if not setting then
             bar = "FocusFrame";
             SetPointBlizzOverride(bar, ...)
         end
     end)
    
    hooksecurefunc(ExtraActionBarFrame, "SetPoint", function(bar, ...)
        if not setting then
            bar = "ExtraActionBarFrame";
            SetPointBlizzOverride(bar, ...)
        end
    end)
    hooksecurefunc(CastingBarFrame, "SetPoint", function(bar, ...)
        if not setting then
            bar = "CastingBarFrame";
            SetPointBlizzOverride(bar, ...)
        end
    end)
    
    hooksecurefunc(TimeManagerClockButton, "SetPoint", function(bar, ...)
        if not setting then
            bar = "TimeManagerClockButton";
            SetPointBlizzOverride(bar, ...)
        end
    end)
    
    hooksecurefunc(MainMenuBarBackpackButton, "SetPoint", function(bar, ...)
        if not setting then
            bar = "MainMenuBarBackpackButton";
            SetPointBlizzOverride(bar, ...)
        end
    end)
        
    hooksecurefunc(CharacterMicroButton, "SetPoint", function(bar, ...)
        if not setting then
            bar = "CharacterMicroButton";
            SetPointBlizzOverride(bar, ...)
        end
    end)
    
    hooksecurefunc(MinimapCluster, "SetPoint", function(bar, ...)
        if not setting then
            bar = "MinimapCluster";
            SetPointBlizzOverride(bar, ...)
        end
    end)
    
    -- print(IsAddOnLoaded("Blizzard_BattlefieldMinimap"));
    
   hooksecurefunc(DurabilityFrame, "SetPoint", function(bar, ...)
       if not setting then
           bar = "DurabilityFrame";
           SetPointBlizzOverride(bar, ...)
       end
   end)
        
   --[[ hooksecurefunc(ObjectiveTrackerFrame, "SetPoint", function(bar, ...)
        if not setting then
            bar = "ObjectiveTrackerFrame";
            SetPointBlizzOverride(bar, ...)
        end
            end) 
    ]]
	
	--[[
    hooksecurefunc(BattlefieldMapFrame, "SetPoint", function(bar, ...)
        if not setting then
            bar = "BattlefieldMapFrame";
            SetPointBlizzOverride(bar, ...)
        end
    end)
    ]]--
	
    hooksecurefunc(GameTooltip, "SetPoint", function(bar, ...)
        if not setting then
            bar = "GameTooltip";
            SetPointBlizzOverride(bar, ...)
        end
    end)
    
    -- Bags
	 --[[ -- Desactivei porque estava a falhar -
     hooksecurefunc(ContainerFrame1, "SetPoint", function(bar, ...)
        if not setting then
            bar = "ContainerFrame1";
            SetPointBlizzOverride(bar, ...)
        end
     end)

     hooksecurefunc(ContainerFrame2, "SetPoint", function(bar, ...)
        if not setting then
            bar = "ContainerFrame2";
            SetPointBlizzOverride(bar, ...)
        end
     end)
    
     hooksecurefunc(ContainerFrame3, "SetPoint", function(bar, ...)
        if not setting then
            bar = "ContainerFrame3";
            SetPointBlizzOverride(bar, ...)
        end
     end)
    
     hooksecurefunc(ContainerFrame4, "SetPoint", function(bar, ...)
        if not setting then
            bar = "ContainerFrame4";
            SetPointBlizzOverride(bar, ...)
        end
     end)
    
     hooksecurefunc(ContainerFrame5, "SetPoint", function(bar, ...)
        if not setting then
            bar = "ContainerFrame5";
            SetPointBlizzOverride(bar, ...)
        end
     end)
    
     hooksecurefunc(ContainerFrame6, "SetPoint", function(bar, ...)
        if not setting then
            bar = "ContainerFrame6";
            SetPointBlizzOverride(bar, ...)
        end
     end)
    
     hooksecurefunc(ContainerFrame7, "SetPoint", function(bar, ...)
        if not setting then
            bar = "ContainerFrame7";
            SetPointBlizzOverride(bar, ...)
        end
     end)
    
     hooksecurefunc(ContainerFrame8, "SetPoint", function(bar, ...)
        if not setting then
            bar = "ContainerFrame8";
            SetPointBlizzOverride(bar, ...)
        end
     end)
    
     hooksecurefunc(ContainerFrame9, "SetPoint", function(bar, ...)
        if not setting then
            bar = "ContainerFrame9";
            SetPointBlizzOverride(bar, ...)
        end
     end)
    
     hooksecurefunc(ContainerFrame10, "SetPoint", function(bar, ...)
        if not setting then
            bar = "ContainerFrame10";
            SetPointBlizzOverride(bar, ...)
        end
     end)
    
     hooksecurefunc(ContainerFrame11, "SetPoint", function(bar, ...)
        if not setting then
            bar = "ContainerFrame11";
            SetPointBlizzOverride(bar, ...)
        end
     end)
     
     hooksecurefunc(ContainerFrame12, "SetPoint", function(bar, ...)
        if not setting then
            bar = "ContainerFrame12";
            SetPointBlizzOverride(bar, ...)
        end
     end)
    ]]--
    -- Debuffs
    hooksecurefunc(BuffFrame, "SetPoint", function(bar, ...)
        if not setting then
            bar = "BuffFrame";
            SetPointBlizzOverride(bar, ...)
        end
     end)

    -- Bags 
    
    --hooksecurefunc(ZoneAbilityFrame, "SetPoint", function(bar, ...)
    --     if not setting then
    --         bar = "ZoneAbilityFrame";
    --         SetPointBlizzOverride(bar, ...)
    --     end
    -- end) 
  
    
    
     --hooksecurefunc(ExtraActionBarFrame, "SetPoint", function(bar, ...)
     --    if not setting then
     --        bar = "ExtraActionBarFrame";
     --        SetPointBlizzOverride(bar, ...)
     --    end
     --end)
     
    --[[
    hooksecurefunc(StanceBarFrame, "SetPoint", function(bar, ...)
        if not setting then
              bar = "StanceBarFrame";
            SetPointBlizzOverride(bar, ...)
        end
    end)

    hooksecurefunc(PetActionBarFrame, "SetPoint", function(bar, ...)
        if not setting then
            bar = "PetActionBarFrame";
            SetPointBlizzOverride(bar, ...)
        end
    end)
    
    --Hook Artifact Status Bar
  hooksecurefunc(ArtifactWatchBar.StatusBar, "SetPoint", function(bar, ...)
        if not setting then
            bar = "ArtifactWatchBar.StatusBar";
            SetPointBlizzOverride(bar, ...)
        end
    end)

    --Hook Reputation Status Bar
      hooksecurefunc(ReputationWatchBar.StatusBar, "SetPoint", function(bar, ...)
        if not setting then
            bar = "ReputationWatchBar.StatusBar";
            SetPointBlizzOverride(bar, ...)
        end
    end)
    
    hooksecurefunc(CharacterMicroButton, "SetPoint", function(bar, ...)
        if not setting then
            bar = "CharacterMicroButton";
            SetPointBlizzOverride(bar, ...)
        end
    end)

    -- Bags 

    hooksecurefunc(MainMenuBarBackpackButton, "SetPoint", function(bar, ...)
        if not setting then
             bar = "MainMenuBarBackpackButton";
            SetPointBlizzOverride(bar, ...)
        end
    end)
    
    ]]
    
--############################################
--[[
function MakeSweetMainBar2()
-- https://eu.battle.net/forums/en/wow/topic/10993609946
-- http://www.wowinterface.com/forums/showthread.php?t=46336
-- https://wow.gamepedia.com/SecureActionButtonTemplate
-- http://wowwiki.wikia.com/wiki/ActionSlot

local slotbase = 13;
local mybuttonId = 1;
local barframe = CreateFrame("frame","SweetMainBar2",UIParent);
local prevbutton; -- keep track of previous button for anchoring purposes
for slot = slotbase, slotbase + 11 do
   local button = CreateFrame("CheckButton","SweetMainBar2Button"..mybuttonId,barframe,"ActionBarButtonTemplate");
   mybuttonId = mybuttonId + 1;
   button:SetAttribute("type","action");
   button:SetAttribute("action",slot);
   if prevbutton then
      button:SetPoint("LEFT",prevbutton,"RIGHT",6,0);
   else
      button:SetPoint("TOPLEFT"); -- anchor to parent frame if first button
   end
   prevbutton = button;
end
barframe:SetSize(prevbutton:GetWidth()*12, prevbutton:GetHeight())
barframe:SetScale(0.9);
barframe:SetPoint("LEFT",ActionButton12,'RIGHT',12,0);
end
]]--
--#############################################
    
	
-- Sweet Revenge (On Load Event)    
function SweetRevUiOptions_OnLoad()
    SweetRevUiOptions:RegisterForDrag("LeftButton");
	
	print("Sweet Revenge - Addon Loaded!")


    -- Set Viewport
    -- WorldFrame:ClearAllPoints(); 
    -- WorldFrame:SetPoint("TOPLEFT", 20, -20); 
    -- WorldFrame:SetPoint("BOTTOMRIGHT", -20, 30);

    -- Hide Gryphons
	--MainMenuBarArtFrame.LeftEndCap:Hide()
	--MainMenuBarArtFrame.RightEndCap:Hide()
    --/run MainMenuBarArtFrame:Hide();
    
    -- Hide Textures of MicroButtons and Bags
    --MainMenuBarTexture2:Hide()
    --MainMenuBarTexture3:Hide()
	

    -- Action Bars Change Positions
    SetPointBlizzOverride("MainMenuBar");
    --* SetPointBlizzOverride("MultiBarBottomLeft");
    --* SetPointBlizzOverride("MultiBarBottomRight");
   -- SetPointBlizzOverride("MultiBarLeft");
    SetPointBlizzOverride("MultiBarRight");
    
    SetPointBlizzOverride("ChatFrame1EditBox");

    SetPointBlizzOverride("PlayerFrame");
    SetPointBlizzOverride("PetFrame");
    SetPointBlizzOverride("TargetFrame");
    SetPointBlizzOverride("TargetFrameToT");
    SetPointBlizzOverride("FocusFrame");
    --SetPointBlizzOverride("ExtraActionBarFrame");
    --* SetPointBlizzOverride("ExtraActionBarFrame");
    SetPointBlizzOverride("CastingBarFrame");
    --SetPointBlizzOverride("ZoneAbilityFrame");
    
    -- SetPointBlizzOverride("StanceBarFrame");
    -- SetPointBlizzOverride("PetActionBarFrame");
    -- SetPointBlizzOverride("ArtifactWatchBar.StatusBar");
    -- SetPointBlizzOverride("ReputationWatchBar.StatusBar");
    SetPointBlizzOverride("TimeManagerClockButton");
    SetPointBlizzOverride("MainMenuBarBackpackButton");
    SetPointBlizzOverride("CharacterMicroButton");
    
    SetPointBlizzOverride("MinimapCluster");

    SetPointBlizzOverride("DurabilityFrame");
    --SetPointBlizzOverride("ObjectiveTrackerFrame");

    SetPointBlizzOverride("BattlefieldMapFrame");

    SetPointBlizzOverride("GameTooltip");
    
	--[[
    SetPointBlizzOverride("ContainerFrame1");
    SetPointBlizzOverride("ContainerFrame2");
    SetPointBlizzOverride("ContainerFrame3");
    SetPointBlizzOverride("ContainerFrame4");
    SetPointBlizzOverride("ContainerFrame5");
    SetPointBlizzOverride("ContainerFrame6");
    SetPointBlizzOverride("ContainerFrame7");
    SetPointBlizzOverride("ContainerFrame8");
    SetPointBlizzOverride("ContainerFrame9");
    SetPointBlizzOverride("ContainerFrame10");
    SetPointBlizzOverride("ContainerFrame11");
    SetPointBlizzOverride("ContainerFrame12");
	]]--

    SetPointBlizzOverride("BuffFrame");  
	

    --MakeSweetMainBar2();
            
    -- MinimapCluster
    -- MinimapCluster:ClearAllPoints(); 
    -- MinimapCluster:SetPoint("BOTTOMRIGHT",UIParent,"BOTTOMRIGHT",0, 0); 

    -- Move PlayerFrame to new position 
    -- Funcionou assim "/run PlayerFrame:ClearAllPoints() PlayerFrame:SetPoint("BOTTOM",UIParent,"BOTTOM",-250,200)"
    --[[
    PlayerFrame:ClearAllPoints(); 
    PlayerFrame:SetPoint("BOTTOM",UIParent,"BOTTOM",-250,200); 
    TargetFrame:ClearAllPoints();
    TargetFrame:SetPoint("BOTTOM",UIParent,"BOTTOM",250,200);
    ]]


    


    -- Objective Tracker Frame

    --    ObjectiveTrackerFrame:SetPoint("TOPRIGHT",UIParent,"TOPRIGHT",0, 0);
    
    -- PET Bar
    --    /run PetActionBarFrame:ClearAllPoints();  PetActionBarFrame:SetPoint("LEFT",MainMenuBar,"CENTER",5, 0);    

    -- Micro Buttons
    --    /run CharacterMicroButton:ClearAllPoints(); CharacterMicroButton:SetPoint("BOTTOMLEFT",MultiBarBottomLeft,"BOTTOMLEFT",0,0); CharacterMicroButton:SetPoint("LEFT",UIParent,"LEFT",0,0);
    --    /run MainMenuMicroButton:ClearAllPoints(); MainMenuMicroButton:SetPoint("TOPLEFT",CharacterMicroButton,"BOTTOMLEFT",0,20);

    -- Bags
    --    /run  MainMenuBarBackpackButton:ClearAllPoints();  MainMenuBarBackpackButton:SetPoint("LEFT",MainMenuMicroButton,"RIGHT",150, -11);

    --    --Hide Bars
    --    --MainMenuBar:Hide();
    --    MainMenuBarTexture0:Hide();
    --    MainMenuBarTexture1:Hide();
    --    MainMenuBarTexture2:Hide();
    --    MainMenuBarTexture3:Hide();

    --    /run MainMenuBarOverlayFrame:SetParent(UIParent); MainMenuBarOverlayFrame:ClearAllPoints(); MainMenuBarOverlayFrame:SetPoint("CENTER",UIParent,"CENTER",0, 0); 

    --    -- Minimap Position
    --    MinimapCluster:SetPoint("BOTTON",WorldFrame,"BOTTON",0, 0); 
    --    -- Minimap:SetPoint("TOPLEFT",PlayerFrame,"BOTTOMRIGHT",0, 0);
    

    --   /run MinimapCluster:ClearAllPoints(); MinimapCluster:SetPoint("BOTTOMRIGHT",UIParent,"BOTTOMRIGHT",0, 0); 
    --   /run MinimapCluster:ClearAllPoints(); MinimapCluster:SetPoint("BOTTOMLEFT",MainMenuBar,"BOTTOMRIGHT",0, 0);
    --   /run MinimapCluster:SetPoint("TOPLEFT",ChatFrame1,"BOTTOMLEFT",0, 0);
    --   /run Minimap:SetPoint("BOTTOMRIGHT",MainMenuBar,"BOTTOMLEFT",-50, 30);

    --    /run MainMenuBar:ClearAllPoints(); MainMenuBar:SetPoint("BOTTOM",WorldFrame,"BOTTOM",0, 0);
	
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

-- Restore the oldSet Party nameplates has blue (http://www.wowhead.com/bluetracker?topic=20755546851)
--SetCVar("nameplateShowOnlyNames",1); -- It is bugged (2018-01-25)
--SetCVar("nameplatesShowDebuffsOnFriendly",1); -- Not sure if it is bugged (2018-01-25)
SetCVar("ShowClassColorInNameplate", 1); --"use this to display the class color in enemy nameplate health bars"
SetCVar("ShowClassColorInFriendlyNameplate",0); --"use this to display the class color in friendly nameplate health bars"
SetCVar("ShowNamePlateLoseAggroFlash",1); --"When enabled, if you are a tank role and lose aggro, the nameplate with briefly flash."
SetCVar("threatWarning",3); --  "Whether or not to show threat warning UI (0 = off, 1 = in dungeons, 2 = in party/raid, 3 = always)"
SetCVar("alwaysCompareItems",1); --  "Always show item comparison tooltips"
SetCVar("violenceLevel",5); -- Sets the violence level of the game"
SetCVar("buffDurations", 1); -- Whether to show buff durations"
SetCVar("threatShowNumeric ",1); --"Whether or not to show numeric threat on the target and focus frames"
SetCVar("NameplatePersonalShowAlways",0); -- "Determines if the the personal nameplate is always shown."
SetCVar("NameplatePersonalShowWithTarget",0); -- "Determines if the personal nameplate is shown when selecting a target. 0 = targeting has no effect, 1 = show on hostile target, 2 = show on any target"
--SetCVar("autoDismount",1); -- "Automatically dismount when needed"
--SetCVar("autoDismountFlying",0); -- "If enabled, your character will automatically dismount before casting while flying"

--SetCVar("showTargetOfTarget",1);
--SetCVar("raidOptionKeepGroupsTogether",1);
--SetCVar("cameraDistanceMaxZoomFactor", 2.6);

SetCVar("cameraSmoothStyle",1); 
-- 0 Never adjust camera; 
-- 1 Adjust camera only horizontal when moving.
-- 2 Always adjust camera.
-- 4 Adjust camera only when moving.
SetCVar("cameraTerrainTilt",0); -- no vertical angle change
--SetCVar("cameraWaterCollision",1);
--SetCVar("profanityFilter",0); -- Allows to use bad words in chat
--SetCVar("colorChatNamesByClass",1);  
--SetCVar("raidFramesDisplayClassColor",1);
--SetCVar("raidFramesDisplayPowerBars",1);

 -- Bind slash command
 
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

-- TO DO A WORKAROUND BECAUSE THE BUG OF MainMenuBar BE RESETED https://www.wowinterface.com/forums/showthread.php?t=56519
-- "4. Yet another solution"  https://stackoverflow.com/questions/59006793/how-to-load-wow-addon-after-club-stream-subscribed-event
	
_G["MainMenuBar"]:SetScript("OnEvent", function(__, event, ...)
    if (event == "PLAYER_ENTERING_WORLD") then
        _G["MainMenuBar"]:UnregisterEvent("PLAYER_ENTERING_WORLD");
        
		_G["MainMenuBar"]:SetMovable(true)
		_G["MainMenuBar"]:SetUserPlaced(true);
		_G["MainMenuBar"]:SetMovable(false)
		_G["MainMenuBar"].ignoreFramePositionManager = true;
		
		
		DEFAULT_CHAT_FRAME:AddMessage( "Sweet Revenge: Fix to the MainMenuBar Executed!"); 
		
		
		_G["BattlefieldMapFrame"]:SetMovable(true)
		_G["BattlefieldMapFrame"]:SetUserPlaced(true);
		_G["BattlefieldMapFrame"]:SetMovable(false)
		_G["BattlefieldMapFrame"].ignoreFramePositionManager = true;
		_G["BattlefieldMapFrame"]:SetScale(1.28);
			
		--PlaySoundFile("Interface\\AddOns\\SweetRevenge\\snd\\vo_801_lady_sylvanas_windrunner_188_f.ogg","Master");
		
		StopMusic();
		--PlaySoundFile(3850505, "Music"); -- https://wow.tools/files/#search=Sylvanas&page=8&sort=4&desc=asc
		--PlaySoundFile(2062721); -- FileDataID: 2062721 Filename	sound/creature/lady_sylvanas_windrunner/vo_801_lady_sylvanas_windrunner_109_f.ogg
		--PlaySoundFile(551682);
		--PlaySoundFile(643937);
		--PlaySoundFile(561144);
		PlaySoundFile(1404539);
		
		--PlaySoundFile(2131062);
		--wait(6);
		--PlaySoundFile(643937);
		--C_Timer.After(6, PlaySoundFile(643937))
		--C_Timer.After(12, function() PlaySoundFile(561144); end)
		--C_Timer.After(14, function() PlaySoundFile(1404539); end)

	end
end);
_G["MainMenuBar"]:RegisterEvent("PLAYER_ENTERING_WORLD");

