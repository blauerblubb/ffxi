-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
 
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
 
    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('organizer-lib')
end
 
-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Sentinel = buffactive.sentinel or false
    state.Buff.Cover = buffactive.cover or false
    state.Buff.Doom = buffactive.Doom or false
end
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Regen', 'TP', 'MidAcc', 'HighAcc', 'BaseDT', 'FullDT', 'PDT', 'MDT', 'HighHP')
    state.IdleMode:options('Normal', 'Regen', 'TP', 'MidAcc', 'HighAcc', 'BaseDT', 'FullDT', 'PDT', 'MDT', 'HighHP')
	state.AutoWS = M{['description']='Auto WS', 'Requiescat', 'Chant du Cygne', 'Savage Blade', 'Knights of Round', 'Atonement'}
	state.Shield = M{['description']='Shield', 'Ochain', 'Aegis', 'Srivatsa'}

	EnmityBlueMagic = S{"Jettatura","Sheep Song","Soporific","Blank Gaze","Geist Wall"} -- BlueMagic --	
	
	target_distance = 6 -- Set Default Distance Here --

	ShieldIndex = 1
	Shield = {"Ochain","Aegis","Srivatsa"} -- Default Shield Set is Ochain --
	Twilight = 'None'
	

	send_command('bind !p gs c auto_action')
	send_command('bind ![ gs c auto_trust')
	send_command('bind !q gs c cure')
	send_command('bind @home gs c cycle AutoWS')
	send_command('bind f10 gs c cycle Shield')
	
 
    select_default_macro_book()
end

function file_unload()
    if binds_on_unload then
        binds_on_unload()
    end

	send_command('unbind !q')
	send_command('unbind !p')
	send_command('unbind ![')
	send_command('unbind @home')
end
 
-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
 
 
	

	sets.Twilight = {head="Twilight Helm",body="Twilight Mail"}
				
	-- TP Base Set --
	sets.engaged = {
			ammo="Vanir Battery",
			head="Founder's Corona",
			neck="Defiant Collar",
			lear="Brutal Earring",
			rear="Telos Earring",
			body="Souveran cuirass",
			hands="Odyssean Gauntlets", --hands="Valorous Mitts",
			lring="Petrov Ring",
			rring="Hetairoi Ring",
			back="Bleating Mantle",
			waist="Windbuffet Belt +1",
			legs="Odyssean Cuisses",
			feet="Odyssean Greaves"}
			
	sets.engaged.Regen = sets.engaged
	sets.engaged.TP = sets.engaged	
			
			
	sets.engaged.MidACC = set_combine(sets.engaged.TP,{
			head="Carmine Mask",
			rear="Cessance Earring",
			waist="Eschan Stone",
			back={ name="Rudianos's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','Accuracy+10','Enmity+10',}},
			})

			
	sets.engaged.HighACC = set_combine(sets.engaged.MidACC,{
			ammo="Amar Cluster", 
			neck="Sanctity Necklace",
			lear="Moonshade Earring",
			back="Grounded Mantle +1"})
			
	-- Ochain TP Sets --			
	--sets.TP.Ochain = set_combine(sets.TP.Base,{sub="Ochain"})			
	--sets.TP.Ochain.MidACC = set_combine(sets.TP.Base.MidACC,{sub="Ochain"})
	--sets.TP.Ochain.HighACC = set_combine(sets.TP.Base.HighACC,{sub="Ochain"})

	-- Aegis TP Sets --
	--sets.TP.Aegis = set_combine(sets.TP.Base,{sub="Aegis"})			
	--sets.TP.Aegis.MidACC = set_combine(sets.TP.Base.MidACC,{sub="Aegis"})
	--sets.TP.Aegis.HighACC = set_combine(sets.TP.Base.HighACC,{sub="Aegis"})
			
	-- Srivatsa TP Sets --
	--sets.TP.Srivatsa = set_combine(sets.TP.Base,{sub="Srivatsa"})			
	--sets.TP.Srivatsa.MidACC = set_combine(sets.TP.Base.MidACC,{sub="Srivatsa"})
	--sets.TP.Srivatsa.HighACC = set_combine(sets.TP.Base.HighACC,{sub="Srivatsa"})

	-- Ragnarok TP Sets --
	--sets.TP.Ragnarok = {}
	--sets.TP.Ragnarok.MidACC = set_combine(sets.TP.Ragnarok,{})	
	--sets.TP.Ragnarok.HighACC = set_combine(sets.TP.Ragnarok.MidACC,{})

	-- Ragnarok(Ionis) TP Sets --
	--sets.TP.Ragnarok.Ionis = set_combine(sets.TP.Ragnarok,{})
	--sets.TP.Ragnarok.MidACC.Ionis = set_combine(sets.TP.Ragnarok.Ionis,{})	
	--sets.TP.Ragnarok.HighACC.Ionis = set_combine(sets.TP.Ragnarok.MidACC.Ionis,{})

	-- PDT/MDT/DT Sets --

	sets.engaged.BaseDT = {
		ammo="Vanir Battery",
		head="Chev. Armet +1",											--  6 convert phys --  MDB 2 -- M.eva 53
		neck="Loricate Torque +1",		--  6 DT --
		lear="Thureous Earring",										--  successful block +2 --
		rear="Ethereal Earring",										--  3 convert damage -
		body="Rev. Surcoat +3",			-- 10 DT --						-- MDB 5 -- M.eva 68
		hands="Sulev. Gauntlets +2",	--  5 DT --						-- M.eva 
		lring="Vocane Ring", 			--  7 DT --
		rring="Defending Ring", 		-- 10 DT --
		back={ name="Rudianos's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','Accuracy+10','Enmity+10',}},										-- 5 convert phys, successful block +3 --
		waist="Flume Belt",								-- 4 PDT --		-- 2 convert damage
		legs="Souveran Diechlings +1",	--  4 DT --
		feet="Reverence Leggings +3"}									-- 10 convert dt --	 		
											-----------
			-- 42 DT --	-- 4 PDT -- -- 15% DT to MP -- -- 11% PDT to MP -- -- 5 Successful Block --
	
	
	sets.engaged.FullDT = {
			ammo="Staunch Tathlum",			--  2 DT --
			head="Founder's corona",		
			neck="Loricate Torque +1",		--  6 DT --
			lear="Thureous Earring",
			rear="Ethereal Earring",
			body="Rev. Surcoat +3",			-- 11 DT --
			hands="Sulev. Gauntlets +2",	--  5 DT --
			lring="Vocane Ring", 			--  7 DT --
			rring="Defending Ring", 		-- 10 DT --
			back="Moonbeam Cape",			--  5 DT --					
			waist="Nierenschutz",			--  3 DT --
			legs="Souveran Diechlings +1",	--  4 DT --
			feet="Reverence Leggings +3"}		 		
											-----------
											-- 51 DT --
	
	
	sets.engaged.MDT = set_combine(sets.FullDT,{
			head="Founder's corona", 		-- 2 MDB --					-- 4 MDT --
			neck="Warder's charm +1",  
			lear="Etiolation Earring", 									-- 3 MDT --
			--hands="Souveran Handschuhs", 	-- 1 MDB -- 				-- 4 MDT --
			waist="Creed baudrier", 							
			})
			
								-- Total -44% DT + -7% MDT = -54%/50% Reduction / +16 MDB --
								-- Primary ACC 961
	
	
	sets.engaged.PDT = set_combine(sets.FullDT,{
			head="Chev. Armet +1",										-- conv 6%
			hands="Founder's Gauntlets",				-- 5 PDT --
			waist="Flume Belt",							-- 4 PDT --		-- conv 2%
			back={ name="Rudianos's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','Accuracy+10','Enmity+10',}},		-- conv 5%
			
			})
									-- Total -41% DT/-9% PDT  = -50%/50% Reduction --
									-- Primary ACC 954 / Defense 1105 / 24% Haste-- 
	
	sets.engaged.HighHP = {
			ammo="Impatiens",
			head="Souveran Schaller", 		--  125+80
			neck="Bloodbead Gorget", 		--   60
			lear="Odnowa Earring +1", 		--  100
			rear="Etiolation Earring", 		--   50
			body="Rev. Surcoat +3", 		--  254
			hands="Cab. Gauntlets +1", 		--  104
			lring="Praan Ring", 			--   60
			rring="Meridian Ring", 			--   90
			back="Moonbeam Cape", 			--  250
			waist="Creed Baudrier", 		--   40
			legs="Souveran Diechlings",		--   57+80
			feet="Amm Greaves"}		 		--   75+50
											-- 1475HP
	
	
	sets.engaged.MDT.Ochain =  set_combine(sets.engaged.MDT,{sub="Ochain"})
	sets.engaged.MDT.Aegis = set_combine(sets.engaged.MDT,{sub="Aegis"})								
	sets.engaged.MDT.Srivatsa = set_combine(sets.engaged.MDT,{sub="Srivatsa"})
	sets.engaged.PDT.Ochain = set_combine(sets.engaged.PDT,{sub="Ochain"})
	sets.engaged.PDT.Aegis = set_combine(sets.engaged.PDT,{sub="Aegis"})
	sets.engaged.PDT.Srivatsa = set_combine(sets.engaged.PDT,{sub="Srivatsa"})
	sets.engaged.BaseDT.Ochain =  set_combine(sets.engaged.BaseDT,{sub="Ochain"})
	sets.engaged.BaseDT.Aegis = set_combine(sets.engaged.BaseDT,{sub="Aegis"})								
	sets.engaged.BaseDT.Srivatsa = set_combine(sets.engaged.BaseDT,{sub="Srivatsa"})
	sets.engaged.FullDT.Ochain =  set_combine(sets.engaged.FullDT,{sub="Ochain"})
	sets.engaged.FullDT.Aegis = set_combine(sets.engaged.FullDT,{sub="Aegis"})								
	sets.engaged.FullDT.Srivatsa = set_combine(sets.engaged.FullDT,{sub="Srivatsa"})
	sets.engaged.HighHP.Ochain =  set_combine(sets.engaged.HighHP,{sub="Ochain"})
	sets.engaged.HighHP.Aegis = set_combine(sets.engaged.HighHP,{sub="Aegis"})								
	sets.engaged.HighHP.Srivatsa = set_combine(sets.engaged.HighHP,{sub="Srivatsa"})

	sets.idle = {
			ammo="Homiliary", --
			head="Founder's corona", -- Head Wind II - Baghere Salade
			neck="Sanctity Necklace", --
			lear="Infused Earring", -- 
			rear="Ethereal Earring", --
			body="Rev. Surcoat +3", -- 
			hands="Sulevia's Gauntlets +2",
			lring="Sheltered Ring", --
			rring="Defending Ring",
			back="Archon Cape", --
			waist="Fucho-no-Obi", --
			legs="Carmine Cuisses +1", --
			feet="Odyssean greaves"} -- 
	-- Idle/Town Sets --
	sets.idle.Regen = {
			ammo="Homiliary", --
			head="Founder's corona", -- Head Wind II - Baghere Salade
			neck="Sanctity Necklace", --
			lear="Infused Earring", -- 
			rear="Ethereal Earring", --
			body="Rev. Surcoat +3", -- 
			hands="Sulevia's Gauntlets +2",
			lring="Sheltered Ring", --
			rring="Defending Ring",
			back="Archon Cape", --
			waist="Fucho-no-Obi", --
			legs="Carmine Cuisses +1", --
			feet="Odyssean greaves"} -- 
	
	sets.idle.TP = sets.idle
	sets.idle.MidACC = sets.idle		
	sets.idle.HighACC = sets.idle
	sets.idle.MDT = sets.engaged.MDT
	sets.idle.PDT = sets.engaged.PDT
	sets.idle.BaseDT = sets.engaged.BaseDT
	sets.idle.FullDT = sets.engaged.FullDT
	sets.idle.HighHP = sets.engaged.HighHP
			
	
	
	-- Weakness/Kiting/Repulse Sets --
	sets.Weakness = {}
	sets.Weakness.Ochain = set_combine(sets.engaged.FullDT.Ochain,{})
	sets.Weakness.Aegis = set_combine(sets.engaged.FullDT.Aegis,{})
	sets.Weakness.Srivatsa = set_combine(sets.engaged.FullDT.Srivatsa,{})

	sets.Kiting = {legs="Carmine Cuisses +1"}
	sets.Kiting.Ochain = set_combine(sets.engaged.FullDT.Ochain,{legs="Carmine Cuisses +1"})
	sets.Kiting.Aegis = set_combine(sets.engaged.FullDT.Aegis,{legs="Carmine Cuisses +1"})
	sets.Kiting.Srivatsa = set_combine(sets.engaged.FullDT.Srivatsa,{legs="Carmine Cuisses +1"})

	sets.Repulse = {}
	sets.Repulse.Base = {
			rring="Vocane Ring",
			back="Philidor Mantle"}
	sets.Repulse.Ochain = set_combine(sets.Repulse.Base,{sub="Ochain"})
	sets.Repulse.Aegis = set_combine(sets.Repulse.Base,{sub="Aegis"})
	sets.Repulse.Srivatsa = set_combine(sets.Repulse.Base,{sub="Srivatsa"})

	-- Hybrid/Shield Skill Sets --
	--sets.TP.Hybrid = {}
	--sets.TP.Hybrid.MidACC = set_combine(sets.TP.Hybrid,{})
	--sets.TP.Hybrid.HighACC = set_combine(sets.TP.Hybrid.MidACC,{})

	--sets.TP.ShieldSkill = {}

	-- WS Base Set --
	sets.WS = {
		ammo="Jukukik Feather",
		--head="Sukeroku hachimaki",				
		neck="Fotia Gorget",			--10%
		lear="Ishvara Earring",			-- 2%
		rear="Moonshade Earring",
		--body="Sulevia's Plate. +1",
		hands="Odyssean Gauntlets",		-- 2%
		lring="Petrov Ring",
		rring="Apate Ring",
		back="Grounded Mantle +1",
		waist="Fotia Belt",				--10%
		legs="Odyssean Cuisses", 		-- 3%
		feet="Sulev. leggings +2"} 		-- 6%

	-- WS Sets --
	sets.WS['Chant du Cygne'] = set_combine(sets.WS,{
		ammo="Vanir Battery",
		head={ name="Carmine Mask", augments={'Accuracy+15','Mag. Acc.+10','"Fast Cast"+3',}},
		body="Rev. Surcoat +3",
		hands="Sulev. Gauntlets +2",
		back="Ground. Mantle +1",
		legs="Lustratio Subligar",
		feet="Thereoid Greaves",
		})

	sets.WS['Savage Blade'] = set_combine(sets.WS,{
		head={ name="Carmine Mask", augments={'Accuracy+15','Mag. Acc.+10','"Fast Cast"+3',}},
		body="Rev. Surcoat +3",
		hands="Sulev. Gauntlets +2",
		legs="Sulevi. Cuisses +1",
		feet="Rev. Leggings +3",
		})

	sets.WS.Requiescat = set_combine(sets.WS,{
		head={ name="Carmine Mask", augments={'Accuracy+15','Mag. Acc.+10','"Fast Cast"+3',}},
		body="Rev. Surcoat +3",
		hands="Sulev. Gauntlets +2",
		legs="Sulevi. Cuisses +1",
		feet="Rev. Leggings +3",
		})

	sets.WS.Resolution = set_combine(sets.WS,{})

	sets.WS.Atonement = set_combine(sets.WS,{})

	sets.WS['Knights of Round'] = set_combine(sets.WS,{})

	sets.WS['Sanguine Blade'] = {
		ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",
		neck="Sanctity Necklace",
		lear="Friomisi Earring",
		rear="Hecate's Earring",
		body="Rev. Surcoat +3",
		hands="Leyline Gloves",
		lring="Petrov Ring",
		lring="Acumen Ring",
		waist="Eschan Stone",
		legs="Carmine Cuisses +1",
		feet="Hippomenes Socks"}

	sets.WS['Aeolian Edge'] = {}

	sets.Enmity = { -- +18 from Burtgang iLvl 119 --
			-- ammo="Iron Gobbet", 
			head="Loess Barbuta +1", -- +9~14 --
			neck="Unmoving Collar +1", -- +10 --
			lear="Friomisi Earring", -- 2 --
			rear="Cryptic Earring", -- 4 --
			body="Souveran Cuirass", -- 14 --
			hands="Macabre Gaunt. +1", -- 7 --
			lring="Apeile Ring", -- 5~9 --
			rring="Apeile Ring +1", -- 5~9 --
			back={ name="Rudianos's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','Accuracy+10','Enmity+10',}}, -- 10 --
			waist="Creed Baudrier", -- 5 --
			legs={ name="Souveran Diechlings", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}}, -- 7 --
			feet="Chev. Sabatons +1"} -- 11 --
									-- Total Enmity+ = 107~120 --

	-- JA Sets --
	sets.JA = {}
	sets.JA['Shield Bash'] = set_combine(sets.Enmity,{hands="Cab. Gauntlets +1"})
	sets.JA.Sentinel = set_combine(sets.Enmity,{feet="Cab. Leggings +1"})
	sets.JA['Holy Circle'] = set_combine(sets.Enmity,{feet="Rev. Leggings +3"})
	sets.JA['Divine Emblem'] = set_combine(sets.Enmity,{feet="Chev. Sabatons +1"})
	sets.JA.Fealty = set_combine(sets.Enmity,{body="Cab. Surcoat +1"})
	sets.JA.Invincible = set_combine(sets.Enmity,{legs="Cab. Breeches +1"})
	sets.JA.Cover = {head="Rev. Coronet +1",body="Cab. Surcoat +1"}
	sets.JA.Palisade = set_combine(sets.Enmity)
	sets.JA.Provoke = set_combine(sets.Enmity)
	sets.JA.Warcry = set_combine(sets.Enmity)
	sets.JA.Souleater = set_combine(sets.Enmity)
	sets.JA['Last Resort'] = set_combine(sets.Enmity)
	sets.JA.Chivalry = {
			ammo="Quartz Tathlum +1",
			head="Rev. Coronet +1",
			body="Cab. Surcoat +1",
			lring="Levia. Ring +1",
			legs="Cab. Breeches +1",
			feet="Whirlpool Greaves"}
	sets.JA.Rampart = set_combine(sets.Enmity,{head="Cab. Coronet +1"})

	-- Sublimation --
	sets.Sublimation = {}

	-- Flourish --
	sets.Flourish = set_combine(sets.Enmity)

	-- Step --
	sets.Step = set_combine(sets.Enmity)

	-- Waltz --
	sets.Waltz = {}

	sets.Precast = {}
	--Fastcast Set --
	sets.Precast.FastCast = {
			ammo="Impatiens", 																	-- 2% q
			head="Carmine Mask", 												-- 12% fc
			neck="Voltsurge Torque", 											--  4% fc
			lear="Etiolation Earring", 											--  1% fc
			rear="Loquac. Earring", 											--  2% fc
			body="Rev. Surcoat +3", 											-- 10% fc
			hands="Leyline Gloves", 											--  8% fc
			lring="Prolix Ring", 												--  2% fc
			rring="Kishar Ring", 												--  4% fc
			back={ name="Rudianos's Mantle", augments={'"Fast Cast"+10',}},		-- 10% fc
			waist="Rumination sash",
			-- legs="Enif Cosciales",
			feet="Odyssean Greaves"} 											--  5% fc
			-- 58% fc / 3% q
			
	-- Precast Enhancing Magic --
	sets.Precast['Enhancing Magic'] = set_combine(sets.Precast.FastCast,{waist="Siegel Sash"})

	-- Cure Precast Set --
	sets.Precast.Cure = set_combine(sets.Precast.FastCast,{rear="Nourish. Earring +1", neck="Diemer Gorget"})

	-- Midcast Base Set --
	sets.Midcast = {}

	-- Spells Recast --
	sets.Midcast.Recast = set_combine(sets.Precast.FastCast,{
			ammo="Impatiens",
			head="Chev. Armet +1",
			neck="Orunmila's Torque",
			lear="Enchntr. Earring +1",
			rear="Loquac. Earring",
			body="Nuevo Coselete",
			--hands="Buremte Gloves",
			lring="Prolix Ring",
			rring="Veneficium Ring",
			back="Repulse Mantle",
			waist="Goading Belt",
			--legs="Founder's hose",
			feet="Chev. Sabatons +1"})

	-- Divine Magic --
	sets.Midcast['Divine Magic'] = set_combine(sets.Midcast.Recast,{
			--head="Jumalik Helm", 			-- 32 MAB
			lear="Elemental Earring",		--  3 Skill
			rear="Friomisi Earring",		-- 10 MAB
			--body="Found. Breastplate",		-- 34 MAB
			hands="Founder's Gauntlets",	-- 35 MAB
			--waist="Asklepian Belt",			-- 10 Skill
			--feet="Founder's Greaves"
			})		-- 33 MAB
											--167
	-- Cure Set -- caps at 47%/50%
	sets.Midcast.Cure = {
			ammo="Impatiens",
			head="Souveran Schaller",
			neck="Sanctity Necklace",
			lear="Mendi. Earring",			-- 05
			rear="Nourishing Earring +1",	-- 06
			body="Jumalik mail",			-- 15
			hands="Macabre Gaunt. +1",		-- 11
			lring="Vocane Ring",			
			--rring="Eihwaz Ring",
			back="Moonbeam Cape",			-- 04
			waist="Rumination Sash",
			legs="Carmine Cuisses +1",
			feet="Odyssean Greaves"}		-- 07

	-- Self Cure Set -- caps at 30%
	sets.Midcast.SelfCure = set_combine(sets.Midcast.Cure,{
			head="Souveran Schaller",		-- 10
			waist="Gishdubar sash",			-- 10
			    legs={ name="Souveran Diechlings", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},})	-- 17

	-- Flash Set --
	sets.Midcast.Flash = set_combine(sets.Enmity,{})

	-- Enhancing Magic --
	sets.Midcast['Enhancing Magic'] = set_combine(sets.Midcast.Recast,{
			ammo="Impatiens",
			neck="Colossus's Torque",
			lear="Andoaa Earring",
			-- rear="Augment. Earring",
			body="Shab. Cuirass +1",
			back="Merciful Cape",
			waist="Siegel Sash",
			legs="Rev. Breeches +1"})
			
	sets.Midcast.Phalanx = set_combine(sets.Midcast['Enhancing Magic'],{
			head={name="Yorium Barbuta",augments={"Accuracy+13","Dbl. Atk.+3","Phalanx+2"}}, -- 2
			body={name="Yorium cuirass",augments={"Enmity+5","Phalanx+3"}}, -- 3
			hands="Souv. Handschuhs", -- 4
			back="Weard Mantle", -- 3
			legs={name="Yorium Cuisses",augments={"Attack+19","Phalanx+3"}}, -- 3
			feet="Souveran Schuhs"}) -- 4
					-- Phalanx +19
	-- Stoneskin --
	sets.Midcast.Stoneskin =  set_combine(sets.Midcast['Enhancing Magic'],{})

	-- Reprisal --
	sets.Midcast.Reprisal = sets.engaged.HighHP
	
end
  
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

 

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_precast(spell, action, spellMap, eventArgs)
	if spell.type == "WeaponSkill" then
		if player.status ~= 'Engaged' then -- Cancel WS If You Are Not Engaged. Can Delete It If You Don't Need It --
			cancel_spell()
			add_to_chat(123,'Unable To Use WeaponSkill: [Disengaged]')
			return
		else
			equipSet = sets.WS
			if equipSet[spell.english] then
				equipSet = equipSet[spell.english]
			end
			if player.tp > 2999 then
				if spell.english == "Resolution" then -- Equip Kokou's Earring When You Have 3000 TP --
					equipSet = set_combine(equipSet,{lear="Kokou's Earring"})
				elseif spell.english == "Chant du Cygne" then -- Equip Jupiter's Pearl When You Have 3000 TP --
					equipSet = set_combine(equipSet,{lear="Jupiter's Pearl"})
				end
			end
			equip(equipSet)
		end
	elseif spell.type == "JobAbility" then
		if sets.JA[spell.english] then
			equip(sets.JA[spell.english])
		end
	elseif spell.type == "Rune" then
		equip(sets.Enmity)
	elseif spell.type:endswith('Magic') or spell.type == "Ninjutsu" then
		if buffactive.silence or spell.target.distance > 16+target_distance then -- Cancel Magic or Ninjutsu If You Are Silenced or Out of Range --
			cancel_spell()
			add_to_chat(123, spell.name..' Canceled: [Silenced or Out of Casting Range]')
			return
		else
			if string.find(spell.english,'Cur') and spell.english ~= "Cursna" then
				equip(sets.Precast.Cure)
			elseif spell.english == "Reprisal" then
				if buffactive['Blaze Spikes'] or buffactive['Ice Spikes'] or buffactive['Shock Spikes'] then -- Cancel Blaze Spikes, Ice Spikes or Shock Spikes When You Cast Reprisal --
					cast_delay(0.2)
					send_command('cancel Blaze Spikes,Ice Spikes,Shock Spikes')
				end
				equip(sets.Precast.FastCast)
			elseif string.find(spell.english,'Utsusemi') then
				if buffactive['Copy Image (3)'] or buffactive['Copy Image (4)'] then
					cancel_spell()
					add_to_chat(123, spell.name .. ' Canceled: [3+ Images]')
					return
				else
					equip(sets.Precast.FastCast)
				end
			elseif sets.Precast[spell.skill] then
				equip(sets.Precast[spell.skill])
			else
				equip(sets.Precast.FastCast)
			end
		end
	elseif string.find(spell.type,'Flourish') then
		if spell.english == "Animated Flourish" then
			equip(sets.Enmity)
		else
			equip(sets.Flourish)
		end
	elseif spell.type == "Step" then
		equip(sets.Step)
	elseif spell.type == "Waltz" then
		refine_waltz(spell,action)
		equip(sets.Waltz)
	elseif spell.english == 'Spectral Jig' and buffactive.Sneak then
		cast_delay(0.2)
		send_command('cancel Sneak')
	end
end


function job_midcast(spell, action, spellMap, eventArgs)
equipSet = {}
	if spell.type:endswith('Magic') or spell.type == 'Ninjutsu' then
		equipSet = sets.Midcast.Recast
		if equipSet[spell.english] then
			equipSet = equipSet[spell.english]
		elseif (string.find(spell.english,'Cur') or spell.english == "Wild Carrot" or spell.english == "Healing Breeze") and spell.english ~= "Cursna" then
			if spell.target.name == player.name then
				equipSet = equipSet.SelfCure
			else
				equipSet = equipSet.Cure
			end
		elseif string.find(spell.english,'Protect') or string.find(spell.english,'Shell') then
			if spell.target.name == player.name then
				equipSet = set_combine(equipSet,{rring="Sheltered Ring"})
			end
		elseif spell.english == "Phalanx" then
			equipSet = sets.Midcast.Phalanx
		elseif spell.english == "Stoneskin" then
			if buffactive.Stoneskin then
				send_command('@wait 1.7;cancel stoneskin')
			end
			equipSet = equipSet.Stoneskin
		elseif spell.english == "Sneak" then
			if spell.target.name == player.name and buffactive['Sneak'] then
				send_command('cancel sneak')
			end
			equipSet = equipSet.Recast
		elseif string.find(spell.english,'Banish') then
			equipSet = set_combine(equipSet,{lring=""})
		elseif EnmityBlueMagic:contains(spell.english) or spell.english == "Stun" or string.find(spell.english,'Absorb') or spell.english == 'Aspir' or spell.english == 'Drain' then
			if buffactive.Sentinel then
				equipSet = equipSet.Recast
			else
				equipSet = equipSet.Flash
			end
		elseif string.find(spell.english,'Spikes') then
			equipSet = equipSet.Recast
		elseif string.find(spell.english,'Utsusemi') then
			if spell.english == 'Utsusemi: Ichi' and (buffactive['Copy Image'] or buffactive['Copy Image (2)']) then
				send_command('@wait 1.7;cancel Copy Image*')
			end
			equipSet = equipSet.Recast
		elseif spell.english == 'Monomi: Ichi' then
			if buffactive['Sneak'] then
				send_command('@wait 1.7;cancel sneak')
			end
			equipSet = equipSet.Recast
		elseif equipSet[spell.skill] then
			equipSet = equipSet[spell.skill]
		end
	elseif equipSet[spell.english] then
		equipSet = equipSet[spell.english]
	end
	equip(equipSet)
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureSelf)
	end
end

 function job_aftercast(spell, action, spellMap, eventArgs)
     
end
 
function job_get_spell_map(spell, default_spell_map)
    if spellMap == 'Cure' and spell.target.type == 'SELF' then
            equip(sets.midcast.CureSelf)
    end
end
  
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
  
-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        state.IdleMode = state.OffenseMode
    end
	if stateField == 'Shield' then
        equip({sub=newValue})
    end
end
  
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

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

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
      
    return idleSet
end
  
-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end
  
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
--Refine Nuke Spells
function refine_various_spells(spell, action, spellMap, eventArgs)
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
					newSpell = 'Cure III'
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
			if player.tp > 1001 and player.target.distance < 8 then -- and player.target.hpp <60 then
				if not check_buffs(272) then
					if player.tp > 2999 then
						send_command('@input /ws "Atonement" <t>')
					end
				else
					send_command('@input /ws "'..state.AutoWS.value..'" <t>')
				end
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
			
			elseif not check_buffs('Defense Boost')
				and player.sub_job == 'BLU'
				and check_recasts(s('Cocoon')) then
				send_command('@input /ma "Cocoon" <me>')
			
			elseif not check_buffs('Haste')
				and player.sub_job == 'BLU'
				and not check_buffs('silence')
				and check_recasts(s('Refueling')) then
				send_command('@input /ma "Refueling" <me>')
			
			elseif not check_buffs(289)
					and check_recasts(s('Crusade')) then
				send_command('@input /ma "Crusade" <me>')

			elseif not check_buffs('Enlight') 
					and check_recasts(s('Enlight')) then
				send_command('@input /ma "Enlight" <me>')

			elseif not check_buffs('Phalanx') 
					and check_recasts(s('Phalanx')) then
				send_command('@input /ma "Phalanx" <me>')
				
			elseif not check_buffs('Protect')
					and check_recasts(s('Protect V')) then
				send_command('@input /ma "Protect V" <me>')
		
			elseif not check_buffs('Shell')
					and check_recasts(s('Shell IV')) then
				send_command('@input /ma "Shell IV" <me>')
			
			elseif player.sub_job == 'NIN'
					and not check_buffs(445)
					and not check_buffs(444) then
						if check_recasts(s('Utsusemi: Ni')) then
							send_command('@input /ma "Utsusemi: Ni" <me>')
						elseif check_recasts(s('Utsusemi: Ichi')) then
							send_command('@input /ma "Utsusemi: Ni" <me>')
						end
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
			
			--if spell_recasts[1003] == 0 and not have_trust("Cornelia") then
			--	windower.send_command('input /ma "Cornelia" <me>')
			--	tickdelay = 250
			--	return true
			if spell_recasts[955] == 0 and not have_trust("Apururu") then
				windower.send_command('input /ma "Apururu (UC)" <me>')
				tickdelay = 250
				return true
			elseif spell_recasts[967] == 0 and not have_trust("Qultada") then
				windower.send_command('input /ma "Qultada" <me>')
				tickdelay = 250
				return true
			elseif spell_recasts[911] == 0 and not have_trust("Joachim") then
				windower.send_command('input /ma "Joachim" <me>')
				tickdelay = 250
				return true
			elseif spell_recasts[979] == 0 and not have_trust("Selh'teus") then
				windower.send_command('input /ma "Selh\'teus" <me>')
				tickdelay = 250
				return true
			elseif spell_recasts[1017] == 0 and not have_trust("Arciela") then
				windower.send_command('input /ma "Arciela II" <me>')
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
	set_macro_page(4, 10)
end



