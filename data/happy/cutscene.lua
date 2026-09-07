local allowCountdown = false
local startedVideo = false
function onStartCountdown()
    if not allowCountdown and isStoryMode and not seenCutscene then
        
        if not startedVideo then
            startVideo('cutscene2', true, false, false, true)
            startedVideo = true
        end

        allowCountdown = true
        return Function_Stop
    end
    return Function_Continue
end