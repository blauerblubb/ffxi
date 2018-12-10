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
	send_command('bind 	 gs c cycle Shield')
	
 
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
	send_command('unbind f10')
end
 
-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
 
 
	

	sets.Twilight = {head="Twilight Helm",body="Twilight Mail"}
				
	-- TP Base Set --
	sets.engaged = {
			ammo="Ginsen",
			head="Founder's Corona",
			neck="Asperity Necklace",
			lear="Brutal Earring",
			rear="Telos Earring",
			body="Souveran cuirass +1",
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
			hands="Souveran Handschuhs +1",	--  5 DT --
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
			back="Engulfer Cape +1",
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
			head="Souveran Schaller +1", 	--  175+105
			neck="Bloodbead Gorget", 		--   60
			lear="Odnowa Earring +1", 		--  100
			rear="Etiolation Earring", 		--   50
			body="Rev. Surcoat +3", 		--  254
			hands="Regal Gauntlets",		--  205
			lring="Praan Ring", 			--   60
			rring="Meridian Ring", 			--   90
			back="Moonbeam Cape", 			--  250
			waist="Creed Baudrier", 		--   40
			legs="Souveran Diechlings",		--   57+80
			feet="Souveran Schuhs +1"} 		--  122+50
											-- 1763HP
	--1760
	
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
			body="Souveran Cuirass +1", -- 
			hands="Regal Gauntlets",
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
			hands="Regal Gauntlets",
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
		--legs="Lustratio Subligar",
		feet="Thereoid Greaves",
		})

	sets.WS['Savage Blade'] = set_combine(sets.WS,{
		head={ name="Carmine Mask", augments={'Accuracy+15','Mag. Acc.+10','"Fast Cast"+3',}},
		body="Rev. Surcoat +3",
		hands="Sulev. Gauntlets +2",
		legs="Sulev. Cuisses +2",
		feet="Rev. Leggings +3",
		})

	sets.WS.Requiescat = set_combine(sets.WS,{
		head={ name="Carmine Mask", augments={'Accuracy+15','Mag. Acc.+10','"Fast Cast"+3',}},
		body="Rev. Surcoat +3",
		hands="Sulev. Gauntlets +2",
		legs="Sulevi. Cuisses +2",
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
	sets.JA.Fealty = set_combine(sets.Enmity,{body="Cab. Surcoat +2"})
	sets.JA.Invincible = set_combine(sets.Enmity,{legs="Cab. Breeches +1"})
	sets.JA.Cover = {head="Rev. Coronet +1",body="Cab. Surcoat +2"}
	sets.JA.Palisade = set_combine(sets.Enmity)
	sets.JA.Provoke = set_combine(sets.Enmity)
	sets.JA.Warcry = set_combine(sets.Enmity)
	sets.JA.Souleater = set_combine(sets.Enmity)
	sets.JA['Last Resort'] = set_combine(sets.Enmity)
	sets.JA.Chivalry = {
			ammo="Quartz Tathlum +1",
			head="Rev. Coronet +1",
			body="Cab. Surcoat +2",
			--lring="Levia. Ring +1",
			legs="Cab. Breeches +1",}
	sets.JA.Rampart = sets.Enmity

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
			--waist="Rumination sash",
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
			--neck="Orunmila's Torque",
			--lear="Enchntr. Earring +1",
			--rear="Loquac. Earring",
			--body="Nuevo Coselete",
			--hands="Buremte Gloves",
			--lring="Prolix Ring",
			--rring="Veneficium Ring",
			--back="Repulse Mantle",
			--waist="Goading Belt",
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
			--waist="Rumination Sash",
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
			neck="Incanter's Torque",
			lear="Andoaa Earring",
			-- rear="Augment. Earring",
			--body="Shab. Cuirass +1",
			--back="Merciful Cape",
			waist="Siegel Sash",
			--legs="Rev. Breeches +1"
		})
			
	sets.Midcast.Phalanx = set_combine(sets.Midcast['Enhancing Magic'],{
			head={name="Yorium Barbuta",augments={"Accuracy+13","Dbl. Atk.+3","Phalanx+2"}}, -- 2
			body={name="Yorium cuirass",augments={"Enmity+5","Phalanx+3"}}, -- 3
			hands="Souveran Handschuhs +1", -- 5
			back="Weard Mantle", -- 3
			legs={name="Yorium Cuisses",augments={"Attack+19","Phalanx+3"}}, -- 3
			feet="Souveran Schuhs +1"}) -- 5
					-- Phalanx +21
	-- Stoneskin --
	sets.Midcast.Stoneskin =  set_combine(sets.Midcast['Enhancing Magic'],{})

	-- Reprisal --
	sets.Midcast.Reprisal = sets.engaged.HighHP
	
end
