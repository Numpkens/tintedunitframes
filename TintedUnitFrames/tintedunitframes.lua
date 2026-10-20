local CLASS_COLORS = {
    WARRIOR = {r = 0.78, g = 0.61, b = 0.43},
    PALADIN = {r = 0.96, g = 0.55, b = 0.73},
    HUNTER  = {r = 0.67, g = 0.83, b = 0.45},
    ROGUE   = {r = 1.00, g = 0.96, b = 0.41},
    PRIEST  = {r = 1.00, g = 1.00, b = 1.00},
    SHAMAN  = {r = 0.00, g = 0.44, b = 0.87},
    MAGE    = {r = 0.41, g = 0.80, b = 0.94},
    WARLOCK = {r = 0.58, g = 0.51, b = 0.79},
    DRUID   = {r = 1.00, g = 0.49, b = 0.04},
}

local function ApplyPlayerClassColor()
    local _, englishClass = UnitClass("player")
    if englishClass and CLASS_COLORS[englishClass] then
        local color = CLASS_COLORS[englishClass]
        if PlayerFrame and PlayerFrame.healthbar then
            PlayerFrame.healthbar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
            PlayerFrame.healthbar:SetStatusBarColor(color.r, color.g, color.b)
        end
    end
end

local function ApplyPetClassColor()
    local _, englishClass = UnitClass("player")
    if englishClass and CLASS_COLORS[englishClass] then
        local color = CLASS_COLORS[englishClass]
        if PetFrame and PetFrame.healthbar then
            PetFrame.healthbar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
            PetFrame.healthbar:SetStatusBarColor(color.r, color.g, color.b)
        end
    end
end

local function ApplyTargetColor()
    if not UnitExists("target") then
        return
    end

    if UnitIsPlayer("target") then
        local _, englishClass = UnitClass("target")
        if englishClass and CLASS_COLORS[englishClass] then
            local color = CLASS_COLORS[englishClass]
            if TargetFrame and TargetFrame.healthbar then
                TargetFrame.healthbar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
                TargetFrame.healthbar:SetStatusBarColor(color.r, color.g, color.b)
            end
        end
    else
        local reaction = UnitReaction("target", "player")
        if TargetFrame and TargetFrame.healthbar then
            TargetFrame.healthbar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
            if reaction and reaction <= 3 then
                TargetFrame.healthbar:SetStatusBarColor(1.0, 0.1, 0.1)
            elseif reaction == 4 then
                TargetFrame.healthbar:SetStatusBarColor(1.0, 0.9, 0.0)
            else
                TargetFrame.healthbar:SetStatusBarColor(0.1, 1.0, 0.1)
            end
        end
    end
end

local function ApplyFocusColor()
    if not UnitExists("focus") then
        return
    end

    if UnitIsPlayer("focus") then
        local _, englishClass = UnitClass("focus")
        if englishClass and CLASS_COLORS[englishClass] then
            local color = CLASS_COLORS[englishClass]
            if FocusFrame and FocusFrame.healthbar then
                FocusFrame.healthbar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
                FocusFrame.healthbar:SetStatusBarColor(color.r, color.g, color.b)
            end
        end
    else
        local reaction = UnitReaction("focus", "player")
        if FocusFrame and FocusFrame.healthbar then
            FocusFrame.healthbar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
            if reaction and reaction <= 3 then
                FocusFrame.healthbar:SetStatusBarColor(1.0, 0.1, 0.1)
            elseif reaction == 4 then
                FocusFrame.healthbar:SetStatusBarColor(1.0, 0.9, 0.0)
            else
                FocusFrame.healthbar:SetStatusBarColor(0.1, 1.0, 0.1)
            end
        end
    end
end

local function ApplyBossColors()
    for i = 1, 5 do
        local bossFrame = _G["Boss" .. i .. "TargetFrame"]
        if bossFrame and bossFrame.healthbar then
            bossFrame.healthbar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
            bossFrame.healthbar:SetStatusBarColor(1.0, 0.1, 0.1)
        end
    end
end

local eventFrame = CreateFrame("Frame")

eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eventFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
eventFrame:RegisterEvent("PLAYER_FOCUS_CHANGED")
eventFrame:RegisterEvent("UNIT_PET")

eventFrame:SetScript("OnEvent", function(self, event, ...)
-- Run color updates based on what event just triggered
if event == "PLAYER_ENTERING_WORLD" then
    ApplyPlayerClassColor()
    ApplyPetClassColor()
    elseif event == "PLAYER_TARGET_CHANGED" then
        ApplyTargetColor()
        ApplyBossColors()
        elseif event == "PLAYER_FOCUS_CHANGED" then
            ApplyFocusColor()
            elseif event == "UNIT_PET" and ... == "player" then
                ApplyPetClassColor()
                end
            end)

SLASH_TINTEDUNITFRAMES1 = "/tuf"
SlashCmdList["TINTEDUNITFRAMES"] = function(msg)
    ApplyPlayerClassColor()
    ApplyPetClassColor()
    ApplyTargetColor()
    ApplyFocusColor()
    ApplyBossColors()
    print("|cff33ff99[TintedUnitFrames]|r Refreshed all frames!")
end

print("|cff33ff99[TintedUnitFrames]|r Addon loaded successfully!")
