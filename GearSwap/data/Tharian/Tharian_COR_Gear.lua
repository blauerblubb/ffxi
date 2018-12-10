-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
  state.OffenseMode:options('Normal','Acc')
  state.RangedMode:options('Normal', 'Acc')
  state.WeaponskillMode:options('Match','Normal', 'Acc','Proc')
  state.CastingMode:options('Normal', 'Resistant')
  state.IdleMode:options('Normal', 'PDT', 'Refresh')
	state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'DWMax'}
	state.Weapons:options('Default','DualWeapons','SavageWeapons','DualRangedWeapons','LeadenWeapons','None')

  gear.RAbullet = "Chrono Bullet"
  gear.WSbullet = "Chrono Bullet"
  gear.MAbullet = "Orichalc. Bullet" --For MAB WS, do not put single-use bullets here.
  gear.QDbullet = "Animikii Bullet"
  options.ammo_warning_limit = 15

  --------------------------------------
  -- COR Capes
  --------------------------------------
  gear.Camulus_ACC_snap = { name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Snapshot"+10',}}
  gear.Camulus_WSD = { name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Magic Damage +10','Weapon skill damage +10%',}}
  gear.Camulus_RACC = gear.Camulus_WSD
  gear.Camulus_engaged = { name="Bleating Mantle"}
  gear.Camulus_MATT = { name="Bleating Mantle"}

  gear.Herc_MAB_head = "Herculean Helm"
  gear.Herc_MAB_body = "Samnuha Coat"
  gear.Herc_MAB_legs = { name="Herculean Trousers", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Crit.hit rate+1','STR+9','Mag. Acc.+15','"Mag.Atk.Bns."+10',}}
  
  gear.Herc_TH_legs = "Volte Hose"

  gear.Herc_TA_body = { name="Herculean Vest", augments={'Accuracy+23','"Triple Atk."+2','AGI+6','Attack+10',}}
  gear.Herc_TA_feet = { name="Herculean Boots", augments={'Accuracy+24 Attack+24','"Triple Atk."+3','DEX+5','Accuracy+5',}}

  gear.Herc_WS_head = { name="Herculean Helm", augments={'Accuracy+29','Weapon skill damage +1%','Attack+13',}}
  gear.Herc_WS_body = gear.Herc_TA_body
  gear.Herc_WS_legs = { name="Herculean Trousers", augments={'Rng.Acc.+21 Rng.Atk.+21','Sklchn.dmg.+5%','AGI+14','Rng.Acc.+5','Rng.Atk.+15',}}
  gear.Herc_WS_feet = gear.Herc_TA_feet
  
 

  gear.Herc_DT_hands = "Meg. Gloves +2"

    -- Additional local binds
	send_command('bind !f11 gs c cycle ExtraMeleeMode')
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind !` gs c elemental quickdraw')

	send_command('bind ^backspace input /ja "Double-up" <me>')
	send_command('bind @backspace input /ja "Snake Eye" <me>')
	send_command('bind !backspace input /ja "Fold" <me>')
	send_command('bind ^@!backspace input /ja "Crooked Cards" <me>')

	send_command('bind ^\\\\ input /ja "Random Deal" <me>')
  send_command('bind !\\\\ input /ja "Bolter\'s Roll" <me>')
	send_command('bind ^@!\\\\ gs c toggle LuzafRing')
	send_command('bind @f7 gs c toggle RngHelper')

	send_command('bind !r gs c weapons SingleWeapon;gs c update')
	send_command('bind @q gs c weapons MaccWeapons;gs c update')
	send_command('bind ^q gs c weapons DualRangedWeapons;gs c update')
	send_command('bind !q gs c weapons SavageWeapons;gs c update')
	send_command('bind @pause roller roll')

  select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
  --------------------------------------
  -- Start defining the sets
  --------------------------------------
  sets.misc = { --Organizer
    main="Fettering Blade",
    sub="Nusku shield",
    ammo="Compensator",
    head="Trump Card",
    neck="Sublime Sushi",
    ring1="Fomalhaut",
    ring2="Atoyac",
  }

  --[[ Missing / Need
  Oshosi Set +1

  --Relic
  Lanun Frac +1 --MATT +61
  Lanun Gants +1 -Snapshot13 or Oshosi Gloves +1
  Lanun Bottes +3 --WSD+10

  -- AF
  Laksa. Tricorne +1,
  Laksa. Body,
  Laksa. Gants +1,
  Laksa. Boots +1

  ]]--

  -- Precast Sets
  -- Precast sets to enhance JAs
  sets.precast.JA['Triple Shot'] = {body="Chasseur's Frac +1"}
  sets.precast.JA['Snake Eye'] = {legs="Lanun trews +1"}
  sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +3"}
  sets.precast.JA['Random Deal'] = {body="Lanun Frac +1"}
  sets.precast.FoldDoubleBust = {hands="Lanun Gants +1"}

  sets.precast.CorsairRoll = {
    head="Lanun Tricorne +2",
    neck="Regal Necklace",
    body="Lanun Frac +1",
    hands="Chasseur's Gants +1",
    --legs="Desultor Tassets",
    back=gear.Camulus_ACC_snap,
  }

  sets.precast.LuzafRing = {ring2="Luzaf's Ring"}

  sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chas. Culottes +1"})
  sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chasseur's Bottes +1"})
  sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chass. Tricorne +1"})
  sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac +1"})
  sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +1"})

  sets.precast.CorsairShot = {
    ammo=gear.QDbullet,
    head=gear.Herc_MAB_head,
    body="Samnuha Coat",
    --body="Lanun Frac +1",
    hands="Carmine Fin. Ga.",
    legs=gear.Herc_MAB_legs,
    feet="Chasseur's Bottes +1",
    --feet="Lanun Bottes +3",
    ear1="Friomisi Earring",
    ear2="Hecate's Earring",
    ring1="Acumen Ring",
    ring2="Dingir Ring",
    neck="Sanctity Necklace", --Baetyl Pendant",
    waist="Eschan Stone",
    back=gear.Camulus_MATT,
  }

  sets.precast.CorsairShot.Proc = set_combine(sets.precast.CorsairShot,{
    ammo=gear.RAbullet,
    head="Wh. Rarab Cap +1",
    legs=gear.Herc_TH_legs,
  })

  sets.precast.CorsairShot['Light Shot'] = {
    ammo=gear.QDbullet,
    head="Carmine Mask",
    neck="Sanctity Necklace",
    ear1="Digni. Earring",
    ear2="Gwati Earring",
    body="Mummu Jacket +2",
    hands="Leyline Gloves",
    ring1="Sangoma Ring", --"Stikini Ring +1",
    ring2="Stikini Ring",
    back=gear.Camulus_MATT,
    waist="Eschan Stone",
    legs="Mummu Kecks +2",
    feet="Mummu Gamash. +2",
  }

  sets.precast.CorsairShot['Dark Shot'] = set_combine(sets.precast.CorsairShot['Light Shot'], {
    feet="Chasseur's Bottes +1"
  })

  -- Waltz set (chr and vit)
  sets.precast.Waltz = {}
	sets.Self_Waltz = {}

  -- Don't need any special gear for Healing Waltz.
  sets.precast.Waltz['Healing Waltz'] = {}

  -- Fast cast sets for spells
  sets.precast.FC = {
    head="Carmine Mask",
    body="Taeon Tabard",
    hands="Leyline Gloves",
    legs="Rawhide Trousers",
    --feet="Carmine Greaves +1",
    neck="Voltsurge Torque",
    ear1="Etiolation Earring",
    ear2="Loquacious Earring",
    ring1="Kishar Ring",
    ring2="Prolix Ring",
    back=gear.Camulus_FC,
    --waist="Ninurta's Sash",
  }

  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})--neck="Magoraga Beads"
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})--ear2="Mendi. Earring"

  sets.precast.RA = { --60 Snapshot in order to be capped
    ammo=gear.RAbullet,
    --head="Taeon Chapeau"
    head="Chass. Tricorne +1",          
    --body="Oshosi Vest +1",
    --body="Oshosi Vest",
    --body="Lak. Frac +1",
    hands="Carmine Fin. Ga.",
    --legs="Adhemar Kecks",               --9
    legs="Lanun Trews +1",
    feet="Meg. Jam. +2",
    back=gear.Camulus_ACC_snap,
    waist="Yemaya Belt",
  }

  sets.precast.RA.Flurry = set_combine(sets.precast.RA, {
    body="Lak. Frac +1",
  })
	sets.precast.RA.Flurry2 = set_combine(sets.precast.RA, {
    head="Chass. Tricorne +1",
  })


  -- Weaponskill sets
  -- Default set for any weaponskill that isn't any more specifically defined
  sets.precast.WS = {
    head=gear.Herc_WS_head,
    --body="Lak. Frac +1",
    body="Meghanada Cuirie +2",
    hands="Meg. Gloves +2",
    legs=gear.Herc_WS_legs,
    feet="Meg. Jam. +2",
    --feet="Lanun Bottes +3",
    neck="Fotia Gorget",
    ear1="Moonshade Earring",
    ear2="Ishvara Earring",
    ring1="Regal Ring",
    --ring2="Shukuyu Ring",
    back=gear.Camulus_WSD,
    waist="Fotia Belt",
  }

  sets.precast.WS.Acc = set_combine(sets.precast.WS,{
    ear2="Telos Earring",
    ear1="Digni. Earring",
    waist="Grunfeld Rope",
  })

  sets.precast.WS.Proc = {}

  -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
  sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
    head="Adhemar Bonnet +1",
		body="Adhemar Jacket +1",
    hands="Meg. Gloves +2",
    legs="Meghanada Chausses +2",
    feet=gear.Herc_TA_feet,
    --ring2="Rufescent Ring",
  })

	sets.precast.WS['Savage Blade'] = {
    head=gear.Herc_WS_head,
    --body="Lak. Frac +1",
    body=gear.Herc_WS_body,
    hands="Meg. Gloves +2",
    legs=gear.Herc_WS_legs,
    feet=gear.Herc_WS_feet,
    --feet="Lanun Bottes +3",
    neck="Fotia Gorget",
    ear1="Moonshade Earring",
    ear2="Ishvara Earring",
    ring1="Regal Ring",
    --ring2="Shukuyu Ring",
    back=gear.Camulus_WSD,
    waist="Fotia Belt",
  }

  sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'],{})

  sets.precast.WS['Last Stand'] = {
    --[[ --BiS
    head="Lanun Tricorne +2",
    body="Lak. Frac +1",
    legs="Herculean Trousers",
    feet="Lanun Bottes +3",
    ]]--
    ammo=gear.WSbullet,
    head="Meghanada Visor +2",
    body="Meghanada Cuirie +2",
    hands="Meg. Gloves +2",
    --legs="Meg. Chausses +2",
    legs=gear.Herc_WS_legs,
    feet=gear.Herc_WS_feet,
    neck="Fotia Gorget",
    ear1="Moonshade Earring",
    ear2="Telos Earring",
    ring1="Regal Ring",
    ring2="Dingir Ring",
    back=gear.Camulus_WSD,
    waist="Fotia Belt",
  }

  sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'],{})

  sets.precast.WS['Detonator'] = sets.precast.WS['Last Stand']
  sets.precast.WS['Detonator'].Acc = sets.precast.WS['Last Stand'].Acc
  sets.precast.WS['Slug Shot'] = sets.precast.WS['Last Stand']
  sets.precast.WS['Slug Shot'].Acc = sets.precast.WS['Last Stand'].Acc
  sets.precast.WS['Numbing Shot'] = sets.precast.WS['Last Stand']
  sets.precast.WS['Numbing Shot'].Acc = sets.precast.WS['Last Stand'].Acc
  sets.precast.WS['Sniper Shot'] = sets.precast.WS['Last Stand']
  sets.precast.WS['Sniper Shot'].Acc = sets.precast.WS['Last Stand'].Acc
  sets.precast.WS['Split Shot'] = sets.precast.WS['Last Stand']
  sets.precast.WS['Split Shot'].Acc = sets.precast.WS['Last Stand'].Acc

  sets.precast.WS['Leaden Salute'] = {
    ammo=gear.MAbullet,
    head="Pixie Hairpin +1",
    body=gear.Herc_MAB_body,
    --body="Lanun Frac +1",
    hands="Carmine Fin. Ga.",
    --legs="Laksa. Trews +1",
    legs=gear.Herc_MAB_legs,
    feet="Lanun Bottes +3",
    neck="Sanctity Necklace",--"Baetyl Pendant",
    ear1="Moonshade Earring",
    ear2="Friomisi Earring",
    ring1="Archon Ring",
    ring2="Dingir Ring",
    back=gear.Camulus_WSD,
    waist="Eschan Stone",
  }

  sets.precast.WS['Leaden Salute'].Acc = set_combine(sets.precast.WS['Leaden Salute'],{})

  sets.precast.WS['Wildfire'] = set_combine(sets.precast.WS['Leaden Salute'],{
    ammo=gear.MAbullet,
    head=gear.Herc_MAB_head,
    ear1="Hecate's Earring",
    ear2="Friomisi Earring",
    ring1="Ilabrat Ring",
    ring2="Dingir Ring",
  })

  sets.precast.WS['Wildfire'].Acc = set_combine(sets.precast.WS['Wildfire'],{})

  sets.precast.WS['Hot Shot'] = sets.precast.WS['Wildfire']
  sets.precast.WS['Hot Shot'].Acc = sets.precast.WS['Wildfire'].Acc

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}

  sets.midcast.Utsusemi = sets.midcast.FastRecast

  -- Ranged gear
  sets.midcast.RA = {
    ammo=gear.RAbullet,
    head="Meghanada Visor +2",
    body="Nisroch Jerkin",
    hands={ name="Adhemar Wristbands", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}},
    legs={ name="Herculean Trousers", augments={'Rng.Acc.+21 Rng.Atk.+21','Sklchn.dmg.+5%','AGI+14','Rng.Acc.+5','Rng.Atk.+15',}},
    feet={ name="Adhe. Gamashes +1", augments={'HP+65','"Store TP"+7','"Snapshot"+10',}},
    neck="Iskur Gorget",
    waist="Yemaya Belt",
    left_ear="Enervating Earring",
    right_ear="Telos Earring",
    left_ring="Dingir Ring",
    right_ring="Ilabrat Ring",
    back=gear.Camulus_RACC,
  }

  sets.midcast.RA.Acc = set_combine(sets.midcast.RA,{})

	sets.buff['Triple Shot'] = {
    --head="Oshosi Mask",
    body="Chasseur's Frac +1",
    hands="Lanun Gants +1",
    --legs="Oshosi Trousers",
    --feet="Oshosi Leggings",
  }

  -- Sets to return to when not performing an action.

	sets.DayIdle = {}
	sets.NightIdle = {}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})

  -- Resting sets
  sets.resting = {}


  -- Idle sets
  sets.idle = {
    ammo=gear.RAbullet,
    head="Meghanada Visor +2",
    neck="Loricate Torque +1",
    ear1="Colossus's Earring",
    ear2="Etiolation Earring",
    body="Meg. Cuirie +2",
    hands=gear.Herc_DT_hands,
    ring1="Defending Ring",
    ring2="Vocane Ring",
    back="Moonbeam Cape",
    waist="Flume Belt",
    legs="Carmine Cuisses +1",
    feet="Meghanada jambeaux +2",
  }

  sets.idle.Refresh = set_combine(sets.idle,{
    --ring1="Stikini Ring +1",
    --ring2="Stikini Ring +1",
  })

  -- Defense sets
  sets.defense.PDT = sets.idle
  sets.defense.MDT = sets.idle
  sets.defense.MEVA = sets.idle

  sets.Kiting = {legs="Carmine Cuisses +1"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.DWMax = {ear1="Suppanomimi",ear2="Eabani Earring",body="Adhemar Jacket +1",waist="Reiki Yotai"} --hands="Floral Gauntlets",

	-- Weapons sets
	sets.weapons.Default = {main="Fettering Blade",sub="Nusku Shield",range="Fomalhaut"}
	sets.weapons.DualWeapons = {main="Fettering Blade",sub="Hepatizon Rapier +1",range="Fomalhaut"}
	sets.weapons.RollMeleeWeapons = {main="Hep. Sapara +1",sub="Hepatizon Rapier +1",range="Compensator"}
	sets.weapons.RollRangedWeapons = {main="Fettering Blade",sub="Hepatizon Rapier +1",range="Compensator"}
	sets.weapons.SavageWeapons = {main="Hep. Sapara +1",sub="Hepatizon Rapier +1",range="Ataktos"}
	sets.weapons.DualRangedWeapons = {main="Fettering Blade",sub="Hepatizon Rapier +1"}
	sets.weapons.LeadenWeapons = {main="Fettering Blade",sub="Hepatizon Rapier +1",range="Fomalhaut"}

  -- Engaged sets

  -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
  -- sets if more refined versions aren't defined.
  -- If you create a set with both offense and defense modes, the offense mode should be first.
  -- EG: sets.engaged.Dagger.Accuracy.Evasion

  -- Normal melee group
  sets.engaged = {
    head="Adhemar Bonnet +1",
    body=gear.Herc_TA_body,
    hands="Adhemar Wristbands",
    legs="Samnuha Tights",
    feet=gear.Herc_TA_feet,
    neck="Iskur Gorget",
    waist="Windbuffet Belt +1",
    ear1="Cessance earring",
    ear2="Brutal Earring",
    ring1="Epona's Ring",
    ring2="Petrov Ring",
    back=gear.Camulus_engaged,
  }

  sets.engaged.Acc = set_combine(sets.engaged,{
    head="Dampening Tam",
    ear2="Telos Earring",
    waist="Eschan Stone",
  })

  sets.engaged.DW = set_combine(sets.engaged,{
    body="Adhemar Jacket +1",
		ear1="Telos earring",
		ear2="Suppanomimi",
		back=gear.Camulus_engaged,
  })

  sets.engaged.DW.Acc = set_combine(sets.engaged.DW,{})
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
  if player.sub_job == 'NIN' then
    set_macro_page(2, 11)
  elseif player.sub_job == 'DNC' then
	set_macro_page(1, 11)
  elseif player.sub_job == 'RNG' then
    set_macro_page(9, 11)
  else
    set_macro_page(10, 11)
  end
end
