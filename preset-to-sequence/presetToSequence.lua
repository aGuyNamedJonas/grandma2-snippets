function print (msg)
  gma.echo(msg)
  gma.feedback(msg)
end

function printWelcomeScreen ()
  print('-------------------------------------------------')
  print('       Starting presetToSequence Plugin...       ')
  print('                                                 ')
  print('       ----------------------------------        ')
  print('       Brought to you by @aGuyNamedJonas         ')
  print('       ----------------------------------        ')
  print('                                                 ')
  print('  SUBSCRIBE      >>> youtube.com/aGuyNamedJonas  ')
  print('  QA & COMMUNITY >>> fb.com/aGuyNamedJonas       ')
  print('  GET IN TOUCH   >>> hi@aGuyNamedJonas.com       ')
  print('-------------------------------------------------')
end

function getPresetRangeFromUser ()
  local presetRange = {}
  presetRange['type'] = tonumber(gma.textinput('Preset TYPE', '(0 for All, 1 for Dimmer, 2 for Position, ...)'))
  presetRange['first'] = tonumber(gma.textinput('Preset START', '1'))
  presetRange['last'] = tonumber(gma.textinput('Preset END'))
  return presetRange
end

function getGroupNumberFromUser ()
  local groupNumber = tonumber(gma.textinput('GROUP', '1'))
  return groupNumber
end

function getFadeTimeFromUser ()
  local fadeTime = tonumber(gma.textinput('FADE', '0'))
  return fadeTime
end

function getTargetExecutorFromUser ()
  local executorNumber = gma.textinput('EXECUTOR', '1.1')
  return executorNumber
end

function getObjectLabel (ma2ObjectName)
  local handle = gma.show.getobj.handle(ma2ObjectName)
  local label = gma.show.getobj.label(handle)
  return label
end

function setObjectLabel (ma2ObjectName, label)
  gma.cmd('Label '..ma2ObjectName..' "'..label..'"')
end

function createSequenceFromPresets (presetType, presetStart, presetEnd, groupNumber, fadeTime, executorNumber)
  local groupName = 'Group '..groupNumber
  local groupLabel = getObjectLabel(groupName)
  local executorName = 'Executor '..executorNumber

  print('Deleting '..executorName)
  gma.cmd('Delete '..executorName..' /nc')

  -- Store presets in sequence
  local presetIndex = presetStart
  local cueIndex = 1
  while presetIndex <= presetEnd do
    local presetName = 'Preset '..presetType..'.'..presetIndex
    local presetLabel = getObjectLabel(presetName)

    print('Storing '..presetName..' "'..presetLabel..'"')
    
    local cueName = 'Cue '..cueIndex
    gma.cmd('ClearAll')
    gma.cmd(groupName..' at '..presetName)
    gma.cmd('Store at '..executorName..' '..cueName..' Fade '..fadeTime)
    gma.cmd('Label '..executorName..' '..cueName..' "'..presetLabel..'"')
    
    presetIndex = presetIndex + 1
    cueIndex = cueIndex + 1
  end

  gma.cmd('Label '..executorName..' "'..groupLabel..'"')
end

function main()
  printWelcomeScreen()
  local presetRange = getPresetRangeFromUser()
  local groupNumber = getGroupNumberFromUser()
  local fadeTime = getFadeTimeFromUser()
  local executorNumber = getTargetExecutorFromUser()
  createSequenceFromPresets(presetRange.type, presetRange.first, presetRange.last, groupNumber, fadeTime, executorNumber) 
end

return main
