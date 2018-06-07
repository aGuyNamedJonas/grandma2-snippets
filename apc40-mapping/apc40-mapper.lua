local feedback = gma.feedback -- create fast shortcut for functionblock. this is speeding up the script significantly
local cmd = gma.cmd

local obj = gma.show.getobj
local handle = obj.handle

local get = gma.show.property.get
local setVar = gma.show.setvar
local getVar = gma.show.getvar

-- LUA "apc40Mapper()"

local LED_CL_EMPTY = '0'
local LED_CL_ORANGE = '5'

-- Settings
local ledMappingExecutors = {
  -- Clip Slot Buttons
  ['6.131'] = { ['empty'] = 'MidiNote 1.53 0', ['loaded'] = 'MidiNote 1.53 5', ['playing'] = 'MidiNote 1.53 3' },
  ['6.141'] = { ['empty'] = 'MidiNote 1.54 0', ['loaded'] = 'MidiNote 1.54 5', ['playing'] = 'MidiNote 1.54 3' },
  ['6.151'] = { ['empty'] = 'MidiNote 1.55 0', ['loaded'] = 'MidiNote 1.55 5', ['playing'] = 'MidiNote 1.55 3' },
  ['6.161'] = { ['empty'] = 'MidiNote 1.56 0', ['loaded'] = 'MidiNote 1.56 5', ['playing'] = 'MidiNote 1.56 3' },
  ['6.171'] = { ['empty'] = 'MidiNote 1.57 0', ['loaded'] = 'MidiNote 1.57 5', ['playing'] = 'MidiNote 1.57 3' },  

  ['6.132'] = { ['empty'] = 'MidiNote 2.53 0', ['loaded'] = 'MidiNote 2.53 5', ['playing'] = 'MidiNote 2.53 3' },
  ['6.142'] = { ['empty'] = 'MidiNote 2.54 0', ['loaded'] = 'MidiNote 2.54 5', ['playing'] = 'MidiNote 2.54 3' },
  ['6.152'] = { ['empty'] = 'MidiNote 2.55 0', ['loaded'] = 'MidiNote 2.55 5', ['playing'] = 'MidiNote 2.55 3' },
  ['6.162'] = { ['empty'] = 'MidiNote 2.56 0', ['loaded'] = 'MidiNote 2.56 5', ['playing'] = 'MidiNote 2.56 3' },
  ['6.172'] = { ['empty'] = 'MidiNote 2.57 0', ['loaded'] = 'MidiNote 2.57 5', ['playing'] = 'MidiNote 2.57 3' },    

  ['6.133'] = { ['empty'] = 'MidiNote 3.53 0', ['loaded'] = 'MidiNote 3.53 5', ['playing'] = 'MidiNote 3.53 3' },
  ['6.143'] = { ['empty'] = 'MidiNote 3.54 0', ['loaded'] = 'MidiNote 3.54 5', ['playing'] = 'MidiNote 3.54 3' },
  ['6.153'] = { ['empty'] = 'MidiNote 3.55 0', ['loaded'] = 'MidiNote 3.55 5', ['playing'] = 'MidiNote 3.55 3' },
  ['6.163'] = { ['empty'] = 'MidiNote 3.56 0', ['loaded'] = 'MidiNote 3.56 5', ['playing'] = 'MidiNote 3.56 3' },
  ['6.173'] = { ['empty'] = 'MidiNote 3.57 0', ['loaded'] = 'MidiNote 3.57 5', ['playing'] = 'MidiNote 3.57 3' },  

  ['6.134'] = { ['empty'] = 'MidiNote 4.53 0', ['loaded'] = 'MidiNote 4.53 5', ['playing'] = 'MidiNote 4.53 3' },
  ['6.144'] = { ['empty'] = 'MidiNote 4.54 0', ['loaded'] = 'MidiNote 4.54 5', ['playing'] = 'MidiNote 4.54 3' },
  ['6.154'] = { ['empty'] = 'MidiNote 4.55 0', ['loaded'] = 'MidiNote 4.55 5', ['playing'] = 'MidiNote 4.55 3' },
  ['6.164'] = { ['empty'] = 'MidiNote 4.56 0', ['loaded'] = 'MidiNote 4.56 5', ['playing'] = 'MidiNote 4.56 3' },
  ['6.174'] = { ['empty'] = 'MidiNote 4.57 0', ['loaded'] = 'MidiNote 4.57 5', ['playing'] = 'MidiNote 4.57 3' },  
  
  ['6.135'] = { ['empty'] = 'MidiNote 5.53 0', ['loaded'] = 'MidiNote 5.53 5', ['playing'] = 'MidiNote 5.53 3' },
  ['6.145'] = { ['empty'] = 'MidiNote 5.54 0', ['loaded'] = 'MidiNote 5.54 5', ['playing'] = 'MidiNote 5.54 3' },
  ['6.155'] = { ['empty'] = 'MidiNote 5.55 0', ['loaded'] = 'MidiNote 5.55 5', ['playing'] = 'MidiNote 5.55 3' },
  ['6.165'] = { ['empty'] = 'MidiNote 5.56 0', ['loaded'] = 'MidiNote 5.56 5', ['playing'] = 'MidiNote 5.56 3' },
  ['6.175'] = { ['empty'] = 'MidiNote 5.57 0', ['loaded'] = 'MidiNote 5.57 5', ['playing'] = 'MidiNote 5.57 3' },  

  ['6.136'] = { ['empty'] = 'MidiNote 6.53 0', ['loaded'] = 'MidiNote 6.53 5', ['playing'] = 'MidiNote 6.53 3' },
  ['6.146'] = { ['empty'] = 'MidiNote 6.54 0', ['loaded'] = 'MidiNote 6.54 5', ['playing'] = 'MidiNote 6.54 3' },
  ['6.156'] = { ['empty'] = 'MidiNote 6.55 0', ['loaded'] = 'MidiNote 6.55 5', ['playing'] = 'MidiNote 6.55 3' },
  ['6.166'] = { ['empty'] = 'MidiNote 6.56 0', ['loaded'] = 'MidiNote 6.56 5', ['playing'] = 'MidiNote 6.56 3' },
  ['6.176'] = { ['empty'] = 'MidiNote 6.57 0', ['loaded'] = 'MidiNote 6.57 5', ['playing'] = 'MidiNote 6.57 3' },  

  ['6.137'] = { ['empty'] = 'MidiNote 7.53 0', ['loaded'] = 'MidiNote 7.53 5', ['playing'] = 'MidiNote 7.53 3' },
  ['6.147'] = { ['empty'] = 'MidiNote 7.54 0', ['loaded'] = 'MidiNote 7.54 5', ['playing'] = 'MidiNote 7.54 3' },
  ['6.157'] = { ['empty'] = 'MidiNote 7.55 0', ['loaded'] = 'MidiNote 7.55 5', ['playing'] = 'MidiNote 7.55 3' },
  ['6.167'] = { ['empty'] = 'MidiNote 7.56 0', ['loaded'] = 'MidiNote 7.56 5', ['playing'] = 'MidiNote 7.56 3' },
  ['6.177'] = { ['empty'] = 'MidiNote 7.57 0', ['loaded'] = 'MidiNote 7.57 5', ['playing'] = 'MidiNote 7.57 3' },  

  ['6.138'] = { ['empty'] = 'MidiNote 8.53 0', ['loaded'] = 'MidiNote 8.53 5', ['playing'] = 'MidiNote 8.53 3' },
  ['6.148'] = { ['empty'] = 'MidiNote 8.54 0', ['loaded'] = 'MidiNote 8.54 5', ['playing'] = 'MidiNote 8.54 3' },
  ['6.158'] = { ['empty'] = 'MidiNote 8.55 0', ['loaded'] = 'MidiNote 8.55 5', ['playing'] = 'MidiNote 8.55 3' },
  ['6.168'] = { ['empty'] = 'MidiNote 8.56 0', ['loaded'] = 'MidiNote 8.56 5', ['playing'] = 'MidiNote 8.56 3' },
  ['6.178'] = { ['empty'] = 'MidiNote 8.57 0', ['loaded'] = 'MidiNote 8.57 5', ['playing'] = 'MidiNote 8.57 3' },
  
  -- Executor Fader
  ['7.1'] = { ['empty'] = 'MidiNote 1.48 0; MidiNote 1.49 0; MidiNote 1.50 0;', ['loaded'] = 'MidiNote 1.48 127; MidiNote 1.49 0; MidiNote 1.50 0;' },
  ['7.2'] = { ['empty'] = 'MidiNote 2.48 0; MidiNote 2.49 0; MidiNote 2.50 0;', ['loaded'] = 'MidiNote 2.48 127; MidiNote 2.49 0; MidiNote 2.50 0;' },  
  ['7.3'] = { ['empty'] = 'MidiNote 3.48 0; MidiNote 3.49 0; MidiNote 3.50 0;', ['loaded'] = 'MidiNote 3.48 127; MidiNote 3.49 0; MidiNote 3.50 0;' },
  ['7.4'] = { ['empty'] = 'MidiNote 4.48 0; MidiNote 4.49 0; MidiNote 4.50 0;', ['loaded'] = 'MidiNote 4.48 127; MidiNote 4.49 0; MidiNote 4.50 0;' },
  ['7.5'] = { ['empty'] = 'MidiNote 5.48 0; MidiNote 5.49 0; MidiNote 5.50 0;', ['loaded'] = 'MidiNote 5.48 127; MidiNote 5.49 0; MidiNote 5.50 0;' },
  ['7.6'] = { ['empty'] = 'MidiNote 6.48 0; MidiNote 6.49 0; MidiNote 6.50 0;', ['loaded'] = 'MidiNote 6.48 127; MidiNote 6.49 0; MidiNote 6.50 0;' },
  ['7.7'] = { ['empty'] = 'MidiNote 7.48 0; MidiNote 7.49 0; MidiNote 7.50 0;', ['loaded'] = 'MidiNote 7.48 127; MidiNote 7.49 0; MidiNote 7.50 0;' },
  ['7.8'] = { ['empty'] = 'MidiNote 8.48 0; MidiNote 8.49 0; MidiNote 8.50 0;', ['loaded'] = 'MidiNote 8.48 127; MidiNote 8.49 0; MidiNote 8.50 0;' },

  -- Track Control Executors
  ['7.66'] = { ['empty'] = 'MidiControl 1.56 0', ['loaded'] = 'MidiControl 1.56 1' },
  ['7.67'] = { ['empty'] = 'MidiControl 1.57 0', ['loaded'] = 'MidiControl 1.57 1' },
  ['7.68'] = { ['empty'] = 'MidiControl 1.58 0', ['loaded'] = 'MidiControl 1.58 1' },
  ['7.69'] = { ['empty'] = 'MidiControl 1.59 0', ['loaded'] = 'MidiControl 1.59 1' },
  ['7.71'] = { ['empty'] = 'MidiControl 1.60 0; MidiNote 1.87 0', ['loaded'] = 'MidiControl 1.60 1; MidiNote 1.87 127' },
  ['7.72'] = { ['empty'] = 'MidiControl 1.61 0; MidiNote 1.88 0', ['loaded'] = 'MidiControl 1.61 1; MidiNote 1.88 127' },
  ['7.73'] = { ['empty'] = 'MidiControl 1.62 0; MidiNote 1.89 0', ['loaded'] = 'MidiControl 1.62 1; MidiNote 1.89 127' },
  ['7.74'] = { ['empty'] = 'MidiControl 1.63 0; MidiNote 1.90 0', ['loaded'] = 'MidiControl 1.63 1; MidiNote 1.90 127' },

  -- Device Control Executors
  ['7.81'] = { ['empty'] = 'MidiControl 1.24 0; MidiNote 1.58 0', ['loaded'] = 'MidiControl 1.24 1; MidiNote 1.58 127' },
  ['7.82'] = { ['empty'] = 'MidiControl 1.25 0; MidiNote 1.59 0', ['loaded'] = 'MidiControl 1.25 1; MidiNote 1.59 127' },
  ['7.83'] = { ['empty'] = 'MidiControl 1.26 0; MidiNote 1.60 0', ['loaded'] = 'MidiControl 1.26 1; MidiNote 1.60 127' },
  ['7.84'] = { ['empty'] = 'MidiControl 1.27 0; MidiNote 1.61 0', ['loaded'] = 'MidiControl 1.27 1; MidiNote 1.61 127' },
  ['7.86'] = { ['empty'] = 'MidiControl 1.28 0; MidiNote 1.62 0', ['loaded'] = 'MidiControl 1.28 1; MidiNote 1.62 127' },
  ['7.87'] = { ['empty'] = 'MidiControl 1.29 0; MidiNote 1.63 0', ['loaded'] = 'MidiControl 1.29 1; MidiNote 1.63 127' },
  ['7.88'] = { ['empty'] = 'MidiControl 1.30 0; MidiNote 1.64 0', ['loaded'] = 'MidiControl 1.30 1; MidiNote 1.64 127' },
  ['7.89'] = { ['empty'] = 'MidiControl 1.31 0; MidiNote 1.65 0', ['loaded'] = 'MidiControl 1.31 1; MidiNote 1.65 127' },
}

local ledMappingPresets = {
  ['0.1'] = { ['empty'] = 'MidiNote 1.52 0', ['loaded'] = 'MidiNote 1.52 1', ['playing'] = 'MidiNote 1.52 2' },
  ['0.2'] = { ['empty'] = 'MidiNote 2.52 0', ['loaded'] = 'MidiNote 2.52 1', ['playing'] = 'MidiNote 2.52 2' },
  ['0.3'] = { ['empty'] = 'MidiNote 3.52 0', ['loaded'] = 'MidiNote 3.52 1', ['playing'] = 'MidiNote 3.52 2' },
  ['0.4'] = { ['empty'] = 'MidiNote 4.52 0', ['loaded'] = 'MidiNote 4.52 1', ['playing'] = 'MidiNote 4.52 2' },
  ['0.5'] = { ['empty'] = 'MidiNote 5.52 0', ['loaded'] = 'MidiNote 5.52 1', ['playing'] = 'MidiNote 5.52 2' },
  ['0.6'] = { ['empty'] = 'MidiNote 6.52 0', ['loaded'] = 'MidiNote 6.52 1', ['playing'] = 'MidiNote 6.52 2' },
  ['0.7'] = { ['empty'] = 'MidiNote 7.52 0', ['loaded'] = 'MidiNote 7.52 1', ['playing'] = 'MidiNote 7.52 2' },
  ['0.8'] = { ['empty'] = 'MidiNote 8.52 0', ['loaded'] = 'MidiNote 8.52 1', ['playing'] = 'MidiNote 8.52 2' },
  ['0.10'] = { ['empty'] = 'MidiNote 1.51 0', ['loaded'] = 'MidiNote 1.51 1', ['playing'] = '' },
  ['0.11'] = { ['empty'] = 'MidiNote 2.51 0', ['loaded'] = 'MidiNote 2.51 1', ['playing'] = '' },
  ['0.12'] = { ['empty'] = 'MidiNote 3.51 0', ['loaded'] = 'MidiNote 3.51 1', ['playing'] = '' },
  ['0.13'] = { ['empty'] = 'MidiNote 4.51 0', ['loaded'] = 'MidiNote 4.51 1', ['playing'] = '' },
  ['0.14'] = { ['empty'] = 'MidiNote 5.51 0', ['loaded'] = 'MidiNote 5.51 1', ['playing'] = '' },
  ['0.15'] = { ['empty'] = 'MidiNote 6.51 0', ['loaded'] = 'MidiNote 6.51 1', ['playing'] = '' },
  ['0.16'] = { ['empty'] = 'MidiNote 7.51 0', ['loaded'] = 'MidiNote 7.51 1', ['playing'] = '' },
  ['0.17'] = { ['empty'] = 'MidiNote 8.51 0', ['loaded'] = 'MidiNote 8.51 1', ['playing'] = '' },
}

local ledMappingGroups = {
  ['1'] = { ['empty'] = 'MidiNote 82 0', ['loaded'] = 'MidiNote 82 1', ['playing'] = 'MidiNote 82 2' },
  ['2'] = { ['empty'] = 'MidiNote 83 0', ['loaded'] = 'MidiNote 83 1', ['playing'] = 'MidiNote 83 2' },
  ['3'] = { ['empty'] = 'MidiNote 84 0', ['loaded'] = 'MidiNote 84 1', ['playing'] = 'MidiNote 84 2' },
  ['4'] = { ['empty'] = 'MidiNote 85 0', ['loaded'] = 'MidiNote 85 1', ['playing'] = 'MidiNote 85 2' },
  ['5'] = { ['empty'] = 'MidiNote 86 0', ['loaded'] = 'MidiNote 86 1', ['playing'] = 'MidiNote 86 2' },
  ['6'] = { ['empty'] = 'MidiNote 81 0', ['loaded'] = 'MidiNote 81 1', ['playing'] = '' },
  ['7'] = { ['empty'] = 'MidiNote 80 0', ['loaded'] = 'MidiNote 80 1', ['playing'] = '' }
}

local slotMappingExecutors = {
  ['1'] = { ['1'] = '6.131', ['2'] = '6.141', ['3'] = '6.151', ['4'] = '6.161', ['5'] = '6.171' },
  ['2'] = { ['1'] = '6.132', ['2'] = '6.142', ['3'] = '6.152', ['4'] = '6.162', ['5'] = '6.172' },
  ['3'] = { ['1'] = '6.133', ['2'] = '6.143', ['3'] = '6.153', ['4'] = '6.163', ['5'] = '6.173' },
  ['4'] = { ['1'] = '6.134', ['2'] = '6.144', ['3'] = '6.154', ['4'] = '6.164', ['5'] = '6.174' },
  ['5'] = { ['1'] = '6.135', ['2'] = '6.145', ['3'] = '6.155', ['4'] = '6.165', ['5'] = '6.175' },
  ['6'] = { ['1'] = '6.136', ['2'] = '6.146', ['3'] = '6.156', ['4'] = '6.166', ['5'] = '6.176' },
  ['7'] = { ['1'] = '6.137', ['2'] = '6.147', ['3'] = '6.157', ['4'] = '6.167', ['5'] = '6.177' },
  ['8'] = { ['1'] = '6.138', ['2'] = '6.148', ['3'] = '6.158', ['4'] = '6.168', ['5'] = '6.178' }
}

-- Classes
local Utils = {}
local Mapper = {}

-----------------------
Utils.exists = function(objString)
  if (handle(objString)) then
    return true
  else
    return false
  end
end

Utils.toggleOnOff = function(status)
  if (status == 'on') then
    return 'off'
  else
    return 'on'
  end
end

-----------------------
Mapper.setup = function()
  local confirmation = gma.textinput("Reset Slots + Setup, continue? [y/n]", 'n')
  if (confirmation == 'y') then
    local ex1 = Utils.exists('Executor 7.1')
    local ex2 = Utils.exists('Executor 7.2')
    local ex3 = Utils.exists('Executor 7.3')
    local ex4 = Utils.exists('Executor 7.4')
    local ex5 = Utils.exists('Executor 7.5')
    local ex6 = Utils.exists('Executor 7.6')
    local ex7 = Utils.exists('Executor 7.7')
    local ex8 = Utils.exists('Executor 7.8')

    -- Cannot setup when one of the slots is loaded!
    if (ex1 or ex2 or ex3 or ex4 or ex5 or ex6 or ex7 or ex8) then
      feedback('Error during setup: Please clear out Executors 7.1 - 7.8 and try again!')
    else
      feedback('Setting up executor slots...')
      setVar('apc40-slot1', 'none')
      setVar('apc40-slot2', 'none')
      setVar('apc40-slot3', 'none')
      setVar('apc40-slot4', 'none')
      setVar('apc40-slot5', 'none')
      setVar('apc40-slot6', 'none')
      setVar('apc40-slot7', 'none')
      setVar('apc40-slot8', 'none')      

      feedback('Setting up group slots...')
      setVar('apc40-group1', 'none')
      setVar('apc40-group2', 'none')
      setVar('apc40-group3', 'none')
      setVar('apc40-group4', 'none')
      setVar('apc40-group5', 'none')
      setVar('apc40-group6', 'none')
      setVar('apc40-group7', 'none')

      feedback('Setting up preset slots...')
      setVar('apc40-preset0.1', 'none')
      setVar('apc40-preset0.2', 'none')
      setVar('apc40-preset0.3', 'none')
      setVar('apc40-preset0.4', 'none')
      setVar('apc40-preset0.5', 'none')
      setVar('apc40-preset0.6', 'none')
      setVar('apc40-preset0.7', 'none')
      setVar('apc40-preset0.8', 'none')
      
      setVar('apc40-preset0.10', 'none')
      setVar('apc40-preset0.11', 'none')
      setVar('apc40-preset0.12', 'none')
      setVar('apc40-preset0.13', 'none')
      setVar('apc40-preset0.14', 'none')
      setVar('apc40-preset0.15', 'none')
      setVar('apc40-preset0.16', 'none')
      setVar('apc40-preset0.17', 'none')

      setVar('apc40-setup', 'done')
      feedback('Setup completed!')
    end
  else
    feedback('No confirmation, no setup! :)')
  end  
end

Mapper.refreshLeds = function()
  -- Go through ledMappingExecutors table
  for k,v in pairs(ledMappingExecutors) do
    local doesExist = Utils.exists('Executor '..k)
    
    if (doesExist) then
      cmd(ledMappingExecutors[k]['loaded'])
    else
      cmd(ledMappingExecutors[k]['empty'])
    end        
  end

  -- Set the loaded clips
  local slot1 = getVar('apc40-slot1')
  local slot2 = getVar('apc40-slot2')
  local slot3 = getVar('apc40-slot3')
  local slot4 = getVar('apc40-slot4')
  local slot5 = getVar('apc40-slot5')
  local slot6 = getVar('apc40-slot6')
  local slot7 = getVar('apc40-slot7')
  local slot8 = getVar('apc40-slot8')

  if (slot1 ~= 'none') then
    cmd(ledMappingExecutors[slot1]['playing'])
  end

  if (slot2 ~= 'none') then
    cmd(ledMappingExecutors[slot2]['playing'])
  end

  if (slot3 ~= 'none') then
    cmd(ledMappingExecutors[slot3]['playing'])
  end

  if (slot4 ~= 'none') then
    cmd(ledMappingExecutors[slot4]['playing'])
  end

  if (slot5 ~= 'none') then
    cmd(ledMappingExecutors[slot5]['playing'])
  end

  if (slot6 ~= 'none') then
    cmd(ledMappingExecutors[slot6]['playing'])
  end

  if (slot7 ~= 'none') then
    cmd(ledMappingExecutors[slot7]['playing'])
  end

  if (slot8 ~= 'none') then
    cmd(ledMappingExecutors[slot8]['playing'])
  end

  -- Go through Presets
  for k,v in pairs(ledMappingPresets) do
    local doesExist = Utils.exists('Preset '..k)
    
    if (doesExist) then
      cmd(ledMappingPresets[k]['loaded'])
    else
      cmd(ledMappingPresets[k]['empty'])
    end        
  end

  -- Go through Groups
  for k,v in pairs(ledMappingGroups) do
    local doesExist = Utils.exists('Group '..k)
    
    if (doesExist) then
      cmd(ledMappingGroups[k]['loaded'])
    else
      cmd(ledMappingGroups[k]['empty'])
    end        
  end
end

Mapper.loadSlot = function(slot, clip)
  local loadSlot = slotMappingExecutors[slot][clip]
  if (loadSlot == nil) then
    feedback('Cannot find slot: '..slot..' with clip: '..clip)
    return
  end  
  
  local newSlot = 'none'
  -- Load slot
  local previousSlot = ''
  local slotExecutor = ''
  
  if (slot == '1') then
    previousSlot = getVar('apc40-slot1')
    slotExecutor = '7.1'
  elseif (slot == '2') then
    previousSlot = getVar('apc40-slot2')
    slotExecutor = '7.2'
  elseif (slot == '3') then
    previousSlot = getVar('apc40-slot3')
    slotExecutor = '7.3'
  elseif (slot == '4') then
    previousSlot = getVar('apc40-slot4')
    slotExecutor = '7.4'
  elseif (slot == '5') then
    previousSlot = getVar('apc40-slot5')
    slotExecutor = '7.5'
  elseif (slot == '6') then
    previousSlot = getVar('apc40-slot6')
    slotExecutor = '7.6'
  elseif (slot == '7') then
    previousSlot = getVar('apc40-slot7')
    slotExecutor = '7.7'
  elseif (slot == '8') then
    previousSlot = getVar('apc40-slot8')
    slotExecutor = '7.8'
  end

  -- If the clip in that slot does not exist, simply do nothing
  if (loadSlot ~= previousSlot and Utils.exists('Executor '..loadSlot) == false) then
    return
  end

  if (loadSlot == previousSlot) then
    cmd('Off Executor '..slotExecutor..'; Move Executor '..slotExecutor..' at Executor '..previousSlot)
    cmd(ledMappingExecutors[previousSlot]['loaded'])
    cmd(ledMappingExecutors[slotExecutor]['empty'])
  else
    if (previousSlot ~= 'none') then      
      cmd('Off Executor '..slotExecutor..'; Move Executor '..slotExecutor..' at Executor '..previousSlot)
      cmd(ledMappingExecutors[previousSlot]['loaded'])
    end

    cmd('Move Executor '..loadSlot..' at Executor '..slotExecutor)
    newSlot = loadSlot
    cmd(ledMappingExecutors[loadSlot]['playing'])
    cmd(ledMappingExecutors[slotExecutor]['loaded'])
  end

  -- Save new slot
  if (slot == '1') then
    setVar('apc40-slot1', newSlot)    
  elseif (slot == '2') then
    setVar('apc40-slot2', newSlot)    
  elseif (slot == '3') then
    setVar('apc40-slot3', newSlot)    
  elseif (slot == '4') then
    setVar('apc40-slot4', newSlot)    
  elseif (slot == '5') then
    setVar('apc40-slot5', newSlot)    
  elseif (slot == '6') then
    setVar('apc40-slot6', newSlot)    
  elseif (slot == '7') then
    setVar('apc40-slot7', newSlot)    
  elseif (slot == '8') then
    setVar('apc40-slot8', newSlot)    
  end
end

Mapper.togglePreset = function(preset)
  if (Utils.exists('Preset '..preset)) then
    local presetStatus = 'none'

    if (preset == '0.1') then
      presetStatus = getVar('apc40-preset0.1')
      setVar('apc40-preset0.1', Utils.toggleOnOff(presetStatus))
    elseif (preset == '0.2') then
      presetStatus = getVar('apc40-preset0.2')
      setVar('apc40-preset0.2', Utils.toggleOnOff(presetStatus))
    elseif (preset == '0.3') then
      presetStatus = getVar('apc40-preset0.3')
      setVar('apc40-preset0.3', Utils.toggleOnOff(presetStatus))
    elseif (preset == '0.4') then
      presetStatus = getVar('apc40-preset0.4')
      setVar('apc40-preset0.4', Utils.toggleOnOff(presetStatus))
    elseif (preset == '0.5') then
      presetStatus = getVar('apc40-preset0.5')
      setVar('apc40-preset0.5', Utils.toggleOnOff(presetStatus))
    elseif (preset == '0.6') then
      presetStatus = getVar('apc40-preset0.6')
      setVar('apc40-preset0.6', Utils.toggleOnOff(presetStatus))
    elseif (preset == '0.7') then
      presetStatus = getVar('apc40-preset0.7')
      setVar('apc40-preset0.7', Utils.toggleOnOff(presetStatus))
    elseif (preset == '0.8') then
      presetStatus = getVar('apc40-preset0.8')
      setVar('apc40-preset0.8', Utils.toggleOnOff(presetStatus))
    elseif (preset == '0.10') then
      presetStatus = getVar('apc40-preset0.10')
      setVar('apc40-preset0.10', Utils.toggleOnOff(presetStatus))
    elseif (preset == '0.11') then
      presetStatus = getVar('apc40-preset0.11')
      setVar('apc40-preset0.11', Utils.toggleOnOff(presetStatus))
    elseif (preset == '0.12') then
      presetStatus = getVar('apc40-preset0.12')
      setVar('apc40-preset0.12', Utils.toggleOnOff(presetStatus))
    elseif (preset == '0.13') then
      presetStatus = getVar('apc40-preset0.13')
      setVar('apc40-preset0.13', Utils.toggleOnOff(presetStatus))
    elseif (preset == '0.14') then
      presetStatus = getVar('apc40-preset0.14')
      setVar('apc40-preset0.14', Utils.toggleOnOff(presetStatus))
    elseif (preset == '0.15') then
      presetStatus = getVar('apc40-preset0.15')
      setVar('apc40-preset0.15', Utils.toggleOnOff(presetStatus))
    elseif (preset == '0.16') then
      presetStatus = getVar('apc40-preset0.16')
      setVar('apc40-preset0.16', Utils.toggleOnOff(presetStatus))
    elseif (preset == '0.17') then
      presetStatus = getVar('apc40-preset0.17')
      setVar('apc40-preset0.17', Utils.toggleOnOff(presetStatus))
    end

    -- Toggle preset
    if (presetStatus == 'on') then
      -- Turn off preset
      cmd('Off Preset '..preset)
      cmd(ledMappingPresets[preset]['loaded'])
      cmd('Appearance Preset '..preset..' /r')
    else
      -- Turn on preset
      cmd('Call Preset '..preset)
      cmd(ledMappingPresets[preset]['playing'])
      cmd('Appearance Preset '..preset..' /color=FF0000')
    end
  end
end

Mapper.toggleGroup = function(group)
  if (Utils.exists('Group '..group)) then
    local groupStatus = 'none'

    -- Get the current status of the group --> Immediately reversing it in the appropriate variable
    if (group == '1') then
      groupStatus = getVar('apc40-group1')
      setVar('apc40-group1', Utils.toggleOnOff(groupStatus))    
    elseif (group == '2') then
      groupStatus = getVar('apc40-group2')
      setVar('apc40-group2', Utils.toggleOnOff(groupStatus))    
    elseif (group == '3') then
      groupStatus = getVar('apc40-group3')
      setVar('apc40-group3', Utils.toggleOnOff(groupStatus))    
    elseif (group == '4') then
      groupStatus = getVar('apc40-group4')
      setVar('apc40-group4', Utils.toggleOnOff(groupStatus))    
    elseif (group == '5') then
      groupStatus = getVar('apc40-group5')
      setVar('apc40-group5', Utils.toggleOnOff(groupStatus))    
    elseif (group == '6') then
      groupStatus = getVar('apc40-group6')
      setVar('apc40-group6', Utils.toggleOnOff(groupStatus))    
    elseif (group == '7') then
      groupStatus = getVar('apc40-group7')
      setVar('apc40-group7', Utils.toggleOnOff(groupStatus))     
    end

    -- Toggle group
    if (groupStatus == 'on') then
      -- Turn off group
      cmd('Off Group '..group)
      cmd(ledMappingGroups[group]['loaded'])
      cmd('Appearance Group '..group..' /r')
    else
      -- Turn on group
      cmd('Group '..group)
      cmd(ledMappingGroups[group]['playing'])
      cmd('Appearance Group '..group..' /color=FF0000')
    end
  end
end

function apc40Mapper()
  local op = getVar('apc40-op')

  -- Check if the system is setup!
  local isSetup = getVar('apc40-setup')

  if (isSetup or op == 'setup') then    
    if (op == 'load-slot') then
      local slot = getVar('apc40-slot')
      local clip = getVar('apc40-clip')

      if (slot and clip) then
        Mapper.loadSlot(slot, clip)      
      else
        feedback('Please set apc40-slot and apc40-clip!')
      end
    elseif (op == 'refresh-leds') then
      Mapper.refreshLeds()
    elseif (op == 'setup') then
      Mapper.setup()
    elseif (op == 'toggle-group') then
      local group = getVar('apc40-group')
      Mapper.toggleGroup(group)
    elseif (op == 'toggle-preset') then
      local preset = getVar('apc40-preset')
      Mapper.togglePreset(preset)
    else
      feedback('Unknown operation "'..op..'"')
    end
  else
    feedback('Error while trying to execute operation "'..op..'": Please run SETUP first!')
  end
end


return apc40Mapper