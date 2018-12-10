
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'TP', 'MidAcc', 'HighAcc', 'DamageTaken', 'Refresh', 'Learning')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Learning')
	state.NotifyWS = M(false)
	
	-- DO NOT TOUCH - These are in use for Skillchain and Auto Re-equip from weapons
	state.SCStage = M('None','ChainAffinity','BurstAffinity','Burst','WS')
	state.CombatWeapon = M{['description']='Combat Weapon', 'DD', 'Magic', 'Off'}
	state.AutoWS = M{['description']='Auto WS', 'Requiescat', 'Chant du Cygne', 'Savage Blade', 'Sanguine Blade', 'Expiacion', 'Circle Blade', 'None'}
	
    -- Utility Binds
    send_command('bind pagedown gs c cycle CombatWeapon')
	send_command('bind pageup gs c toggle NotifyWS')
	
	-- Additional local binds
	send_command('bind ^q input /ja "Diffusion" <me>; wait 1;input /ma "Mighty Guard" <me>')
	send_command('bind !q input /ja "Chain Affinity" <me>')
    send_command('bind @q input /ja "Burst Affinity" <me>')
	--send_command('bind ` input /ja "Efflux" <me>')
	send_command('bind !p gs c auto_action')
	send_command('bind ![ gs c auto_trust')
	send_command('bind !o gs c cure')
	send_command('bind @home gs c cycle AutoWS')
	
    send_command('wait 7; input /lockstyleset 22;wait 5;input /displayhead on')

    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind pageup')
	send_command('unbind pagedown')
    send_command('unbind ^`')
    send_command('unbind !`')
	send_command('unbind @`')
    --send_command('unbind `')
end


-- Set up gear sets.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
	sets.keep = {
		hand="Trizek Ring",
		waist="Hachirin-No-Obi",
		legs="Sublime Sushi",
		}
		
	sets.buff = {}
	sets.buff['Burst Affinity'] = {feet="Hashishin Basmak +1"}
    sets.buff['Chain Affinity'] = {head="Hashi. Kavuk +1", feet="Assim. Charuqs +1"}
    sets.buff.Convergence = {head="Luhlaza Keffiyeh"}
    sets.buff.Diffusion = {feet="Luhlaza Charuqs +1"}
    sets.buff.Enchainment = {body="Luhlaza Jubbah"}
    sets.buff.Efflux = {head="Hashishin Kavuk +1",legs="Hashishin Tayt +1",back="Rosmerta's Cape",}

    -- Gear for learning spells: +skill and AF hands.
    sets.Learning = {ammo="Mavi Tathlum",hands="Assimilator's Bazubands +1"}
        --head="Luhlaza Keffiyeh",
        --body="Assimilator's Jubbah",hands="Assimilator's Bazubands +1",
        --back="Cornflower Cape",legs="Mavi Tayt +2",feet="Luhlaza Charuqs"}
    sets.latent_refresh = {waist="Fucho-no-obi"}
    --sets.misc.Obi = {waist="Hachirin-no-Obi"}

    -- Precast Sets
	sets.precast = {}
    -- Precast sets to enhance JAs
	sets.precast.JA = {}
    sets.precast.JA['Azure Lore'] = {hands="Luh. Bazubands +1"}
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells

    sets.precast.FC = {
		ammo="Impatiens",
		head="Carmine Mask",
		neck="Voltsurge Torque",
		lear="Loquac. Earring",
		--rear="",
		body="Jhakri Robe +2",
		hands="Leyline Gloves",
		lring="Kishar Ring",
		rring="Prolix Ring",
		back="Ogapepo Cape",
		waist="Witful Belt",
		legs="Jhakri slops +2",
		feet="Jhakri pigaches +2",
		
		}

    sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body="Hashishin Mintan +1",hands="Hashi. Bazubands"})


    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo="Amar cluster",
        head="Dampening Tam",
        neck="Fotia Gorget", 																								--10% WSD
        lear="Moonshade Earring",
		rear="Ishvara Earring",																								--02% WSD
        body="Assim. Jubbah +3",																							--10% WSD
        hands="Jhakri Cuffs +2",																							--07% WSD
        lring="Apate Ring",
		rring="Ilabrat Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},	--10% WSD
        waist="Fotia Belt",																									--10% WSD
        legs="Herculean Trousers",
        feet="Thereoid Greaves",}

    sets.precast.WS.acc = set_combine(sets.precast.WS, {})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
        ammo="Jukukik Feather",
		--lear="Mache earring",
		--rear="Mache earring",
		})

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Sanguine Blade'] = {ammo="Pemphredo Tathlum",
        head="Amalric coif",
        neck="Sanctity Necklace",
        lear="Friomisi Earring",rear="Hecate's Earring",
        body="Amalric doublet",
        hands="Amalric gages",
        lring="Strendu Ring",rring="Adoulin Ring",
        back="Cornflower Cape",
        waist="Hachirin-no-Obi",
        legs="Amalric Slops",
        feet="Amalric nails",}


    -- Midcast Sets
	sets.midcast = {}
	
    sets.midcast.FastRecast = {
        ammo="Impatiens",
        head="Herculean Helm",
        rear="Loquacious Earring",
        body="Taeon tabard",
        hands="Helios gloves",
        lring="Prolix Ring",
        back="Swith Cape",
        waist="Witful Belt",
        feet="Amalric nails",}

    sets.midcast['Blue Magic'] = {body="Hashishin Mintan"}

    -- Physical Spells --

    sets.midcast['Blue Magic'].Physical = {
        lring="Apate ring",
        hands="Adhemar wristbands",
        back="Cornflower Cape",
        legs="Herculean Trousers",}

    sets.midcast['Blue Magic'].PhysicalAcc = set_combine(sets.midcast['Blue Magic'].Physical,{
        neck="Sanctity Necklace",
        rear="Enchntr. Earring +1",lear="Eabani Earring",
        body="Mekosu. Harness",
        waist="Olseni Belt",})
    sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical)
    sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical)
    sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical)
    sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical)
    sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical)
    sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical,{
        ammo="Quartz Tathlum +1",
        neck="Phalaina Locket",
        hands="Luh. Bazubands +1",
        rring="Levia. Ring +1",
        legs="Hashishin Tayt +1",})
    sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical)
    sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical)


    -- Magical Spells --
    sets.midcast['Blue Magic'].Magical = {
		ammo="Dosis Tathlum", 
		head={ name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic burst dmg.+11%',}}, 
		neck="Sanctity Necklace", 
		lear="Friomisi Earring", 
		rear="Hecate's Earring", 
		body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+21','Mag. Acc.+21','Haste+3','Mag. Acc.+14 "Mag.Atk.Bns."+14',}}, 
		hands="Jhakri cuffs +2",
		lring="Strendu Ring", 
		rring="Acumen Ring",
		back="Cornflower Cape", 
		waist="Eschan Stone",
		legs="Jhakri Slops +2", 
		feet="Jhakri Pigaches +2"}

    sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical)
    sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical)
    sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical)

    sets.midcast['Blue Magic'].MagicAccuracy = {
          head="Amalric coif",
          neck="Sanctity Necklace",
          lear="Friomisi Earring",rear="Hecate's Earring",
          body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+21','Mag. Acc.+21','Haste+3','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
          hands="Helios gloves",
          lring="Strendu Ring",rring="Acumen Ring",
          back="Cornflower Cape",
          waist="Caudata Belt",
          legs="Amalric Slops",
          feet="Amalric nails"}

    sets.midcast['Blue Magic'].MagicalDark = set_combine(sets.midcast['Blue Magic'].Magical,{head="Pixie Hairpin +1",lring="Archon Ring"})

    -- Breath Spells --
    sets.midcast['Blue Magic'].Breath = {
          ammo="Mavi Tathlum",
          head="Luh. Keffiyeh +1"}

    -- Other Types --

    sets.midcast['Blue Magic'].Stun = set_combine(sets.midcast['Blue Magic'].MagicAccuracy,{})

    sets.midcast['Blue Magic'].Healing = {
          ammo="Quartz Tathlum +1",
          head="Telchine Cap",
          neck="Phalaina Locket",
          lear="Loquac. Earring", 
		  --rear="Enchntr. Earring +1",
          body="Telchine Chas.",
          hands="Telchine Gloves",
          --lring="Levia. Ring +1", 
		  --rring="Levia. Ring +1",
		  back="Swith Cape +1",
          waist="Cascade Belt",
          legs="Telchine Braconi",
          feet="Telchine Pigaches",}

    sets.midcast['Blue Magic'].SkillBasedBuff = {}

    sets.midcast['Blue Magic'].Buff = {}



    -- Sets to return to when not performing an action.

    -- Idle sets
    sets.idle = {
          ammo="Amar Cluster",
          head="Dampening Tam",
          neck="Loricate Torque +1",
          lear="Eabani Earring",rear="Infused earring",
		  body="Jhakri Robe +2",
          hands="Serpentes Cuffs",
          lring="Vocane Ring",rring="Defending Ring",
          back="Moonbeam Cape",
          waist="Flume Belt",
          --legs="Rawhide Trousers", --refresh
          legs="Carmine Cuisses +1",
          feet="Serpentes Sabots",}


    sets.idle.Learning = set_combine(sets.idle, sets.Learning)


    -- Defense sets
	sets.defense = {}
	
    sets.defense.PDT = {
            ammo="Staunch Tathlum",			--  2 DT
			head="Aya. Zucchetto +2",		--  3 DT
			body="Ayanmo Corazza +2",		--  6 DT
			hands="Aya. Manopolas +2",		--  3 DT
			legs="Aya. Cosciales +2",		--  5 DT
			feet="Aya. Gambieras +2",		--  3 DT
			neck="Loricate Torque +1",		--  6 DT
			waist="Flume Belt",				--			2 PDT	2 convert MP
			left_ear="Infused Earring",		--	Evasion?
			right_ear="Ethereal Earring",	--					3 convert MP
			left_ring="Vocane Ring",		--  7 DT
			right_ring="Defending Ring",	-- 10 DT
			back="Moonbeam Cape",}			--  5 DT
											--------
											-- 50 DT
			
			
    sets.defense.MDT = {}

    sets.Kiting = {legs="Carmine Cuisses +1",feet="Hippomenes socks"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- misc, currently only used to equip weapons
	sets.misc = {}
	sets.misc.weapon = {}
	sets.misc.weapon['Magic'] = {main={ name="Colada", augments={'MND+2','Mag. Acc.+25','"Mag.Atk.Bns."+23','DMG:+13',}}, sub={ name="Colada", augments={'"Refresh"+1','Mag. Acc.+23','"Mag.Atk.Bns."+23',}},}
	sets.misc.weapon['DD'] = {main="Tizona",sub="Almace",}
	sets.misc.weapon['Off'] = {}
	
	
    -- Normal melee group
	-- need to equip 11DW to cap with Magic haste cap, gear haste cap and 1 trait level set (@2100JP T3 DW, 25%)
	-- 30STP with spells
    sets.engaged = { 				--	Haste	DW	STP
		ammo="Ginsen",
		head="Adhemar Bonnet +1",
		body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
		hands={ name="Herculean Gloves", augments={'Attack+29','"Triple Atk."+3','DEX+8',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'Accuracy+24 Attack+24','"Triple Atk."+3','DEX+5','Accuracy+5',}},
		neck="Ainia Collar",
		waist="Windbuffet Belt +1",
		left_ear="Telos Earring",
		right_ear="Suppanomimi",
		left_ring="Hetairoi Ring",
		right_ring="Epona's Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10',}},}		--	   4
		
	sets.engaged.TP = { 			-- STP
		ammo="Ginsen",				--   3
		head="Adhemar Bonnet +1",		--
		neck="Ainia Collar",		--   8
		lear="Cessance Earring",	--   
		rear="Brutal Earring",		--   5
		body="Adhemar Jacket +1",		--
		hands="Herculean Gloves",	--
		lring="Petrov Ring",		--   5
		rring="Ilabrat Ring",		--   5
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10',}},		--  10
		waist="Windbuffet Belt +1",	--
		legs="Samnuha Tights",		--   7
		feet="Herculean boots"}


    sets.engaged.MidAcc = set_combine(sets.engaged,{ -- done
        neck="Sanctity Necklace",
		lear="Digni. Earring",
		hands="Aya. Manopolas +2",
		lring="Mars's Ring"})

	sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc,{ -- done
		ammo="Honed Tathlum",
		head="Carmine mask",
		lear="Cessance Earring",
		rear="Telos Earring",
		rring="Apate ring",
		back="Grounded Mantle +1",
		waist="Eschan Stone",
		legs="Carmine Cuisses +1"})
	
	sets.engaged.Blink = {}
	
    sets.engaged.Refresh = set_combine(sets.engaged, {
		body="Jhakri Robe +1",
		legs="Lengo Pants"
		})
	
	sets.engaged.DamageTaken = set_combine(sets.engaged,{ 	-- PDT	MDT	DT
		ammo="Staunch Tathlum",								--			 2
		head="Aya. Zuchetto +1",							--			 2
        neck="Loricate Torque +1",							--			 6
        lear="Colossus's Earring", 							--  1
		rear="Ethereal Earring",
        body="Emet Harness +1",								--  6
        hands="Herculean Gloves",							--  2
        lring="Vocane Ring", 								--			 7
		rring="Defending Ring",								--			10
        back="Moonbeam Cape",								--			 4
        waist="Flume Belt",									--  4
        legs="Herculean trousers",							--  2
        feet="Herculean boots"})							--  2

    sets.engaged.Learning = set_combine(sets.engaged, sets.Learning)
	
	sets.self_healing = {lring="Kunaji Ring",rring="Asklepian Ring"}
	
end