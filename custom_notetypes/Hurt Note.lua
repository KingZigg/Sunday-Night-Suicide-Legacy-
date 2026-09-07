function onCreatePost()
    for i = 0, getProperty('unspawnNotes.length') - 1 do
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Hurt Note' then
            setPropertyFromGroup('unspawnNotes', i, 'texture', 'noteTypes/HURTNOTE_assets')

            setPropertyFromGroup('unspawnNotes', i, 'rgbShader.enabled', false)
            setPropertyFromGroup('unspawnNotes', i, 'noteSplashData.texture', 'noteTypes/HURTnoteSplashes')
        end
    end
end