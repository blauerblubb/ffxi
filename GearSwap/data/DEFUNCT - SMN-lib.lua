-------------------------------------------------------------------------------------------------------------------
-- Under the hood after this point, modify at your own risk
-------------------------------------------------------------------------------------------------------------------
 
function setup_hud()
    smn_property = {
	    avatar="\\cs(255,0,0)None\\cr",
	    pacts = {['Rage']="",['Ward']=""},
    }
    smn_info = {}
    smn_info.box={
	    pos={x=hud_x_pos,y=hud_y_pos},
	    text={font='Segoe UI Symbol', size=hud_font_size, Fonts={'sans-serif'},},
	    bg={alpha=hud_transparency,red=0,green=15,blue=0},
	    flags={draggable=hud_draggable},
	    padding=7
    }
    window = texts.new(smn_info.box)
    initialize(window, smn_info.box)
    icon_settings = {
	    name='avatar_icon',
	    color={alpha=hud_transparency,red=255,green=255,blue=255},
	    size={height=hud_icon_width,width=hud_icon_height},
	    pos={x=1300,y=0},
	    draggable=false
    }
    avatar_icon = images.new('',icon_settings,nil)
    images.path(avatar_icon,base_icon_dir..'base.png')
    images.show(avatar_icon)

    window:show()
    updatedisplay()
end
images =require('images')
inwkr = 0
--display_hud=true

function d_chat(s)
	if debug_gs1 then add_to_chat(122,s) end
end
function get_sets()
    mote_include_version = 2
 
    -- Load and initialize the include file.
    include('Mote-Include.lua')
    include('organizer-lib')
end
 
function initialize(text, settings)
	local properties = L{}
	properties:append('Avatar : ${avatar}')
	properties:append('${ragepacts}')
	properties:append('${wardpacts}')
	properties:append('${modestates}')
	text:clear()
	text:append(properties:concat('\n'))
end
function concat_strings(s)
    local t = { }
    for k,v in ipairs(s) do
        t[#t+1] = tostring(v)
    end
    return table.concat(t,"\n")
end
function set_hud_info()
	if pet.name then 
		smn_property.avatar = "\\cs(125,125,255)"..pet.name.."\\cr"
	else
		smn_property.avatar = "\\cs(125,125,125)None\\cr"
	end
	--print('c:'..pet.name)
	tmp_sort = {['Rage']={},['Ward']={}}
	--print(tostring(tmp_sort['Ward']))
	smn_property.pacts['Rage'] = ''
	smn_property.pacts['Ward'] = ''
	for index,value in pairs(pacts) do
		--print('p:'..smn_property.pacts)
		--print('i:'..index)
		--print('v:'..pacts[index][pet.name])
		if pacts[index][pet.name] then 
			keybindtxt = ''
			category = ''
			for k,v in pairs(pact_keys[index]) do 
				category = k
				keybindtxt = v
				break 
			end
			--print (category..keybindtxt)
			tmp_sort[category][keybindtxt] = smn_property.pacts[category].."\n     ".. keybindtxt.. ": \\cs(125,125,255)".. pacts[index][pet.name]..'\\cr     ' 
		end
	end
	for index,value in spairs(tmp_sort['Rage']) do
		smn_property.pacts['Rage'] = smn_property.pacts['Rage']..value
	end
	for index,value in spairs(tmp_sort['Ward']) do
		smn_property.pacts['Ward'] = smn_property.pacts['Ward']..value
	end
	if smn_property.pacts['Rage'] ~= '' then smn_property.pacts['Rage'] = "-- Rage --"..smn_property.pacts['Rage'] end
	if smn_property.pacts['Ward'] ~= '' then smn_property.pacts['Ward'] = "\n-- Ward --"..smn_property.pacts['Ward'] end
	if display_states then 
		modestates_table = {
			'\n-- Modes --\n     Offense: \\cs(125,125,255)'..tostring(state.OffenseMode.value)..'\\cr',
			'     Casting: \\cs(125,125,255)'..tostring(state.CastingMode.value)..'\\cr',
			'     DT: \\cs(125,125,255)'..tostring(state.damagetaken.value)..'\\cr',
			'     Pet DT: \\cs(125,125,255)'..tostring(state.petdamagetaken.value)..'\\cr',
			'     Capacity Points: \\cs(125,125,255)'..tostring(state.cpmode.value)..'\\cr',
			'     Movement: \\cs(125,125,255)'..tostring(state.movement.value)..'\\cr',
			'     TP/Staff Lock: \\cs(125,125,255)'..tostring(state.tplock.value)..'\\cr',
			'     Impact Debuff: \\cs(125,125,255)'..tostring(state.impactmode.value)..'\\cr',
			'     Favor: \\cs(125,125,255)'..tostring(state.favor.value)..'\\cr',
			'     Magic Burst: \\cs(125,125,255)'..tostring(state.burstmode.value)..'\\cr',
		}
		smn_property.modestates = concat_strings(modestates_table)
	else
		smn_property.modestates = ''
	end
end
update_delay=0
function updatedisplay() --update hud display
	if update_delay ~=0 then
		coroutine.sleep(update_delay)
		update_delay = 0
	end
	set_hud_info()
	local info = {}
	info.avatar = smn_property.avatar
	info.ragepacts = smn_property.pacts['Rage']
	info.wardpacts = smn_property.pacts['Ward']
	info.modestates = smn_property.modestates
	if pet.name then 
		icon = pet.name:lower()
	else
		icon = 'base'
	end
	images.path(avatar_icon,base_icon_dir..icon..'.png')
	images.pos(avatar_icon,smn_info.box.pos.x,smn_info.box.pos.y-32)
	images.update(avatar_icon)
	--button:update(info)
	--button:show()
	window:update(info)
	if display_hud then
		window:show()
	end
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    --send_command('exec verda/verda_smn.txt');
    state.Buff["Avatar's Favor"] = buffactive["Avatar's Favor"] or false
    state.Buff["Astral Conduit"] = buffactive["Astral Conduit"] or false
    buffrotation = {
	    [0] = {['Hastega II']='Garuda'},
	    [1] = {['Aerial Armor']='Garuda'},
	    [2] = {['Crimson Howl']='Ifrit'},
	    [3] = {['Earthen Armor']='Titan'},
	    [4] = {['Crystal Blessing']='Shiva'},
	    [5] = {['Frost Armor']='Shiva'},
	    [6] = {['Ecliptic Growl']='Fenrir'},
	    [7] = {['Ecliptic Howl']='Fenrir'},
	    [8] = {['Heavenward Howl']='Fenrir'},
	    [9] = {['Dream Shroud']='Diabolos'},
	    [10] = {['Noctoshield']='Diabolos'},
	    [11] = {['Soothing Current']='Leviathan'},
    }
    rotationfavor = 'Ifrit'
    buffrot_count = 0
    for index, value in pairs( buffrotation ) do
	    buffrot_count = buffrot_count + 1
    end
 
    spirits = S{"LightSpirit", "DarkSpirit", "FireSpirit", "EarthSpirit", "WaterSpirit", "AirSpirit", "IceSpirit", "ThunderSpirit"}
    avatars = S{"Carbuncle", "Fenrir", "Diabolos", "Ifrit", "Titan", "Leviathan", "Garuda", "Shiva", "Ramuh", "Odin", "Alexander", "Cait Sith"}
 
    magicalRagePacts = S{
        'Inferno','Earthen Fury','Tidal Wave','Aerial Blast','Diamond Dust','Judgment Bolt','Searing Light','Howling Moon','Ruinous Omen',
        'Fire II','Stone II','Water II','Aero II','Blizzard II','Thunder II',
        'Fire IV','Stone IV','Water IV','Aero IV','Blizzard IV','Thunder IV','Chaotic strike',
        'Thunderspark','Volt strike','Burning Strike','Meteorite','Nether Blast',
        'Meteor Strike','Conflag Strike','Heavenly Strike','Wind Blade','Geocrush','Crag Throw','Grand Fall','Thunderstorm',
        'Holy Mist','Lunar Bay','Night Terror','Level ? Holy','Impact','Zantetsuken'}
    enticersRagePacts = S{
	    'Impact','Heavenly Strike','Wind Blade','Geocrush','Thunderstorm','Meteor Strike','Grand Fall'
    }
    enticersWardPacts = S{
	    'HealingRuby II','Whispering Wind','Healing Ruby','Spring Water'
    }
    hybridPacts = S{
	    'Flaming Crush'
    }
 
    sets.cpmode = {back="Mecisto. Mantle"}
--    sets.dtmode = {
--	    main="Earth Staff",
--	    left_ring="Gelatinous Ring +1",
--	    right_ring="Defending Ring",
--    }
 
    pacts = {}
    pacts.cure = {['Carbuncle']='Healing Ruby'}
    pacts.curaga = {['Carbuncle']='Healing Ruby II', ['Garuda']='Whispering Wind', ['Leviathan']='Spring Water'}
    pacts.buffoffense = {['Carbuncle']='Glittering Ruby', ['Ifrit']='Crimson Howl', ['Garuda']='Hastega', ['Garuda']='Hastega II', ['Ramuh']='Rolling Thunder',
        ['Fenrir']='Ecliptic Growl'}
    pacts.buffdefense = {['Carbuncle']='Shining Ruby', ['Shiva']='Frost Armor', ['Garuda']='Aerial Armor', ['Titan']='Earthen Ward',
        ['Ramuh']='Lightning Armor', ['Fenrir']='Ecliptic Howl', ['Diabolos']='Noctoshield', ['Cait Sith']='Reraise II'}

    pacts.buffspecial = {['Ifrit']='Inferno Howl', ['Garuda']='Fleet Wind', ['Titan']='Earthen Armor', ['Diabolos']='Dream Shroud',
        ['Carbuncle']='Soothing Ruby',['Carbuncle']='Pacifying ruby', ['Shiva']='Crystal blessing',['Fenrir']='Heavenward Howl', ['Leviathan']='Soothing current',['Cait Sith']='Raise II',}

    pacts.debuff1 = {['Shiva']='Diamond Storm', ['Ramuh']='Shock Squall', ['Leviathan']='Tidal Roar', ['Fenrir']='Lunar Cry',
        ['Diabolos']='Pavor Nocturnus', ['Cait Sith']='Eerie Eye',['Carbuncle']='Soothing Ruby' }
    pacts.debuff2 = {['Leviathan']='Slowga', ['Fenrir']='Lunar Roar', ['Diabolos']='Somnolence'}
    pacts.sleep = {['Shiva']='Sleepga', ['Diabolos']='Nightmare', ['Cait Sith']='Mewing Lullaby'}
    pacts.nuke2 = {['Ifrit']='Fire II', ['Shiva']='Blizzard II', ['Garuda']='Aero II', ['Titan']='Stone II',
        ['Ramuh']='Thunder II', ['Leviathan']='Water II'}
    pacts.nuke4 = {['Ifrit']='Fire IV', ['Shiva']='Blizzard IV', ['Garuda']='Aero IV', ['Titan']='Stone IV',
        ['Ramuh']='Thunder IV', ['Leviathan']='Water IV',['Fenrir']='Crescent Fang'}
    pacts.bp70 = {
	    ['Ifrit']='Flaming Crush', ['Shiva']='Rush', ['Garuda']='Predator Claws', ['Titan']='Mountain Buster',
	    ['Ramuh']='Chaotic Strike', ['Leviathan']='Spinning Dive', ['Carbuncle']='Meteorite', ['Fenrir']='Eclipse Bite',
	    ['Diabolos']='Nether Blast',['Cait Sith']='Regal Scratch'
    }
    pacts.bp75 = {['Ifrit']='Meteor Strike', ['Shiva']='Heavenly Strike', ['Garuda']='Wind Blade', ['Titan']='Geocrush',
        ['Ramuh']='Thunderstorm', ['Leviathan']='Grand Fall', ['Carbuncle']='Holy Mist', ['Fenrir']='Lunar Bay',
        ['Diabolos']='Night Terror', ['Cait Sith']='Level ? Holy'}
    pacts.astralflow = {['Ifrit']='Inferno', ['Shiva']='Diamond Dust', ['Garuda']='Aerial Blast', ['Titan']='Earthen Fury',
        ['Ramuh']='Judgment Bolt', ['Leviathan']='Tidal Wave', ['Carbuncle']='Searing Light', ['Fenrir']='Howling Moon',
        ['Diabolos']='Ruinous Omen', ['Cait Sith']="Altana's Favor"}
    pacts.bprage1 = {['Fenrir']='Impact',['Ramuh']='Volt Strike',['Cait Sith']='Regal Gash',['Carbuncle']='Poison Nails',['Ifrit']='Conflag Strike',['Titan']='Crag Throw',['Diabolos']='Blindside'}
    pacts.misc1 = {['Ramuh']='Thunderspark',['Fenrir']='Moonlit Charge'}
    pacts.misc2 = {['Diabolos']='Ultimate Terror'}

    --Note this is only for display on the Summoner HUD, if you want to change the actual keybinds you need to go to the user_setup function, this saves string comparisons but mostly makes it easier on the programmer (me)
    pact_keys = {}
    pact_keys.cure = {['Ward']='Alt 1'}
    pact_keys.curaga = {['Ward']='Alt 2'}
    pact_keys.buffoffense = {['Ward']='Alt 3'}
    pact_keys.buffdefense = {['Ward']='Alt 4'}
    pact_keys.buffspecial = {['Ward']='Alt 5'}
    pact_keys.debuff1 = {['Ward']='Alt 6'}
    pact_keys.debuff2 = {['Ward']='Alt 7'}
    pact_keys.sleep = {['Ward']='Alt 8'}
    pact_keys.nuke2 = {['Rage']='Ctrl 1'}
    pact_keys.nuke4 = {['Rage']='Ctrl 2'}
    pact_keys.bp70 = {['Rage']='Ctrl 3'}
    pact_keys.bp75 = {['Rage']='Ctrl 4'}
    pact_keys.bprage1 = {['Rage']='Ctrl 5'}
    pact_keys.astralflow = {['Rage']='Ctrl 6'}
    pact_keys.misc1 = {['Rage']='Ctrl 7'}
    pact_keys.misc2 = {['Ward']='Alt 9'}
 
    -- Wards table for creating custom timers  
    wards = {}
    -- Base duration for ward pacts.
    -- Icons to use when creating the custom timer.
    -- Base duration for ward pacts.
    wards.durations = {
        ['Crimson Howl'] = 60, ['Earthen Armor'] = 60, ['Inferno Howl'] = 60, ['Heavenward Howl'] = 60,
        ['Rolling Thunder'] = 120, ['Fleet Wind'] = 120,
        ['Shining Ruby'] = 180, ['Frost Armor'] = 180, ['Lightning Armor'] = 180, ['Ecliptic Growl'] = 180,
        ['Glittering Ruby'] = 180, ['Hastega'] = 180, ['Hastega II'] = 180,['Noctoshield'] = 180, ['Ecliptic Howl'] = 180,
        ['Dream Shroud'] = 180,
        ['Reraise II'] = 3600
    }
    -- Icons to use when creating the custom timer.
--    wards.icons = {
--        ['Earthen Armor']   = 'spells/00299.png', -- 00299 for Titan
--        ['Shining Ruby']    = 'spells/00043.png', -- 00043 for Protect
--        ['Dream Shroud']    = 'spells/00304.png', -- 00304 for Diabolos
--        ['Noctoshield']     = 'spells/00106.png', -- 00106 for Phalanx
--        ['Inferno Howl']    = 'spells/00298.png', -- 00298 for Ifrit
--        ['Hastega']         = 'spells/00358.png', -- 00358 for Hastega
--        ['Hastega II']         = 'spells/00358.png', -- 00358 for Hastega
--        ['Rolling Thunder'] = 'spells/00104.png', -- 00358 for Enthunder
--        ['Frost Armor']     = 'spells/00250.png', -- 00250 for Ice Spikes
--        ['Lightning Armor'] = 'spells/00251.png', -- 00251 for Shock Spikes
--        ['Reraise II']      = 'spells/00135.png', -- 00135 for Reraise
--        ['Fleet Wind']      = 'abilities/00074.png', --
--    }
   
end
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
function user_unload()
    send_command('unbind !1')
    send_command('unbind !2')
    send_command('unbind !3')
    send_command('unbind !4')
    send_command('unbind !5')
    send_command('unbind !6')
    send_command('unbind !7')
    send_command('unbind !8')
    send_command('unbind !9')
    send_command('unbind !0')

    send_command('unbind ^1')
    send_command('unbind ^2')
    send_command('unbind ^3')
    send_command('unbind ^4')
    send_command('unbind ^5')
    send_command('unbind ^6')
    send_command('unbind ^7')
    send_command('unbind ^8')
    send_command('unbind ^9')
    send_command('unbind ^0')
    send_command('unbind !%numpad1')
    send_command('unbind !%numpad2')
    send_command('unbind !%numpad3')
    send_command('unbind !%numpad4')
    send_command('unbind !%numpad5')
    send_command('unbind !%numpad6')
    send_command('unbind !%numpad7')
    send_command('unbind !%numpad8')
    send_command('unbind !%numpad9')
    send_command('unbind !%numpad0')
    send_command('unbind !%numpadenter')
    send_command('unbind !%numpad.')

    send_command('unbind !%delete')
    send_command('unbind !%pagedown')
    send_command('unbind !%end')

    send_command('unbind @%numpad0')
    send_command('unbind #0')
    send_command('unbind #9')

    send_command('unbind ^o')
    send_command('unbind !q')
    send_command('unbind !o')
    send_command('unbind !%numpad+')
    send_command('unbind !%numpad-')
    send_command('unbind f11')
    send_command('unbind !f11')
    send_command('unbind f10')
    send_command('unbind ^f10')
    send_command('unbind !f10')
    send_command('unbind !f9')
    send_command('unbind ^[')
    send_command('unbind ![')
    send_command('unbind ^]')
    --send_command('unbind %numpad1 setkey f8 down;wait .1;setkey f8 up;input /pet "Heavenly Strike" <t>')
    --send_command('unbind %numpad3 setkey f8 down;wait .1;setkey f8 up;input /pet "Sleepga" <t>')
    send_command('unbind %numpad3')
    send_command('unbind !%numpad.')
end
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
 
--swapspaused = false
--function pauseswaps(seconds)
--	swapspaused = true
--	coroutine.sleep(seconds)
--	swapspaused = false
--end

is_midpact = false
function check_midpact(spell,eventArgs)
    local recast = windower.ffxi.get_ability_recasts()
    d_chat('checking if mid pact prev is '..tostring(is_midpact))
    --174 BP Ward
    --173 BP Rage

    if spell.type == "BloodPactWard" and recast[174] ~= 0 then 
	d_chat('Blood Pact Ward Cancelled, it is on cooldown')
        eventArgs.handled = true
	return true
    end
    if spell.type == "BloodPactRage" and recast[173] ~= 0 then 
	d_chat('Blood Pact Rage Cancelled, it is on cooldown')
        eventArgs.handled = true
	return true
    end
--    if (spell.type == "BloodPactRage" and recast[173] == 0) or (spell.type=="BloodPactWard" and recast[174] == 0) then 
--	swapspaused = true
--	coroutine.schedule(function()
--		swapspaused = false
--	end, 3000)
--    end
    if pet_midaction() then
	d_chat('Avatar Midaction, cancelling')
        eventArgs.handled = true
	return true
    end
    return false
end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	d_chat("Job Precast")
--    if state.damagetaken.value ~= "None" then 
--	    tempset = {}
--	    pr (eventArgs)
--	    pr(action)
--    end
--
    --if swapspaused then eventArgs.handled = true end
    beforemp = player.mp
    is_midpact = check_midpact(spell,eventArgs)
--    if is_midpact then 
--	    d_chat('job_precast return due to midpact')
--	    return 
--    end
    if buffactive['Astral Conduit'] then
        eventArgs.handled = true
    end
    if buffactive['Apogee'] then
        eventArgs.handled = true
    end
    if state.damagetaken.value ~= "None" then 
	    state.CastingMode:set('PDT')
	    --eventArgs.handled = true
    elseif state.CastingMode.value == 'PDT' then 
	    state.CastingMode:reset()
    end
end
 
function job_midcast(spell, action, spellMap, eventArgs)
    --if swapspaused then eventArgs.handled = true end
    is_midpact = check_midpact(spell,eventArgs)
    --print ('check '..check)
--    if is_midpact then 
--	    d_chat('job_midcast return due to midpact')
--	    return 
--    end
    --print (spell.english)
    --print(spell.type)
    --if state.Buff['Astral Conduit'] and pet_midaction() then
    --    eventArgs.handled = true
    --end
    if spell.english:startswith('Cure') and spell.target.name == player.name then
	    equip(sets.midcast.Cure.Self)
    end
    if spell.english:contains('Cursna') and spell.target.name == player.name then
	    equip(sets.midcast.Cursna.Self)
    end
    if spell.english:contains('Refresh') and spell.target.name == player.name then
	    equip(sets.midcast.Refresh.Self)
    end
--    elseif spell.type=='SummonerPact' then
--	equip(sets.midcast.interruption)
--        eventArgs.handled = true
--    end
end
function job_pet_midcast(spell,action,spellMap,eventArgs)
    d_chat('Pet Midcast')
end
sets.cait = {
	hands="Lamassu Mitts +1"
}
function job_post_pet_midcast(spell,action,spellMap,eventArgs)--override equip sets for bloodpacts without lots of messy sets
	d_chat('Pet Post Midcast')
	if pet.name=='Cait Sith' then
		equip({ hands="Lamassu Mitts +1", })
	elseif pet.name=='Carbuncle' then
		equip({ hands="Asteria Mitts +1", })
	end
	if state.bpmagicacc.current=='on' and (spellMap == 'TPMagicalBloodPactRage' or spellMap == 'MagicalBloodPactRage' or spellMap == 'IfritMagicalBloodPactRage') then
	--if state.bpmagicacc.current=='on' then
		equip(sets.bp_magic_acc)
	end
	if state.bpmagicacc.current=='on' and (spellMap == 'PhysicalBloodPactRage') then
		equip(sets.bp_phys_acc)
	end
	if state.bpmagicacc.current=='on' and (spellMap == 'HybridBloodPactRage') then
		equip(sets.bp_hybrid_acc)
	end
	if state.burstmode.value=='Burst' and enticersRagePacts:contains(spell.english) and spell.english~="Impact" then
		equip(sets.burstmode.Burst)
	end
end
function job_aftercast(spell, action, spellMap, eventArgs)
	--if swapspaused then eventArgs.handled = true end
	is_midpact = check_midpact(spell,eventArgs,false)
	d_chat('Job Aftercast')
	--if is_midpact then return end

	--print('spell '..spell.type..' aftercast')
	--handle_equipping_gear(player.status,pet.status)
	--    if spell.type == 'Summoning' then
	--	return 'idle.Avatar'
	--    end
end
 
-- Runs when pet completes an action.
function job_pet_aftercast(spell, action, spellMap, eventArgs)
	is_midpact = check_midpact(spell,eventArgs)
	--if is_midpact then return end
	d_chat('Job Pet Aftercast')
--	if is_midpact then 
--		d_chat('job_pet_aftercast returned due to midpact')
--		return
--	end

	--d_chat('check is '..tostring(is_midpact))
	--add_to_chat(122,'Player Status is '..player.status)
	--    if not spell.interrupted and spell.type == 'BloodPactWard' and spellMap ~= 'DebuffBloodPactWard' then
	--        wards.flag = true
	--        wards.spell = spell.english
	--        send_command('wait 4; gs c reset_ward_flag')
	--    end
	--    if player.status == 'Engaged' then
	--	equip(sets.engaged)
	--    end
	aftermp = player.mp
	diffmp = beforemp - aftermp
	savemp = 100*diffmp/248
	savemp = tonumber(string.format("%.3f", savemp))
	handle_equipping_gear(player.status,pet.status)
	--if(spell.en == "Hastega II" and diffmp < 248) then add_to_chat (122,'Blood Boon! Cost was about '..savemp..'% ['..diffmp..'] before:'..beforemp..' after:'..aftermp) end
	--handle_equipping_gear(player.status,pet.status)
	--print ('pet aftercast '..pet.status..' action '..action)
	--    if pet.isvalid and pet.status == 'Engaged'  then
	--	    print('pet aftercast')
	--	    equip(sets.Avatar.Haste)
	--	    return 'Avatar.Haste'
	--    end
	--    if pet.isvalid and not midaction() and not pet_midaction() then
	--	    if player.status == "Idle" then
	--		    --equip(sets.idle.Avatar)
	--		    return 'idle.Avatar'
	--	    end
	--    end
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    elseif storms:contains(buff) then
        handle_equipping_gear(player.status)
    end
    if gain and buff=="quickening" then
        handle_equipping_gear(player.status)
    end
end
 
 
-- Called when the player's pet's status changes.
-- This is also called after pet_change after a pet is released.  Check for pet validity.
function job_pet_status_change(newStatus, oldStatus, eventArgs)
--   local check = check_midpact(spell,eventArgs)
    --d_chat('Pet Status Change new '..newStatus..' old '..oldStatus..' player'..player.status..' midaction '..tostring(pet_midaction())..' is_midpact '..tostring(is_midpact))
    d_chat('Pet Status Change new '..newStatus..' old '..oldStatus..' player'..player.status..' midaction '..tostring(pet_midaction()))
    if pet_midaction() then 
	    --d_chat('check is '..tostring(is_midpact))
	    d_chat('Pet Status Change cancelled')
	    eventArgs.handled=true
	    return 
	    --coroutine.sleep(1)
    end
    handle_equipping_gear(player.status,newStatus)

end
 
function spairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys 
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end
-- Called when a player gains or loses a pet.
-- pet == pet structure
-- gain == true if the pet was gained, false if it was lost.
function job_pet_change(petparam, gain)
    classes.CustomIdleGroups:clear()
    if gain then
	trackavatar = pet.name
	smn_property.pacts = {['Rage']="",['Ward']=""} 
        if avatars:contains(pet.name) then
            classes.CustomIdleGroups:append('Avatar')
        elseif spirits:contains(pet.name) then
            classes.CustomIdleGroups:append('Spirit')
        end
	updatedisplay()
    else
	smn_property.avatar = "\\cs(255,0,0)None\\cr"
	smn_property.pacts = {['Rage']="",['Ward']=""} 
	updatedisplay()
    end
end
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
-- Custom spell mapping.
function job_get_spell_map(spell)
    if spell.type == 'BloodPactRage' then
	if spell.english == "Impact" and state.impactmode.value==true then
            return 'DebuffBloodPactWard'
	elseif enticersRagePacts:contains(spell.english) and spell.english ~= 'Impact' and pet.tp > 35 then
            return 'MagicalBloodPactRage'
	elseif enticersRagePacts:contains(spell.english) then
            return 'TPMagicalBloodPactRage'
        elseif hybridPacts:contains(spell.english) then
            return 'HybridBloodPactRage'
	elseif magicalRagePacts:contains(spell.english) and pet.name=="Ifrit" then
            return 'IfritMagicalBloodPactRage'
	elseif magicalRagePacts:contains(spell.english) then
            return 'MagicalBloodPactRage'
	else
            return 'PhysicalBloodPactRage'
        end
    elseif spell.type == 'BloodPactWard' and spell.target.type == 'MONSTER' then
        return 'DebuffBloodPactWard'
    elseif spell.type=='BloodPactWard' and enticersWardPacts:contains(spell.english) then
	return 'TPBloodPactWard'
    end
end
-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	--print('customize idle set')
	if pet.isvalid then
		if pet.element == world.day_element then
			idleSet = set_combine(idleSet, sets.perp.Day)
		end
		if pet.element == world.weather_element then
			idleSet = set_combine(idleSet, sets.perp.Weather)
		end
		if sets.perp[pet.name] then
			idleSet = set_combine(idleSet, sets.perp[pet.name])
		end
--		gear.perp_staff.name = elements.perpetuance_staff_of[pet.element]
--		if gear.perp_staff.name and (player.inventory[gear.perp_staff.name] or player.wardrobe[gear.perp_staff.name]) then
--			idleSet = set_combine(idleSet, sets.perp.staff_and_grip)
--		end
		if state.Buff["Avatar's Favor"] and avatars:contains(pet.name) then
			--idleSet = set_combine(idleSet, sets.idle.Avatar.Favor)
			idleSet = set_combine(idleSet,sets.favor[state.favor.value])
		end
		if pet.status == 'Engaged' then
			idleSet = set_combine(idleSet, sets.Avatar.Haste)
		end
	end
	if player.max_mp - player.mp < 100 and usemephitas then
		if pet.isvalid then idleSet = set_combine(idleSet, {left_ring="Mephitas's Ring +1", right_ring="Evoker's Ring"})
		else idleSet = set_combine(idleSet, {left_ring="Mephitas's Ring +1"})
		end
	end
	if pet.name=='Cait Sith' then
		--idleSet = set_combine(idleSet, {hands="Lamassu Mitts +1"})
	end

	if player.mpp < 51 then -- this won't work because gear isn't considered only base
		idleSet = set_combine(idleSet, sets.latent_refresh)
	end
    
	if state.damagetaken.value ~= "None" then idleSet = set_combine(idleSet,sets.damagetaken[state.damagetaken.value]) end
	if state.petdamagetaken.value ~= "None" then idleSet = set_combine(idleSet,sets.petdamagetaken[state.petdamagetaken.value]) end
	if state.pullmode.current == 'on' then idleSet = set_combine(idleSet,sets.pullmode) end

	if areas.Cities:contains(world.area) and world.area:contains("Adoulin") then
		idleSet = set_combine(idleSet, sets.adoulinmovement)
	elseif  world.area:contains("Mog Garden") then
		idleSet = set_combine(idleSet, sets.farmer)
		--windower.send_command('input /ja Release <me>;wait 2;input /ma '..tosummon..' <me>')
	elseif buffactive["Quickening"] or buffactive["Fleet Wind"] or areas.Cities:contains(world.area) then
		idleSet = set_combine(idleSet, sets.movement)
	elseif state.movement.current == 'on' then 
		idleSet = set_combine(idleSet, sets.movement)
	end

	
	if state.cpmode.current == 'on' then idleSet = set_combine(idleSet,sets.cpmode) end
	if state.tplock.current == 'on' then 
		idleSet = set_combine(idleSet,sets.tplock) 
		equip(idleSet)
		disable('main','sub')
	else
		enable('main','sub')
	end
	
	if inwkr == 1 then 
		idleSet = set_combine(idleSet, sets.inwkr)
	end
	equip(idleSet)

	return idleSet
end

function customize_melee_set(meleeSet)
    if state.damagetaken.value ~= "None" then meleeSet = set_combine(meleeSet,sets.damagetaken[state.damagetaken.value]) end
    if state.petdamagetaken.value ~= "None" then meleeSet = set_combine(meleeSet,sets.petdamagetaken[state.petdamagetaken.value]) end
    if state.cpmode.current == 'on' then meleeSet = set_combine(meleeSet,sets.cpmode) end
    if state.pullmode.current == 'on' then meleeSet = set_combine(meleeSet,sets.pullmode) end
    if state.tplock.current == 'on' then 
	    meleeSet = set_combine(meleeSet,sets.tplock) 
	    equip(meleeSet)
	    disable('main','sub')
    else
	    enable('main','sub')
    end
    if inwkr == 1 then 
	    meleeSet = set_combine(meleeSet, sets.inwkr)
    end
    return meleeSet
    --if state.dtmode.current == 'on' then meleeSet = set_combine(meleeSet,sets.dtmode) end
end
function customize_resting_set(restingSet)
    if state.damagetaken.value ~= "None" then restingSet = set_combine(meleeSet,sets.damagetaken[state.damagetaken.value]) end
	
    if state.cpmode.current == 'on' then restingSet = set_combine(restingSet,sets.cpmode) end
    return restingSet
end

 
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
    if pet.isvalid then
        if avatars:contains(pet.name) then
            classes.CustomIdleGroups:append('Avatar')
        elseif spirits:contains(pet.name) then
            classes.CustomIdleGroups:append('Spirit')
        end
    end
end
 
-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
 
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------
 
modepage = 0;
movement=0
buffrotkey=0
-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'toggle' or cmdParams[1] == 'cycle' then
	    send_command('wait .5;gs c force_hud_refresh')-- there is no way to hook into motes modes function when called, if I update now it is before motes does, a .5 second delay is minimal for update to hud and seems to work well.  coroutine.sleep gives a return error because we have function returns going on
    end
    if cmdParams[1]:lower() == 'petweather' then
        handle_petweather()
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'test' then
	pr(buffactive['Apogee']) 
    elseif cmdParams[1]:lower() == 'siphon' then
        handle_siphoning()
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'pact' then
        handle_pacts(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1] == 'reset_ward_flag' then
        wards.flag = false
        wards.spell = ''
        eventArgs.handled = true
    elseif cmdParams[1] == 'smn' then
	tosummon = cmdParams[2]
	smntarget = "<me>"
	if tosummon=='atomos' then smntarget="<t>" end
	if tosummon == 'caitsith' then tosummon='cait sith' end
	if tosummon == 'lightspirit' then tosummon='light spirit' end
        if pet.isvalid and pet.name:lower()==tosummon then
		add_to_chat(122,cmdParams[2].." is already summoned!")
        elseif pet.isvalid then
		windower.send_command('input /ja Release <me>;wait 2;input /ma '..tosummon..' '..smntarget)
        else  
		windower.send_command('input /ma '..tosummon..' '..smntarget)
	end
        eventArgs.handled = true
    elseif cmdParams[1] == 'fleet_wind' then
        if pet.isvalid and pet.name:lower()=='garuda' then
		send_command('input /ma Fleet Wind <me>')
	elseif pet.isvalid then
		send_command('input /ja Release <me>;wait 1;input /ma Garuda <me>;wait 4;input /ma Fleet Wind <me>;wait 2')
	else
		send_command('input /ma Garuda <me>;wait 4;input /ma Fleet Wind <me>')
	end
    elseif cmdParams[1] == 'supportmode' then
	    send_command('input /ja "Light Arts";wait 1;input /ja "Sublimation";wait 1;input /ja "Addendum: White";wait 1;input /ma "Aurorastorm" <me>')
    elseif cmdParams[1] == 'nukemode' then
	    send_command('input /ja "Dark Arts";wait 1;input /ja "Sublimation";wait 1;input /ja "Addendum: Black";wait 1;input /ma "Firestorm" <me>')

    elseif cmdParams[1] == 'release' then
        set_macro_page(1,2)
	send_command('input /pet "Release" <me>')
    elseif cmdParams[1] == 'buffrotation' then
	    buffability,buffavatar = next(buffrotation[buffrotkey]) 
	    print (buffavatar)
	    if pet.isvalid and pet.name ~= buffavatar then
		    send_command('input /ja "Release" <me>;wait 1;input /ma "'..buffavatar..'" <me>;wait 5;input /ja "'..buffability..'"')
	    elseif not pet.isvalid then
		    send_command('input /ma "'..buffavatar..'" <me>;wait 5;input /ja "'..buffability..'"')
	    else
		    send_command('input /ja "'..buffability..'"')
	    end
	    buffrotkey = buffrotkey + 1
	    if buffrotkey >= buffrot_count then buffrotkey=0 end
    elseif cmdParams[1] == 'warpring' then
	    equip({left_ring="Warp Ring"})
	    send_command('wait 9;input /item "Warp Ring" <me>')
    elseif cmdParams[1] == 'toggle_hud' then
	    if display_hud==true then 
		    display_hud = false
		    window:hide()
		    images.hide(avatar_icon)
	    else 
		    display_hud=true
		    window:show()
		    images.show(avatar_icon)
	    end
    elseif cmdParams[1] == 'toggle_states' then
	    if display_states==true then 
		    display_states = false
	    else 
		    display_states=true
	    end
	    updatedisplay()
    elseif cmdParams[1] == 'force_hud_refresh' then
	    updatedisplay()
    elseif cmdParams[1] == 'toggle' and cmdParams[2]=='cpmode' then
	--logic is reversed b/c it's true/false and lags behind motes toggle since this is called first
	if state.cpmode.current ~= 'on' then 
		equip(sets.cpmode) 
		send_command('gs disable back')
	else
		send_command('gs enable back')
	end
    end
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
-- Cast the appopriate storm for the currently summoned avatar, if possible.
function handle_petweather()
    if player.sub_job ~= 'SCH' then
        add_to_chat(122, "You can not cast storm spells")
        return
    end
       
    if not pet.isvalid then
        add_to_chat(122, "You do not have an active avatar.")
        return
    end
   
    local element = pet.element
    if element == 'Thunder' then
        element = 'Lightning'
    end
   
--    if S{'Light','Dark','Lightning'}:contains(element) then
--        add_to_chat(122, 'You do not have access to '..elements.storm_of[element]..'.')
--        return
--    end
   
    local storm = elements.storm_of[element]
   
    if storm then
        send_command('@input /ma "'..elements.storm_of[element]..'" <me>')
    else
        add_to_chat(123, 'Error: Unknown element ('..tostring(element)..')')
    end
end
 
 
-- Custom uber-handling of Elemental Siphon
function handle_siphoning()
    if areas.Cities:contains(world.area) then
        add_to_chat(122, 'Cannot use Elemental Siphon in a city area.')
        return
    end
 
    local siphonElement
    local stormElementToUse
    local releasedAvatar
    local dontRelease
   
    -- If we already have a spirit out, just use that.
    if pet.isvalid and spirits:contains(pet.name) then
        siphonElement = pet.element
        dontRelease = true
        -- If current weather doesn't match the spirit, but the spirit matches the day, try to cast the storm.
        if player.sub_job == 'SCH' and pet.element == world.day_element and pet.element ~= world.weather_element then
--            if not S{'Light','Dark','Lightning'}:contains(pet.element) then
--                stormElementToUse = pet.element
--            end
	    stormElementToUse = pet.element
        end
    -- If we're subbing /sch, there are some conditions where we want to make sure specific weather is up.
    -- If current (single) weather is opposed by the current day, we want to change the weather to match
    -- the current day, if possible.
    elseif player.sub_job == 'SCH' and world.weather_element ~= 'None' then
        -- We can override single-intensity weather; leave double weather alone, since even if
        -- it's partially countered by the day, it's not worth changing.
        if get_weather_intensity() == 1 then
            -- If current weather is weak to the current day, it cancels the benefits for
            -- siphon.  Change it to the day's weather if possible (+0 to +20%), or any non-weak
            -- weather if not.
            -- If the current weather matches the current avatar's element (being used to reduce
            -- perpetuation), don't change it; just accept the penalty on Siphon.
            if world.weather_element == elements.weak_to[world.day_element] and
                (not pet.isvalid or world.weather_element ~= pet.element) then
                -- We can't cast lightning/dark/light weather, so use a neutral element
--                if S{'Light','Dark','Lightning'}:contains(world.day_element) then
--                    stormElementToUse = 'Wind'
--                else
--                    stormElementToUse = world.day_element
--                end
		stormElementToUse = world.day_element
            end
        end
    end
   
    -- If we decided to use a storm, set that as the spirit element to cast.
    if stormElementToUse then
        siphonElement = stormElementToUse
    elseif world.weather_element ~= 'None' and (get_weather_intensity() == 2 or world.weather_element ~= elements.weak_to[world.day_element]) then
        siphonElement = world.weather_element
    else
        siphonElement = world.day_element
    end
   
    local command = ''
    local releaseWait = 0
    local elementused = ''
   
    if pet.isvalid and avatars:contains(pet.name) then
        command = command..'input /pet "Release" <me>;wait 1.1;'
        releasedAvatar = pet.name
        releaseWait = 10
    end
   
    if stormElementToUse then
        command = command..'input /ma "'..elements.storm_of[stormElementToUse]..'" <me>;wait 5;'
        releaseWait = releaseWait - 4
	elementused = stormElementToUse
    end
   
    if not (pet.isvalid and spirits:contains(pet.name)) then
        command = command..'input /ma "'..elements.spirit_of[siphonElement]..'" <me>;wait 5;'
        releaseWait = releaseWait - 4
	elementused = siphonElement
    end
   
    command = command..'input /ja "Elemental Siphon" <me>;'
    releaseWait = releaseWait - 1
    releaseWait = releaseWait + 0.1
   
    if not dontRelease then
        if releaseWait > 0 then
            command = command..'wait '..tostring(releaseWait)..';'
        else
            command = command..'wait 1.1;'
        end
       
        command = command..'input /pet "Release" <me>;'
    end
   
    if releasedAvatar then
        command = command..'wait 1.1;input /ma "'..releasedAvatar..'" <me>'
    end
   
    send_command(command)
end
 
 
-- Handles executing blood pacts in a generic, avatar-agnostic way.
-- cmdParams is the split of the self-command.
-- gs c [pact] [pacttype]
function handle_pacts(cmdParams)
    if areas.Cities:contains(world.area) then
        add_to_chat(122, 'You cannot use pacts in town.')
        return
    end
 
    if not pet.isvalid then
        --add_to_chat(122,'No avatar currently available. Returning to default macro set.')
        return
    end
 
    if spirits:contains(pet.name) then
        add_to_chat(122,'Cannot use pacts with spirits.')
        return
    end
 
    if not cmdParams[2] then
        add_to_chat(123,'No pact type given.')
        return
    end
   
    local pact = cmdParams[2]:lower()
   
    if not pacts[pact] then
        add_to_chat(123,'Unknown pact type: '..tostring(pact))
        return
    end
   
    if pacts[pact][pet.name] then
        if pact == 'astralflow' and not buffactive['astral flow'] then
            add_to_chat(122,'Cannot use Astral Flow pacts at this time.')
            return
        end
       
        -- Leave out target; let Shortcuts auto-determine it.
        send_command('@input /pet "'..pacts[pact][pet.name]..'"')
    else
        add_to_chat(122,pet.name..' does not have a pact of type ['..pact..'].')
    end
end
 
function select_default_macro_book(reset)
    -- Default macro set/book
    set_macro_page(1, 2)
end
 
-- Event handler for updates to player skill, since we can't rely on skill being
-- correct at pet_aftercast for the creation of custom timers.
--windower.raw_register_event('incoming chunk',
--    function (id)
--        if id == 0x62 then
--            if wards.flag then
--                create_pact_timer(wards.spell)
--                wards.flag = false
--                wards.spell = ''
--            end
--        end
--    end)
 
-- Function to create custom timers using the Timers addon.  Calculates ward duration
-- based on player skill and base pact duration (defined in job_setup).
--function create_pact_timer(spell_name)
--    -- Create custom timers for ward pacts.
--    if wards.durations[spell_name] then
--        local ward_duration = wards.durations[spell_name]
--        if ward_duration < 181 then
--            local skill = player.skills.summoning_magic
--            if skill > 300 then
--                skill = skill - 300
--                --if skill > 200 then skill = 200 end
--                ward_duration = ward_duration + skill
--            end
--        end
--       
--        local timer_cmd = 'timers c "'..spell_name..'" '..tostring(ward_duration)..' down'
--       
--        if wards.icons[spell_name] then
--            timer_cmd = timer_cmd..' '..wards.icons[spell_name]
--        end
-- 
--        send_command(timer_cmd)
--    end
--end
 
-- Select default macro book on initial load or subjob change.
--windower.raw_register_event('mouse', function(type, x, y, delta, blocked)
--    if type == 2 then
--	    updatedisplay()
--    end
--end)
