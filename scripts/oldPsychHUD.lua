local defaultNoteSkin = 'noteSkins/NOTE_assets'
local defaultSplashSkin = 'noteSplashes/noteSplashes'

local iconOffset = 26

luaDebugMode = true
function onCreate()
    if getPropertyFromClass('backend.ClientPrefs', 'data.noteSkin') == 'Default' then
        setPropertyFromClass('states.PlayState', 'SONG.disableNoteRGB', true)

        setPropertyFromClass('states.PlayState', 'SONG.arrowSkin', defaultNoteSkin)
        setPropertyFromClass('states.PlayState', 'SONG.splashSkin', defaultSplashSkin)

        precacheImage(defaultNoteSkin)
        precacheImage(defaultSplashSkin)
    end
end

function onCreatePost()
    setObjectCamera('comboGroup', 'camGame')
    callMethod('comboGroup.setPosition', {215, 15})
end

function onBeatHit()
    scaleObject('iconP1', 1, 1)
    scaleObject('iconP2', 1, 1)

    for icon = 1, 2 do
        setGraphicSize('iconP'..icon, getProperty('iconP'..icon..'.width') + 30)
        updateHitbox('iconP'..icon)
    end
end

function onUpdate(elapsed)
    for icon = 1, 2 do
        setGraphicSize('iconP'..icon, lerp(150, getProperty('iconP'..icon..'.width'), boundTo(1 - (elapsed * 30), 0, 1)))
        updateHitbox('iconP'..icon)
    end

    setProperty('iconP1.x', getProperty('healthBar.x') + (getProperty('healthBar.width') * remapToRange(getProperty('healthBar.percent'), 0, 100, 100, 0) * 0.01) - iconOffset)
    setProperty('iconP2.x', getProperty('healthBar.x') + (getProperty('healthBar.width') * remapToRange(getProperty('healthBar.percent'), 0, 100, 100, 0) * 0.01) - (getProperty('iconP2.width') - iconOffset))
end

function onUpdateScore(miss)
    if getProperty('ratingName') == '?' then
        setTextString('scoreTxt', 'Score: '..getProperty('songScore')..' | Misses: '..getProperty('songMisses')..' | Rating: '..getProperty('ratingName'))
    else
        setTextString('scoreTxt', 'Score: '..getProperty('songScore')..' | Misses: '..getProperty('songMisses')..' | Rating: '..getProperty('ratingName')..' ('..math.floor(getProperty('ratingPercent') * 100)..'%)')
    end
    return Function_Stop
end

function noteMiss(index, noteData, noteType, isSustainNote)
    playSound('missnote'..getRandomInt(1, 3), getRandomFloat(0.1, 0.2))
end

function lerp(a, b, ratio)
    return a + ratio * (b - a);
end

function boundTo(value, min, max)
    local newValue = value

    if (newValue < min) then newValue = min
    elseif (newValue > max) then newValue = max
    end

    return newValue;
end

function remapToRange(value, start1, stop1, start2, stop2)
    return start2 + (value - start1) * ((stop2 - start2) / (stop1 - start1))
end