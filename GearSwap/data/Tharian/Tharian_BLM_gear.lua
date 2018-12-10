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
	sets.precast = {}
    sets.precast.Death = { --never ever switch precast with low mp for death! 1962 MP ( 1936 MP nuke )
		main={ name="Grioavolr", augments={'"Occult Acumen"+3','MP+79','Mag. Acc.+29','"Mag.Atk.Bns."+27','Magic Damage +2',}},
		sub="Niobid Strap",
		ammo="Strobilus",
		--head={ name="Amalric Coif", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		body="Shango Robe",
		hands={ name="Merlinic Dastanas", augments={'"Fast Cast"+6','CHR+2','Mag. Acc.+11','"Mag.Atk.Bns."+12',}},
		--legs={ name="Amalric Slops", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+8%','INT+5','Mag. Acc.+8',}},
		neck="Sanctity Necklace",
		waist="Witful Belt",
		--lear="Barkaro. Earring",
		rear="Etiolation Earring",
		lring="Mephitas's Ring +1",
		rring="Mephitas's Ring",
		back={ name="Taranus's Cape", augments={'MP+60','"Fast Cast"+10',}},
		}
		
    -- Precast sets to enhance JAs
	sets.precast.JA = {}
    sets.precast.JA['Mana Wall'] = {feet="Wicce Sabots",back="Taranus's cape"}

    sets.precast.JA.Manafont = {body="Archmage's Coat"}
    
    -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
    sets.precast.JA.Convert = {}

    -- Fast cast sets for spells

    sets.precast.FC = { --more FC on merlinic + merlinic feet ? // 51% FC // 53% with grip // 57% with staff/grip
		main="Grioavolr", --4%
		sub="Clerisy Strap",--2%
		ammo="Impatiens",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic burst dmg.+11%',}}, -- fc 8%
		body="Anhur Robe",--10%
        hands={ name="Merlinic Dastanas", augments={'"Fast Cast"+6','CHR+2','Mag. Acc.+11','"Mag.Atk.Bns."+12',}}, --FC 6%
		legs="Lengo Pants", --fc 5%
		feet="Merlinic Crackows",--5%
		--neck="Orunmila's Torque",--5%
		rear="Loquacious Earring",--2%
		lring="Prolix Ring",--2%
        --back="Perimede cape",--qc 4%
		back={ name="Taranus's Cape", augments={'MP+60','"Fast Cast"+10',}}, --10%
		waist="Witful Belt", --3%
		}
	
	
	
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC,{waist="Siegel Sash"})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC,{ --59%
		ammo="Hydrocera", --get rid of quickcast when nuking. Maybe I should do this only when MB status is set?
		waist="Channeler's Stone",	--get rid of quickcast
		})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		body="Heka's Kalasiris",
		back="Pahtli Cape",
		lear="Mendicant's Earring",
		--feet="Vanya clogs",
		})

    sets.precast.FC.Curaga = sets.precast.FC.Cure
	
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
	
	-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	-- these go first as I use them as set_combine below
	sets.buff = {}
    sets.buff['Mana Wall'] = {
		feet="Wicce Sabots",
		back="Taranus's Cape",
		}
	
	sets.magic_burst = { --48%
		head={ name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic burst dmg.+11%',}},
		neck="Mizu. Kubikazari",			--10
		hands="Amalric Gages",				--05II
		lring="Mujin band",					--05II
		rring="Locus Ring",					--05
		back="Seshaw Cape",					--05
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic burst dmg.+8%','AGI+1','Mag. Acc.+7',}},
		feet="Jhakri Pigaches +2",			--05
		--back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+8','"Mag.Atk.Bns."+10',}},--5%
		}
		
    ---- Midcast Sets ----
	sets.midcast = {}
    sets.midcast.FastRecast = {
        head={ name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic burst dmg.+11%',}},
		rear="Loquacious Earring",
        lring="Prolix Ring",
        back={ name="Taranus's Cape", augments={'MP+60','"Fast Cast"+10',}},
		waist="Witful Belt",
		}

    sets.midcast.Cure = {
        main="Arka IV",				--24
		--head="Vanya hood",
		body="Heka's Kalasiris",	--15
		hands="Telchine Gloves",	--10
		lear="Mendicant's Earring",	--05
		lring="Ephedra Ring",
		rring="Ephedra Ring",
        --back="Moonbeam Cape",
		--legs="Vanya Slops",
		--feet="Vanya Clogs"
		}

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
		body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+21','Mag. Acc.+21','Haste+3','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Enmity-6','Mag. Acc.+15','"Mag.Atk.Bns."+5',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+8%','INT+5','Mag. Acc.+8',}},
		neck="Incanter's Torque",
		waist="Eschan Stone",
		--lear="Barkarole Earring",
		rear="Digni. Earring",
		lring="Acumen Ring",rring="Perception Ring",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
	}
        
    sets.midcast.ElementalEnfeeble = sets.midcast['Enfeebling Magic']

    sets.midcast['Dark Magic'] = {
		--ammo="Sturm's Report",
	    ammo="Impatiens",
		--head="Befouled Crown",
		--body="Shango Robe",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic Damage +13','INT+6','Mag. Acc.+13','"Mag.Atk.Bns."+8',}},
		--body="Shango Robe",
		body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+21','Mag. Acc.+21','Haste+3','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		--legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Enmity-6','Mag. Acc.+15','"Mag.Atk.Bns."+5',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+8%','INT+5','Mag. Acc.+8',}},
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		--lear="Barkarole Earring",
		rear="Digni. Earring",
		lring="Acumen Ring",
		rring="Evanescence Ring",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
		}

	sets.midcast['Dark Magic'].Death = set_combine(sets.midcast['Elemental Magic'],{ -- 1936 MP
		main={ name="Grioavolr", augments={'"Occult Acumen"+3','MP+79','Mag. Acc.+29','"Mag.Atk.Bns."+27','Magic Damage +2',}},
		sub="Niobid Strap",
		ammo="Strobilus",
		head="Pixie Hairpin +1",
		--body={ name="Amalric Doublet", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		--hands={ name="Amalric Gages", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		--legs={ name="Amalric Slops", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		--feet={ name="Merlinic Crackows", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+8%','INT+5','Mag. Acc.+8',}},
		neck="Mizu. Kubikazari",
		waist="Eschan Stone",
		--lear="Barkaro. Earring",
		--rear="Static Earring",
		lring="Mephitas's Ring +1",
		rring="Archon Ring",
		back={ name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
		})	
	sets.midcast.Death = set_combine(sets.midcast['Dark Magic'].Death,{})

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'],{
		head="Pixie Hairpin +1",
		lring="Evanescence Ring",
		waist="Fucho-no-Obi",
		feet="Merlinic Crackows",
		})
    
    sets.midcast.Aspir = sets.midcast.Drain

    -- Elemental Magic sets
 	sets.midcast['Elemental Magic'] = {
		main="Lathi",
		sub="Niobid Strap",
		ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +1",
		neck="Saevus pendant +1", --more att/less acc
		lear="Hecate's Earring",
		rear="Friomisi Earring",
		body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+21','Mag. Acc.+21','Haste+3','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		lring="Acumen Ring",
		rring="Strendu Ring",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
		waist="Eschan Stone",		
		--waist="Refoccilation Stone",
		legs="Jhakri Slops +1",
		--legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Enmity-6','Mag. Acc.+15','"Mag.Atk.Bns."+5',}},
		--feet={ name="Merlinic Crackows", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+8%','INT+5','Mag. Acc.+8',}},
		feet="Jhakri Pigaches +2",
		}
	
    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'],{
		neck="Sanctity necklace",
		rear="Digni. Earring",
		})
	
    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'],{})
    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant,{})

	sets.midcast.Stun = set_combine(sets.midcast['Elemental Magic'].Resistant,{
		main="Lathi",sub="Niobid Strap",
		--ammo="Sturm's Report",
        head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic Damage +13','INT+6','Mag. Acc.+13','"Mag.Atk.Bns."+8',}},
		--lear="Barkaro. Earring",
		rear="Digni. Earring",
        waist="Witful Belt",
		})
	

    -- Minimal damage gear for procs.
    sets.midcast['Elemental Magic'].Proc = {
		main="Earth Staff", sub="Mephitis Grip",
		ammo="Impatiens",
		lear="Ethereal Earring",rear="Loquacious Earring",
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
		neck="Loricate Torque +1",
		rear="Infused Earring",
        body="Jhakri Robe +1",
		--hands="Serpentes Cuffs",--not enough defense
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		lring="Defending Ring",
		rring="Vocane Ring",
        back="Archon Cape",
		waist="Ninurta's sash",
		legs="Assiduity Pants +1",
		--feet="Serpentes Sabots",--not enough defense
		feet="Merlinic Crackows",
		}

    -- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
	sets.idle.PDT = set_combine(sets.idle,{
		main="Earth Staff",
		--sub="Mensch Strap",
		--ammo="Impatiens",
		neck="Loricate Torque +1",
		lring="Defending Ring",
		rring="Vocane Ring",
		waist="Flume belt",
        back="Archon Cape",
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
		--hands={ name="Amalric Gages", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs="Assid. Pants +1",
		--feet={ name="Amalric Nails", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Conserve MP"+6',}},
		neck="Sanctity Necklace",
		waist="Fucho-no-Obi",
		--lear="Barkaro. Earring",
		rear="Etiolation Earring",
		lring="Mephitas's Ring +1",
		rring="Mephitas's Ring",
		back={ name="Bane Cape", augments={'Elem. magic skill +8','Dark magic skill +10','"Mag.Atk.Bns."+2',}},
		})
	
    -- Defense sets
	sets.defense = {}
    sets.defense.PDT = set_combine(sets.idle.PDT,{
		neck="Loricate Torque +1",
		lring="Defending Ring",
        back="Archon Cape",})

    sets.defense.MDT = set_combine(sets.defense.PDT,{
		--ammo="Demonry Stone",
		neck="Loricate Torque +1",
        --body="Vanir Cotehardie",
		lring="Defending Ring",
		rring=="Vocane Ring",
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
		--ammo="Amar Cluster",
		--neck="Asperity Necklace",
		--lear="Bladeborn Earring",
		--rear="Steelflash Earring",
		--lring="Apate ring",rring="Petrov Ring",
        --back="Kayapa cape",
		waist="Windbuffet belt +1",}

	sets.engaged.ACC = set_combine(sets.engaged,{
		neck="Sanctity necklace",
		lring="Mars's ring",rring="Enlivened Ring"})

		-- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = set_combine(sets.engaged,{
		waist="Fotia Belt"})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Vidohunir'] = set_combine(sets.midcast['Elemental Magic'],{waist="Fotia Belt"})
    
	sets.precast.WS['Myrkr'] = set_combine(sets.midcast['Dark Magic'].Death,{}) --as much MP as possible. Similar to Death

end

function select_default_macro_book()
    set_macro_page(6, 15)
end