-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Migawari = buffactive.migawari or false
    state.Buff.Doom = buffactive.doom or false
    state.Buff.Yonin = buffactive.Yonin or false
    state.Buff.Innin = buffactive.Innin or false
    state.Buff.Futae = buffactive.Futae or false

    determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'Evasion', 'PDT')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('PDT', 'Evasion')
	state.AutoWS = M{['description']='Auto WS', 'Blade: Jin', 'Blade: Ten', 'Blade: Chi', 'Blade: Ei', 'Blade: To'}
	
    gear.MovementFeet = {name="Danzo Sune-ate"}
    gear.DayFeet = "Danzo Sune-ate"
    gear.NightFeet = "Hachiya Kyahan"
    
    select_movement_feet()
    select_default_macro_book()
	
	send_command('bind !p gs c auto_action')
	send_command('bind ![ gs c auto_trust')
	send_command('bind @home gs c cycle AutoWS')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Mijin Gakure'] = {legs="Mochizuki Hakama"}
    sets.precast.JA['Futae'] = {legs="Iga Tekko +2"}
    sets.precast.JA['Sange'] = {legs="Mochizuki Chainmail"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Sonia's Plectrum",
        head="Felistris Mask",
        body="Hachiya Chainmail +1",hands="Buremte Gloves",ring1="Spiral Ring",
        back="Iximulew Cape",waist="Caudata Belt",legs="Nahtirah Trousers",feet="Otronif Boots +1"}
        -- Uk'uxkaj Cap, Daihanshi Habaki
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Set for acc on steps, since Yonin drops acc a fair bit
    sets.precast.Step = {
        head="Whirlpool Mask",neck="Ej Necklace",
        body="Otronif Harness +1",hands="Buremte Gloves",ring1="Patricius Ring",
        back="Yokaze Mantle",waist="Chaac Belt",legs="Manibozho Brais",feet="Otronif Boots +1"}

    sets.precast.Flourish1 = {waist="Chaac Belt"}

    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Impatiens",ear2="Loquacious Earring",hands="Thaumas Gloves",ring1="Prolix Ring"}
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Mochizuki Chainmail"})

    -- Snapshot for ranged
    sets.precast.RA = {hands="Manibozho Gloves",legs="Nahtirah Trousers",feet="Wurrukatte Boots"}
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Qirmiz Tathlum",
        head="Whirlpool Mask",neck=gear.ElementalGorget,ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Qaaxo Harness",hands="Mochizuki Tekko",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Atheling Mantle",waist=gear.ElementalBelt,legs="Manibozho Brais",feet="Otronif Boots +1"}
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {ammo="Jukukik Feather",hands="Buremte Gloves",
        back="Yokaze Mantle"})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Blade: Jin'] = set_combine(sets.precast.WS,
        {neck="Rancor Collar",ear1="Brutal Earring",ear2="Moonshade Earring",feet="Daihanshi Habaki"})

    sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS,
        {head="Felistris Mask",hands="Hachiya Tekko",ring1="Stormsoul Ring",legs="Nahtirah Trousers"})

    sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS, {feet="Daihanshi Habaki"})


    sets.precast.WS['Aeolian Edge'] = {
        head="Wayfarer Circlet",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Moonshade Earring",
        body="Wayfarer Robe",hands="Wayfarer Cuffs",ring1="Acumen Ring",ring2="Demon's Ring",
        back="Toro Cape",waist="Thunder Belt",legs="Shneddick Tights +1",feet="Daihanshi Habaki"}

    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
        head="Felistris Mask",ear2="Loquacious Earring",
        body="Hachiya Chainmail +1",hands="Mochizuki Tekko",ring1="Prolix Ring",
        legs="Hachiya Hakama",feet="Qaaxo Leggings"}
        
    sets.midcast.Utsusemi = set_combine(sets.midcast.SelfNinjutsu, {feet="Iga Kyahan +2"})

    sets.midcast.ElementalNinjutsu = {
        head="Hachiya Hatsuburi",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Hachiya Chainmail +1",hands="Iga Tekko +2",ring1="Icesoul Ring",ring2="Acumen Ring",
        back="Toro Cape",waist=gear.ElementalObi,legs="Nahtirah Trousers",feet="Hachiya Kyahan"}

    sets.midcast.ElementalNinjutsu.Resistant = set_combine(sets.midcast.Ninjutsu, {ear1="Lifestorm Earring",ear2="Psystorm Earring",
        back="Yokaze Mantle"})

    sets.midcast.NinjutsuDebuff = {
        head="Hachiya Hatsuburi",neck="Stoicheion Medal",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        hands="Mochizuki Tekko",ring2="Sangoma Ring",
        back="Yokaze Mantle",feet="Hachiya Kyahan"}

    sets.midcast.NinjutsuBuff = {head="Hachiya Hatsuburi",neck="Ej Necklace",back="Yokaze Mantle"}

    sets.midcast.RA = {
        head="Felistris Mask",neck="Ej Necklace",
        body="Hachiya Chainmail +1",hands="Hachiya Tekko",ring1="Beeline Ring",
        back="Yokaze Mantle",legs="Nahtirah Trousers",feet="Qaaxo Leggings"}
    -- Hachiya Hakama/Thurandaut Tights +1

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
    
    -- Resting sets
    sets.resting = {head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",
        ring1="Sheltered Ring",ring2="Paguroidea Ring"}
    
    -- Idle sets
    sets.idle = {
		ammo="Ginsen",
		head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
		body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
		hands={ name="Herculean Gloves", augments={'Attack+29','"Triple Atk."+3','DEX+8',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'Accuracy+24 Attack+24','"Triple Atk."+3','DEX+5','Accuracy+5',}},
		neck="Sanctity Necklace",
		waist="Windbuffet Belt +1",
		left_ear="Telos Earring",
		right_ear="Suppanomimi",
		left_ring="Defending Ring",
		right_ring="Vocane Ring",
		back="Moonbeam Cape",}

    sets.idle.Town = sets.idle
    sets.idle.Weak = sets.idle
    
    -- Defense sets
    sets.defense.Evasion = {
        head="Felistris Mask",neck="Ej Necklace",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="Defending Ring",ring2="Beeline Ring",
        back="Yokaze Mantle",waist="Flume Belt",legs="Nahtirah Trousers",feet="Otronif Boots +1"}

    sets.defense.PDT = set_combine(sets.idle, {
		left_ear="Colossus's Earring",
		neck="Loricate Torque +1",
		left_ring="Defending Ring",
		right_ring="Vocane Ring",
		back="Moonbeam Cape",})

    sets.defense.MDT = set_combine(sets.defense.PDT, {
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",})


    sets.Kiting = {feet=gear.MovementFeet}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
		ammo="Ginsen",
		head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
		body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
		hands={ name="Herculean Gloves", augments={'Attack+29','"Triple Atk."+3','DEX+8',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'Accuracy+24 Attack+24','"Triple Atk."+3','DEX+5','Accuracy+5',}},
		neck="Ainia Collar",
		waist="Windbuffet Belt +1",
		left_ear="Telos Earring",
		right_ear="Suppanomimi",
		left_ring="Hetairoi Ring",
		right_ring="Epona's Ring",
		back="Bleating Mantle",}
		
    sets.engaged.Acc = set_combine(sets.engaged, {})
    sets.engaged.Evasion = set_combine(sets.engaged, {})
    sets.engaged.Acc.Evasion = set_combine(sets.engaged, {})
    sets.engaged.PDT = set_combine(sets.engaged, {})
    sets.engaged.Acc.PDT = set_combine(sets.engaged, {})

    -- Custom melee group: High Haste (~20% DW)
    sets.engaged.HighHaste = set_combine(sets.engaged, {})
    sets.engaged.Acc.HighHaste = set_combine(sets.engaged, {})
    sets.engaged.Evasion.HighHaste = set_combine(sets.engaged, {})
    sets.engaged.Acc.Evasion.HighHaste = set_combine(sets.engaged, {})
    sets.engaged.PDT.HighHaste = set_combine(sets.engaged, {})
    sets.engaged.Acc.PDT.HighHaste = set_combine(sets.engaged, {})

    -- Custom melee group: Embrava Haste (7% DW)
    sets.engaged.EmbravaHaste = set_combine(sets.engaged, {})
    sets.engaged.Acc.EmbravaHaste = set_combine(sets.engaged, {})
    sets.engaged.Evasion.EmbravaHaste = set_combine(sets.engaged, {})
    sets.engaged.Acc.Evasion.EmbravaHaste = set_combine(sets.engaged, {})
    sets.engaged.PDT.EmbravaHaste = set_combine(sets.engaged, {})
    sets.engaged.Acc.PDT.EmbravaHaste = set_combine(sets.engaged, {})

    -- Custom melee group: Max Haste (0% DW)
    sets.engaged.MaxHaste = set_combine(sets.engaged, {})
    sets.engaged.Acc.MaxHaste = set_combine(sets.engaged, {})
    sets.engaged.Evasion.MaxHaste = set_combine(sets.engaged, {})
    sets.engaged.Acc.Evasion.MaxHaste = set_combine(sets.engaged, {})
    sets.engaged.PDT.MaxHaste = set_combine(sets.engaged, {})
    sets.engaged.Acc.PDT.MaxHaste = set_combine(sets.engaged, {})


    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Migawari = {body="Iga Ningi +2"}
    sets.buff.Doom = {ring2="Saida Ring"}
    sets.buff.Yonin = {}
    sets.buff.Innin = {}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.Buff.Doom then
        equip(sets.buff.Doom)
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted and spell.english == "Migawari: Ichi" then
        state.Buff.Migawari = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste','march','embrava','haste samba'}:contains(buff:lower()) then
        determine_haste_group()
        handle_equipping_gear(player.status)
    elseif state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    end
end

function job_status_change(new_status, old_status)
    if new_status == 'Idle' then
        select_movement_feet()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Get custom spell maps
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == "Ninjutsu" then
        if not default_spell_map then
            if spell.target.type == 'SELF' then
                return 'NinjutsuBuff'
            else
                return 'NinjutsuDebuff'
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.Buff.Migawari then
        idleSet = set_combine(idleSet, sets.buff.Migawari)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    return idleSet
end


-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Migawari then
        meleeSet = set_combine(meleeSet, sets.buff.Migawari)
    end
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    return meleeSet
end

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
    select_movement_feet()
    determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_haste_group()
    -- We have three groups of DW in gear: Hachiya body/legs, Iga head + Patentia Sash, and DW earrings
    
    -- Standard gear set reaches near capped delay with just Haste (77%-78%, depending on HQs)

    -- For high haste, we want to be able to drop one of the 10% groups.
    -- Basic gear hits capped delay (roughly) with:
    -- 1 March + Haste
    -- 2 March
    -- Haste + Haste Samba
    -- 1 March + Haste Samba
    -- Embrava
    
    -- High haste buffs:
    -- 2x Marches + Haste Samba == 19% DW in gear
    -- 1x March + Haste + Haste Samba == 22% DW in gear
    -- Embrava + Haste or 1x March == 7% DW in gear
    
    -- For max haste (capped magic haste + 25% gear haste), we can drop all DW gear.
    -- Max haste buffs:
    -- Embrava + Haste+March or 2x March
    -- 2x Marches + Haste
    
    -- So we want four tiers:
    -- Normal DW
    -- 20% DW -- High Haste
    -- 7% DW (earrings) - Embrava Haste (specialized situation with embrava and haste, but no marches)
    -- 0 DW - Max Haste
    
    classes.CustomMeleeGroups:clear()
    
    if buffactive.embrava and (buffactive.march == 2 or (buffactive.march and buffactive.haste)) then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.march == 2 and buffactive.haste then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.embrava and (buffactive.haste or buffactive.march) then
        classes.CustomMeleeGroups:append('EmbravaHaste')
    elseif buffactive.march == 1 and buffactive.haste and buffactive['haste samba'] then
        classes.CustomMeleeGroups:append('HighHaste')
    elseif buffactive.march == 2 then
        classes.CustomMeleeGroups:append('HighHaste')
    end
end


function select_movement_feet()
    if world.time >= 17*60 or world.time < 7*60 then
        gear.MovementFeet.name = gear.NightFeet
    else
        gear.MovementFeet.name = gear.DayFeet
    end
end


function check_buffs(...)
    --[[ Function Author: Arcon
            Simple check before attempting to auto activate Job Abilities that
            check active buffs and debuffs ]]
    return table.any({...}, table.get+{buffactive})
end

do
    --[[ Author: Arcon
            The three next "do" sections are used to aid in checking recast
            times, can check multiple recast times at once ]]
    local cache = {}

    function j(str)
        if not cache[str] then
            cache[str] = gearswap.res.job_abilities:with('name', str)
        end

        return cache[str]
    end
end

do
    local cache = {}

    function s(str)
        if not cache[str] then
            cache[str] = gearswap.res.spells:with('name', str)
        end

        return cache[str]
    end
end

do
    local ja_types = S(gearswap.res.job_abilities:map(table.get-{'type'}))

    function check_recasts(...)
        local spells = S{...}

        for spell in spells:it() do
            local fn = 'get_' .. (ja_types:contains(spell.type)
                    and 'ability'
                    or 'spell') ..'_recasts'
            if windower.ffxi[fn]()[spell.recast_id] > 0 then
                return false
            end
        end

        return true
    end
end

windower.register_event('tp change', function(new, old)
	if not areas.Cities:contains(world.area) then
		if auto_trust == 'On' then
			check_trust()
		end
		if auto_action == 'On' then
			relaxed_play_mode()
			if new > 349 and player.status == 'Engaged' then
				relaxed_play_mode_WS()
			end
		end
	end
end)

windower.register_event('time change', function(time)
	if not areas.Cities:contains(world.area) then
		if auto_trust == 'On' then
			check_trust()
		end
		if auto_action == 'On' then
			relaxed_play_mode()
			if player.tp == 3000 and player.status == 'Engaged' then
				relaxed_play_mode_WS()
			end
		end
	end
end)

function job_self_command(cmdParams, eventArgs)

    -- Use an in game macro "/con gs c auto_action" to toggle bot Off and On
    if cmdParams[1]:lower() == 'auto_action' then
        if auto_action == 'Off' then
            auto_action = 'On'
        else
            auto_action = 'Off'
        end
        windower.add_to_chat(8,'Auto action event set to: '..auto_action)
	end
	
	if cmdParams[1]:lower() == 'auto_trust' then
        if auto_trust == 'Off' then
            auto_trust = 'On'
        else
            auto_trust = 'Off'
        end
        windower.add_to_chat(8,'Auto trust event set to: '..auto_trust)
	end
	
	if cmdParams[1]:lower() == 'cure' then
		if party.count > 1 then
			send_command('@input /ma "Cure IV" <stpc>')
		else
			send_command('@input /ma "Cure IV" <me>')
		end
	end
	
	if cmdParams[1]:lower() == 'test' then
		windower.add_to_chat(8,'Test')
		--testing framework		
	end
end

function relaxed_play_mode_WS(cmdParams, eventArgs)
	if not midaction() then
		if not check_buffs('Sleep','petrification','Terror') then		
			if player.tp > 1029 and player.target.distance < 8 then
				send_command('@input /ws "'..state.AutoWS.value..'" <t>')
			end
		end
	end
end

function relaxed_play_mode(cmdParams, eventArgs)
    -- This can be used as a mini bot to automate actions
	if not midaction() then
		if not check_buffs('Sleep','petrification','Terror','silence', 'mute') then
			local allRecasts = windower.ffxi.get_ability_recasts()
			local composureRecast = allRecasts[50]
			
			if player.hpp < 50					
					and check_recasts(s('Cure IV')) then
				send_command('@input /ma "Cure IV" <me>')
			
			elseif not check_buffs('Defender')
				and player.sub_job == 'WAR'
				and not check_buffs('Berserk')
				and check_recasts(s('Defender')) then
				send_command('@input /ja "Defender" <me>')
				
			end
		end
    end
end

function have_trust(trustname)
	local party = windower.ffxi.get_party()

	for i = 1,5 do
		local member = party['p' .. i]
		if member then
			if member.name:lower() == trustname:lower() then return true end
		end
		
	end

	return false
end

function check_trust()
	if not areas.Cities:contains(world.area) then
		local party = windower.ffxi.get_party()
		if party.p5 == nil then
			local spell_recasts = windower.ffxi.get_spell_recasts()
			
			if spell_recasts[932] == 0 and not have_trust("Fablinix") then
				windower.send_command('input /ma "Fablinix" <me>')
				tickdelay = 250
				return true
			elseif spell_recasts[955] == 0 and not have_trust("Apururu") then
				windower.send_command('input /ma "Apururu (UC)" <me>')
				tickdelay = 250
				return true
			elseif spell_recasts[1013] == 0 and not have_trust("Lilisette") then
				windower.send_command('input /ma "Lilisette II" <me>')
				tickdelay = 250
				return true
			elseif spell_recasts[979] == 0 and not have_trust("Selh'teus") then
				windower.send_command('input /ma "Selh\'teus" <me>')
				tickdelay = 250
				return true
			elseif spell_recasts[898] == 0 and not have_trust("Kupipi") then
				windower.send_command('input /ma "Kupipi" <me>')
				tickdelay = 250
				return true
			elseif spell_recasts[911] == 0 and not have_trust("Joachim") then
				windower.send_command('input /ma "Joachim" <me>')
				tickdelay = 250
				return true
			elseif spell_recasts[1017] == 0 and not have_trust("Arciela") then
				windower.send_command('input /ma "Arciela II" <me>')
				tickdelay = 250
				return true
			elseif spell_recasts[987] == 0 and not have_trust("Ullegore") then
				windower.send_command('input /ma "Ullegore" <me>')
				tickdelay = 250
				return true			
			elseif spell_recasts[909] == 0 and not have_trust("Mihli Aliapoh") then
				windower.send_command('input /ma "Mihli Aliapoh" <me>')
				tickdelay = 250
				return true	
			
			else
				return false
			end
		end
	
	end
	return false
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(4, 3)
    elseif player.sub_job == 'THF' then
        set_macro_page(5, 3)
    else
        set_macro_page(1, 3)
    end
end
