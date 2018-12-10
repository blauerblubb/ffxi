--[[

This Gearswap Library is specifically intended to help generate UI elements showing gearswap related information such as current Gearswap Modes.
Additionally it allows to add displays containgin other informations.

Currently added features are:
- Gearswap Modes. By default it only shows when a mode is in a non standard mode, but this can be adjusted by setting 'minimal = false'
- Scholar Timer. This is a timer which will display information on available strategems
- Rune Helper. This shows the Rune Elements and their resistance
- Movement Speed Information
- Zone Timer


Planned features:
- Way to toggle the different UI elements from the game instead of the file

]]


--[[
========================================
=== Configuration
========================================
]]--

local InfoBox = require('ui-lib-box')
local packets = require('packets')
local res = require('resources')
local start_time = os.time()

local boxSettings = {}
local uibox = {}
local schbuff = ''
local runes = ''

-- UI Options:
separator = 'OFF'
minimal = 'ON'
timerinfo = 'ON'
speedinfo = 'ON'
strathelper = 'OFF'
bsthelper = 'OFF'

--boxSettings.modes = {pos = {x = 998, y = -234},text = {font='Arial', size = 12, stroke = {width = 1.75, red = 0, green = 0,blue = 0}},flags = {bottom = true}, bg = {alpha = 0}}
boxSettings.modes = {pos = {x = 18, y = -19},text = {font='Arial', size = 12, stroke = {width = 1.75, red = 0, green = 0,blue = 0}},flags = {bottom = true}, bg = {alpha = 0}}
boxSettings.stratagems = {pos = {x = 5, y = 500},text = {font='Arial', size = 12, stroke = {width = 1.75, red = 0, green = 0,blue = 0}}, bg = {alpha = 0}}
boxSettings.bstcharges = {pos = {x = 5, y = 500},text = {font='Arial', size = 12, stroke = {width = 1.75, red = 0, green = 0,blue = 0}}, bg = {alpha = 0}}
boxSettings.runefencer = {pos = {x = 5, y = 500},text = {font='Arial', size = 12, stroke = {width = 1.75, red = 0, green = 0,blue = 0}}, bg = {alpha = 0}}
boxSettings.speed = {pos = {x = 0, y = -19},text = {font='Arial', size = 10, stroke = {width = 1.75, red = 0, green = 0,blue = 0}}, bg = {alpha = 0}, flags = {bottom = true, right = true}}
boxSettings.haste = {pos = {x = -120, y = -20}, text = {font='Arial', size = 12, stroke = {width = 1.75, red = 0, green = 0,blue = 0}}, bg = {alpha = 0}, flags = {bottom = true, right = true}}
boxSettings.player = {pos = {x = -220, y = -20}, text = {font='Arial', size = 12, stroke = {width = 1.75, red = 0, green = 0,blue = 0}}, bg = {alpha = 0}, flags = {bottom = true, right = true}}
boxSettings.zt = {pos = {x = -100, y = 0}, text = {font='Arial', size = 10, stroke = {width = 1.75, red = 0, green = 0,blue = 0}}, bg = {alpha = 0}, flags = {right = true}}

--Colors
local colred = '\\cs(255,60,60)'
local colgreen = '\\cs(50,255,50)'
local colblue = '\\cs(50,125,255)'
local colorange = '\\cs(255,150,0)'
local colyellow = '\\cs(255,255,0)'
local colblack = '\\cs(120,120,120)'

--JOB Groups
local offense_jobs = T{'SAM','DRK','WAR','BLU','MNK','THF','BST','RNG','DRG','COR','PUP','DNC','RUN'}
local tank_jobs = T{'PLD','RUN','NIN'}
local range_jobs = T{'RNG','COR'}
local mage_jobs = T{'SCH','BLM','WHM','RDM','GEO','SMN','BRD','BLU'}
local pet_jobs = T{'SMN','BST','PUP'}

uibox.modes = InfoBox.new(boxSettings.modes)
uibox.stratagems = InfoBox.new(boxSettings.stratagems, 'Stratagems')
uibox.bstcharges = InfoBox.new(boxSettings.bstcharges)
uibox.runefencer = InfoBox.new(boxSettings.runefencer)
uibox.speed = InfoBox.new(boxSettings.speed)
uibox.haste = InfoBox.new(boxSettings.haste)
uibox.player = InfoBox.new(boxSettings.player)
uibox.zt = InfoBox.new(boxSettings.zt)

--[[
========================================
=== UI Functions
========================================
]]--


windower.register_event('prerender', function()
  if player then
    ui_gs_modes() --modes

    local now = os.time()
    if zonetimer == 'ON' then
      uibox.zt:updateContents(os.date('!%H:%M:%S', now-start_time))
    else
      uibox.zt:hide()
    end

    if S{player.main_job, player.sub_job}:contains('SCH') then
      scholartimer()
    end
    if S{player.main_job}:contains('BST') then
      ui_bstcharges()
    end
    local me = windower.ffxi.get_mob_by_target('me')

    if me and speedinfo == 'ON' then
      uibox.speed:updateContents('%+.0f %%':format(100*((me.movement_speed/5)-1)))
    else
      uibox.speed:hide()
    end
  end
end)

function ui_gs_modes()
  -- disable minimalist mode for certain jobs
  --[[
  if minimal == true and player.main_job == 'RUN' then
    minimal = false
  else
    minimal = true
  end
  ]]--

  --reformat(windower.ffxi.get_abilities())
  local str = ''
  if separator == 'ON' then
    local str = '  \\cs(255,255,0)***\\cr     '
  end
  --Create UI for the different Modes

  --some custom modes I want to have at the beginning:
  ------------------
  -- Weapons
  ------------------
  if player.equipment.main ~= nil then
    if player.equipment.main == 'Epeolatry' then
      str = str..'Weapon:\\cs(255,0,0) Epeolatry\\cr     '
    elseif player.equipment.main == 'Lionheart' then
      str = str..'Weapon:\\cs(255,215,0) Lionheart\\cr     '
    else
      str = str..'Weapon:\\cs(50,125,255) '..player.equipment.main..'\\cr     '
    end
  end


  ----------
  -- PLD
  ----------
  if player.main_job == 'PLD' then
    if player.equipment.sub == 'Aegis' then
      str = str..'Shield:\\cs(255,215,0) Aegis\\cr     '
    elseif player.equipment.sub == 'Ochain' then
      str = str..'Shield:\\cs(132,132,130) Ochain\\cr     '
    elseif player.equipment.sub == 'Srivatsa' then
      str = str..'Shield:\\cs(138,43,226) Srivatsa\\cr     '
    else
      str = str..'Shield:\\cs(50,125,255) '..player.equipment.sub..'\\cr     '
    end
  end

  ----------
  -- RUN
  ----------
  if player.main_job == 'RUN' then
    if separator == 'ON' then
      str = str..'[~\\cs(255,255,0)RUN\\cr~]\\cr  '
    end
    runedetails()
    if state.Runes ~= nil then
      if state.Runes.value == 'Ignis' then
        runes = 'Runes: '..colred..state.Runes.value..'\\cr     '
      elseif state.Runes.value == 'Gelus' then
        runes = 'Runes: '..'\\cs(100,200,255)'..state.Runes.value..'\\cr     '
      elseif state.Runes.value == 'Flabra' then
        runes = 'Runes: '..colgreen..state.Runes.value..'\\cr     '
      elseif state.Runes.value == 'Tellus' then
        runes = 'Runes: '..colyellow..state.Runes.value..'\\cr     '
      elseif state.Runes.value == 'Sulpor' then
        runes = 'Runes: '..'\\cs(200,50,200)'..state.Runes.value..'\\cr     '
      elseif state.Runes.value == 'Unda' then
        runes = 'Runes: '..colblue..state.Runes.value..'\\cr     '
      elseif state.Runes.value == 'Lux' then
        runes = 'Runes: '..'\\cs(255,255,255)'..state.Runes.value..'\\cr     '
      elseif state.Runes.value == 'Tenebrae' then
        runes = 'Runes: '..'\\cs(120,120,120)'..state.Runes.value..'\\cr     '
      end
      str = str..runes
    end
  end

  ----------
  -- BRD
  ----------
  if player.main_job == 'BRD' then
    if buffmode ~= nil then
      if buffmode == 'marsy' then
        str = str..'Instr.: \\cs(0,206,210)Marsyas\\cr     '
      elseif buffmode == 'harp' then
        str = str..'Instr.: \\cs(215,72,148)Daurdabla\\cr     '
      elseif buffmode == 'horn' then
        str = str..'Instr.: \\cs(255,215,0)Gjallarhorn\\cr     '
      else
        str = str..'Instr.: '..colblue..buffmode..'\\cr     '
      end
    end
    if durationmode ~= nil then
      if durationmode == 'off' then
        if minimal == 'OFF' then
          str = str..'Duration: '..colblue..durationmode..'\\cr     '
        end
      else
        str = str..'Duration: '..colred..durationmode..'\\cr     '
      end
    end
    if Idlemode ~= nil then
      str = str..'Idle: '..colblue..Idlemode..'\\cr     '
    end
    if dwmode ~= nil then
      if minimal == 'OFF' then
        if dwmode == '12dw' then
          str = str..'DW: '..colgreen..dwmode..'\\cr     '
        elseif dwmode == '14dw' then
          str = str..'DW: '..colorange..dwmode..'\\cr     '
        elseif dwmode ~= nil then
          str = str..'DW: '..colblue..dwmode..'\\cr     '
        end
      end
    end
    if ddmode ~= nil then
      if ddmode == 'Standard' then
        if minimal == 'OFF' then
          str = str..'ACC: '..colblue..ddmode..'\\cr     '
        end
      else
        str = str..'ACC: '..colorange..ddmode..'\\cr     '
      end
    end
    if WeaponMode ~= nil then
      if WeaponMode == 'Locked' then
        str = str..'Weapon: '..colred..WeaponMode..'\\cr     '
      else
        str = str..'Weapon: '..colblue..WeaponMode..'\\cr     '
      end
    end
  end

  --Universal Modes
  if state.OffenseMode ~= nil then
    if separator == 'ON' then
      str = str..'[~\\cs(255,255,0)ATT\\cr~]\\cr  '
    end
    if state.OffenseMode.value == 'None' or state.OffenseMode.value == 'Normal' then
      if minimal == 'OFF' then
        str = str..'Offense: '..colblue..state.OffenseMode.value..'\\cr     '
      end
    elseif state.OffenseMode.value == 'STP' then
      str = str..'Offense: '..colorange..state.OffenseMode.value..'\\cr     '
    elseif state.OffenseMode.value:contains('Acc') then
      str = str..'Offense: '..colgreen..state.OffenseMode.value..'\\cr     '
    elseif state.OffenseMode.value == 'Mixed' then
      str = str..'Offense: '..colred..state.OffenseMode.value..'\\cr     '
    else
      str = str..'Offense: '..colorange..state.OffenseMode.value..'\\cr     '
    end
  end
  if state.DefenseMode ~= nil then
    if separator == 'ON' then
      str = str..'[~\\cs(255,255,0)DEF\\cr~]\\cr  '
    end
    if state.DefenseMode.value == 'None' then
      if minimal == 'OFF' then
        str = str..'Defense: '..colblue..state.DefenseMode.value..'\\cr     '
      end
    else
      str = str..'Defense: '..colred..state.DefenseMode.value..'\\cr     '
    end
  end
  if state.IdleMode ~= nil then
    if state.IdleMode.value == 'Normal' then
      if minimal == 'OFF' then
        str = str..'Idle: '..colblue..state.IdleMode.value..'\\cr     '
      end
    else
      str = str..'Idle: '..colblue..state.IdleMode.value..'\\cr     '
    end
  end

  --Tank Modes:
  for i,job in pairs(tank_jobs) do
    if S{player.main_job}:contains(job) then
      if separator == 'ON' then
        str = str..'[~\\cs(255,255,0)TANK\\cr~]\\cr  '
      end
      --windower.add_to_chat(123,job)
      if state.PhysicalDefenseMode ~= nil then
        if state.PhysicalDefenseMode.value == 'PDT' then
          if minimal == 'OFF' then
            str = str..'PDT: '..colblue..state.PhysicalDefenseMode.value..'\\cr     '
          end
        else
          str = str..'PDT: '..colred..state.PhysicalDefenseMode.value..'\\cr     '
        end
      end
      if state.MagicalDefenseMode ~= nil then
        if state.MagicalDefenseMode.value == 'MDT' then
          if minimal == 'OFF' then
            str = str..'MDT: '..colblue..state.MagicalDefenseMode.value..'\\cr     '
          end
        else
          str = str..'MDT: '..colred..state.MagicalDefenseMode.value..'\\cr     '
        end
      end
    end
  end

  -- DD Jobs
  for i,job in pairs(offense_jobs) do
    if S{player.main_job}:contains(job) then
      if separator == 'ON' then
        str = str..'[~\\cs(255,255,0)DD\\cr~]\\cr  '
      end
      --windower.add_to_chat(123,job)
      if state.WeaponMode ~= nil then
        if state.WeaponMode.value == 'Normal' then
          if minimal == 'OFF' then
            str = str..'Hybrid: '..colorange..state.WeaponMode.value..'\\cr     '
          end
        else
          str = str..'Hybrid: '..colorange..state.WeaponMode.value..'\\cr     '
        end
      end
      if state.HybridMode ~= nil then
        if state.HybridMode.value == 'Normal' then
          if minimal == 'OFF' then
            str = str..'Hybrid: '..colorange..state.HybridMode.value..'\\cr     '
          end
        else
          str = str..'Hybrid: '..colorange..state.HybridMode.value..'\\cr     '
        end
      end
      if state.WeaponskillMode ~= nil then
        if state.WeaponskillMode.value == 'Normal' then
          if minimal == 'OFF' then
            str = str..'WS: '..colorange..state.WeaponskillMode.value..'\\cr     '
          end
        else
          str = str..'WS: '..colorange..state.WeaponskillMode.value..'\\cr     '
        end
      end
      if state.CustomMeleeGroups ~= nil then
        if state.CustomMeleeGroups.value == 'Normal' then
          if minimal == 'OFF' then
            str = str..'CustomMelee: '..colorange..state.CustomMeleeGroups.value..'\\cr     '
          end
        else
          str = str..'CustomMelee: '..colorange..state.CustomMeleeGroups.value..'\\cr     '
        end
      end
    end
  end

  --Mage Modes:
  for i,job in pairs(mage_jobs) do
    if S{player.main_job}:contains(job) then
      if separator == 'ON' then
        str = str..'[~\\cs(255,255,0)MAGE\\cr~]\\cr  '
      end
      --windower.add_to_chat(123,job)
      if state.CastingMode ~= nil then
        if state.CastingMode.value == 'Normal' then
          if minimal == 'OFF' then
            str = str..'Casting: '..colgreen..state.CastingMode.value..'\\cr     '
          end
        else
          str = str..'Casting: '..colgreen..state.CastingMode.value..'\\cr     '
        end
      end
      if state.MagicBurst ~= nil then
        if state.MagicBurst.value == 'off' then
          if minimal == 'OFF' then
            str = str..'Burst: '..colgreen..state.MagicBurst.value..'\\cr     '
          end
        else
          str = str..'Burst: '..colgreen..state.MagicBurst.value..'\\cr     '
        end
      end
      if state.MPMode ~= nil and player.main_job == 'BLM' then
        if state.MPMode.value == '0' then
          if minimal == 'OFF' then
            str = str..'AF Body%: '..colgreen..state.MPMode.value..'\\cr     '
          end
        else
          str = str..'AF Body%: '..colgreen..state.MPMode.value..'\\cr     '
        end
      end
    end
  end

  --Range Modes:
  for i,job in pairs(range_jobs) do
    if S{player.main_job}:contains(job) then
      if separator == 'ON' then
        str = str..'[~\\cs(255,255,0)RANGE\\cr~]\\cr  '
      end
      --windower.add_to_chat(123,job)
      if state.RangedMode ~= nil then
        if state.RangedMode.value == 'Normal' then
          if minimal == 'OFF' then
            str = str..'Range: '..colred..state.RangedMode.value..'\\cr     '
          end
        else
          str = str..'Range: '..colred..state.RangedMode.value..'\\cr     '
        end
      end
    end
  end

  --Pet Modes:
  for i,job in pairs(pet_jobs) do
    if S{player.main_job}:contains(job) then
      if separator == 'ON' then
        str = str..'[~\\cs(255,255,0)PET\\cr~]\\cr  '
      end
      --windower.add_to_chat(123,job)
      if state.CorrelationMode ~= nil then
        if state.CorrelationMode.value == 'Neutral' then
          if minimal == 'OFF' then
            str = str..'Correlation: '..colgreen..state.CorrelationMode.value..'\\cr     '
          end
        else
          str = str..'Correlation: '..colgreen..state.CorrelationMode.value..'\\cr     '
        end
      end
      if state.CustomIdleGroups ~= nil then
        if state.CustomIdleGroups.value == 'Normal' then
          if minimal == 'OFF' then
            str = str..'CustomIdle: '..colgreen..state.CustomIdleGroups.value..'\\cr     '
          end
        else
          str = str..'CustomIdle: '..colgreen..state.CustomIdleGroups.value..'\\cr     '
        end
      end
    end
  end

  -- Update Box
  if str ~= nil then
    if separator == 'ON' then
      local str = '\\cs(255,255,0)***\\cr  '
    end
    uibox.modes:updateContents(str)
  else
    uibox.modes:hide()
  end
end

function ui_self_command(cmdParams)
  if command == 'reset' then
    local var = 0
    windower.add_to_chat(0, 'Reset Complete')
  end
end


--[[
========================================
=== Helper Functions
========================================
]]--

-- Set Start Time
windower.register_event('zone change', function(new_zone, old_zone)
	start_time = os.time()
end)

-- For BST to see how many Charges Remain
function ui_bstcharges()
  charges = 3
  if S{player.main_job}:contains('BST') and bsthelper == 'ON' then
      ready = windower.ffxi.get_ability_recasts()[102]
    if ready ~= 0 then
      charges = math.floor(((30 - ready) / 10))
    end
    uibox.bstcharges:updateContents('Ready Recast: '..ready..'\nCharges Remaining: '..charges..'')
  else
    uibox.bstcharges:hide()
  end
end

function scholartimer()
  -- Create SCH Strattimer
  if windower.ffxi.get_player() ~= nil then
  	if S{player.main_job, player.sub_job}:contains('SCH') and strathelper == 'ON' then
  		local strats = get_current_strategem_count()
  		local allRecasts = windower.ffxi.get_ability_recasts()
  		local stratsRecast = allRecasts[231]
  		local stratcol = '\\cs(0,255,0)'
  		local modecol = '\\cs(0,255,0)'
  		if (strats == 0) then
  			stratcol = '\\cs(255,0,0)'
  		elseif (strats <= 2) and player.main_job == 'SCH' then
  			stratcol = '\\cs(255,100,0)'
  		end
  		if ui_check_buffs('Addendum: Black') then
  			modecol = '\\cs(153,85,187)'
  			schbuff = 'Addendum: Black'
  		elseif ui_check_buffs('Dark Arts') then
  			modecol = '\\cs(153,85,187)'
  			schbuff = 'Dark Arts'
  		elseif ui_check_buffs('Addendum: White') then
  			modecol = '\\cs(238,221,130)'
  			schbuff = 'Addendum: White'
  		elseif ui_check_buffs('Light Arts') then
  			modecol = '\\cs(238,221,130)'
  			schbuff = 'Light Arts'
  		else
  			modecol = '\\cs(0,0,0)'
  		end
  		uibox.stratagems:updateContents('\nMode: '..modecol..schbuff..'\\cr\n*Remaining:  '..stratcol..strats..'/'..maxStrategems..' charges\\cr\n*Recast:     '..recast_timer()..' seconds\n*FullCharge: '..stratsRecast..' seconds')
  	else
  		uibox.stratagems:hide()
  	end
  else
    uibox.stratagems:hide()
  end
end

function runedetails()
  local msg = ''
  if S{player.main_job, player.sub_job}:contains('RUN') and runeHelper == 'ON' then
    msg = msg .. '[ *          '..runes.. '     * ]'
  	msg = msg .. '\n \\cs(255,0,0) Ignis = Fire\\cr >>> \\cs(100,200,255) Resist Ice\\cr'
  	msg = msg .. '\n \\cs(100,200,255) Gelus = Ice \\cr >>> \\cs(50,255,50) Resist Wind\\cr'
  	msg = msg .. '\n \\cs(50,255,50) Flabra = Wind \\cr	>>> \\cs(255,255,0) Resist Earth\\cr'
  	msg = msg .. '\n \\cs(255,255,0) Tellus = Earth \\cr >>> \\cs(200,50,200) Resist Thunder\\cr'
  	msg = msg .. '\n \\cs(200,50,200) Sulpor = Thunder \\cr >>> \\cs(50,125,255) Resist Water\\cr'
  	msg = msg .. '\n \\cs(50,125,255) Unda = Water \\cr >>> \\cs(255,0,0) Resist Fire\\cr'
  	msg = msg .. '\n \\cs(255,255,255) Lux = Light \\cr >>> \\cs(120,120,120) Resist Dark\\cr'
  	msg = msg .. '\n \\cs(120,120,120) Tenebrae  = Dark \\cr >>> \\cs(255,255,255) Resist Light\\cr'
    uibox.runefencer:updateContents(msg)
  else
    uibox.runefencer:hide()
  end
end

-- Calculate stratagems
function usersetup(org)
	local sub_job = windower.ffxi.get_player().sub_job
	local main_job = windower.ffxi.get_player().main_job

	if main_job == 'SCH' then
    local totaljp = player.job_points.sch.jp_spent
		local main_job_level = windower.ffxi.get_player().main_job_level
		if main_job_level >= 10 and main_job_level <= 29 then
			strattimer = '240'
		elseif main_job_level >= 30 and main_job_level <= 49 then
			strattimer = '120'
		elseif main_job_level >= 50 and main_job_level <= 69 then
			strattimer = '80'
		elseif main_job_level >= 70 and main_job_level <= 89 then
			strattimer = '60'
		elseif main_job_level >= 90 and main_job_level < 99 then
			strattimer = '48'
		elseif main_job_level == 99 then
			if totaljp ~= nil and totaljp < 550 then
				strattimer = '48'
			else
				strattimer = '33'
			end
		end
		return strattimer
	elseif sub_job == 'SCH' then
		local sub_job_level = windower.ffxi.get_player().sub_job_level
		if sub_job_level >= 10 and sub_job_level <= 29 then
			strattimer = '240'
		elseif sub_job_level >= 30 and sub_job_level <= 49 then
			strattimer = '120'
		end
		return strattimer
	end
end

function get_current_strategem_count()
	local allRecasts = windower.ffxi.get_ability_recasts()
	local stratsRecast = allRecasts[231]
	if windower.ffxi.get_player().main_job == 'SCH' then
		maxStrategems = math.floor((windower.ffxi.get_player().main_job_level + 10) / 20)
	elseif windower.ffxi.get_player().sub_job == 'SCH' then
		maxStrategems = math.floor((windower.ffxi.get_player().sub_job_level + 10) / 20)
	else
		print('Something went wrong with the current job selection.')
	end
	if usersetup(strattimer) ~= nil then
		local strattimer = usersetup(strattimer)
	else
		local strattimer = '33'
	end
	local fullRechargeTime = math.floor(maxStrategems * strattimer)
	local currentCharges = math.floor(maxStrategems - maxStrategems * stratsRecast / fullRechargeTime)
	return currentCharges
end

function recast_timer()
	if windower.ffxi.get_player().main_job == 'SCH' then
		maxStrategems = math.floor((windower.ffxi.get_player().main_job_level + 10) / 20)
	elseif windower.ffxi.get_player().sub_job == 'SCH' then
		maxStrategems = math.floor((windower.ffxi.get_player().sub_job_level + 10) / 20)
	else
		print('Something went wrong with the current job selection.')
	end
	local allRecasts = windower.ffxi.get_ability_recasts()
	local stratsRecast = allRecasts[231]
	local usedstrat = math.floor(maxStrategems - get_current_strategem_count())
	local totalrecast = math.floor(usedstrat * usersetup(strattimer))
	if usedstrat > 1 then
		timer = math.floor(stratsRecast - ((maxStrategems - get_current_strategem_count()) - 1) * usersetup(strattimer))
	else
		timer = math.floor(stratsRecast)
	end
	return timer
end

-- check buffs
function ui_check_buffs(...)
    --[[ Function Author: Arcon
            Simple check before attempting to auto activate Job Abilities that
            check active buffs and debuffs ]]
    return table.any({...}, table.get+{buffactive})
end
