--[[
Some added features compared to Motentent original:
-- Automatic Spell adjustment T6 >, Aspir, Sleep, -ja, Cure (This is normally in my globals as I use this on several jobs)
-- Mana wall option for Feet and Back
-- Auto Lock Slots for gear as mecisto. Mantle, Warp ring
Note: Mana wall WILL overwrite this, since I want to make sure I always have full effect.
-- Death Set (got this is a mess of script in my case, and doesn't work yet as I would like it to since it still switches my gear. But I know this and know how to avoid losing MP (feel free to share any solution you have) CTRL + F12 to toggle. If enable mode has NOT been enabled ( F9 ) this will switch your staff and cause you to loose TP.
++ change 'if state.IdleMode.value == 'Death' and player.mpp > 65 then' to 'if state.IdleMode.value == 'Death' then' should death gear switch in unwanted situation. that keeps the gear from switching to non-death sets at all.

-- Auto MP Return AF Body ( CTRL + ` ) @Never, 35% MPP, 60% MPP or Always (helps in boring enduring fights where you want to keep mp over an extended amount of time. e.g. Vagary, APEX, etc)
-- Hachirin-no-obi for weather. I just added Death to this (I had the obi permanently in before), but had no time to test. You can find the previous version here should something fail: http://pastebin.com/LEUxq3N0
-- Mode to be permanently in MBurst ( ALT + ` ) set so that you can easily double tap. (no need to waste MP) Modes: none, temp, perma

]]--

-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    count_msg_mecisto = 0
	count_msg_ring = 0
	
    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('organizer-lib')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()

end


--[[

2016-07-11: redid midcast sets starting from sets.midcast['Enfeebling Magic']
			still need to do enhancing and above, including fc. (except death)

]]--


-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'None', 'TP')
    state.CastingMode:options('Normal', 'Resistant', 'Proc')
    state.IdleMode:options('Normal', 'Death', 'PDT')
    
    state.MagicBurst = M{['description']='MB', 'off', 'tmp', 'Perma'}
	--state.MPMode = M{['description']='None', 'Normal', 'MPP35', 'MPP60', 'MPALL'}
	state.MPMode = M{['description']='MPP Trigger %: ', '0', '35', '60', '75', '100'}
	
    lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
        'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
        'Stone III', 'Water III', 'Aero III', 'Fire III', 'Blizzard III', 'Thunder III',
        'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',
        'Stonega II', 'Waterga II', 'Aeroga II', 'Firaga II', 'Blizzaga II', 'Thundaga II'}
    
    -- Additional local binds
    --send_command('bind ^` input /ma Stun <t>')
    send_command('bind !` gs c cycle MagicBurst')
	send_command('bind ^` gs c cycle MPMode')

    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    ---- Precast Sets ----
    sets.precast.Death = { --never ever switch precast with low mp for death! 1962 MP ( 1936 MP nuke )
		main={ name="Grioavolr", augments={'"Occult Acumen"+3','MP+79','Mag. Acc.+29','"Mag.Atk.Bns."+27','Magic Damage +2',}},
		sub="Niobid Strap",
		ammo="Strobilus",
		head={ name="Amalric Coif", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		body="Shango Robe",
		hands={ name="Merlinic Dastanas", augments={'"Fast Cast"+6','CHR+2','Mag. Acc.+11','"Mag.Atk.Bns."+12',}},
		legs={ name="Amalric Slops", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+8%','INT+5','Mag. Acc.+8',}},
		neck="Sanctity Necklace",
		waist="Witful Belt",
		left_ear="Barkaro. Earring",
		right_ear="Etiolation Earring",
		left_ring="Mephitas's Ring +1",
		right_ring="Mephitas's Ring",
		back={ name="Taranus's Cape", augments={'MP+60','"Fast Cast"+10',}},
		}
		
    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {feet="Wicce Sabots",back="Taranus's cape"}

    sets.precast.JA.Manafont = {body="Archmage's Coat"}
    
    -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
    sets.precast.JA.Convert = {}

    -- Fast cast sets for spells

    sets.precast.FC = { --more FC on merlinic + merlinic feet ? // 57% FC // 59% with grip // 63% with staff/grip
		main="Grioavolr", --4%
		sub="Clerisy Strap",--2%
		head={ name="Merlinic Hood", augments={'"Fast Cast"+4','CHR+10','Mag. Acc.+9','"Mag.Atk.Bns."+13',}}, -- fc 12%
		body="Anhur Robe",--10%
        hands={ name="Merlinic Dastanas", augments={'"Fast Cast"+6','CHR+2','Mag. Acc.+11','"Mag.Atk.Bns."+12',}}, --FC 6%
		legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}}, --fc 7%
		feet="Amalric nails",--5%
		--neck="Orunmila's Torque",--5%
		left_ear="Loquacious Earring",--2%
		ring1="Prolix Ring",--2%
        --back="Perimede cape",--qc 4%
		back={ name="Taranus's Cape", augments={'MP+60','"Fast Cast"+10',}}, --10%
		waist="Witful Belt", --3%
		}
	
	sets.precast.FC.quickcast = set_combine(sets.precast.FC, {
		ammo="Impatiens",				--2
		back="Perimede cape",			--4
		waist="Witful belt",			--3
		right_ring="Veneficum Ring",	--1
	})
	
	
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC,{waist="Siegel Sash"})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC,{ --59%
		ammo="Hydrocera", --get rid of quickcast when nuking. Maybe I should do this only when MB status is set?
		waist="Ninurta's Sash",	--get rid of quickcast
		right_ear="Barkaro. Earring",
		})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		back="Pahtli Cape",
		feet="Vanya clogs",
		})

    sets.precast.FC.Curaga = sets.precast.FC.Cure

	
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
	
	
	-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	-- these go first as I use them as set_combine below
    sets.buff['Mana Wall'] = {
		feet="Wicce Sabots",
		back="Taranus's Cape",
		}
	
	sets.magic_burst = { --48%
		main={ name="Grioavolr", augments={'"Occult Acumen"+3','MP+79','Mag. Acc.+29','"Mag.Atk.Bns."+27','Magic Damage +2',}},
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+8%','INT+5','Mag. Acc.+8',}},
		neck="Mizu. Kubikazari",--10%
		left_ear="Static Earring",--5%
		--ring1="Locus Ring",--5%
		ring2="Mujin Band",--5% over cap
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+8','"Mag.Atk.Bns."+10',}},--5%
		}
		
    ---- Midcast Sets ----
    sets.midcast.FastRecast = {
        head="Merlinic Hood",head={ name="Merlinic Hood", augments={'"Fast Cast"+4','CHR+10','Mag. Acc.+9','"Mag.Atk.Bns."+13',}},
		right_ear="Loquacious Earring",
        ring1="Prolix Ring",
        back={ name="Taranus's Cape", augments={'MP+60','"Fast Cast"+10',}},
		waist="Witful Belt",
		}

    sets.midcast.Cure = {
        head="Vanya hood",
		body="Vanya Robe",
		hands="Telchine Gloves",
		ring1="Ephedra Ring",ring2="Ephedra Ring",
        back="Solemnity Cape",
		legs="Vanya Slops",
		feet="Vanya Clogs"}

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast['Enhancing Magic'] = {
		head="Befouled Crown",
		neck="Incanter's Torque",
        body="Anhur robe",
		}
    
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		waist="Siegel Sash",
		})

    sets.midcast['Enfeebling Magic'] = {
		ammo="Impatiens",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic Damage +13','INT+6','Mag. Acc.+13','"Mag.Atk.Bns."+8',}},
		--body="Shango Robe",
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic burst mdg.+2%','Mag. Acc.+14','"Mag.Atk.Bns."+15',}},
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Enmity-6','Mag. Acc.+15','"Mag.Atk.Bns."+5',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+8%','INT+5','Mag. Acc.+8',}},
		neck="Incanter's Torque",
		waist="Eschan Stone",
		left_ear="Barkarole Earring",right_ear="Digni. Earring",
		ring1="Adoulin Ring",ring2="Perception Ring",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+8','"Mag.Atk.Bns."+10',}},
	}
        
    sets.midcast.ElementalEnfeeble = sets.midcast['Enfeebling Magic']

    sets.midcast['Dark Magic'] = {
		--ammo="Sturm's Report",
	    ammo="Impatiens",
		--head="Befouled Crown",
		--body="Shango Robe",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic Damage +13','INT+6','Mag. Acc.+13','"Mag.Atk.Bns."+8',}},
		--body="Shango Robe",
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic burst mdg.+2%','Mag. Acc.+14','"Mag.Atk.Bns."+15',}},
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Enmity-6','Mag. Acc.+15','"Mag.Atk.Bns."+5',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+8%','INT+5','Mag. Acc.+8',}},
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		left_ear="Barkarole Earring",right_ear="Digni. Earring",
		ring1="Adoulin Ring",ring2="Evanescence Ring",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+8','"Mag.Atk.Bns."+10',}},
		}

	sets.midcast['Dark Magic'].Death = set_combine(sets.midcast['Elemental Magic'],{ -- 1936 MP
		main={ name="Grioavolr", augments={'"Occult Acumen"+3','MP+79','Mag. Acc.+29','"Mag.Atk.Bns."+27','Magic Damage +2',}},
		sub="Niobid Strap",
		ammo="Strobilus",
		head="Pixie Hairpin +1",
		body={ name="Amalric Doublet", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		hands={ name="Amalric Gages", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs={ name="Amalric Slops", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+8%','INT+5','Mag. Acc.+8',}},
		neck="Mizu. Kubikazari",
		waist="Eschan Stone",
		left_ear="Barkaro. Earring",right_ear="Static Earring",
		ring1="Mephitas's Ring +1",ring2="Archon Ring",
		back={ name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
		})	
	sets.midcast.Death = set_combine(sets.midcast['Dark Magic'].Death,{})

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'],{
		head="Pixie Hairpin +1",
		ring1="Evanescence Ring",
		waist="Fucho-no-Obi",
		feet="Merlinic Crackows",
		})
    
    sets.midcast.Aspir = sets.midcast.Drain

    -- Elemental Magic sets
 	sets.midcast['Elemental Magic'] = {
		main="Lathi",
		sub="Niobid Strap",
		ammo="Pemphredo Tathlum",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic Damage +13','INT+6','Mag. Acc.+13','"Mag.Atk.Bns."+8',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic burst mdg.+2%','Mag. Acc.+14','"Mag.Atk.Bns."+15',}},
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Enmity-6','Mag. Acc.+15','"Mag.Atk.Bns."+5',}},
		--feet={ name="Merlinic Crackows", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+8%','INT+5','Mag. Acc.+8',}},
		feet="Jhakri pigaches +1",
		--neck="Sanctity Necklace", --let's use resistant for macc
		neck="Saevus pendant +1", --more att/less acc
		waist="Refoccilation Stone",
		left_ear="Barkaro. Earring",right_ear="Friomisi Earring",
		ring1="Adoulin Ring",ring2="Strendu Ring",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+8','"Mag.Atk.Bns."+10',}},
	}

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'],{
		neck="Sanctity necklace",
		right_ear="Digni. Earring",
		})
	
    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'],{})
    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant,{})

	sets.midcast.Stun = set_combine(sets.midcast['Elemental Magic'].Resistant,{
		main="Lathi",sub="Niobid Strap",
		ammo="Sturm's Report",
        head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic Damage +13','INT+6','Mag. Acc.+13','"Mag.Atk.Bns."+8',}},
		left_ear="Barkaro. Earring",right_ear="Digni. Earring",
        waist="Witful Belt",
		})
	

    -- Minimal damage gear for procs.
    sets.midcast['Elemental Magic'].Proc = {
		main="Terra's Staff", sub="Mephitis Grip",
		ammo="Impatiens",
		neck="Twilight Torque",
		left_ear="Ethereal Earring",right_ear="Loquacious Earring",
        body="Spaekona's coat +1",
        back="Swith Cape",
		waist="Witful Belt",
		}
		
	sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})	
		
    -- Sets to return to when not performing an action.  
    -- Resting sets
	-- Not really needed anymore with all the MP return options a BLM has now
    sets.resting = set_combine(sets.idle,{})
    

    -- Idle sets  
    -- Normal refresh idle set
    sets.idle = {
		main="Lathi", sub="Oneiros Grip",
		ammo="Impatiens",
        head="Befouled crown",
		neck="Twilight Torque",
		right_ear="Infused Earring",
        body="Jhakri Robe +1",
		--hands="Serpentes Cuffs",--not enough defense
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		ring1="Defending Ring",ring2="Vertigo Ring",
        back="Shadow Mantle",
		waist="Ninurta's sash",
		legs="Assiduity Pants +1",
		--feet="Serpentes Sabots",--not enough defense
		feet="Amalric Nails",
		}

    -- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
	sets.idle.PDT = set_combine(sets.idle,{
		main="Terra's Staff",
		sub="Mensch Strap",
		ammo="Impatiens",
		neck="Twilight Torque",
		ring1="Defending Ring",ring2="Vertigo Ring",
		waist="Flume belt +1",
        back="Shadow Mantle",
		})

    -- Idle mode scopes:
    -- Idle mode when weak.
    sets.idle.Weak = set_combine(sets.idle.PDT,{})
    sets.idle.Death	= set_combine(sets.midcast['Elemental Magic'],{ --Baeeeem 1968 MP
	    main={ name="Grioavolr", augments={'"Occult Acumen"+3','MP+79','Mag. Acc.+29','"Mag.Atk.Bns."+27','Magic Damage +2',}},
		sub="Niobid Strap",
		ammo="Strobilus",
		head="Befouled Crown",
		body={ name="Amalric Doublet", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		hands={ name="Amalric Gages", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs="Assid. Pants +1",
		feet={ name="Amalric Nails", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Conserve MP"+6',}},
		neck="Sanctity Necklace",
		waist="Fucho-no-Obi",
		left_ear="Barkaro. Earring",right_ear="Etiolation Earring",
		ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
		back={ name="Bane Cape", augments={'Elem. magic skill +6','Dark magic skill +3','"Mag.Atk.Bns."+1','"Fast Cast"+3',}},
		})
	
    -- Defense sets

    sets.defense.PDT = set_combine(sets.idle.PDT,{
		neck="Twilight Torque",
		ring1="Defending Ring",
        back="Shadow Mantle",})

    sets.defense.MDT = set_combine(sets.defense.PDT,{
		--ammo="Demonry Stone",
		neck="Twilight Torque",
        --body="Vanir Cotehardie",
		ring1="Defending Ring",
		ring2=="Shadow Ring",
		})

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
		ammo="Hasty Pinion +1",
		neck="Asperity Necklace",
		left_ear="Bladeborn Earring",right_ear="Steelflash Earring",
		ring1="Apate ring",ring2="Petrov Ring",
        back="Kayapa cape",
		waist="Windbuffet belt +1",}

	sets.engaged.ACC = set_combine(sets.engaged,{
		neck="Sanctity necklace",
		ring1="Mars's ring",ring2="Enlivened Ring"})

		-- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = set_combine(sets.engaged,{
		waist="Fotia Belt"})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Vidohunir'] = set_combine(sets.midcast['Elemental Magic'],{waist="Fotia Belt"})
    
	sets.precast.WS['Myrkr'] = set_combine(sets.midcast['Dark Magic'].Death,{}) --as much MP as possible. Similar to Death

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

--lock gear from swapping
function check_equip_lock() -- Lock Equipment Here --	
	if player.target.name ~= nil and player.target.name:contains('Apex') then
		if player.equipment.back ~= "Mecisto. Mantle" then
			equip{back="Mecisto. Mantle"}
			disable('back')
		end
	end
	if player.equipment.back == "Mecisto. Mantle" then
		disable('back')
        if count_msg_mecisto == 1 then
            windower.add_to_chat(8,'REMINDER:  Mecistopins mantle equiped on back')
        end
        count_msg_mecisto = (count_msg_mecisto + 1)
	else
		enable('back')
		count_msg_mecisto = 0
	end
	if	(count_msg_mecisto == 100) then
			count_msg_mecisto = 0
	end
	
	if player.equipment.left_ring == "Warp Ring" or player.equipment.left_ring == "Capacity Ring" or player.equipment.right_ring == "Warp Ring" or player.equipment.right_ring == "Capacity Ring" then
		disable('ring1','ring2')
		if count_msg_ring == 1 then
            windower.add_to_chat(8,'REMINDER: You have yourself some rings that need to be swapped out...')
		end
		count_msg_ring = (count_msg_ring + 1)
	else
		enable('ring1','ring2')
		count_msg_ring = 0
	end
	if	(count_msg_ring == 100) then 
			count_msg_ring = 0
	end	
end

function job_precast(spell, action, spellMap, eventArgs)
    if spell.skill ~= 'Elemental Magic' then
        equip(sets.precast.FC.quickcast)
    end
end

--Refine Nuke Spells
function refine_various_spells(spell, action, spellMap, eventArgs)
	aspirs = S{'Aspir','Aspir II','Aspir III'}
	sleeps = S{'Sleep II','Sleep'}
	sleepgas = S{'Sleepga II','Sleepga'}
	nukes = S{'Fire', 'Blizzard', 'Aero', 'Stone', 'Thunder', 'Water',
	'Fire II', 'Blizzard II', 'Aero II', 'Stone II', 'Thunder II', 'Water II',
	'Fire III', 'Blizzard III', 'Aero III', 'Stone III', 'Thunder III', 'Water III',
	'Fire IV', 'Blizzard IV', 'Aero IV', 'Stone IV', 'Thunder IV', 'Water IV',
	'Fire V', 'Blizzard V', 'Aero V', 'Stone V', 'Thunder V', 'Water V',
	'Fire VI', 'Blizzard VI', 'Aero VI', 'Stone VI', 'Thunder VI', 'Water VI',
	'Firaga', 'Blizzaga', 'Aeroga', 'Stonega', 'Thundaga', 'Waterga',
	'Firaga II', 'Blizzaga II', 'Aeroga II', 'Stonega II', 'Thundaga II', 'Waterga II',
	'Firaga III', 'Blizzaga III', 'Aeroga III', 'Stonega III', 'Thundaga III', 'Waterga III',	
	'Firaja', 'Blizzaja', 'Aeroja', 'Stoneja', 'Thundaja', 'Waterja',
	}
	cures = S{'Cure IV','Cure V','Cure IV','Cure III','Curaga III','Curaga II', 'Curaga',}
	
	if spell.skill == 'Healing Magic' then
		if not cures:contains(spell.english) then
			return
		end
		
		local newSpell = spell.english
		local spell_recasts = windower.ffxi.get_spell_recasts()
		local cancelling = 'All '..spell.english..' spells are on cooldown. Cancelling spell casting.'
		
		if spell_recasts[spell.recast_id] > 0 then
			if cures:contains(spell.english) then
				if spell.english == 'Cure' then
					add_to_chat(122,cancelling)
					eventArgs.cancel = true
				return
				elseif spell.english == 'Cure IV' then
					newSpell = 'Cure V'
				elseif spell.english == 'Cure V' then
					newSpell = 'Cure IV'
				elseif spell.english == 'Cure IV' then
					newSpell = 'Cure III'
				end
			end
		end
		
		if newSpell ~= spell.english then
			send_command('@input /ma "'..newSpell..'" '..tostring(spell.target.raw))
			eventArgs.cancel = true
			return
		end
	elseif spell.skill == 'Enfeebling Magic' then
		if not sleepgas:contains(spell.english) and not sleeps:contains(spell.english) then
			return
		end
		
		local newSpell = spell.english
		local spell_recasts = windower.ffxi.get_spell_recasts()
		local cancelling = 'All '..spell.english..' spells are on cooldown. Cancelling spell casting.'
		
		if spell_recasts[spell.recast_id] > 0 then
			if sleeps:contains(spell.english) then
				if spell.english == 'Sleep' then
					add_to_chat(122,cancelling)
					eventArgs.cancel = true
					return
				elseif spell.english == 'Sleep II' then
					newSpell = 'Sleep'
				end
			elseif sleepgas:contains(spell.english) then
				if spell.english == 'Sleepga' then
					add_to_chat(122,cancelling)
					eventArgs.cancel = true
					return
				elseif spell.english == 'Sleepga II' then
					newSpell = 'Sleepga'
				end
			end
		end
		
		if newSpell ~= spell.english then
			send_command('@input /ma "'..newSpell..'" '..tostring(spell.target.raw))
			eventArgs.cancel = true
			return
		end
	
	elseif spell.skill == 'Dark Magic' then
		if not aspirs:contains(spell.english) then
			return
		end
		
		local newSpell = spell.english
		local spell_recasts = windower.ffxi.get_spell_recasts()
		local cancelling = 'All '..spell.english..' spells are on cooldown. Cancelling spell casting.'

		if spell_recasts[spell.recast_id] > 0 then
			if aspirs:contains(spell.english) then
				if spell.english == 'Aspir' then
					add_to_chat(122,cancelling)
					eventArgs.cancel = true
				return
				elseif spell.english == 'Aspir II' then
					newSpell = 'Aspir'
				elseif spell.english == 'Aspir III' then
					newSpell = 'Aspir II'
				end
			end
		end
		
		if newSpell ~= spell.english then
			send_command('@input /ma "'..newSpell..'" '..tostring(spell.target.raw))
			eventArgs.cancel = true
			return
		end
	elseif spell.skill == 'Elemental Magic' then
		--add_to_chat(122,'elemental')
		
		if not nukes:contains(spell.english) then
			return
		end
		local newSpell = spell.english
		local spell_recasts = windower.ffxi.get_spell_recasts()
		local cancelling = 'All '..spell.english..' spells are on cooldown. Cancelling spell casting.'

		if spell_recasts[spell.recast_id] > 0 then
			if nukes:contains(spell.english) then	
				if spell.english == 'Fire' then
					eventArgs.cancel = true
					return
				elseif spell.english == 'Fire VI' then
					newSpell = 'Fire V'
				elseif spell.english == 'Fire V' then
					newSpell = 'Fire IV'
				elseif spell.english == 'Fire IV' then
					newSpell = 'Fire III'	
				elseif spell.english == 'Fire II' then
					newSpell = 'Fire'
				elseif spell.english == 'Firaja' then
					newSpell = 'Firaga III'
				elseif spell.english == 'Firaga III' then
					newSpell = 'Firaga II'
				elseif spell.english == 'Firaga II' then
					newSpell = 'Firaga'
				end 
				if spell.english == 'Blizzard' then
					eventArgs.cancel = true
					return
				elseif spell.english == 'Blizzard VI' then
					newSpell = 'Blizzard V'
				elseif spell.english == 'Blizzard V' then
					newSpell = 'Blizzard IV'
				elseif spell.english == 'Blizzard IV' then
					newSpell = 'Blizzard III'	
				elseif spell.english == 'Blizzard II' then
					newSpell = 'Blizzard'
				elseif spell.english == 'Blizzaja' then
					newSpell = 'Blizzaga III'
				elseif spell.english == 'Blizzaga III' then
					newSpell = 'Blizzaga II'		
				elseif spell.english == 'Blizzaga II' then
					newSpell = 'Blizzaga'	
				end 
				if spell.english == 'Aero' then
					eventArgs.cancel = true
					return
				elseif spell.english == 'Aero VI' then
					newSpell = 'Aero V'
				elseif spell.english == 'Aero V' then
					newSpell = 'Aero IV'
				elseif spell.english == 'Aero IV' then
					newSpell = 'Aero III'	
				elseif spell.english == 'Aero II' then
					newSpell = 'Aero'
				elseif spell.english == 'Aeroja' then
					newSpell = 'Aeroga III'
				elseif spell.english == 'Aeroga III' then
					newSpell = 'Aeroga II'
				elseif spell.english == 'Aeroga II' then
					newSpell = 'Aeroga'	
				end 
				if spell.english == 'Stone' then
					eventArgs.cancel = true
					return
				elseif spell.english == 'Stone VI' then
					newSpell = 'Stone V'
				elseif spell.english == 'Stone V' then
					newSpell = 'Stone IV'
				elseif spell.english == 'Stone IV' then
					newSpell = 'Stone III'	
				elseif spell.english == 'Stone II' then
					newSpell = 'Stone'
				elseif spell.english == 'Stoneja' then
					newSpell = 'Stonega III'
				elseif spell.english == 'Stonega III' then
					newSpell = 'Stonega II'
				elseif spell.english == 'Stonega II' then
					newSpell = 'Stonega'	
				end 
				if spell.english == 'Thunder' then
					eventArgs.cancel = true
					return
				elseif spell.english == 'Thunder VI' then
					newSpell = 'Thunder V'
				elseif spell.english == 'Thunder V' then
					newSpell = 'Thunder IV'
				elseif spell.english == 'Thunder IV' then
					newSpell = 'Thunder III'	
				elseif spell.english == 'Thunder II' then
					newSpell = 'Thunder'
				elseif spell.english == 'Thundaja' then
					newSpell = 'Thundaga III'
				elseif spell.english == 'Thundaga III' then
					newSpell = 'Thundaga II'
				elseif spell.english == 'Thundaga II' then
					newSpell = 'Thundaga'	
				end 
				if spell.english == 'Water' then
					eventArgs.cancel = true
					return
				elseif spell.english == 'Water VI' then
					newSpell = 'Water V'
				elseif spell.english == 'Water V' then
					newSpell = 'Water IV'
				elseif spell.english == 'Water IV' then
					newSpell = 'Water III'	
				elseif spell.english == 'Water II' then
					newSpell = 'Water'
				elseif spell.english == 'Waterja' then
					newSpell = 'Waterga III'
				elseif spell.english == 'Waterga III' then
					newSpell = 'Waterga II'
				elseif spell.english == 'Waterga II' then
					newSpell = 'Waterga'	
				end 
			end
		end

		if newSpell ~= spell.english then
			send_command('@input /ma "'..newSpell..'" '..tostring(spell.target.raw))
			eventArgs.cancel = true
			return
		end
	end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	check_equip_lock()
	if spellMap ~= 'Stun' then
		refine_various_spells(spell, action, spellMap, eventArgs)
	end
	if state.IdleMode.value == 'Death' and player.mpp > 65 then
		eventArgs.handled = true
		equip(sets.precast.Death)
	elseif spell.skill == 'Elemental Magic' then
		if state.CastingMode.value == 'Proc' then
			classes.CustomClass = 'Proc'
		end
	end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if state.IdleMode.value == 'Death' and player.mpp > 65 then
		equip(sets.precast.Death)
		eventArgs.handled = false
	end
end


function job_post_midcast(spell, action, spellMap, eventArgs)    
	if state.IdleMode.value == 'Death' and player.mpp > 65 then 
		eventArgs.handled = true
		if spell.element == world.day_element or spell.element == world.weather_element then
			equip(sets.midcast['Dark Magic'].Death,{waist="Hachirin-No-Obi"})
		else
			equip(sets.midcast['Dark Magic'].Death)
		end
	elseif spell.skill == 'Elemental Magic' and spell.target.type == 'MONSTER' then
		if state.MagicBurst.value == 'tmp' or state.MagicBurst.value == 'Perma' then
			windower.add_to_chat(8,'MBurst: '..state.MagicBurst.value)
			equip(sets.magic_burst)
		end
		if spell.element == world.day_element or spell.element == world.weather_element then
			windower.add_to_chat(8,'Weather: '..spell.element)
			equip({waist="Hachirin-No-Obi"})
		end
		if state.MPMode.value ~= nil then
			local mpp = tonumber(state.MPMode.value) + 1
			if player.mpp < mpp then
				--windower.add_to_chat(8,'MPP Yo: '..state.MPMode.value)
				equip({body="Spaekona's coat +1"})
			end
		end
	end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    -- Lock feet after using Mana Wall.
    if not spell.interrupted then
        if spell.english == 'Mana Wall' then
            enable('feet','back')
			equip(sets.buff['Mana Wall'])
			if count_msg_mecisto > 0 then
				windower.add_to_chat(8,'NOTE: Mecistopins mantle be gone. Enable Mana Wall Gear !')
				count_msg_mecisto = 0
			end
            disable('feet','back')
        elseif spell.skill == 'Elemental Magic' and state.MagicBurst.value == 'tmp' then
            state.MagicBurst:reset()
		-- Sleep Timers
		elseif spell.name == "Sleep II" or spell.name == "Sleepga II" or spell.name == "Repose" or spell.name == "Dream Flower" then
			windower.send_command('wait 80;input /echo [ WARNING! '..spell.name..' : Will wear off within 0:10 ]')
			windower.send_command('wait 85;input /echo [ WARNING! '..spell.name..' : Will wear off within 0:05 ]')
		elseif spell.name == "Sleep" or spell.name == "Sleepga" then
			windower.send_command('wait 50;input /echo [ WARNING! '..spell.name..' : Will wear off within 0:10 ]')
			windower.send_command('wait 55;input /echo [ WARNING! '..spell.name..' : Will wear off within 0:05 ]')
		end
    end
	if state.OffenseMode.value == 'TP' or state.OffenseMode.value == 'Normal' then
	--if state.OffenseMode.value == 'TP' then
		if player.equipment.main ~= "Grioavolr" then
			if player.equipment.sub ~= "Niobid Strap" then
				--windower.add_to_chat(8,'Fool! I just hope you left the mog house when a horde orcs attacked you. Check your staff and grip !!')
			else
				--windower.add_to_chat(8,'Wow! What did I just see? You nuke with THAT Staff ? Don\'t you have something else? !!')
			end
		elseif player.equipment.sub ~= "Niobid Strap" then
			--windower.add_to_chat(8,'Really? Do you really want to nuke with your refresh strap again? Check your Grip !!')
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- Unlock feet when Mana Wall buff is lost.
    if buff == "Mana Wall" and not gain then
		enable('feet','back')
		handle_equipping_gear(player.status)
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
		elseif newValue == "TP" then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
-- Custom spell mapping.
--[[
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
        --No real need to differentiate with current gear.
        if lowTierNukes:contains(spell.english) then
            return 'LowTierNuke'
        else
            return 'HighTierNuke'
        end
    end
end
--]]

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	--if state.IdleMode.value == 'Death' then
	--	idleSet = set_combine(sets.idle.Death)
	if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
	end
    return idleSet
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 15)
end