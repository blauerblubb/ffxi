--[[

Common Macros needed:

Geo AutoAction (ON/OFF)
/con send {Player} gs c auto_action


Indi/Geo Mode:
# Modes:
- Fury = iFury / G.Frailty
- Haste = iHaste / G.Frailty
- Attunement = iAttunement / G.Vex
- Acumen = iAcumen / G.Malaise
- Precision = iPrecision / G.Torpor
- Focus = iFocus / G.Languor

# Macro:
/con send {Player} gs c geo_mode


Entrust Mode:
# Modes:
/con send {Player} gs c entrust_mode


# Entrust Macros: (This goes always to <p1>)
/con send {Player} gs c entrust_cast

# Optional
/con send {Player} gs c entrust_acc
/con send {Player} gs c entrust_focus
/con send {Player} gs c entrust_fury
/con send {Player} gs c entrust_haste


Geo BoG: (BoG the current Geo Bubble set as mode)
/con send {Player} gs c blaze


Assist (To get on the hate list on new mobs)
/con send {Player} /assist <p1>   // oder {DD}
/wait 1
/con send {Player} /ma "Dia II" <t>




Bind Script:
/Windower/Scripts/Phat_GEO.txt
###################################
// To initialise
//exec Phat_GEO.txt

//Spells:
bind numpad1 send Phat /assist <p1>;wait 2;/ma "Dia 2" <t>
bind numpad2 send Phat /ma "Dia 2" <t>
bind numpad3 send Phat /ma "Distract" <t>


//Entrust:
bind numpad4 send Phat gs c entrust_fury
bind numpad5 send Phat gs c entrust_haste
bind numpad6 send Phat gs c entrust_cast


//Modes:
bind numpad7 send Phat gs c auto_action
bind numpad8 send Phat gs c geo_mode
bind numpad9 send Phat gs c entrust_mode


//JA:
//bind numpad* send Phat gs c bolster
bind numpad* send Phat /echo Test
bind numpad- send Phat gs c blaze
bind numpad+ send Phat /ja "Full Circle" <me>

###################################


Unbind Script:
/Windower/Scripts/unbind.txt
###################################

unbind numpad0
unbind numpad1
unbind numpad2
unbind numpad3
unbind numpad4
unbind numpad5
unbind numpad6
unbind numpad7
unbind numpad8
unbind numpad9
unbind numpad+
unbind numpad-
unbind numpad*
unbind numpad/
unbind numpad.

###################################

]]--

-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
	--include('Mote-Include.lua')

    -- VARIABLES --
    auto_action = 'Off'
	geo_mode = 'Fury'
	entrust_mode = 'precision'
	blaze = 'Off'
	bolster = 'Off'
	notification = 'Off'
	notification_player = 'Playername'


	-- CUSTOM Auto Mode --
	custom_buff = 'Refresh'
	custom_indi = 'Indi-Haste'
	custom_indimp = 186
	custom_geo = 'Geo-Fury'
	custom_geomp = 379
	custom_target = '<me>'
	custom_entrust = 'Indi-Wilt'

	windower.register_event('tp change', function(new, old)
        if new > 349
        and auto_action == 'On' then
            relaxed_play_mode()
        end
    end)

    windower.register_event('time change', function(time)
        if auto_action == 'On' then
            relaxed_play_mode()
        end
    end)


	--------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast = {}
    sets.precast.JA = {}
    sets.precast.JA.Bolster = {body="Bagua tunic +1"}
    sets.precast.JA['Life cycle'] = {body="Geomancy Tunic +2"}
	  sets.precast.JA['Full cycle'] = {head="Azimuth Hood +1"}
    sets.precast.JA['Radial Arcana'] = {feet="Bagua sandals"}

    -- Fast cast sets for spells
    sets.precast.FastCast = {
  		sub="Culminus",
  		head="Merlinic Hood",
  		ear2="Loquacious Earring",
  		body="Anhur Robe",
  		ring1="Prolix Ring",
  		back="Swith Cape",
  		waist="Witful Belt",
  		legs="Geomancy pants +2",
  		feet="Regal Pumps",
		}

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Flash Nova'] = {}

    sets.precast.WS['Starlight'] = {ear2="Moonshade Earring"}

    sets.precast.WS['Moonlight'] = {ear2="Moonshade Earring"}

    --------------------------------------
    -- Midcast sets
    --------------------------------------

    -- Base fast recast for spells
    sets.midcast = {}
    sets.midcast.FastRecast = {
      legs="Merlinic Shalwar",
      feet="Amalric nails",
    }

    sets.midcast.Geomancy = {
      main="Solstice",
      range="Dunna",
      head="Azimuth Hood",
      body="Bagua tunic +1",
      hands="Geomancy mitaines +2",
      ring1="Stikini Ring",
      ring2="Stikini Ring",
      back="Lifestream Cape",
      neck="Deceiver's torque",
		}

    sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy,{
    	legs="Bagua Pants",
    	feet="Azimuth Gaiters",
		})

    sets.midcast.Cure = {main="Tamaxchi",sub="Sors shield",
      body="Anhur Robe",
    	hands="Telchine gloves",
    	ring1="Ephedra Ring",
      ring2="Ephedra Ring",
      back="Solemnity Cape",
    	legs="Vanya Slops",
    	feet="Vanya clogs",
    }

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast.Protectra = {ring1="Sheltered Ring"}

    sets.midcast.Shellra = {ring1="Sheltered Ring"}

    sets.midcast['Enhancing Magic'] = {
      head="Befouled Crown",
		  neck="Incanter's torque",
		  ear1="Etiolation Earring", ear2="Loquacious Earring",
      body="Telchine Chasuble",
		  hands="Amalric gages",
		  lring="Metamor. Ring +1", rring="Perception ring",
      back="Merciful Cape",
		  waist="Refoccilation Stone",
		  legs="Assiduity Pants +1",
		  feet="Azimuth Gaiters +1"
    }

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash", neck="Stone gorget"})

    sets.midcast['Enfeebling Magic'] = {
  		main="Marin staff +1", sub="Niobid Strap", range="Aureole",
  		head="Befouled Crown",
  		neck="Incanter's torque",
  		rear="Barkarole Earring", lear="Psystorm Earring",
  		body="Vanya Robe",
  		hands="Azimuth Gloves",
  		lring="Metamor. Ring +1", rring="Perception ring",
  		back="Lifestream Cape",
  		waist="Ovate Rope",
  		legs="Psycloth Lappas",
  		feet="Merlinic Crackows",
    }

    sets.midcast['Elemental Magic'] = {
  		main={ name="Solstice", augments={'INT+15','"Mag.Atk.Bns."+10','"Refresh"+1',}},
  		head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+23','Magic burst mdg.+7%','INT+7','Mag. Acc.+10',}},
  		body={ name="Amalric Doublet", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
  		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
  		legs={ name="Amalric Slops", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
  		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+25','Magic burst mdg.+11%','"Mag.Atk.Bns."+7',}},
  		neck="Sanctity Necklace",
  		waist="Eschan Stone",
  		left_ear="Sortiarius Earring",
  		right_ear="Hecate's Earring",
  		left_ring="Strendu Ring",
  		right_ring="Acumen Ring",
  		back="Izdubar Mantle",
    }


    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})

    sets.midcast['Dark Magic'] = {
  		head="Bagua Galero",
  		body="Amalric Doublet",
  		hands="Amalric Gages",
  		legs="Amalric Slops",
  		feet="Merlinic Crackows",
  		neck="Sanctity Necklace",
  		waist="Eschan Stone",
  		left_ear="Sortiarius Earring",
  		right_ear="Hecate's Earring",
  		left_ring="Perception Ring",
  		right_ring="Acumen Ring",
  		back="Izdubar Mantle",
		}

    sets.magic_burst = {
  		head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+23','Magic burst mdg.+7%','INT+7','Mag. Acc.+10',}},--7%
  		hands="Amalric gages", -- +5 over cap
  		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+25','Magic burst mdg.+11%','"Mag.Atk.Bns."+7',}}, --11%
  		neck="Mizukage-no-Kubikazari", --10%
  		ear1="Static Earring", --5%
  		ring1="Locus Ring",ring2="Mujin Band", --5% each
  		back="Seshaw Cape",--5%
		}


	sets.obi = {}

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    -- Resting sets
    sets.resting = {}

    -- Idle sets

    sets.idle = {
      main={ name="Solstice", augments={'INT+15','"Mag.Atk.Bns."+10','"Refresh"+1',}},
		  sub="Moogle Guard +1",
  		range="Dunna",
  		body="Azimuth Coat",
  		neck="Loricate Torque +1",
  		waist="Eschan Stone",
  		left_ear="Dominance Earring",
  		right_ear="Beastly Earring",
  		left_ring="Perception Ring",
  		right_ring="Acumen Ring",

      --pet idle
  		feet="Bagua Sandals",
  		back="Nantosuelta's cape",
  		hands="Geomancy mitaines +2",
		}

    sets.idle.PDT = set_combine(sets.idle,{
  		main="Solstice",sub="Genbu's Shield",
  		range="Dunna",
      body="Gyve doublet",
  		ring1="Defending Ring",
  		back="Solemnity Cape",
		})

    -- .Pet sets are for when Luopan is present.
  	sets.idle.Pet = set_combine(sets.idle,{
  		head="Azimuth hood",
  		feet="Bagua Sandals",
  		back="Nantosuelta's cape",
  		hands="Geomancy mitaines +2",
  	})

    sets.idle.PDT.Pet = sets.idle.Pet

    -- .Indi sets are for when an Indi-spell is active.
    --sets.idle.Indi = set_combine(sets.idle, {legs="Bagua Pants"})
    --sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {legs="Bagua Pants"})
    --sets.idle.PDT.Indi = set_combine(sets.idle.PDT, {legs="Bagua Pants"})
    --sets.idle.PDT.Pet.Indi = set_combine(sets.idle.PDT.Pet, {legs="Bagua Pants"})

    sets.Kiting = {feet="Geomancy Sandals +2"}

    sets.latent_refresh = {waist="Fucho-no-obi"}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {}
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

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    indi_timer = ''
    indi_duration = 180


	    -- VARIABLES --
    auto_action = 'Off'
	geo_mode = 'Fury'
	blaze = 'Off'

	windower.register_event('tp change', function(new, old)
        if new > 349
        and auto_action == 'On' then
            relaxed_play_mode()
        end
    end)

    windower.register_event('time change', function(time)
        if auto_action == 'On' then
            relaxed_play_mode()
        end
    end)


end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')

	state.MagicBurst = M(false, 'Magic Burst')

    -- Additional local binds
    send_command('bind ^` gs c toggle MagicBurst')
end

function self_command(str)
    -- Use an in game macro "/con gs c auto_action" to toggle bot Off and On
    if str == 'auto_action' then
		if auto_action == 'Off' then
			auto_action = 'On'
		else
			auto_action  = 'Off'
		end
		windower.add_to_chat(8,'Auto fire event set to: '..auto_action)
		if notification == 'On' then
			windower.send_command('send '..notification_player..' /echo Auto_action: '..auto_action)
		end

	elseif str == 'geo_mode' then
		if geo_mode == 'Fury' then
			geo_mode = 'Haste'
		elseif geo_mode == 'Haste' then
			geo_mode = 'Attunement'
		elseif geo_mode == 'Attunement' then
			geo_mode = 'Acumen'
		elseif geo_mode == 'Acumen' then
			geo_mode = 'Precision'
		elseif geo_mode == 'Precision' then
			geo_mode = 'Focus'
		elseif geo_mode == 'Focus' then
			geo_mode = 'Custom'
		elseif geo_mode == 'Custom' then
			geo_mode = 'Fury'
		end
		windower.add_to_chat(8,'Geo set mode: '..geo_mode)
		if notification == 'On' then
			send_command('send '..notification_player..' /echo Geo Mode: '..geo_mode)
		end

	elseif str == 'entrust_mode' then
		if entrust_mode == 'precision' then
			entrust_mode = 'focus'
		elseif entrust_mode == 'focus' then
			entrust_mode = 'refresh'
		elseif entrust_mode == 'refresh' then
			entrust_mode = 'fury'
		elseif entrust_mode == 'fury' then
			entrust_mode = 'haste'
		elseif entrust_mode == 'haste' then
			entrust_mode = 'custom'
		elseif entrust_mode == 'custom' then
			entrust_mode = 'precision'
		end
		windower.add_to_chat(8,'Entrust set mode: '..entrust_mode)
		if notification == 'On' then
			windower.send_command('send '..notification_player..' /echo Entrust Mode: '..entrust_mode)
		end

	elseif str == 'entrust_cast' then
		windower.send_command('@wait 1;gs c entrust_'..entrust_mode)

	elseif str == 'entrust_acc' then
		if not check_buffs('silence', 'mute')
		and check_recasts(s('Indi-Precision'))
		and check_recasts(s('Entrust')) then
			windower.send_command('Entrust <me>;wait 1;Indi-Precision <p1>')
		end

	elseif str == 'entrust_focus' then
		if not check_buffs('silence', 'mute')
		and check_recasts(s('Indi-Focus'))
		and check_recasts(s('Entrust')) then
			windower.send_command('Entrust <me>;wait 1;Indi-Focus <p1>')
		end

	elseif str == 'entrust_refresh' then
		if not check_buffs('silence', 'mute')
		and check_recasts(s('Indi-Refresh'))
		and check_recasts(s('Entrust')) then
			windower.send_command('Entrust <me>;wait 1;Indi-Refresh <p1>')
		end

	elseif str == 'entrust_fury' then
		if not check_buffs('silence', 'mute')
		and check_recasts(s('Indi-Fury'))
		and check_recasts(s('Entrust')) then
			windower.send_command('Entrust <me>;wait 1;Indi-Fury <p1>')
		end

	elseif str == 'entrust_haste' then
		if not check_buffs('silence', 'mute')
		and check_recasts(s('Indi-Haste'))
		and check_recasts(s('Entrust')) then
			windower.send_command('Entrust <me>;wait 1;Indi-Haste <p1>')
		end

	elseif str == 'entrust_custom' then
		if not check_buffs('silence', 'mute')
		and check_recasts(s(custom_entrust))
		and check_recasts(s('Entrust')) then
			windower.send_command('Entrust <me>;wait 1;'..custom_entrust..' <p1>')
		end

	elseif str == 'blaze' then
		if not check_buffs('silence', 'mute', 'Terror', 'Amnesia')
		and player.mp > 379
		and check_recasts(s('Radial Arcana'))
		and check_recasts(s('Blaze of Glory'))
		and check_recasts(s('Dematerialize')) then
			blaze = 'On'
		end

	elseif str == 'bolster' then
		if not check_buffs('silence', 'mute', 'Terror', 'Amnesia')
		and player.mp > 379
		and check_recasts(s('Bolster')) then
			bolster = 'On'
		end
	end
end

function relaxed_play_mode()
    -- This can be used as a mini bot to automate actions
    if not midaction() then
        if player.hpp < 70
			and not check_buffs('silence', 'mute')
			and check_recasts(s('cure4')) then
			windower.send_command('cure4 <me>')

		elseif player.hpp > 90
			and player.mpp < 10
			and check_recasts(s('Convert')) then
			windower.send_command('Convert;wait 1;cure4 <me>')

		elseif not check_buffs('Refresh')
			and not check_buffs('silence', 'mute')
			and check_recasts(s('Refresh')) then
			windower.send_command('Refresh <me>')

		--Indi
		elseif not check_buffs('Attack Boost')
			and not check_buffs('silence', 'mute')
			and geo_mode == 'Fury'
			and check_recasts(s('Indi-Fury')) then
			windower.send_command('Indi-Fury')

		elseif not buffactive[580] --GEO-Haste
			and not check_buffs('silence', 'mute')
			and geo_mode == 'Haste'
			and check_recasts(s('Indi-Haste')) then
			windower.send_command('Indi-Haste')

		elseif not check_buffs('Magic Evasion Boost')
			and not check_buffs('silence', 'mute')
			and geo_mode == 'Attunement'
			and check_recasts(s('Indi-Attunement')) then
			windower.send_command('Indi-Attunement')

		elseif not check_buffs('Magic Atk. Boost')
			and not check_buffs('silence', 'mute')
			and geo_mode == 'Acumen'
			and check_recasts(s('Indi-Acumen')) then
			windower.send_command('Indi-Acumen')

		elseif not check_buffs('Accuracy Boost')
			and not check_buffs('silence', 'mute')
			and geo_mode == 'Precision'
			and check_recasts(s('Indi-Haste')) then
			windower.send_command('Indi-Haste')

		elseif not check_buffs('Magic Accuracy Boost')
			and not check_buffs('silence', 'mute')
			and geo_mode == 'Focus'
			and check_recasts(s('Indi-Focus')) then
			windower.send_command('Indi-Focus')

		elseif not check_buffs(custom_buff)
			and not check_buffs('silence', 'mute')
			and geo_mode == 'Custom'
			and check_recasts(s(custom_indi)) then
			windower.send_command(custom_indi)

		--blaze of glory
		elseif blaze == 'On'
			and not check_buffs('silence', 'mute')
			and check_recasts(s('Radial Arcana'))
			and check_recasts(s('Blaze of Glory'))
			and check_recasts(s('Dematerialize')) then
				if player.mp > 294 and geo_mode == 'Fury' and check_recasts(s('Geo-Frailty')) then
					windower.send_command('Radial Arcana <me>;wait 1;Blaze of Glory <me>;wait 2;Geo-Frailty <bt>;wait 6;Dematerialize <me>;wait 1;Life Cycle <me>;wait 1;Lasting Emanation <me>;wait 1;Dia2 <bt>')
				elseif player.mp > 294 and geo_mode == 'Haste' and check_recasts(s('Geo-Frailty')) then
					windower.send_command('Radial Arcana <me>;wait 1;Blaze of Glory <me>;wait 2;Geo-Frailty <bt>;wait 6;Dematerialize <me>;wait 1;Life Cycle <me>;wait 1;Lasting Emanation <me>;wait 1;Dia2 <bt>')
				elseif player.mp > 273 and geo_mode == 'Attunement' and check_recasts(s('Geo-Vex')) then
					windower.send_command('Radial Arcana <me>;wait 1;Blaze of Glory <me>;wait 2;Geo-Vex <bt>;wait 6;Dematerialize <me>;wait 1;Life Cycle <me>;wait 1;Lasting Emanation <me>;wait 1;Dia2 <bt>')
				elseif player.mp > 348 and geo_mode == 'Acumen' and check_recasts(s('Geo-Malaise')) then
					windower.send_command('Radial Arcana <me>;wait 1;Blaze of Glory <me>;wait 2;Geo-Malaise <bt>;wait 6;Dematerialize <me>;wait 1;Life Cycle <me>;wait 1;Lasting Emanation <me>;wait 1;Dia2 <bt>')
				elseif player.mp > 203 and geo_mode == 'Precision' and check_recasts(s('Geo-Torpor')) then
					windower.send_command('Radial Arcana <me>;wait 1;Blaze of Glory <me>;wait 2;Geo-Torpor <bt>;wait 6;Dematerialize <me>;wait 1;Life Cycle <me>;wait 1;Lasting Emanation <me>;wait 1;Dia2 <bt>')
				elseif player.mp > 124 and geo_mode == 'Focus' and check_recasts(s('Geo-Languor')) then
					windower.send_command('Radial Arcana <me>;wait 1;Blaze of Glory <me>;wait 2;Geo-Languor <bt>;wait 6;Dematerialize <me>;wait 1;Life Cycle <me>;wait 1;Lasting Emanation <me>;wait 1;Dia2 <bt>')
				elseif player.mp > custom_geomp and geo_mode == 'Custom' and check_recasts(s(custom_geo)) then
					if custom_target == '<me>'then
						windower.send_command('Radial Arcana <me>;wait 1;Blaze of Glory <me>;wait 2;'..custom_geo..'  <me>;wait 6;Dematerialize <me>;wait 1;Life Cycle <me>;wait 1;Lasting Emanation <me>;')
					else
						windower.send_command('Radial Arcana <me>;wait 1;Blaze of Glory <me>;wait 2;'..custom_geo..'  <bt>;wait 6;Dematerialize <me>;wait 1;Life Cycle <me>;wait 1;Lasting Emanation <me>;wait 1;Dia2 <bt>')
					end
				end
				blaze = 'Off'

		--bolster
		elseif bolster == 'On' and not check_buffs('silence', 'mute') and check_recasts(s('Bolster')) then
			--Indi
			if geo_mode == 'Fury'
				and check_recasts(s('Geo-Frailty'))
				and check_recasts(s('Indi-Fury')) then
				windower.send_command('Bolster <me>;wait 1;Indi-Fury')

			elseif geo_mode == 'Haste'
				and check_recasts(s('Geo-Frailty'))
				and check_recasts(s('Indi-Haste')) then
				windower.send_command('Bolster <me>;wait 1;Indi-Haste')

			elseif geo_mode == 'Attunement'
				and check_recasts(s('Geo-Vex'))
				and check_recasts(s('Indi-Attunement')) then
				windower.send_command('Bolster <me>;wait 1;Indi-Attunement')

			elseif geo_mode == 'Acumen'
				and check_recasts(s('Geo-Malaise'))
				and check_recasts(s('Indi-Acumen')) then
				windower.send_command('Bolster <me>;wait 1;Indi-Acumen')

			elseif geo_mode == 'Precision'
				and check_recasts(s('Geo-Torpor'))
				and check_recasts(s('Indi-Haste')) then
				windower.send_command('Bolster <me>;wait 1;Indi-Haste')

			elseif geo_mode == 'Focus'
				and check_recasts(s('Geo-Languor'))
				and check_recasts(s('Indi-Focus')) then
				windower.send_command('Bolster <me>;wait 1;Indi-Focus')

			elseif geo_mode == 'Custom'
				and check_recasts(s(custom_geo))
				and check_recasts(s(custom_indi)) then
				windower.send_command('Bolster <me>;wait 1;'..custom_indi)
			end

			if pet.isvalid then
				if check_recasts(s('Radial Arcana'))
					and check_recasts(s('Blaze of Glory'))
					and check_recasts(s('Dematerialize')) then
					blaze = 'On'
				else
					windower.send_command('wait 1;Full Circle <me>')
				end
			end
			bolster = 'Off'

		--Geo
		elseif not pet.isvalid and not check_buffs('silence', 'mute') then
			if player.mp > 294	and geo_mode == 'Fury' and check_recasts(s('Geo-Frailty')) then
				windower.send_command('wait 1;Geo-Frailty <bt>;wait 7;Dia2 <bt>;wait 3;Distract <bt>')
			elseif player.mp > 294	and geo_mode == 'Haste' then
				windower.send_command('wait 1;Geo-Frailty <bt>;wait 7;Dia2 <bt>;wait 3;Distract <bt>')
			elseif player.mp > 273	and geo_mode == 'Attunement' and check_recasts(s('Geo-Vex')) then
				windower.send_command('wait 1;Geo-Vex <bt>;wait 7;Dia2 <bt>;wait 3;Distract <bt>')
			elseif player.mp > 348 and geo_mode == 'Acumen' and check_recasts(s('Geo-Malaise')) then
				windower.send_command('wait 1;Geo-Malaise <bt>;wait 7;Dia2 <bt>;wait 3;Frazzle <bt>')
			elseif player.mp > 203 and geo_mode == 'Precision' and check_recasts(s('Geo-Torpor')) then
				windower.send_command('wait 1;Geo-Torpor <bt>;wait 7;Dia2 <bt>;wait 3;Distract <bt>')
			elseif player.mp > 124 and geo_mode == 'Focus' and check_recasts(s('Geo-Languor')) then
				windower.send_command('wait 1;Geo-Languor <bt>;wait 7;Dia2 <bt>;wait 3;Frazzle <bt>')
			elseif player.mp > custom_geomp and geo_mode == 'Custom' and check_recasts(s(custom_geo)) then
				if custom_target == '<me>' then
					windower.send_command('wait 1;'..custom_geo..' <me>')
				else
					windower.send_command('wait 1;'..custom_geo..' <bt>;wait 7;Dia2 <bt>;wait 3;Frazzle <bt>')
				end
			end
		end
	end
end


-- Define sets and vars used by this job file.
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Geomancy' then
            if spell.english:startswith('Indi') then
                return 'Indi'
            end
        end
    end
end


function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
    if player.indi then
        classes.CustomIdleGroups:append('Indi')
    end
end

-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    local msg = 'Offense'
    msg = msg .. ': [' .. state.OffenseMode.value .. '], '
    msg = msg .. 'Casting'
    msg = msg .. ': [' .. state.CastingMode.value .. '], '
    msg = msg .. 'Idle'
    msg = msg .. ': [' .. state.IdleMode.value .. '], '

    if state.MagicBurst.value == true then
        msg = msg .. 'Magic Burst: [On]'
    elseif state.MagicBurst.value == false then
        msg = msg .. 'Magic Burst: [Off]'
    end

    add_to_chat(122, msg)

    eventArgs.handled = true
end


function check_buffs(...)
    --[[ Function Author: Arcon
            Simple check before attempting to auto activate Job Abilities that
            check active buffs and debuffs ]]
    return table.any({...}, table.get+{buffactive})
end

function gear_modes()
    -- User created bridge for aftercast and status_change functions
    -- Sequential gear sets used to easily allow for changing player needs
    --slot_disabling()

    local attack_preference = 'null'

    if player.status == 'Engaged' then
        equip(sets.engaged)
    elseif player.status == 'Idle' then
        equip(sets.idle)
        if dt_mode == 'None' then
            --print(party.count)
            if party.count > 1 then
                equip(sets.idle.SphereRefresh)
            end
            if player.mpp < 50 then
                equip(sets.idle.under_50mpp)
            end
        end
    end
end

	 

function precast(spell,arg)
    gear_change_ok = false
    slot_disabling()



	--spell degration
	local spell_recasts = windower.ffxi.get_spell_recasts()
    if (spell_recasts[spell.recast_id]>0 or player.mp<actual_cost(spell)) and find_degrade_table(spell) then
        degrade_spell(spell,find_degrade_table(spell))
		return
    end

    --[[ Generic equip command for Job Abilities and Weaponskills that have
            a gear set listed in get_sets()
            If Idle and a weaponskill macro is pressed you will change to
            current Idle/DT set, useful as a fast way to equip proper gear
            For then in game macros the quotations("") and <t> aren't needed
            EX: /ws Expiacion ]]
    if sets.precast.JA[spell.name] then
        equip(sets.precast.JA[spell.name])
    elseif sets.precast.WS[spell.name] then
        if player.status == 'Engaged' then
            equip(sets.precast.WS[spell.name])
        else
            cancel_spell()
            gear_modes()
            return
        end
    end

    -- Magic spell gear handling(Precast)
    if spell.prefix == '/magic' or spell.prefix == '/ninjutsu' then
		equip(sets.precast.FastCast)
        if spell.name == 'Utsusemi: Ichi'
                and check_recasts(spell)
                and shadow_type == 'Ni' then
            if check_buffs(
                    'Copy Image',
                    'Copy Image (2)',
                    'Copy Image (3)') then
                windower.send_command('cancel copy image;'
                    ..'cancel copy image (2); cancel copy image (3)')
            end
        elseif (spell.name == 'Monomi: Ichi' or spell.name == 'Sneak')
                and check_buffs('Sneak')
                and check_recasts(spell)
                and spell.target.type == 'SELF' then
            windower.send_command('cancel sneak')
        end
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == "Magic" then
        if spell.element == world.weather_element or spell.element == world.day_element then
            equip(sets.obi[spell.element])
        end
    end
    if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
        equip(sets.magic_burst)
    end
end

function midcast(spell,arg)
    -- Special handling for Spell Mappings outlined in get_maps()
    local stat

	if spell.english:startswith('Indi') or spell.english:startswith('Geo') then
		equip(sets.midcast.Geomancy)
	end

    if spell.skill == 'Healing Magic' or spell.skill == 'Enhancing Magic'
            or spell.type == 'Trust' then
        equip(sets.midcast.FastRecast)
        if spell.name:startswith('Cure') then
            equip(sets.midcast.Cure)
            if spell.target.type == 'SELF' then
                equip(sets.midcast.Cure)
            end
        end
    elseif spell.skill == 'Elemental Magic' then
        equip(sets.midcast.BlueMagic.Nuke)
    end

    if spell.name:startswith('Utsusemi') then
        equip(sets.misc.DT.Active)
    end
end

function aftercast(spell,arg)
	aftercast_start = os.clock()
	if spell.action_type ~= 'Magic' then
		aftercast_start = nil
	end

    gear_change_ok = true
    gear_modes()

    -- Gear info, useful if using DressUp or BlinkMeNot

    if not spell.interrupted then
        -- Changes shadow type variable to allow cancel Copy Image
        -- if last cast was Utsusemi: Ni
        if spell.name == 'Utsusemi: Ni' then
            shadow_type = 'Ni'
        elseif spell.name == 'Utsusemi: Ichi' then
            shadow_type = 'Ichi'
        end
    end
end

function slot_disabling()
    -- Disable slots for items you don't want removed when performing actions
    if player.equipment.head == 'Reraise Hairpin' then
        disable('head')
        windower.add_to_chat(8,'Reraise Hairpin equiped on head')
    else
        enable('head')
    end

    if player.equipment.left_ear == 'Reraise Earring' then
        disable('left_ear')
        windower.add_to_chat(8,'Reraise Earring equiped on left ear')
    else
        enable('left_ear')
    end

    if player.equipment.right_ear == 'Reraise Earring' then
        disable('right_ear')
        windower.add_to_chat(8,'Reraise Earring equiped on right ear')
    else
        enable('right_ear')
    end
end

function status_change(new,old)
    if T{'Idle','Engaged'}:contains(new) and gear_change_ok then
        gear_modes()
    end
end


----------------------------------------------------------------------
--- DEGRADE SPELLS
----------------------------------------------------------------------
degrade_tables = {}
degrade_tables.Cure = {"Cure","Cure II","Cure III","Cure IV","Cure V","Cure VI"}
degrade_tables.Curaga = {"Curaga","Curaga II","Curaga III"}
degrade_tables.Fire = {"Fire","Fire II","Fire III","Fire IV","Fire V","Fire VI"}
degrade_tables.Stone = {"Stone","Stone II","Stone III","Stone IV","Stone V","Stone VI"}
degrade_tables.Blizzard = {"Blizzard","Blizzard II","Blizzard III","Blizzard IV","Blizzard V","Blizzard VI"}
degrade_tables.Water = {"Water","Water II","Water III","Water IV","Water V","Water VI"}
degrade_tables.Aero = {"Aero","Aero II","Aero III","Aero IV","Aero V","Aero VI"}
degrade_tables.Thunder = {"Thunder","Thunder II","Thunder III","Thunder IV","Thunder V","Thunder VI"}
degrade_tables.Firaga = {'Firaga', 'Firaga II','Firaga III','Firaja'}
degrade_tables.Blizzaga = {'Blizzaga', 'Blizzaga II','Blizzaga III','Blizzaja'}
degrade_tables.Aeroga = {'Aeroga', 'Aeroga II','Aeroga III','Aeroja'}
degrade_tables.Stonega = {'Stonega','Stonega II','Stonega III','Stoneja'}
degrade_tables.Thundaga = {'Thundaga','Thundaga II','Thundaga III','Thundaja'}
degrade_tables.Waterga = {'Waterga','Waterga II','Waterga III','Waterja'}
degrade_tables.Fira = {'Fira', 'Fira II','Fira III'}
degrade_tables.Blizzara = {'Blizzara', 'Blizzara II','Blizzara III'}
degrade_tables.Aera = {'Aera', 'Aera II','Aera III'}
degrade_tables.Stonera = {'Stonera','Stonera II','Stonera III'}
degrade_tables.Thundara = {'Thundara','Thundara II','Thundara III'}
degrade_tables.Watera = {'Watera','Watera II','Watera III'}
degrade_tables.Aspir = {"Aspir","Aspir II","Aspir III"}
degrade_tables.Drain = {"Drain","Drain II","Drain III"}
degrade_tables.Sleep = {"Sleep","Sleep II"}
degrade_tables.Sleepga = {"Sleepga","Sleepga II"}
degrade_tables.Utsusemi = {"Utsusemi: Ichi","Utsusemi: Ni","Utsusemi: San"}

function check_degrading_spell()
	-- Automatic Spell Degration
	local spell_recasts = windower.ffxi.get_spell_recasts()
    if (spell_recasts[spell.recast_id]>0 or player.mp<actual_cost(spell)) and find_degrade_table(spell) then
        degrade_spell(spell,find_degrade_table(spell))
		return
    end
end


function find_degrade_table(lookup_spell)
	for __,spells in pairs(degrade_tables) do
		for ___,spell in pairs(spells) do
			if spell == lookup_spell.english then
				return spells
			end
		end
	end
	return false
end

function degrade_spell(spell,degrade_array)
	local spell_index = table.find(degrade_array,spell.english)
	if spell_index>1 then
		local new_spell = degrade_array[spell_index - 1]

		change_spell(new_spell,spell.target.id)
		add_to_chat(307,spell.english..' canceled - Using '..new_spell..'')
	end
end

function change_spell(spellName,target)
	cancel_spell()
	send_command(spellName:gsub('%s','')..' '..target)
end




function actual_cost(spell)
	local cost = spell.mp_cost
	if spell.type=="WhiteMagic" then
		if buffactive["Penury"] then
			return cost*.5
		elseif buffactive["Light Arts"] or buffactive["Addendum: White"] then
			return cost*.9
		elseif buffactive["Dark Arts"] or buffactive["Addendum: Black"] then
			return cost*1.1
		end
	elseif spell.type=="BlackMagic" then
		if buffactive["Parsimony"] then
			return cost*.5
		elseif buffactive["Dark Arts"] or buffactive["Addendum: Black"] then
			return cost*.9
		elseif buffactive["Light Arts"] or buffactive["Addendum: White"] then
			return cost*1.1
		end
	end
	return cost
end
