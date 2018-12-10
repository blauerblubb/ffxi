function user_setup()
	-- Options: Override default values
  state.OffenseMode:options('Normal','SomeAcc','Acc','FullAcc','Fodder')
  state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','FullAcc','Fodder')
  state.HybridMode:options('Normal')
  state.PhysicalDefenseMode:options('PDT', 'PDTReraise')
  state.MagicalDefenseMode:options('MDT', 'MDTReraise')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'PDT','Refresh','Reraise')
  state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None'}
	state.Passive = M{['description'] = 'Passive Mode','None','Twilight'}
	--state.Weapons:options('Chango','Bravura','Sword','Greatsword','ProcDagger','ProcSword','ProcGreatSword','ProcScythe','ProcPolearm','ProcGreatKatana','ProcClub','ProcStaff')
  state.Weapons:options('Chango','Sword','Greatsword')
	state.AutoWS = M{['description']='Auto WS', 'Upheaval', "Ukko's Fury", "King's Justice", "Steel Cyclone"}

  ---	Cichol's Mantle
	gear.CicholDA = 		{ name = "Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',} }
	gear.CicholWSDSTR =  gear.CicholDA
	--{ name = "Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',} }
	gear.CicholWSDVIT =  gear.CicholDA
	--{ name = "Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',} }
	gear.CicholMeva = 	gear.CicholDA
	--{ name = "Cichol's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10',} }

  --- Job Ability + Buff Bindings
	send_command('bind %1 input /ja "Berserk" <me>')
	send_command('bind %2 input /ja "Aggressor" <me>')
	send_command('bind %3 input /ja "Restraint" <me>')
	send_command('bind %4 input /ja "Retaliation" <me>')
	send_command('bind %5 input /ja "Warcry" <me>; input /party Warcry | TP-Bonus 700')
	send_command('bind %6 input /ja "Blood Rage" <me>; input /party Blood Rage')
	send_command('bind %x input /ja "Weapon Bash" <t>')

	-- Additional local binds
	send_command('bind ^` input /ja "Hasso" <me>')
	send_command('bind !` input /ja "Seigan" <me>')
  send_command('bind !f11 gs c cycle ExtraMeleeMode')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind !r gs c weapons Greatsword;gs c update')
	send_command('bind !p gs c auto_action')
	send_command('bind ![ gs c auto_trust')
	send_command('bind @home gs c cycle AutoWS')

	--select_default_macro_book()

  --- Lockstyle Binding
	send_command('wait 7; input /lockstyleset 20;wait 5;input /displayhead on')

	--- Augmented Gear
	include('Tharian-Items.lua')
end

--- User Unload
function user_unload()

	--- Unload Binds
	send_command('unbind %1')
	send_command('unbind %2')
	send_command('unbind %3')
	send_command('unbind %4')
	send_command('unbind %5')
	send_command('unbind %6')
	send_command('unbind %z')
	send_command('unbind ^z')
	send_command('unbind %=')
	send_command('unbind ^=')
	send_command('unbind ^d')
	send_command('unbind ^s')
	send_command('unbind %x')
	send_command('unbind ^x')
	send_command('unbind %e')
	send_command('unbind !e')
	send_command('unbind %q')
	send_command('unbind ^q')
	send_command('unbind !q')
	send_command('unbind home')
	send_command('unbind delete')
	send_command('unbind end')
	send_command('unbind !end')
	send_command('unbind pagedown')
	send_command('unbind !pagedown')
	send_command('unbind @`')
	send_command('unbind !p')
	send_command('unbind ![')
	send_command('unbind @home')

	--- Unload React
	send_command('lua unload react')

end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	-- Precast Sets

  sets.Enmity = {}
	sets.Knockback = {}
	sets.passive.Reraise = {head="Twilight Helm",body="Twilight Mail"}

	-- Precast sets to enhance JAs
  sets.precast.JA['Blood Rage'] = {
		body  =  "Boii Lorica +1" -- Duration +34s
	}
	sets.precast.JA['Berserk'] = {
		feet  =  "Agoge Calligae +1", -- Duration +20s
		body  =  "Pummeler's Lorica +1", -- Duration +18s
		back  =  gear.CicholDA -- Duration +15s
	}
	sets.precast.JA['Aggressor'] = {
		head  =  "Pummeler's Mask +3", -- Duration +18s
		body  =  "Agoge Lorica +1" -- Duration +20s
	}
	sets.precast.JA['Warcry'] = {
		head  =  "Agoge Mask +1" -- Duration +30s
	}
	sets.precast.JA['Tomahawk'] = {
		ammo  =  "Thr. Tomahawk",
		feet  =  "Agoge Calligae +1" -- 1% Reduction
	}
	sets.precast.JA['Mighty Strikes'] = {
		hands =  "Agoge Mufflers" -- Duration +15s
	}
	sets.precast.JA['Provoke'] = set_combine(sets.Enmity,{})

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.precast.Step = {}

	sets.precast.Flourish1 = {}

	-- Fast cast sets for spells

	sets.precast.FC = {
    ammo  =  "Impatiens",
		neck  =  "Voltsurge Torque",      -- FC'4
		ear1  =  "Enchanter Earring +1",  -- FC'1
		ear2  =  "Loquacious Earring",    -- FC'2
		body  =  gear.Odyssean_Body_FC,   -- FC'9
		hands =  "Leyline Gloves",        -- FC'8
		ring1 =  "Prolix Ring",           -- FC'2
		ring2 =  "Kishar Ring",           -- FC'4
		waist =  "Tempus Fugit",
		legs  =  "Rawhide Trousers",      -- FC'5
		feet  =  gear.Odyssean_Feet_FC    -- FC'9
	}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})

	-- Midcast Sets
	sets.midcast.FastRecast = set_combine(sets.precast.FC, {})
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {back="Mujin Mantle"})
	sets.midcast.Cure = {}

	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
  sets.precast.WS = {
    ammo  =  "Knobkierrie",
		--head  =  gear.Val_Head_WSD,
		--head  =  gear.Odyssean_Head_WSD,
		neck  =  "Fotia Gorget",
		ear1  =  "Cessance Earring",
		ear2  =  "Ishvara Earring",
		body  =  "Pummeler's Lorica +1",
		--hands =  gear.Val_Hands_WSD,
		--hands =  gear.Odyssean_Hands_WSD,
		ring1 =  "Regal Ring",
		--back  =  gear.CicholWSDSTR,
		waist =  "Fotia Belt",
		--legs  =  gear.Val_Legs_WSD,
		feet  =  "Sulev. Leggings +2"
  }

	sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {back="Letalis Mantle",})
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {neck="Combatant's Torque"})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {neck="Combatant's Torque"})
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})

  ----------------------------------------------------------------------
	--- Weaponskills Great Sword
	----------------------------------------------------------------------
  --- Scourge (40% STR 40% VIT | fTP: 3.0)
  sets.precast.WS['Scourge'] = {}
  sets.precast.WS['Scourge'].SomeAcc = set_combine(sets.precast.WS['Scourge'], {})
  sets.precast.WS['Scourge'].Acc = set_combine(sets.precast.WS['Scourge'].SomeAcc, {})
  sets.precast.WS['Scourge'].FullAcc = set_combine(sets.precast.WS['Scourge'].Acc, {})
  sets.precast.WS['Scourge'].Fodder = set_combine(sets.precast.WS['Scourge'], {})

  sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {
    ammo  =  "Seething Bomblet +1",
		head  =  "Flamma Zucchetto +2",   -- STP'6
		body  =  "Argosy Hauberk +1",
		hands =  "Argosy Mufflers +1",    -- STP'6
		legs  =  "Argosy Breeches +1",
    feet  =  "Lustratio Leggings +1", --replace with flamma feet?
		--feet  =  "Pummeler's calligae +1" -- STP'4
		neck  =  "Fotia Gorget",
		ear1  =  "Cessance Earring",
		ear2  =  "Brutal Earring",
		ring1 =  "Niqmaddu Ring",
		ring2 =  "Regal Ring",
		back  =  gear.CicholDA,
		waist =  "Fotia Belt",
  })
  sets.precast.WS['Resolution'].SomeAcc = set_combine(sets.precast.WS['Resolution'], {
    legs  =  "Pummeler's Cuisses +1",
    feet  =  "Pummeler's calligae +1" -- STP'4
  })
  sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'].SomeAcc, {})
  sets.precast.WS['Resolution'].FullAcc = set_combine(sets.precast.WS['Resolution'].Acc, {})
  sets.precast.WS['Resolution'].Fodder = set_combine(sets.precast.WS.Fodder, {})

  --- Shockwave (Sleeps enemies)
  sets.precast.WS['Shockwave'] = {
		ammo  =  "Pemphredo Tathlum",
		head  =  "Flamma Zucchetto +2",
		body  =  "Flamma Korazin +2",
		hands =  "Flamma Manopolas +2",
		legs  =  "Flamma Dirs +2",
		feet  =  "Flamma Gambieras +2",
		neck  =  "Sanctity Necklace",
		ear1  =  "Moonshade Earring",
		ear2  =  "Dignitary's Earring",
		ring1 =  "Stikini Ring +1",
    ring2 =  "Stikini Ring +1",
		back  =  gear.CicholWSDSTR,
		waist =  "Eschan Stone",
	}

  ----------------------------------------------------------------------
	--- Weaponskills Great Axe
	----------------------------------------------------------------------
  --- Metatron Torment (80% STR | fTP: 2.75)
  sets.precast.WS['Metatron Torment'] = {}

  --- Upheaval 4-Hit (80% VIT | fTP: 1.0, 3.5, 6.5)
	sets.precast.WS['Upheaval'] =  set_combine(sets.precast.WS, {
		ammo  =  "Knobkierrie",
		head  =  "Flamma Zucchetto +2",
		--head  =  gear.Odyssean_Head_WSD,
		body  =  gear.valorous_da_body,
		hands =  "Sulevia's Gauntlets +2",
		legs  =  gear.odyssean_da_legs, -- STP'5
		feet  =  "Sulev. Leggings +2",
		--legs  =  "Pummeler's Cuisses +1",
		--feet  =  "Pummeler's calligae +1" -- STP'4
		neck  =  "Fotia Gorget",
		ear1  =  "Ishvara Earring",
		ear2  =  "Moonlight Earring",
		ring1 =  "Apate Ring",
		ring2 =  "Regal Ring",
		back  =  gear.CicholDA,
		waist =  "Fotia Belt",
	})
  sets.precast.WS['Upheaval'].SomeAcc = set_combine(sets.precast.WS['Upheaval'], {})
  sets.precast.WS['Upheaval'].Acc = set_combine(sets.precast.WS['Upheaval'].SomeAcc, {})
  sets.precast.WS['Upheaval'].FullAcc = set_combine(sets.precast.WS['Upheaval'].Acc, {})
  sets.precast.WS['Upheaval'].Fodder = set_combine(sets.precast.WS['Upheaval'], {})
  sets.precast.WS['Upheaval'].WSD = set_combine(sets.precast.WS['Upheaval'], {
    --hands =  gear.Val_Hands_WSD,
		--back  =  gear.CicholWSDVIT,
		--legs  =  gear.Val_Legs_WSD, -- STP'5
		feet  =  "Sulev. Leggings +2"
  })

  sets.precast.WS["Ukko's Fury"] = set_combine(sets.precast.WS, {
    ammo  =  "Yetshila +1",
		head  =  "Argosy Celata +1",    -- STP'6
		body  =  "Argosy Hauberk +1",
		hands =  "Argosy Mufflers +1",  -- STP'6
		legs  =  "Argosy Breeches +1",
		feet  =  "Thereoid Greaves",
    --feet  =  "Pummeler's calligae +1" -- STP'4
		neck  =  "Fotia Gorget",
		ear1  =  "Cessance Earring",
		ear2  =  "Brutal Earring",
		ring1 =  "Niqmaddu Ring",
		ring2 =  "Regal Ring",
		back  =  gear.CicholDA,
		waist =  "Fotia Belt",
  })
  sets.precast.WS["Ukko's Fury"].SomeAcc = set_combine(sets.precast.WS["Ukko's Fury"], {})
  sets.precast.WS["Ukko's Fury"].Acc = set_combine(sets.precast.WS["Ukko's Fury"].SomeAcc, {})
  sets.precast.WS["Ukko's Fury"].FullAcc = set_combine(sets.precast.WS["Ukko's Fury"].Acc, {})
  sets.precast.WS["Ukko's Fury"].Fodder = set_combine(sets.precast.WS["Ukko's Fury"], {})

  sets.precast.WS["King's Justice"] = set_combine(sets.precast.WS, {
    ammo  =  "Seething Bomblet +1",
		head  =  "Flamma Zucchetto +2", -- STP'6
    body  =  "Argosy Hauberk +1",
		hands =  "Argosy Mufflers +1",  -- STP'6
		legs  =  "Argosy Breeches +1",
		feet  =  "Flamma Gambieras +2", -- STP'6
		neck  =  "Fotia Gorget",
		ear1  =  "Cessance Earring",
		ear2  =  "Brutal Earring",
		ring1 =  "Niqmaddu Ring",
		ring2 =  "Regal Ring",
		back  =  gear.CicholDA,
		waist =  "Fotia Belt",
  })
  sets.precast.WS["King's Justice"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
  sets.precast.WS["King's Justice"].Acc = set_combine(sets.precast.WS.Acc, {})
  sets.precast.WS["King's Justice"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
  sets.precast.WS["King's Justice"].Fodder = set_combine(sets.precast.WS.Fodder, {})
  sets.precast.WS["King's Justice"].WSD = set_combine(sets.precast.WS["King's Justice"], {
    ammo  =  "Knobkierrie",
		--head  =  gear.Odyssean_Head_WSD,
		head  =  gear.Val_Head_WSD,
		body  =  "Pummeler's Lorica +1",
		hands =  gear.Val_Hands_WSD,
		back  =  gear.CicholWSDSTR,
		legs  =  gear.Val_Legs_WSD,
		feet  =  "Sulev. Leggings +2"
  })

  --- Weapon Break (60% STR / 60% VIT | fTP: 1.0) Attack -25%
	sets.precast.WS['Weapon Break'] = set_combine(sets.precast.WS['Shockwave'], {})

	--- Armor Break (60% STR / 60% VIT | fTP: 1.0) -25% defense.
	sets.precast.WS['Armor Break'] = set_combine(sets.precast.WS['Shockwave'], {})

	--- Full Break (60% STR / 60% VIT | fTP: 1.0) Attack/Defense 12.5% | Evasion/Aaccuracy 20
	sets.precast.WS['Full Break'] = set_combine(sets.precast.WS['Shockwave'], {})

  ----------------------------------------------------------------------
	--- Weaponskills Sword
	----------------------------------------------------------------------

	--- Savage Blade (50% MND 50% STR | fTP: 4.0  10.25  13.75)
  sets.precast.WS['Savage Blade'] = {
		ammo  =  "Knobkierrie",
		--head  =  gear.Odyssean_Head_WSD,
    head  =  gear.Val_Head_WSD,
		neck  =  "Fotia Gorget",
    ear1  =  "Cessance Earring",
    ear2  =  "Ishvara Earring",
		body  =  "Pummeler's Lorica +1",
		--hands =  gear.Odyssean_Hands_WSD,
    hands =  gear.Val_Hands_WSD,
		ring1 =  "Regal Ring",
		back  =  gear.CicholWSDSTR,
		waist =  "Prosilio Belt +1",
		--legs  =  gear.Odyssean_Legs_WSD,
    legs  =  gear.Val_Legs_WSD,
		feet  =  "Sulev. Leggings +2"
	}
  sets.precast.WS['Savage Blade'].SomeAcc = set_combine(sets.precast.WS['Savage Blade'], {})
  sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'].SomeAcc, {})
  sets.precast.WS['Savage Blade'].FullAcc = set_combine(sets.precast.WS['Savage Blade'].Acc, {})
  sets.precast.WS['Savage Blade'].Fodder = set_combine(sets.precast.WS['Savage Blade'], {})


	--- Vorpal Blade (60% STR | fTP: 1.375)
	sets.precast.WS['Vorpal Blade'] = {
		ammo  =  "Seething Bomblet +1",
		head  =  "Flamma Zucchetto +2",
		body  =  "Argosy Hauberk +1",
		hands =  "Argosy Mufflers +1",
		legs  =  "Argosy Breeches +1",
		feet  =  "Pummeler's calligae +1",
		neck  =  "Fotia Gorget",
		ear1  =  "Cessance Earring",
		ear2  =  "Brutal Earring",
		ring1 =  "Niqmaddu Ring",
		ring2 =  "Regal Ring",
		back  =  gear.CicholDA,
		waist =  "Fotia Belt",
	}

  --- Requiescat (73~85% MND)
  sets.precast.WS['Requiescat'] = {
  	ammo  =  "Seething Bomblet +1",
  	head  =  "Flamma Zucchetto +2",
  	body  =  "Argosy Hauberk +1",
  	hands =  "Argosy Mufflers +1",
  	legs  =  "Argosy Breeches +1",
  	feet  =  "Pummeler's calligae +1",
  	neck  =  "Fotia Gorget",
  	ear1  =  "Cessance Earring",
  	ear2  =  "Brutal Earring",
  	ring1 =  "Niqmaddu Ring",
  	ring2 =  "Regal Ring",
  	back  =  gear.CicholDA,
  	waist =  "Fotia Belt",
  }
  ------------------------------------------------------------------------------------------
  --- Special WS Sets
  ------------------------------------------------------------------------------------------

  --- Mighty Strikes WS Set
  sets.MS_WS = { -- DA + Crit ??
    ammo  =  "Yetshila +1",
    --head  =  ValHead_MS,
    --body  =  ValBody_MS,
    body  =  gear.Val_body_DA,
    --hands =  ValHands_MS,
    --legs  =  ValLegs_MS,
    --feet  =  ValFeet_MS,
  }

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Lugra Earring +1",ear2="Lugra Earring",}
	sets.AccMaxTP = {ear1="Zennaroi Earring",ear2="Telos Earring"}
	sets.AccDayMaxTPWSEars = {ear1="Zennaroi Earring",ear2="Telos Earring"}
	sets.DayMaxTPWSEars = {ear1="Ishvara Earring",ear2="Brutal Earring",}
	sets.AccDayWSEars = {ear1="Zennaroi Earring",ear2="Telos Earring"}
	sets.DayWSEars = {ear1="Brutal Earring",ear2="Moonshade Earring"}

  -- Sets to return to when not performing an action.

  -- Resting sets
  sets.resting = {}

	-- Idle sets
	sets.idle = {
    ammo  =  "Staunch Tathlum",
    --head  =  "Sulevia's Mask +2",
    neck  =  "Sanctity Necklace",
    ear1  =  "Etiolation Earring",
    --ear2  =  "Hearty Earring",
    ear2	=	 "Infused Earring",
    --body  =  "Sulevia's Platemail +2",
    --hands =  "Sulevia's Gauntlets +2",
    ring1 =  "Defending Ring",
    ring2 =  "Vocane Ring",
    back  =  "Moonlight Cape",
    waist =  "Flume Belt",
    --legs  =  "Sulevia's Cuisses +2",
		--feet  =  "Sulevia's leggings +2",
		head={ name="Souv. Schaller +1", augments={'HP+105','VIT+12','Phys. dmg. taken -4',}},
    body={ name="Souv. Cuirass +1", augments={'VIT+12','Attack+25','"Refresh"+3',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+65','Shield skill +15','Phys. dmg. taken -4',}},
    legs={ name="Souv. Diechlings +1", augments={'STR+12','VIT+12','Accuracy+20',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
  }

	sets.idle.Weak = set_combine(sets.idle, {head="Twilight Helm",body="Twilight Mail"})

	sets.idle.Reraise = set_combine(sets.idle, {head="Twilight Helm",body="Twilight Mail"})

	-- Defense sets
	sets.defense.PDT = {
    ammo  =  "Staunch Tathlum", 			-- DT'3
		head={ name="Souv. Schaller +1", augments={'HP+105','VIT+12','Phys. dmg. taken -4',}},
    body={ name="Souv. Cuirass +1", augments={'VIT+12','Attack+25','"Refresh"+3',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+65','Shield skill +15','Phys. dmg. taken -4',}},
    legs={ name="Souv. Diechlings +1", augments={'STR+12','VIT+12','Accuracy+20',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck  =  "Loricate Torque +1", 			-- DT'6
		ring1 =  "Defending Ring", 					-- DT'10
		ring2 =  "Vocane Ring", 						-- DT'4
		back  =  gear.CicholDA,
		waist =  "Tempus Fugit",
  }

	sets.defense.PDTReraise = set_combine(sets.defense.PDT, {head="Twilight Helm",body="Twilight Mail"})

	sets.defense.MDT = {
    main  =  "Firangi",
    sub   =  "Adapa Shield",
    ear1  =  "Flashward Earring",
    ear2  =  "Odnowa Earring +1",
    back  =  "Moonlight Cape",
    waist =  "Flume Belt",
    feet  =  "Amm Greaves"
    }

	sets.defense.MDTReraise = set_combine(sets.defense.MDT, {head="Twilight Helm",body="Twilight Mail"})

	sets.defense.MEVA = {
    ammo  =  "Staunch Tathlum",
    head  =  "Pummeler's Mask +3",
    neck  =  "Warder's Charm +1",
    ear1  =  "Flashward Earring",
    ear2  =  "Hearty Earring",
    body  =  "Pummeler's Lorica +1",
    hands =  "Leyline Gloves",
    ring1 =  "Vengeful Ring",
    ring2 =  "Purity Ring",
    back  =  gear.CicholMeva,
    waist =  "Asklepian Belt",
    legs  =  "Pummeler's Cuisses +1",
    feet  =  "Founder's Greaves"
    }

	sets.Kiting = {}
	sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}

  -- Engaged sets
  sets.engaged = {
    ammo  =  "Ginsen", -- STP'3
    head  =  "Flamma Zucchetto +2", -- STP'6 | TA'5 | HA'4
    neck  =  "Lissome Necklace", -- STP'4 | DA'1
    ear1  =  "Telos Earring", -- STP'5 | DA'1
    ear2  =  "Brutal Earring", -- STP'1 | DA'5
    --body  =  gear.Val_Body_STP, -- STP'9 | DA'2 | HA'3
    hands =  "Sulevia's Gauntlets +2", -- DA'6 | HA'3
    ring1 =  "Niqmaddu Ring", -- QA'3
    ring2 =  "Petrov Ring", -- STP'5 | DA'1
    --back  =  gear.CicholDA, -- DA'10
    waist =  "Ioskeha Belt", -- DA'9 | HA'8
    legs  =  "Pummeler's Cuisses +1", -- DA'11 | HA'6
		feet  =  "Pummeler's calligae +3", -- STP'4 | DA'9 | HA'4
  }

  --------------------------------------------------------------------------
  --- Engage Chango
  --------------------------------------------------------------------------

	--- ACC'1185  HA'28  STP'39/39 (5/1250)  DA'61  TA'5
	sets.engaged.Chango = {
		--main = "Chango",									-- STP'10
		ammo  =  "Ginsen", 									-- STP'3
		head  =  "Flamma Zucchetto +2", 		-- STP'6 | DA'0 | HA'4 | TA'5
		neck 	=	 "Asperity Necklace",				-- STP'3 | DA'2
		ear1	=	 "Telos Earring",						-- STP'5 | DA'1
		ear2  =  "Brutal Earring", 					-- STP'1 | DA'5
		body  =  gear.valorous_da_body, 		-- STP'3 | DA'6	| HA'3
		hands =  "Sulevia's Gauntlets +2", 	-- STP'0 | DA'6 | HA'3
		ring1 =  "Petrov Ring",							-- STP'5 | DA'1
		ring2 =  "Flamma Ring", 						-- STP'5 
		waist =  "Ioskeha Belt", 						-- STP'0 | DA'8 | HA'7
		legs  =  "Pummeler's Cuisses +2",		-- STP'0 | DA'8 | HA'6
		feet  =  "Pummeler's calligae +3",	-- STP'4 | DA'9 | HA'4
																				----------------------
																				-- 		45 |   46 |   27
	}

	--- ACC 1223
	sets.engaged.Chango.Acc = set_combine(sets.engaged.Chango, {
		ear2  =  "Telos Earring", -- STP'5 | DA'1
		ring2 =  "Flamma Ring" -- ACC'6 | STP'5
	})

	--Extra Special Sets

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Retaliation = {}
	sets.buff.Restraint = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

	-- Weapons sets
	sets.weapons.Chango = {main="Chango",sub="Utu Grip"}
  sets.weapons.Greatsword = {main="Raetic Algol +1",sub="Utu Grip"}
  --sets.weapons.Bravura = {main="Bravura",sub="Utu Grip"}
  if player.sub_job == 'DNC' or player.sub_job == 'NIN' then
    sets.weapons.Sword = {main="Firangi",sub="Reikiko"}
  else
    sets.weapons.Sword = {main="Firangi",sub="Blurred Shield +1"}
  end
	--sets.weapons.Greatsword = {main="Montante +1",sub="Utu Grip"}
	sets.weapons.ProcDagger = {main="Kustawi",sub=empty}
	sets.weapons.ProcSword = {main="Ark Sword",sub=empty}
	sets.weapons.ProcGreatSword = {main="Irradiance Blade",sub=empty}
	sets.weapons.ProcScythe = {main="Ark Scythe",sub=empty}
	sets.weapons.ProcPolearm = {main="Pitchfork +1",sub=empty}
	sets.weapons.ProcGreatKatana = {main="Hardwood Katana",sub=empty}
	sets.weapons.ProcClub = {main="Dream Bell +1",sub=empty}
	sets.weapons.ProcStaff = {main="Terra's Staff",sub=empty}

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'SAM' then
        set_macro_page(3, 3)
    elseif player.sub_job == 'DNC' then
        set_macro_page(4, 3)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 3)
    else
        set_macro_page(5, 3)
    end
end

function user_bind_ws(var)
  if state.Weapons.value == 'Ragnarok' then
    --- Bind Ragnarok WeaponSkills
		send_command('bind %q input /ws "Resolution" <t>')
		send_command('bind ^q input /ws "Scourge" <t>')
		send_command('bind !q input /ws "Scourge" <t>')

	elseif state.Weapons.value == 'Greatsword' then
	  --- Bind Algol WeaponSkills
		send_command('bind %q input /ws "Resolution" <t>')

	elseif state.Weapons.value == 'Chango' then
		--- Bind Chango WeaponSkills
		send_command('bind !q input /ws "King/s Justice" <t>')
		send_command('bind %q input /ws "Upheaval" <t>')
		send_command('bind ^q input /ws "Ukko/s Fury" <t>')

  elseif state.Weapons.value == 'Bravura' then
	  --- Bind Bravura WeaponSkills
		send_command('bind !q input /ws "Metatron Torment" <t>')
		send_command('bind %q input /ws "Upheaval" <t>')
		send_command('bind ^q input /ws "Ukko/s Fury" <t>')

	elseif state.Weapons.value == 'Sword' then
	  --- Bind Sword WeaponSkills
		send_command('bind %q input /ws "Savage Blade" <t>')
		send_command('bind !q input /ws "Red Lotus Blade" <t>')
		send_command('bind ^q input /ws "Flat Blade" <t>')
  end
	-- Trigger on unbind.
	if var == 'unload' then
		send_command('unbind %q')
		send_command('unbind ^q')
		send_command('unbind !q')
	end
end

--Job Specific Trust Overwrite

