-- For debugging: 
local debug = false

local data

local function has_value (table, val)
    for index, value in ipairs(table) do
        if value == val then
            return true
        end
    end
    return false
end

function update_ToggleableTrackable(itemcode)
    local item = Tracker:FindObjectForCode(itemcode)
    if item then
        item.CurrentStage = 1
        if debug then
            print("Set " .. itemcode .. " to 1")
        end
    end
end

function update_ProgressiveTrackable(itemcode, stage)
    local item = Tracker:FindObjectForCode(itemcode)
    if item then
        item.CurrentStage = stage
        if debug then
            print("Set " .. itemcode .. " to " .. stage)
        end
    end
end

function updateTracker(filecontent)
    -- function json.parse() is defined in json.lua and loaded in init.lua.
    data = json.parse(filecontent)

    -- Skills region
    for index, value in ipairs(data["skills"]) do
        -- Value is the name in the json dump, the parameter is the name used in the Tracker.
        if value == 'Bash'  	    then update_ToggleableTrackable('bash')         end
        if value == 'DoubleJump'    then update_ToggleableTrackable('doublejump')   end
        if value == 'Launch'        then update_ToggleableTrackable('launch')       end
        if value == 'Feather'       then update_ToggleableTrackable('feather')      end
        if value == 'WaterBreath'   then update_ToggleableTrackable('waterbreath')  end
        if value == 'LightBurst'    then update_ToggleableTrackable('lightburst')   end
        if value == 'Grapple'       then update_ToggleableTrackable('grapple')      end
        if value == 'Flash'         then update_ToggleableTrackable('flash')        end
        if value == 'Regenerate'    then update_ToggleableTrackable('regen')        end
        if value == 'SpiritArc'     then update_ToggleableTrackable('spiritarc')    end
        if value == 'Burrow'        then update_ToggleableTrackable('burrow')       end
        if value == 'Dash'          then update_ToggleableTrackable('dash')         end
        if value == 'WaterDash'     then update_ToggleableTrackable('waterdash')    end
        if value == 'Seir'          then update_ToggleableTrackable('seir')         end
        if value == 'Flap'          then update_ToggleableTrackable('flap')         end
        -- if value == 'Torch'         then update_ToggleableTrackable('Torch')              end  # No tracking of torch required (?)
        -- if value == 'SpiritEdge'    then update_ToggleableTrackable('SpiritEdge')         end  # No tracking of sword required (?)

        -- Progressive skill Damage Upgrade
        if has_value(data["skills"], 'DamageUpgrade1') and has_value(data["skills"], 'DamageUpgrade2') then
            update_ProgressiveTrackable('weaponUpgrade', 2)
        elseif has_value(data["skills"], 'DamageUpgrade1') or  has_value(data["skills"], 'DamageUpgrade2') then
            update_ProgressiveTrackable('weaponUpgrade', 1)
        end

        -- Progressive skill Spirit Spear
        if has_value(data["skills"], 'Spike2') then
            update_ProgressiveTrackable('spear', 2)
        elseif has_value(data["skills"], 'Spike') then
            update_ProgressiveTrackable('spear', 1)
        end

        -- Progressive skill Sentry
        if has_value(data["skills"], 'Sentry2') then
            update_ProgressiveTrackable('sentry', 2)
        elseif has_value(data["skills"], 'Sentry') then
            update_ProgressiveTrackable('sentry', 1)
        end

        -- Progressive skill Blaze
        if has_value(data["skills"], 'Blaze2') then
            update_ProgressiveTrackable('blaze', 2)
        elseif has_value(data["skills"], 'Blaze') then
            update_ProgressiveTrackable('blaze', 1)
        end

        -- Progressive skill Spirit Smash
        if has_value(data["skills"], 'SpiritSmash2') then
            update_ProgressiveTrackable('hammer', 2)
        elseif has_value(data["skills"], 'SpiritSmash') then
            update_ProgressiveTrackable('hammer', 1)
        end

        -- Progressive skill Spirit Star
        if has_value(data["skills"], 'SpiritStar2') then
            update_ProgressiveTrackable('chakram', 2)
        elseif has_value(data["skills"], 'SpiritStar') then
            update_ProgressiveTrackable('chakram', 1)
        end
    end
    -- End of Skills region

    -- Wisps region
    for index, value in ipairs(data["wisps"]) do
        if value == 'Voice'     then update_ToggleableTrackable('voicewisp')    end
        if value == 'Eyes'      then update_ToggleableTrackable('eyeswisp')     end
        if value == 'Memory'    then update_ToggleableTrackable('memorywisp')   end
        if value == 'Strength'  then update_ToggleableTrackable('strengthwisp') end
        if value == 'Heart'     then update_ToggleableTrackable('goldenwisp')   end
    end
    -- End of Wisps region

end

-- A guess of how the new function will look: ScriptHost:AddFileWatch(NAME, FILEPATH, FUNCTION TO EXECUTE ON CHANGE)
ScriptHost:AddFileWatch("Skills", 'C:/moon/tracker.json', updateTracker)