-- Last Updated: 11/06/2015 --

function get_sets()
	include('organizer-lib')
	AccIndex = 1
	AccArray = {"LowACC","MidACC","HighACC"} -- Default ACC Set is Low --
	ShieldIndex = 1
	ShieldArray = {"Ochain","Aegis","Priwen"} -- Default Shield Set is Ochain --
	IdleIndex = 4
	IdleArray = {"Movement","Regen","Refresh","Hybrid"} -- Default Idle Set Is Hybrid --
	Armor = 'None'
	DefenseIndex = 1
	DefenseArray = {"None","BaseDT","FullDT","PDT","MDT"}
	Twilight = 'None'
	Repulse = 'OFF' -- Set Default Repulse ON or OFF Here --
	Capa = 'OFF' -- Set Default Capacity Points+ Mantle ON or OFF Here --
	target_distance = 6 -- Set Default Distance Here --
	select_default_macro_book() -- Change Default Macro Book At The End --

	Cure_Spells = {"Cure","Cure II","Cure III","Cure IV"} -- Cure Degradation --
	sc_map = {SC1="Flash", SC2="UtsusemiNi", SC3="UtsusemiIchi"} -- 3 Additional Binds. Can Change Whatever JA/WS/Spells You Like Here. Remember Not To Use Spaces. --
	EnmityBlueMagic = S{"Jettatura","Sheep Song","Soporific","Blank Gaze","Geist Wall"} -- BlueMagic --
	
	Cities = S{
                        "Ru'Lude Gardens","Upper Jeuno","Lower Jeuno","Port Jeuno",
                        "Port Windurst","Windurst Waters","Windurst Woods","Windurst Walls","Heavens Tower",
                        "Port San d'Oria","Northern San d'Oria","Southern San d'Oria",
                        "Port Bastok","Bastok Markets","Bastok Mines","Metalworks",
                        "Aht Urhgan Whitegate","Nashmau","Tavanazian Safehold",
                        "Selbina","Mhaura","Norg","Eastern Adoulin","Western Adoulin","Kazham","Tavnazia"}
						
	
	
	sets.Idle = {}
	-- Idle/Town Sets --
	sets.Idle.Regen = {
			ammo="Homiliary", --
			head="Founder's corona", -- Head Wind II - Baghere Salade
			neck="Sanctity Necklace", --
			ear1="Infused Earring", -- 
			ear2="Ethereal Earring", --
			body="Ares' Cuirass +1", -- 
			hands="Sulevia's Gauntlets",
			ring1="Sheltered Ring", --
			ring2="Defending Ring",
			back="Archon Cape", --
			waist="Fucho-no-Obi", --
			legs="Carmine Cuisses", --
			feet="Odyssean greaves"} -- 


	sets.Twilight = {head="Twilight Helm",body="Twilight Mail"}
				
	-- TP Base Set --
	sets.TP = {}

	sets.TP.Base = {
			ammo="Vanir Battery",
			head="Founder's Corona",
			neck="Defiant Collar",
			ear1="Brutal Earring",
			ear2="Ethereal Earring",
			body="Souveran cuirass",
			hands="Odyssean Gauntlets", --hands="Valorous Mitts",
			ring1="Petrov Ring",
			ring2="Hetairoi Ring",
			back="Bleating Mantle",
			waist="Windbuffet Belt +1",
			legs="Odyssean Cuisses",
			feet="Odyssean Greaves"}	
	
	sets.TP.Base.MidACC = set_combine(sets.TP.Base,{
			head="Carmine Mask",
			ear2="Cessance Earring",
			waist="Eschan Stone",
			back="Agema Cape"})
			
	sets.TP.Base.HighACC = set_combine(sets.TP.Base.MidACC,{
			ammo="Hasty Pinion +1", 
			neck="Sanctity Necklace",
			ear1="Moonshade Earring",
			back="Grounded Mantle +1"})
			
	-- Ochain TP Sets --			
	sets.TP.Ochain = set_combine(sets.TP.Base,{sub="Ochain"})			
	sets.TP.Ochain.MidACC = set_combine(sets.TP.Base.MidACC,{sub="Ochain"})
	sets.TP.Ochain.HighACC = set_combine(sets.TP.Base.HighACC,{sub="Ochain"})

	-- Aegis TP Sets --
	sets.TP.Aegis = set_combine(sets.TP.Base,{sub="Aegis"})			
	sets.TP.Aegis.MidACC = set_combine(sets.TP.Base.MidACC,{sub="Aegis"})
	sets.TP.Aegis.HighACC = set_combine(sets.TP.Base.HighACC,{sub="Aegis"})
			
	-- Priwen TP Sets --
	sets.TP.Priwen = set_combine(sets.TP.Base,{sub="Priwen"})			
	sets.TP.Priwen.MidACC = set_combine(sets.TP.Base.MidACC,{sub="Priwen"})
	sets.TP.Priwen.HighACC = set_combine(sets.TP.Base.HighACC,{sub="Priwen"})

	-- Ragnarok TP Sets --
	sets.TP.Ragnarok = {}
	sets.TP.Ragnarok.MidACC = set_combine(sets.TP.Ragnarok,{})	
	sets.TP.Ragnarok.HighACC = set_combine(sets.TP.Ragnarok.MidACC,{})

	-- Ragnarok(Ionis) TP Sets --
	sets.TP.Ragnarok.Ionis = set_combine(sets.TP.Ragnarok,{})
	sets.TP.Ragnarok.MidACC.Ionis = set_combine(sets.TP.Ragnarok.Ionis,{})	
	sets.TP.Ragnarok.HighACC.Ionis = set_combine(sets.TP.Ragnarok.MidACC.Ionis,{})

	-- PDT/MDT/DT Sets --

	sets.BaseDT = {}
	sets.BaseDT.Base = {
		ammo="Vanir Battery",
		head="Chev. Armet +1",											--  6 convert phys --  MDB 2 -- M.eva 53
		neck="Loricate Torque +1",		--  6 DT --
		ear1="Thureous Earring",										--  successful block +2 --
		ear2="Ethereal Earring",										--  3 convert damage -
		body="Rev. Surcoat +3",			-- 10 DT --						-- MDB 5 -- M.eva 68
		hands="Sulev. Gauntlets +1",	--  4 DT --						-- M.eva 
		ring1="Vocane Ring", 			--  7 DT --
		ring2="Defending Ring", 		-- 10 DT --
		back="Rudianos's Mantle",										-- 5 convert phys, successful block +3 --
		waist="Flume Belt",								-- 4 PDT --		-- 2 convert damage
		legs="Souveran Diechlings +1",	--  4 DT --
		feet="Reverence Leggings +3"}									-- 10 convert dt --	 		
											-----------
			-- 41 DT --	-- 4 PDT -- -- 15% DT to MP -- -- 11% PDT to MP -- -- 5 Successful Block --
	
	
	sets.FullDT = {}
	sets.FullDT.Base = {
			ammo="Staunch Tathlum",			--  2 DT --
			head="Founder's corona",		
			neck="Loricate Torque +1",		--  6 DT --
			ear1="Thureous Earring",
			ear2="Ethereal Earring",
			body="Rev. Surcoat +3",			-- 11 DT --
			hands="Sulev. Gauntlets +1",	--  4 DT --
			ring1="Vocane Ring", 			--  7 DT --
			ring2="Defending Ring", 		-- 10 DT --
			back="Philidor Mantle",			--  5 DT --					
			waist="Nierenschutz",			--  3 DT --
			legs="Souveran Diechlings +1",	--  4 DT --
			feet="Reverence Leggings +3"}		 		
											-----------
											-- 50 DT --
	
	
	sets.MDT = {}
	sets.MDT.Base = set_combine(sets.FullDT.Base,{
			head="Founder's corona", 		-- 2 MDB --					-- 4 MDT --
			neck="Warder's charm +1",  
			ear1="Etiolation Earring", 									-- 3 MDT --
			hands="Souveran Handschuhs", 	-- 1 MDB -- 				-- 4 MDT --
			back="Engulfer cape +1", 									-- 4 MDT --
			waist="Windbuffet belt +1", 							
			})
			
								-- Total -39% DT + -15% MDT = -54%/50% Reduction / +16 MDB --
								-- Primary ACC 961
	
	
	sets.PDT = {}
	sets.PDT.Base = set_combine(sets.FullDT.Base,{
			head="Chev. Armet +1",										-- conv 6%
			hands="Founder's Gauntlets",				-- 5 PDT --
			waist="Flume Belt",							-- 4 PDT --		-- conv 2%
			back="Rudianos's Mantle",									-- conv 5%
			
			})
									-- Total -41% DT/-9% PDT  = -50%/50% Reduction --
									-- Primary ACC 954 / Defense 1105 / 24% Haste-- 
	
	
	
	sets.MDT.Ochain =  set_combine(sets.MDT.Base,{sub="Ochain"})
	sets.MDT.Aegis = set_combine(sets.MDT.Base,{sub="Aegis"})								
	sets.MDT.Priwen = set_combine(sets.MDT.Base,{sub="Priwen"})
	sets.PDT.Ochain = set_combine(sets.PDT.Base,{sub="Ochain"})
	sets.PDT.Aegis = set_combine(sets.PDT.Base,{sub="Aegis"})
	sets.PDT.Priwen = set_combine(sets.PDT.Base,{sub="Priwen"})
	sets.BaseDT.Ochain =  set_combine(sets.BaseDT.Base,{sub="Ochain"})
	sets.BaseDT.Aegis = set_combine(sets.BaseDT.Base,{sub="Aegis"})								
	sets.BaseDT.Priwen = set_combine(sets.BaseDT.Base,{sub="Priwen"})
	sets.FullDT.Ochain =  set_combine(sets.FullDT.Base,{sub="Ochain"})
	sets.FullDT.Aegis = set_combine(sets.FullDT.Base,{sub="Aegis"})								
	sets.FullDT.Priwen = set_combine(sets.FullDT.Base,{sub="Priwen"})

	-- Weakness/Kiting/Repulse Sets --
	sets.Weakness = {}
	sets.Weakness.Ochain = set_combine(sets.PDT.Ochain,{})
	sets.Weakness.Aegis = set_combine(sets.PDT.Aegis,{})
	sets.Weakness.Priwen = set_combine(sets.PDT.Priwen,{})

	sets.Kiting = {}
	sets.Kiting.Ochain = set_combine(sets.PDT.Ochain,{legs="Carmine Cuisses"})
	sets.Kiting.Aegis = set_combine(sets.PDT.Aegis,{legs="Carmine Cuisses"})
	sets.Kiting.Priwen = set_combine(sets.PDT.Priwen,{legs="Carmine Cuisses"})

	sets.Repulse = {}
	sets.Repulse.Base = {
			ring2="Vocane Ring",
			back="Philidor Mantle"}
	sets.Repulse.Ochain = set_combine(sets.Repulse.Base,{sub="Ochain"})
	sets.Repulse.Aegis = set_combine(sets.Repulse.Base,{sub="Aegis"})
	sets.Repulse.Priwen = set_combine(sets.Repulse.Base,{sub="Priwen"})

	-- Hybrid/Shield Skill Sets --
	sets.TP.Hybrid = {}
	sets.TP.Hybrid.MidACC = set_combine(sets.TP.Hybrid,{})
	sets.TP.Hybrid.HighACC = set_combine(sets.TP.Hybrid.MidACC,{})

	sets.TP.ShieldSkill = {}

	-- WS Base Set --
	sets.WS = {
			ammo="Jukukik Feather",
			head="Sukeroku hachimaki",				
			neck="Fotia Gorget",			--10%
			ear1="Ishvara Earring",			-- 2%
			ear2="Brutal Earring",
			body="Sulevia's Plate. +1",
			hands="Odyssean Gauntlets",		-- 2%
			ring1="Mars's Ring",
			ring2="Apate ring",
			back="Grounded Mantle +1",
			waist="Fotia Belt",				--10%
			legs="Odyssean Cuisses", 		-- 3%
			feet="Sulev. leggings +1"} 		-- 6%

	-- WS Sets --
	sets.WS["Chant du Cygne"] = set_combine(sets.WS,{})

	sets.WS["Savage Blade"] = set_combine(sets.WS,{})

	sets.WS.Requiescat = set_combine(sets.WS,{})

	sets.WS.Resolution = set_combine(sets.WS,{})

	sets.WS.Atonement = set_combine(sets.WS,{})

	sets.WS["Knights of Round"] = set_combine(sets.WS,{})

	sets.WS["Sanguine Blade"] = {}

	sets.WS["Aeolian Edge"] = {}

	sets.Enmity = { -- +18 from Burtgang iLvl 119 --
			-- ammo="Iron Gobbet", 
			head="Loess Barbuta +1", -- +9~14 --
			neck="Unmoving Collar +1", -- +10 --
			ear1="Friomisi Earring", -- 2 --
			ear2="Cryptic Earring", -- 4 --
			body="Souveran Cuirass", -- 14 --
			hands="Macabre Gaunt. +1", -- 7 --
			ring1="Apeile Ring", -- 5~9 --
			ring2="Apeile Ring +1", -- 5~9 --
			back={ name="Rudianos's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','Accuracy+10','Enmity+10',}}, -- 10 --
			waist="Creed Baudrier", -- 5 --
			legs={ name="Souveran Diechlings", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}}, -- 7 --
			feet="Chev. Sabatons +1"} -- 11 --
									-- Total Enmity+ = 107~120 --

	-- JA Sets --
	sets.JA = {}
	sets.JA["Shield Bash"] = set_combine(sets.Enmity,{hands="Cab. Gauntlets +1"})
	sets.JA.Sentinel = set_combine(sets.Enmity,{feet="Cab. Leggings +1"})
	sets.JA["Holy Circle"] = set_combine(sets.Enmity,{feet="Rev. Leggings +1"})
	sets.JA["Divine Emblem"] = set_combine(sets.Enmity,{feet="Chev. Sabatons +1"})
	sets.JA.Fealty = set_combine(sets.Enmity,{body="Cab. Surcoat +1"})
	sets.JA.Invincible = set_combine(sets.Enmity,{legs="Cab. Breeches +1"})
	sets.JA.Cover = {head="Rev. Coronet +1",body="Cab. Surcoat +1"}
	sets.JA.Palisade = set_combine(sets.Enmity)
	sets.JA.Provoke = set_combine(sets.Enmity)
	sets.JA.Warcry = set_combine(sets.Enmity)
	sets.JA.Souleater = set_combine(sets.Enmity)
	sets.JA["Last Resort"] = set_combine(sets.Enmity)
	sets.JA.Chivalry = {
			ammo="Quartz Tathlum +1",
			head="Rev. Coronet +1",
			body="Cab. Surcoat +1",
			ring1="Levia. Ring +1",
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
			ear1="Etiolation Earring", 											--  1% fc
			ear2="Loquac. Earring", 											--  2% fc
			body="Rev. Surcoat +3", 											-- 10% fc
			hands="Leyline Gloves", 											--  7% fc
			ring1="Prolix Ring", 												--  2% fc
			ring2="Kishar Ring", 												--  4% fc
			back={ name="Rudianos's Mantle", augments={'"Fast Cast"+10',}},		-- 10% fc
			waist="Rumination sash",
			-- legs="Enif Cosciales",
			feet="Odyssean Greaves"} 											--  5% fc
			-- 57% fc / 3% q
			
	-- Precast Enhancing Magic --
	sets.Precast['Enhancing Magic'] = set_combine(sets.Precast.FastCast,{waist="Siegel Sash"})

	-- Cure Precast Set --
	sets.Precast.Cure = set_combine(sets.Precast.FastCast,{ear2="Nourish. Earring +1", neck="Diemer Gorget"})

	-- Midcast Base Set --
	sets.Midcast = {}

	-- Spells Recast --
	sets.Midcast.Recast = {
			ammo="Impatiens",
			head="Chev. Armet +1",
			neck="Orunmila's Torque",
			ear1="Enchntr. Earring +1",
			ear2="Loquac. Earring",
			body="Nuevo Coselete",
			hands="Buremte Gloves",
			ring1="Prolix Ring",
			ring2="Veneficium Ring",
			back="Repulse Mantle",
			waist="Goading Belt",
			legs="Founder's hose",
			feet="Chev. Sabatons +1"}

	-- Divine Magic --
	sets.Midcast['Divine Magic'] = set_combine(sets.Midcast.Recast,{
			head="Jumalik Helm", 			-- 32 MAB
			ear1="Elemental Earring",		--  3 Skill
			ear2="Friomisi Earring",		-- 10 MAB
			body="Found. Breastplate",		-- 34 MAB
			hands="Founder's Gauntlets",	-- 35 MAB
			waist="Asklepian Belt",			-- 10 Skill
			feet="Founder's Greaves"})		-- 33 MAB
											--167
	-- Cure Set -- caps at 47%/50%
	sets.Midcast.Cure = {
			ammo="Impatiens",
			head="Souveran Schaller",
			neck="Sanctity Necklace",
			ear1="Mendi. Earring",			-- 05
			ear2="Nourishing Earring +1",	-- 06
			body="Jumalik mail",			-- 15
			hands="Macabre Gaunt. +1",		-- 11
			ring1="Vocane Ring",			
			--ring2="Eihwaz Ring",
			back="Solemnity Cape",			-- 04
			waist="Rumination Sash",
			legs="Carmine cuisses",
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
			ear1="Andoaa Earring",
			-- ear2="Augment. Earring",
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
	sets.Midcast.Reprisal = {
			ammo="Impatiens",
			head="Souveran Schaller", 		--  125+80
			neck="Bloodbead Gorget", 		--   60
			ear1="Odnowa Earring +1", 		--  100
			ear2="Etiolation Earring", 		--   50
			body="Rev. Surcoat +3", 		--  254
			hands="Cab. Gauntlets +1", 		--  104
			ring1="Praan Ring", 			--   60
			ring2="Meridian Ring", 			--   90
			back="Reiki Cloak", 			--  130
			waist="Creed Baudrier", 		--   40
			legs="Souveran Diechlings",		--   57+80
			feet="Amm Greaves"}		 		--   75+50
											-- 1355HP
			
	
    -- Start defining the sets
    --------------------------------------
 
    -- Precast Sets
    -- Precast sets to enhance JAs
	sets.precast = {}
	sets.precast.JA = {}
    sets.precast.JA['Chainspell'] = {body="Vitivation Tabard +1"}
 
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
 
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
 
    -- Fast cast sets for spells
 
    -- 81%/80% Fast Cast (including trait) for all spells, plus 10% quick cast in separate set, triggered for non-elemental spells
    -- No other FC sets necessary.
    sets.precast.FC = { 																													--30 from trait
		head={ name="Carmine Mask", augments={'Accuracy+15','Mag. Acc.+10','"Fast Cast"+3',}}, 												--12
		neck="Voltsurge Torque", 																											--04
		left_ear="Estoqueur's Earring", 																									--02
		right_ear="Loquac. Earring", 																										--02
		body={ name="Viti. Tabard +1", augments={'Enhances "Chainspell" effect',}}, 														--13
		hands="Leyline Gloves", 																											--06
		left_ring="Prolix Ring", 																											--02
		legs={ name="Lengo Pants", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Refresh"+1',}}, 									--05
		feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+12','Crit.hit rate+1','"Refresh"+1','Mag. Acc.+6 "Mag.Atk.Bns."+6',}},} 	--05
	
	sets.precast.FC.quickcast = set_combine(sets.precast.FC, {
		ammo="Impatiens",				--2
		back="Perimede cape",			--4
		waist="Witful belt",			--3
		right_ring="Veneficum Ring",	--1
	})
    
	sets.precast.FC.Impact = set_combine(sets.precast.FC.quickcast, {head=empty,body="Twilight Cloak"})
 
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
	
	sets.precast.WS = {
		ammo="Vanir Battery",
        head="Carmine Mask",
		neck="Fotia gorget",
		ear1="Brutal earring",
		ear2="Ishvara Earring",
        body="Jhakri Robe +1",
		hands="Atrophy gloves +2",
		ring1="Apate ring",
		ring2="Petrov Ring",
        back="Bleating Mantle",
		waist="Fotia belt",
		legs="Jhakri slops +1",
		feet="Atrophy Boots +1"}
	
    sets.precast.WS.physical = set_combine(sets.precast.WS, {})
 
	sets.precast.WS.magical = set_combine(sets.precast.WS, {
		ammo="Pemphredo Tathlum",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic Damage +13','INT+6','Mag. Acc.+13','"Mag.Atk.Bns."+8',}},
		neck="Sanctity Necklace",
		left_ear="Friomisi Earring",
		right_ear="Hecate's Earring",
		body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+21','Mag. Acc.+21','Haste+3','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		left_ring="Acumen Ring",
		right_ring="Strendu Ring",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
		waist="Eschan Stone",
		legs="Jhakri Slops +1",
		feet="Jhakri Pigaches +2"})
 
 
    sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS.magical, {})
	
	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS.magical, {})
 
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS.physical, {})     
 
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS.physical, {})
 
    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS.physical, {})
 
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS.physical, {})
         
    sets.precast.WS['Death Blossom'] = set_combine(sets.precast.WS, {})
 
    -- Midcast Sets
	sets.midcast = {}
    sets.midcast.Cure = {
		main="Tamaxchi", 				--22
		--sub="Sors shield",			
		ammo="Esper Stone +1",
        head="Gendewitha Caubeen",		--10
		--neck="Colossus's Torque",
		ear1="Mendi. Earring",			--05
		--ear2="Digni. Earring",
        body="Kaykaus Bliaut",			--05 03II
		hands="Telchine Gloves",		--10
		ring1="Ephedra ring",						--skill 7
		ring2="Ephedra ring",						--skill 7
        back="Vates cape +1",						--skill 7
		waist="Rumination Sash",
		legs="Atrophy Tights +1",		--10
		feet="Vitivation Boots +1"}
 
    sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.CureSelf = {
		ring2="Vocane Ring",
		hands="Buremte Gloves"}
 
    sets.midcast['Enhancing Magic'] = {
        head="Befouled Crown",					-- 16
		neck="Melic Torque",					-- 10
		ear1="Andoaa earring",					-- 05
		-- ear2="Augmenting earring", 3 skill
        body="Vitivation tabard +1",
		hands="Atrophy gloves +2",
		--ring1="Perception ring",
        back="Sucellos's cape",
		--waist="Olympus Sash",
		legs="Atrophy tights +1",
		feet="Lethargy Houseaux +1"}
 
    sets.midcast['Enhancing Magic'].EnSpells = set_combine(sets.midcast['Enhancing Magic'],{
	--ear2="Hollow Earring",
	hands="Vitivation Gloves +1"})
 
    sets.midcast['Enhancing Magic'].GainSpells = set_combine(sets.midcast['Enhancing Magic'],{
		hands="Vitivation Gloves +1"})
 
    sets.midcast.EnhancingDuration = {
		main="Bolelabunga", sub="Ammurapi Shield",
		head="Telchine Cap",
		body="Telchine Chasuble",
		hands="Atrophy gloves +2",
		legs="Telchine Braconi",
		back="Sucellos's cape",
		feet="Telchine Pigaches"}
		
	sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration,{--Regen effect + conserver MP. I prefer duration over effect though.
		main="Bolelabunga",sub="Culminus",--Regen Potency +10%
		
		})
	
	sets.buff = {}
    sets.buff.ComposureOther = {
		head="Leth. Chappel +1",
		body="Lethargy Sayon +1",
		hands="Leth. Gantherots +1",
		legs="Lethargy Fuseau +1",
		feet="Lethargy Houseaux +1"}
 
    sets.midcast.Protect = {ring2="Sheltered Ring"}
    sets.midcast.Shell = sets.midcast.Protect
 
    sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'],{})--main="Egeking"})
 
    sets.midcast.Cursna = {
		--neck="Malison medallion",
		--back="Oretania's cape +1",
		ring1="Ephedra ring",
		ring2="Ephedra ring",
		--feet="Vanya clogs"
		}
 
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'],{
		--neck="Stone gorget",
		--ear2="Earthcry earring",
		--hands="Stone mufflers",
		waist="Siegel Sash",
		--legs="Haven hose"
		})
 
    sets.midcast['Enfeebling Magic'] = {
		main={ name="Colada", augments={'Mag. Acc.+24','DEX+2','Accuracy+24','Attack+15','DMG:+13',}}, 
		ammo="Regal Gem",
		--ammo="Quartz Tathlum +1", -- enfeebling +4
        head="Carmine Mask", -- enfeebling +10, macc +38
		--neck="Henic torque",
		ear1="Dignitary's Earring",-- macc
		ear2="Estoqueur's Earring",-- macc
        body="Shango Robe", -- enfeebling +15, macc +23
		--body="Atrophy Tabard +1", -- enfeebling +17
		hands="Lethargy gantherots +1", -- enfeebling +19
		ring1="Kishar Ring", --macc ring
		ring2="Sangoma Ring", -- macc ring
        back="Sucellos's Cape",
		waist="Rumination Sash",
		legs="Lethargy fuseau +1",
		feet="Vitivation boots +1",}
 
    sets.midcast.Distract = set_combine(sets.midcast['Enfeebling Magic'], {})
 
    sets.midcast.Frazzle = set_combine(sets.midcast['Enfeebling Magic'], {})
 
    sets.midcast['Dia III'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Vitivation Chapeau +1"})
 
    sets.midcast['Slow II'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Vitivation Chapeau +1"})
 
    sets.midcast['Elemental Magic'] = {
		main={ name="Colada", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','"Store TP"+3',}},
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +1",
		--head={ name="Helios Band", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic crit. hit rate +7','Mag. crit. hit dmg. +7%',}},
		neck="Sanctity Necklace",
		left_ear="Friomisi Earring",
		right_ear="Hecate's Earring",
		body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+21','Mag. Acc.+21','Haste+3','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
		hands="Jhakri cuffs +1",
		left_ring="Acumen Ring",
		right_ring="Strendu Ring",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
		waist="Eschan Stone",
		legs="Jhakri Slops +1",
		feet="Jhakri Pigaches +2"}

 
    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})
	
	sets.midcast.Burst = set_combine(sets.midcast['Elemental Magic'], {
		head={ name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic burst dmg.+11%',}},
		neck="Mizu. Kubikazari",			--10
		hands="Amalric Gages",				--05II
		left_ring="Mujin band",				--05II
		right_ring="Locus Ring",			--05
		back="Seshaw Cape",					--05
		feet="Jhakri Pigaches +2",})		--05
 
    sets.midcast.Drain = {
		waist="Fucho-no-Obi",
		feet="Merlinic Crackows"}
 
    sets.midcast.Aspir = sets.midcast.Drain
 
    sets.midcast['Stun'] = {
		main={ name="Colada", augments={'Mag. Acc.+24','DEX+2','Accuracy+24','Attack+15','DMG:+13',}},								-- 39
		sub="Ammurapi Shield",		
		ammo="Pemphredo Tathlum", 																									-- 08 
        head="Carmine mask", 																										-- 38
		neck="Sanctity necklace",																									-- 10
		ear1="Dignitary's Earring",																									-- 10
		ear2="Estoqueur's Earring",																									-- 03
        body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+21','Mag. Acc.+21','Haste+3','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},	-- 55
		hands="Lethargy gantherots +1", 																							-- 24
		ring1="Strendu Ring",																										-- 02
		ring2="Sangoma Ring", 																										-- 08
        back="Sucellos's Cape",																										-- 20
		waist="Eschan Stone",																										-- 07
		legs="Lethargy fuseau +1",																									-- 22
		feet="Vitivation boots +1"}																									-- 15
																																	--261
    -- Sets to return to when not performing an action.
 
    -- Resting sets
    sets.resting = {}
 
    -- Idle sets
	sets.idle = {
		main="Bolelabunga",
		sub="Genmei Shield",
		ammo="Homiliary",
		head="Viti. Chapeau +1",
		body={ name="Witching Robe", augments={'MP+5','"Refresh"+1',}},
		hands="Serpentes Cuffs",
		legs={ name="Lengo Pants", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Refresh"+1',}},
		feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+12','Crit.hit rate+1','"Refresh"+1','Mag. Acc.+6 "Mag.Atk.Bns."+6',}},
		neck="Sanctity Necklace",
		waist="Flume Belt",
		left_ear="Etiolation Earring",
		right_ear="Infused Earring",
		left_ring="Sheltered Ring",
		right_ring="Defending Ring",
		back="Archon Cape",
	}
 
    sets.idle.Town = sets.idle
 
    sets.idle.Weak = sets.idle
 
    -- Defense sets
	sets.defense = {}
    sets.defense.PDT = set_combine(sets.idle, {
		main="Demers. Degen +1",
		sub="Genmei shield",			--		10
		ammo="Staunch Tathlum",			--  02
		head="Aya. Zucchetto +1",		--  02
		neck="Loricate Torque +1",		--	06		
		ear2="Colossus's earring",		--		01
		body="Emet Harness +1",			--		06
		hands="Aya. Manopolas +1",		--  02
		ring1="Vocane Ring",			--	07
		ring2="Defending Ring",			--	10
        back="Umbra cape",				--		06				
		waist="Flume belt",				--		04
		feet="Aya. Gambieras +1"		--  02
		})								--  31  27
 
    sets.defense.MDT = set_combine(sets.defense.PDT, {
		main="Demers. Degen +1",
		sub="Beatific shield",			--		25
		neck="Warder's Charm +1",		
		ear1="Etiolation earring",		--		03		

        back="Engulfer cape +1",		--		04				
		})
 
    sets.Kiting = {legs="Carmine Cuisses"}
 
    sets.latent_refresh = {waist="Fucho-no-obi"}
 
    -- Engaged sets
 
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
 
    -- Normal melee group
    sets.engaged = {
		main="Demers. Degen +1",
		sub="Beatific shield",
		ammo="Vanir Battery",
        head="Aya. Zucchetto +1",
		neck="Defiant Collar",
		ear1="Brutal earring",
		ear2="Cessance earring",
        body="Jhakri Robe +1",
		hands="Atrophy gloves +2",
		ring1="Petrov Ring",
		ring2="Hetairoi Ring",
        back="Bleating Mantle",
		waist="Windbuffet belt +1",
		legs="Carmine cuisses",
		feet="Ayanmo gambieras +1"}
 
    -- Sets for special buff conditions on spells.
	sets.buff = {}
    sets.buff.Saboteur = {hands="Lethargy Gantherots +1"}	
	

	sets.keep = {
		hand="Trizek Ring",
		waist="Hachirin-No-Obi",
		legs="Sublime Sushi",
		}
		
	sets.buff = {}
	sets.buff['Burst Affinity'] = {feet="Hashishin Basmak +1"}
    sets.buff['Chain Affinity'] = {head="Hashi. Kavuk +1", feet="Assimilator's Charuqs"}
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

    sets.precast.FC = {}

    sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body="Hashishin Mintan +1",hands="Hashi. Bazubands"})


    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo="Amar cluster",
        head="Dampening Tam",
        --neck="Sanctity necklace",
        neck="Fotia Gorget",
        lear="Brutal Earring",
		rear="Dignitary's Earring",
        body="Adhemar Jacket",
        hands="Adhemar wristbands",
        lring="Petrov ring",
		rring="Epona's Ring",
        back="Rosmerta's Cape",
        waist="Fotia Belt",
        legs="Herculean Trousers",
        feet="Herculean boots",}

    sets.precast.WS.acc = set_combine(sets.precast.WS, {})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Chant du Cygne'] = {
        ammo="Amar cluster",
        head="Dampening Tam",
        --neck="Sanctity necklace",
        neck="Fotia Gorget",
        lear="Brutal Earring",
		rear="Dignitary's Earring",
        body="Adhemar Jacket",
        hands="Adhemar wristbands",
        lring="Petrov ring",
		rring="Epona's Ring",
        back="Rosmerta's Cape",
        waist="Fotia Belt",
        legs="Herculean Trousers",
        feet="Herculean boots",}

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
		hands="Jhakri cuffs +1",
		lring="Strendu Ring", 
		rring="Acumen Ring",
		back="Cornflower Cape", 
		waist="Eschan Stone",
		legs="Jhakri Slops +1", 
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
          lear="Loquac. Earring", rear="Enchntr. Earring +1",
          body="Telchine Chas.",
          hands="Telchine Gloves",
          lring="Levia. Ring +1", rring="Levia. Ring +1",
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
          body="Adhemar Jacket",
          hands="Serpentes Cuffs",
          lring="Vocane Ring",rring="Defending Ring",
          back="Solemnity Cape",
          waist="Flume Belt",
          --legs="Rawhide Trousers", --refresh
          legs="Carmine cuisses",
          feet="Serpentes Sabots",}


    sets.idle.Learning = set_combine(sets.idle, sets.Learning)


    -- Defense sets
	sets.defense = {}
	
    sets.defense.PDT = { --done
        head="Iuitl Headgear +1",
        neck="Loricate Torque +1",
        lear="Colossus's Earring", rear="Ethereal Earring",
        body="Emet Harness",
        hands="Herculean Gloves",
        lring="Vocane Ring", rring="Defending Ring",
        back="Xucau mantle",
        waist="Flume Belt",
        legs="Herculean trousers",
        feet="Herculean boots"}

    sets.defense.MDT = {}

    sets.Kiting = {legs="Carmine cuisses",feet="Hippomenes socks"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- misc, currently only used to equip weapons
	sets.misc = {}
	sets.misc.weapon = {}
	sets.misc.weapon['Magic'] = {main="Vampirism",sub="Vampirism",}
	sets.misc.weapon['DD'] = {main="Tanmogayi +1",sub={ name="Colada", augments={'Mag. Acc.+24','DEX+2','Accuracy+24','Attack+15','DMG:+13',}},}
	sets.misc.weapon['Off'] = {}
	
	
    -- Normal melee group
    sets.engaged = { --done
		ammo="Ginsen",
		head="Dampening Tam",
		neck="Defiant Collar",
		lear="Brutal Earring",
		rear="Suppanomimi",
		body="Adhemar Jacket",
		hands="Herculean Gloves",
		lring="Hetairoi Ring",
		rring="Epona's Ring",
		back="Bleating mantle",
		waist="Windbuffet Belt +1",
		legs="Samnuha Tights",
		feet="Herculean boots"}

    sets.engaged.MidAcc = set_combine(sets.engaged,{ -- done
        neck="Sanctity Necklace",
		lear="Digni. Earring",
		hands="Aya. Manopolas +1",
		lring="Mars's Ring"})

	sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc,{ -- done
		ammo="Honed Tathlum",
		head="Carmine mask",
		rear="Cessance Earring",
		rring="Apate ring",
		back="Grounded Mantle +1",
		waist="Eschan Stone",
		legs="Carmine cuisses"})
	
	sets.engaged.Blink = {body="Emet Harness",}
    sets.engaged.Refresh = {}
	
	sets.engaged.DamageTaken = set_combine(sets.engaged,{ -- done
		head="Iuitl Headgear +1",
        neck="Loricate Torque +1",
        lear="Colossus's Earring", rear="Ethereal Earring",
        body="Emet Harness",
        hands="Herculean Gloves",
        lring="Vocane Ring", rring="Defending Ring",
        back="Solemnity Cape",
        waist="Flume Belt",
        legs="Herculean trousers",
        feet="Herculean boots"})

    sets.engaged.Learning = set_combine(sets.engaged, sets.Learning)


    sets.self_healing = {ring1="Kunaji Ring",ring2="Asklepian Ring"}
end
	
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
		--left_ear="Barkaro. Earring",
		right_ear="Etiolation Earring",
		left_ring="Mephitas's Ring +1",
		right_ring="Mephitas's Ring",
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
		ear2="Loquacious Earring",--2%
		ring1="Prolix Ring",--2%
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
		ear1="Mendicant's Earring",
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
		ring1="Mujin band",					--05II
		ring2="Locus Ring",					--05
		back="Seshaw Cape",					--05
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic burst dmg.+8%','AGI+1','Mag. Acc.+7',}},
		feet="Jhakri Pigaches +2",			--05
		--back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+8','"Mag.Atk.Bns."+10',}},--5%
		}
		
    ---- Midcast Sets ----
	sets.midcast = {}
    sets.midcast.FastRecast = {
        head={ name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic burst dmg.+11%',}},
		ear2="Loquacious Earring",
        ring1="Prolix Ring",
        back={ name="Taranus's Cape", augments={'MP+60','"Fast Cast"+10',}},
		waist="Witful Belt",
		}

    sets.midcast.Cure = {
        main="Arka IV",				--24
		--head="Vanya hood",
		body="Heka's Kalasiris",	--15
		hands="Telchine Gloves",	--10
		ear1="Mendicant's Earring",	--05
		ring1="Ephedra Ring",
		ring2="Ephedra Ring",
        --back="Solemnity Cape",
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
		--ear1="Barkarole Earring",
		ear2="Digni. Earring",
		ring1="Acumen Ring",ring2="Perception Ring",
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
		--ear1="Barkarole Earring",
		ear2="Digni. Earring",
		ring1="Acumen Ring",
		ring2="Evanescence Ring",
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
		--ear1="Barkaro. Earring",
		--ear2="Static Earring",
		ring1="Mephitas's Ring +1",
		ring2="Archon Ring",
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
		head="Jhakri Coronal +1",
		neck="Saevus pendant +1", --more att/less acc
		ear1="Hecate's Earring",
		ear2="Friomisi Earring",
		body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+21','Mag. Acc.+21','Haste+3','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		ring1="Acumen Ring",
		ring2="Strendu Ring",
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
		ear2="Digni. Earring",
		})
	
    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'],{})
    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant,{})

	sets.midcast.Stun = set_combine(sets.midcast['Elemental Magic'].Resistant,{
		main="Lathi",sub="Niobid Strap",
		--ammo="Sturm's Report",
        head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic Damage +13','INT+6','Mag. Acc.+13','"Mag.Atk.Bns."+8',}},
		--ear1="Barkaro. Earring",
		ear2="Digni. Earring",
        waist="Witful Belt",
		})
	

    -- Minimal damage gear for procs.
    sets.midcast['Elemental Magic'].Proc = {
		main="Earth Staff", sub="Mephitis Grip",
		ammo="Impatiens",
		ear1="Ethereal Earring",ear2="Loquacious Earring",
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
		ear2="Infused Earring",
        body="Jhakri Robe +1",
		--hands="Serpentes Cuffs",--not enough defense
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		ring1="Defending Ring",
		ring2="Vocane Ring",
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
		ring1="Defending Ring",
		ring2="Vocane Ring",
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
		--ear1="Barkaro. Earring",
		ear2="Etiolation Earring",
		ring1="Mephitas's Ring +1",
		ring2="Mephitas's Ring",
		back={ name="Bane Cape", augments={'Elem. magic skill +8','Dark magic skill +10','"Mag.Atk.Bns."+2',}},
		})
	
    -- Defense sets
	sets.defense = {}
    sets.defense.PDT = set_combine(sets.idle.PDT,{
		neck="Loricate Torque +1",
		ring1="Defending Ring",
        back="Archon Cape",})

    sets.defense.MDT = set_combine(sets.defense.PDT,{
		--ammo="Demonry Stone",
		neck="Loricate Torque +1",
        --body="Vanir Cotehardie",
		ring1="Defending Ring",
		ring2=="Vocane Ring",
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
		--ammo="Hasty Pinion +1",
		--neck="Asperity Necklace",
		--ear1="Bladeborn Earring",
		--ear2="Steelflash Earring",
		--ring1="Apate ring",ring2="Petrov Ring",
        --back="Kayapa cape",
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
------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal', 'ACC')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	---------------------------------------
	--- 		Precast Sets			---
	---------------------------------------

	-- Fast cast sets for spells
	organizer_items	= {
		mjollnir="Mjollnir",
		sindri="Sindri",
		ddshield="Thorfinn Shield +1",
		cpring="Trizek Ring",
		xpring="Echad Ring",
		cpring2="Capacity Ring",
		}
	
	
	sets.precast.FC = { --caps at 80% // @FC 47%, QC 10%
		--head="Haruspex hat",				--	 8%
		ammo="Impatiens",					-- 			2%
		neck="Voltsurge Torque",			--	 4%
		ear1="Etiolation earring",			--	 1%
		ear2="Loquacious Earring",			--	 2%
		ring1="Veneficium Ring",				--			1%
		ring2="Kishar Ring",				--	 4%
		body="Inyanga jubbah +1",			--	13%
		--hands="Fanatic Gloves",				--	 7%
		back="Perimede cape",				--			4%
		waist="Witful Belt",				--	 3%		3%
		legs="Lengo Pants",					--	 5%
		feet="Regal pumps",					--	 3%
		}
		
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

	--sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

	sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {
		legs="Ebers Pantaloons +1",})
	
	sets.precast.FC.Regen = set_combine(sets.precast.FC, {-- I have added duration to ensure it's effect even with QC. ca 3minutes
		main="Bolelabunga",--Regen Potency +10%
		sub="Culminus",
		head="Telchine Cap", --8
		body="Piety Briault +1",--Potency +36%
		hands="Ebers Mitts +1",--Duration +22 (beats anything)
		legs="Theophany Pantaloons +1",--18 seconds extra.
		--feet="Telchine Pigaches",--potency +2
		feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +7',}},--9
		})

	sets.precast.FC.StatusRemoval = set_combine(sets.precast.FC['Healing Magic'],{
		legs="Ebers Pantaloons +1",--precast 10%
	})

	sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], { --caps at 48%(50) // @about 1-2 seconds cast time
		main="Queller rod",
		sub="Sors Shield",							--Time - 5%
		ear1="Nourishing earring +1", 				--Time - 4%
		ear2="Mendicant's earring",					--Time - 5%
		head="Piety Cap +1",						--time -13%
		--legs="Chironic hose",--time -8% // Kaykaus got FC6% + Time -5%
		feet="Hygieia Clogs",						--time -17%
		back="Pahtli cape"							--time - 8%
		})

	sets.precast.FC.CureSolace = sets.precast.FC.Cure
		
	sets.precast.FC.Curaga = sets.precast.FC.Cure
	
	-- Precast sets to enhance JAs
	sets.precast.JA.Benediction = {body="Piety Briault +1"}
	
	
	---------------------------------------
	--- 		Midcast Sets			---
	---------------------------------------
	sets.midcast.FastRecast = set_combine(sets.precast.FC,{
		waist="Ninurta's sash"})
	
	-- Cure sets
	sets.midcast.CureSolace = { --when afflatus solace is on --I 61%, II 7%
		main="Queller rod", 						-- II 2%	I 10%	Skill +15
		sub="Sors Shield",	
		head="Ebers Cap +1",						--			I 16%
		neck="Incanter's torque",					--					Skill +10
		ear1="Nourishing earring +1",				--			I  6%
		ear2="Glorious Earring",					-- II 2%
		body="Ebers Bliaut +1",						-- II 3%	I  5%
		hands="Telchine gloves",					--			I 10%
		ring1="Ephedra Ring",						--					Skill + 7
		ring2="Ephedra Ring",						--					Skill + 7
		legs="Ebers Pantaloons +1",													--6% Cure Amount returned to MP
		--feet="Vanya Clogs",							--			I  5%	Skill +40
		feet="Piety duckbills +1",
		back="Alaunus's cape",														--Solace+10
		--body="Ebers Bliaud +1",--solace 14
		--feet="Hygieia clogs",--Conserve MP
		--back="Solemnity Cape",--7%
		}

	sets.midcast.Cure = set_combine(sets.midcast.CureSolace,{body="Kaykaus Bliaut",})
	sets.midcast.Curaga = set_combine(sets.midcast.CureSolace,{body="Kaykaus Bliaut",}) --removed for the moment as I don't use curaga enough

	sets.midcast.CureMelee = {--currently 51% + 5% II
		--head="Vanya Hood",--17%
		head="Ebers Cap +1",
		neck="Incanter's torque",--skill+10
		ear1="Glorious Earring",
		ear2="Nourishing earring +1",--II 2%, I 6%
		--body="Ebers Bliaud +1",--solace 14
		body="Kaykaus Bliaut",--II 3%
		hands="Telchine gloves",--10%
		ring1="Ephedra Ring",
		ring2="Ephedra Ring",--lolSkill
		back="Solemnity Cape",--7%
		legs="Ebers Pantaloons +1",--6% Cure Amount returned to MP
		--feet="Vanya Clogs",--5%
		feet="Piety duckbills +1",
		}
	
	sets.midcast.Cursna = { --this should be cursna and healing magic skill, skill 576
		--main="Yagrush",
		sub="Culminus",
		head="Ebers Cap +1",--divine veil+22%,skill+24
		neck="Incanter's torque",--skill+10
		body="Ebers Bliaud +1",--skill+24
		hands="Fanatic gloves",--Cursna+15
		ring1="Ephedra Ring",
		ring2="Ephedra Ring",--Cursna +10% ea.
		--back="Mending Cape",--Cursna +15%
		back="Alaunus's Cape",--Cursna +25
		legs="Theophany Pantaloons +2",-- Cursna +15
		--feet="Vanya clogs"--Skill +40
		}

	sets.midcast.StatusRemoval = {
		--main="Yagrush",
		neck="Incanter's torque",
		head="Ebers Cap +1",--22%
		--legs="Ebers Pantaloons +1",--precast 10%
		}

	---------------------------------------
	--		ENHANCEMENT MAGIC SETS		---
	---------------------------------------
	-- 510 total Enhancing Magic Skill; caps even without Light Arts
	sets.midcast['Enhancing Magic'] = { --541 skill
		main="Gada",--skill 18
		head="Befouled Crown", --skill 16
		neck="Incanter's Torque", -- skill 10 / mp deplete
		body="Telchine chasuble", --skill 12
		--hands="Dynasty Mitts", --skill 18 / duration 5
		hands="Telchine gloves",
		back="Mending Cape", --skill 1
		legs="Piety Pantaloons +1", --skill 22 / bar 30
		feet="Ebers Duckbills +1", --skill 25

		}

	sets.midcast.EnhDuration = set_combine(sets.midcast['Enhancing Magic'],{--46 total duration / skill 460
		main="Gada",				-- 6
		head="Telchine Cap",		-- 8
		body="Telchine Chas.",		
		hands="Telchine Gloves",	--10
		legs="Telchine Braconi",	
		feet="Telchine Pigaches",	-- 7
		neck="Incanter's Torque", })

	sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'],{--BarEffect 230 (cap), no need to add duration 4/5 Ebers?
		--main="Beneficus",
		sub="Culminus",
		head="Ebers cap +1",
		body="Ebers Bliaud +1",
		hands="Ebers Mitts +1",
		legs="Piety Pantaloons +1",
		feet="Ebers Duckbills +1",		
		})
	
	sets.midcast.Stoneskin = set_combine(sets.midcast.EnhDuration,{--skill+bonus
		hands="Dynasty Mitts",
		waist="Siegel Sash",})

	sets.midcast.Auspice = set_combine(sets.midcast.EnhDuration,{
		feet="Ebers Duckbills +1"})

	sets.midcast.Haste = set_combine(sets.midcast.EnhDuration,{
		waist="Ninurta's sash",})
	
	sets.midcast.refresh = set_combine(sets.midcast.EnhDuration,{--should I ever be /RDM
		waist="Gishdubar sash",
		feet="Inspirited boots",
		})

	sets.midcast.Regen = set_combine(sets.midcast.EnhDuration,{--Regen effect + conserver MP. I prefer duration over effect though.
		main="Bolelabunga",sub="Culminus",--Regen Potency +10%
		head="Inyanga Tiara +1",--Potency 12%
		body="Piety Briault +1",--Potency +36%
		hands="Ebers Mitts +1",--Duration +22 (beats anything)
		legs="Theophany Pantaloons +1",--18 seconds extra.
		--feet="Telchine Pigaches",--potency +2
		})

	sets.midcast.Protectra = set_combine(sets.midcast.EnhDuration,{ring1="Sheltered Ring",feet="Piety duckbills +1"})
	sets.midcast.Shellra = set_combine(sets.midcast.EnhDuration,{ring1="Sheltered Ring",legs="Piety Pantaloons +1"})
	
	
	---------------------------------------
	--			MATT / ENFEEB			---
	---------------------------------------
	-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	sets.buff['Divine Caress'] = {
		hands="Ebers Mitts +1",
		back="Mending Cape"}
	
	sets.midcast.MAB = { --ugh. Do we need it? @219 MAB
		main={ name="Gada", augments={'Enh. Mag. eff. dur. +5','STR+1','Mag. Acc.+19','"Mag.Atk.Bns."+15',}},
		sub="Culminus",
		ammo="Pemphredo tathlum",
		head="Befouled Crown",
		body={ name="Chironic Doublet", augments={'Mag. Acc.+16 "Mag.Atk.Bns."+16','"Cure" potency +1%','CHR+4','Mag. Acc.+15','"Mag.Atk.Bns."+1',}},
		hands={ name="Chironic Gloves", augments={'Mag. Acc.+27','Sklchn.dmg.+1%','Accuracy+20 Attack+20','Mag. Acc.+7 "Mag.Atk.Bns."+7',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+25','"Cure" spellcasting time -8%','CHR+6','"Mag.Atk.Bns."+2',}},
		feet={ name="Chironic Slippers", augments={'"Mag.Atk.Bns."+23','"Store TP"+2','"Refresh"+1',}},
		neck="Saevus Pendant +1",
		waist="Refoccilation Stone",
		left_ear="Friomisi Earring",
		right_ear="Hecate's Earring",
		left_ring="Strendu Ring",
		right_ring="Adoulin Ring",
		back="Izdubar Mantle",
		}
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast.MAB,{})

	sets.midcast['Dark Magic'] = set_combine(sets.midcast.MAB,{
		head="Pixie hairpin +1",
		ring1="Archon Ring",
		})
	
	sets.midcast.MACC = { --Since I don't want to enfeeble in MAB gear
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		right_ear="Digni. Earring",
		left_ring="Perception Ring",
	}
	
	-- Custom spell classes
	sets.midcast.MndEnfeebles = set_combine(sets.midcast.MACC,{})
	sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles,{})

	
	---------------------------------------
	---				IDLE SETS 			--- 
	---------------------------------------
	--[[
		Sets to return to when not performing an action.
	]]--
	sets.idle = {
		main="Queller Rod", sub="Genmei shield",--Refresh/PDT
		ammo="Homiliary",--Refresh
		head="Befouled Crown",--Refresh
		neck="Loricate Torque +1",--DT
		ear1="Etiolation earring",ear2="Infused Earring",--Regen/DT
		body="Witching Robe",--Refresh
		hands={ name="Chironic Gloves", augments={'Spell interruption rate down -1%','Pet: Mag. Acc.+22','"Refresh"+2',}},--Refresh
		ring1="Defending Ring",ring2="Vocane Ring",--PDT/MDT/DT
		back="Solemnity Cape",--Annuls DT
		waist="Ninurta's sash",--interruption rate down. PDT/MDT would be better
		legs="Assiduity Pants +1",--refresh 1-2
		feet={ name="Chironic Slippers", augments={'"Mag.Atk.Bns."+23','"Store TP"+2','"Refresh"+1',}},--refresh +1
		}

	sets.idle.PDT = set_combine(sets.idle,{ --34% DT, 25% PDT, 17% MDT --- 50% PDT, 50% MDT ++ 30%MDT ShellV
		main="Mafic Cudgel",
		sub="Genmei Shield",
		head="Inyanga Tiara +1",
		body="Inyanga Jubbah +1",
		hands="Inyan. Dastanas +1",
		legs="Aya. Cosciales +1",
		feet="Aya. Gambieras +1",
		neck="Loricate Torque +1",
		waist="Ninurta's Sash",
		left_ear="Etiolation Earring",
		right_ear="Genmei Earring",
		left_ring="Defending Ring",
		right_ring="Vocane Ring",
		back="Solemnity Cape",})
	
	sets.idle.Weak = set_combine(sets.idle.PDT,{})
	sets.latent_refresh = {waist="Fucho-no-obi"}
	
	-- Resting sets
	sets.resting = set_combine(sets.idle,{}) --haven't rested as WHM in a long long time, let's use the refresh set
	
	-- Defense sets
	sets.defense.PDT = set_combine(sets.idle.PDT,{
		main="Mafic Cudgel",
		sub="Genmei Shield",
		ammo="Homiliary",
		head="Aya. Zucchetto +1",
		body="Ayanmo Corazza +1",
		hands="Aya. Manopolas +1",
		legs="Aya. Cosciales +1",
		feet="Aya. Gambieras +1",
		neck="Loricate Torque +1",
		waist="Ninurta's Sash",
		left_ear="Etiolation Earring",
		right_ear="Genmei Earring",
		left_ring="Defending Ring",
		right_ring="Vocane Ring",
		back="Solemnity Cape",})
	sets.defense.MDT = set_combine(sets.defense.PDT,{
		head="Inyanga Tiara +1",
		body="Inyanga Jubbah +1",
		hands="Inyan. Dastanas +1",
		left_ear="Etiolation Earring",})
	sets.Kiting = {feet="Herald's Gaiters"}

	---------------------------------------
	-- 			ENGAGED SETS			---
	---------------------------------------
	--[[
		Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
		sets if more refined versions aren't defined.
		If you create a set with both offense and defense modes, the offense mode should be first.
		EG: sets.engaged.Dagger.Accuracy.Evasion
	]]--
	-- Basic set for if no TP weapon is defined.
	sets.engaged = { --ca 985 ACC
		ammo="Hasty Pinion +1",
		head="Blistering Sallet",
		body="Ayanmo Corazza +1",
		hands="Aya. Manopolas +1",
		legs="Aya. Cosciales +1",
		feet="Aya. Gambieras +1",
		neck="Sanctity Necklace",
		waist="Windbuffet Belt +1",
		left_ear="Digni. Earring",
		right_ear="Brutal Earring",
		left_ring="Hetairoi Ring",
		right_ring="Petrov Ring",
		back="Kayapa Cape",	
		}
	
	sets.engaged.ACC = set_combine(sets.engaged,{ --ca 1050 acc
		ammo="Hasty Pinion +1",
		head="Aya. Zucchetto +1",
		body="Ayanmo Corazza +1",
		hands="Aya. Manopolas +1",
		legs="Aya. Cosciales +1",
		feet="Aya. Gambieras +1",
		neck="Sanctity Necklace",
		waist="Windbuffet Belt +1",
		left_ear="Digni. Earring",
		right_ear="Brutal Earring",
		left_ring="Chirich Ring",
		right_ring="Chirich Ring",
		back="Kayapa Cape",
		})
	
	-- Weaponskill sets

	-- Default set for any weaponskill that isn't any more specifically defined
	gear.default.weaponskill_neck = "Fotia Gorget"
	gear.default.weaponskill_waist = "Fotia Belt"
	sets.precast.WS = set_combine(sets.engaged.ACC,{
		neck="Fotia Gorget",
		ring1="Rajas Ring",ring2="K\'ayres Ring",
		waist="Fotia Belt",
		})
	
	sets.precast.WS['Flash Nova'] = set_combine(sets.midcast.MAB,{}) --that way I only have to manage one set
end
	
	-- Organizer Items --
	organizer_items = {}
end


function check_equip_lock() -- Lock Equipment Here --	
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
	if	(count_msg_ring == 10) then 
			count_msg_ring = 0
	end	
end 



function pretarget(spell,action)
	if (spell.type:endswith('Magic') or spell.type == "Ninjutsu") and buffactive.silence then -- Auto Use Echo Drops If You Are Silenced --
		cancel_spell()
		send_command('input /item "Echo Drops" <me>')
	elseif spell.english:ifind("Cure") and player.mp<actualCost(spell.mp_cost) then
		degrade_spell(spell,Cure_Spells)
	elseif spell.english == "Berserk" and buffactive.Berserk then -- Cancel Berserk If Berserk Is On --
		send_command('cancel Berserk')
	elseif spell.english == "Defender" and buffactive.Defender then -- Cancel Defender If Defender Is On --
		send_command('cancel Defender')
	elseif spell.english == "Souleater" and buffactive.Souleater then -- Cancel Souleater If Souleater Is On --
		send_command('cancel Souleater')
	elseif spell.english == "Last Resort" and buffactive["Last Resort"] then -- Cancel Last Resort If Last Resort Is On --
		send_command('cancel Last Resort')
	elseif spell.type == "WeaponSkill" and spell.target.distance > target_distance and player.status == 'Engaged' then -- Cancel WS If You Are Out Of Range --
		cancel_spell()
		add_to_chat(123, spell.name..' Canceled: [Out of Range]')
		return
	elseif buffactive['Light Arts'] or buffactive['Addendum: White'] then
		if spell.english == "Light Arts" and not buffactive['Addendum: White'] then
			cancel_spell()
			send_command('input /ja Addendum: White <me>')
		elseif spell.english == "Manifestation" then
			cancel_spell()
			send_command('input /ja Accession <me>')
		elseif spell.english == "Alacrity" then
			cancel_spell()
			send_command('input /ja Celerity <me>')
		elseif spell.english == "Parsimony" then
			cancel_spell()
			send_command('input /ja Penury <me>')
		end
	elseif buffactive['Dark Arts'] or buffactive['Addendum: Black'] then
		if spell.english == "Dark Arts" and not buffactive['Addendum: Black'] then
			cancel_spell()
			send_command('input /ja Addendum: Black <me>')
		elseif spell.english == "Accession" then
			cancel_spell()
			send_command('input /ja Manifestation <me>')
		elseif spell.english == "Celerity" then
			cancel_spell()
			send_command('input /ja Alacrity <me>')
		elseif spell.english == "Penury" then
			cancel_spell()
			send_command('input /ja Parsimony <me>')
		end
	end
end

function precast(spell,action)
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
			if equipSet[AccArray[AccIndex]] then
				equipSet = equipSet[AccArray[AccIndex]]
			end
			if player.tp > 2999 then
				if spell.english == "Resolution" then -- Equip Kokou's Earring When You Have 3000 TP --
					equipSet = set_combine(equipSet,{ear1="Kokou's Earring"})
				elseif spell.english == "Chant du Cygne" then -- Equip Jupiter's Pearl When You Have 3000 TP --
					equipSet = set_combine(equipSet,{ear1="Jupiter's Pearl"})
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
	if Twilight == 'Twilight' then
		equip(sets.Twilight)
	end
end

function midcast(spell,action)
	equipSet = {}
	if spell.type:endswith('Magic') or spell.type == 'Ninjutsu' then
		equipSet = sets.Midcast
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
				equipSet = set_combine(equipSet,{ring2="Sheltered Ring"})
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
			equipSet = set_combine(equipSet,{ring1=""})
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

function aftercast(spell,action)
	if not spell.interrupted then
		if spell.type == "WeaponSkill" then
			send_command('wait 0.2;gs c TP')
		elseif spell.english == "Banish II" then -- Banish II Countdown --
			send_command('@wait 20;input /echo Banish Effect: [WEARING OFF IN 10 SEC.]')
		elseif spell.english == "Holy Circle" then -- Holy Circle Countdown --
			send_command('wait 260;input /echo '..spell.name..': [WEARING OFF IN 10 SEC.];wait 10;input /echo '..spell.name..': [OFF]')
		end
	end
	status_change(player.status)
end

function status_change(new,old)
	check_equip_lock()
	if Armor == 'PDT' then
		equip(sets.PDT[ShieldArray[ShieldIndex]])
	elseif Armor == 'MDT' then
		equip(sets.MDT[ShieldArray[ShieldIndex]])
	elseif Armor == 'Kiting' then
		equip(sets.Kiting[ShieldArray[ShieldIndex]])
	elseif Armor == 'Weakness' then
		equip(sets.Weakness[ShieldArray[ShieldIndex]])
	elseif Armor == 'BaseDT' then
		equip(sets.BaseDT[ShieldArray[ShieldIndex]])
	elseif Armor == 'FullDT' then
		equip(sets.FullDT[ShieldArray[ShieldIndex]])
	elseif buffactive["Sublimation: Activated"] then
		equip(sets.Sublimation)
	elseif new == 'Engaged' then
		equipSet = sets.TP
		if Armor == 'Hybrid' and equipSet["Hybrid"] then
			equipSet = equipSet["Hybrid"]
		end
		if equipSet[player.equipment.main] then
			equipSet = equipSet[player.equipment.main]
		end
		if equipSet[ShieldArray[ShieldIndex]] then
			equipSet = equipSet[ShieldArray[ShieldIndex]]
		end
		if equipSet[AccArray[AccIndex]] then
			equipSet = equipSet[AccArray[AccIndex]]
		end
		if buffactive.Ionis and equipSet["Ionis"] then
			equipSet = equipSet["Ionis"]
		end
		if Armor == 'ShieldSkill' then
			equipSet = set_combine(equipSet,sets.TP.ShieldSkill)
		end
		equip(equipSet)
	elseif new == 'Idle' then
		equipSet = sets.Idle.Regen
		if equipSet[IdleArray[IdleIndex]] then
			equipSet = equipSet[IdleArray[IdleIndex]]
		end
		if equipSet[ShieldArray[ShieldIndex]] then
			equipSet = equipSet[ShieldArray[ShieldIndex]]
		end
	if buffactive['Reive Mark'] then -- Equip Ygnas's Resolve +1 During Reive --
		equipSet = set_combine(equipSet,{neck="Ygnas's Resolve +1"})
	end
	if world.area:endswith('Adoulin') then
		equipSet = set_combine(equipSet,{body="Councilor's Garb"})
	end
		equip(equipSet)
	elseif new == 'Resting' then
		equip(sets.Resting)
	end
	if Repulse == 'ON' then -- Use Repulse Toggle To Lock Repulse Mantle --
		equip(sets.Repulse[ShieldArray[ShieldIndex]])
	end
	if Twilight == 'Twilight' then
		equip(sets.Twilight)
	end
	if Cities:contains(world.area) then
		equipSet = equip(sets.Town)
	end
end

function buff_change(buff,gain)
	buff = string.lower(buff)
	if buff == "aftermath: lv.3" then -- AM3 Timer/Countdown --
		if gain then
			send_command('timers create "Aftermath: Lv.3" 180 down;wait 120;input /echo Aftermath: Lv.3 [WEARING OFF IN 60 SEC.];wait 30;input /echo Aftermath: Lv.3 [WEARING OFF IN 30 SEC.];wait 20;input /echo Aftermath: Lv.3 [WEARING OFF IN 10 SEC.]')
		else
			send_command('timers delete "Aftermath: Lv.3"')
			add_to_chat(123,'AM3: [OFF]')
		end
	elseif buff == 'weakness' then -- Weakness Timer --
		if gain then
			send_command('timers create "Weakness" 300 up')
		else
			send_command('timers delete "Weakness"')
		end
	end
	if buff == "sleep" and gain and player.hp > 200 and player.status == "Engaged" then -- Equip Berserker's Torque When You Are Asleep & Have 200+ HP --
		equip({neck=""})
	else
		if not midaction() then
			status_change(player.status)
		end
	end
end

--Macros--
--send_command('bind f9 gs c C7') --PDT--
--send_command('bind f8 gs c C15') --MDT--
--send_command('bind !f11 gs c C2') --Ochain/Aegis/Priwen--
send_command('bind f9 gs c C1') --ACC Level--
send_command('bind f11 gs c C18') --BaseDT/FullDT/PDT/MDT/None--
send_command('bind f10 gs c C2') --Ochain/Aegis/Priwen--
--send_command('bind f11 gs c C16') --Repulse--

function file_unload()
    if binds_on_unload then
        binds_on_unload()
    end

	send_command('unbind f11')
	send_command('unbind !f11')
    send_command('unbind f10')
    send_command('unbind f9')
	--send_command('unbind f7')
	--send_command('unbind f6')
	--send_command('unbind f5')
end


-- In Game: //gs c (command), Macro: /console gs c (command), Bind: gs c (command) --
function self_command(command)
	if command == 'C1' then -- Accuracy Level Toggle --
		AccIndex = (AccIndex % #AccArray) + 1
		status_change(player.status)
		add_to_chat(158,'Accuracy Level: '..AccArray[AccIndex])
	elseif command == 'C5' then -- Auto Update Gear Toggle --
		status_change(player.status)
		add_to_chat(158,'Auto Update Gear')
	elseif command == 'C2' then -- Shield Type Toggle --
		ShieldIndex = (ShieldIndex % #ShieldArray) + 1
		status_change(player.status)
		add_to_chat(158,'Shield Type: '..ShieldArray[ShieldIndex])
	elseif command == 'C9' then -- Hybrid Toggle --
		if Armor == 'Hybrid' then
			Armor = 'None'
			add_to_chat(123,'Hybrid Set: [Unlocked]')
		else
			Armor = 'Hybrid'
			add_to_chat(158,'Hybrid Set: '..AccArray[AccIndex])
		end
		status_change(player.status)
	elseif command == 'C7' then -- PDT Toggle --
		if Armor == 'PDT' then
			Armor = 'None'
			add_to_chat(123,'PDT Set: [Unlocked]')
		else
			Armor = 'PDT'
			add_to_chat(158,'PDT Set: [Locked]')
		end
		status_change(player.status)
	elseif command == 'C15' then -- MDT Toggle --
		if Armor == 'MDT' then
			Armor = 'None'
			add_to_chat(123,'MDT Set: [Unlocked]')
		else
			Armor = 'MDT'
			add_to_chat(158,'MDT Set: [Locked]')
		end
		status_change(player.status)
	elseif command == 'C12' then -- Kiting Toggle --
		if Armor == 'Kiting' then
			Armor = 'None'
			add_to_chat(123,'Kiting Set: [Unlocked]')
		else
			Armor = 'Kiting'
			add_to_chat(158,'Kiting Set: [Locked]')
		end
		status_change(player.status)
	elseif command == 'C4' then -- Capa Back Toggle --
		if Capa == 'ON' then
			Capa = 'OFF'
			add_to_chat(123,'Capacity Mantle: [Unlocked]')
		else
			Capa = 'ON'
			add_to_chat(158,'Capacity Mantle: [Locked]')
		end
		status_change(player.status)
	elseif command == 'C10' then -- Weakness Set Toggle --
		if Armor == 'Weakness' then
			Armor = 'None'
			add_to_chat(123,'Weakness Set: [Unlocked]')
		else
			Armor = 'Weakness'
			add_to_chat(158,'Weakness Set: [Locked]')
		end
		status_change(player.status)
	elseif command == 'C17' then -- DT Toggle --
		if Armor == 'DT' then
			Armor = 'None'
			add_to_chat(123,'DT Set: [Unlocked]')
		else
			Armor = 'DT'
			add_to_chat(158,'DT Set: [Locked]')
		end
		status_change(player.status)
	elseif command == 'C16' then -- Repulse Mantle Toggle --
		if Repulse == 'ON' then
			Repulse = 'OFF'
			add_to_chat(123,'Repulse Mantle: [Unlocked]')
		else
			Repulse = 'ON'
			add_to_chat(158,'Repulse Mantle: [Locked]')
		end
		status_change(player.status)
	elseif command == 'C11' then -- Shield Skill Toggle --
		if Armor == 'ShieldSkill' then
			Armor = 'None'
			add_to_chat(123,'Shield Skill Set: [Unlocked]')
		else
			Armor = 'ShieldSkill'
			add_to_chat(158,'Shield Skill Set: [Locked]')
		end
		status_change(player.status)
	elseif command == 'C3' then -- Twilight Toggle --
		if Twilight == 'Twilight' then
			Twilight = 'None'
			add_to_chat(123,'Twilight Set: [Unlocked]')
		else
			Twilight = 'Twilight'
			add_to_chat(158,'Twilight Set: [locked]')
		end
		status_change(player.status)
	elseif command == 'C8' then -- Distance Toggle --
		if player.target.distance then
			target_distance = math.floor(player.target.distance*10)/10
			add_to_chat(158,'Distance: '..target_distance)
		else
			add_to_chat(123,'No Target Selected')
		end
	elseif command == 'C6' then -- Idle Toggle --
		IdleIndex = (IdleIndex % #IdleArray) + 1
		status_change(player.status)
		add_to_chat(158,'Idle Set: '..IdleArray[IdleIndex])
	elseif command == 'TP' then
		add_to_chat(158,'TP Return: ['..tostring(player.tp)..']')
	elseif command:match('^SC%d$') then
		send_command('//' .. sc_map[command])
	elseif command == 'C18' then -- DT Toggle --			
		DefenseIndex = (DefenseIndex % #DefenseArray) + 1
		Armor = DefenseArray[DefenseIndex]
		status_change(player.status)
		add_to_chat(158,'Defense Type: '..DefenseArray[DefenseIndex])
	end
end

function check_equip_lock() -- Lock Equipment Here --
	if player.equipment.left_ring == "Warp Ring" or player.equipment.left_ring == "Capacity Ring" or player.equipment.right_ring == "Warp Ring" or player.equipment.right_ring == "Capacity Ring" then
		disable('ring1','ring2')
	elseif player.equipment.back == "Mecisto. Mantle" or player.equipment.back == "Aptitude Mantle +1" or player.equipment.back == "Aptitude Mantle" then
		disable('back')
	else
		enable('ring1','ring2','back')
	end
end

function actualCost(originalCost)
	if buffactive["Penury"] then
		return originalCost*.5
	elseif buffactive["Light Arts"] then
		return originalCost*.9
	else
		return originalCost
	end
end

function degrade_spell(spell,degrade_array)
	spell_index = table.find(degrade_array,spell.name)
	if spell_index>1 then
		new_spell = degrade_array[spell_index - 1]
		change_spell(new_spell,spell.target.raw)
		add_to_chat(8,spell.name..' Canceled: ['..player.mp..'/'..player.max_mp..'MP::'..player.mpp..'%] Casting '..new_spell..' instead.')
	end
end

function change_spell(spell_name,target)
	cancel_spell()
	send_command('//'..spell_name..' '..target)
end

function refine_waltz(spell,action)
	if spell.type ~= 'Waltz' then
		return
	end

	if spell.name == "Healing Waltz" or spell.name == "Divine Waltz" or spell.name == "Divine Waltz II" then
		return
	end

	local newWaltz = spell.english
	local waltzID

	local missingHP

	if spell.target.type == "SELF" then
		missingHP = player.max_hp - player.hp
	elseif spell.target.isallymember then
		local target = find_player_in_alliance(spell.target.name)
		local est_max_hp = target.hp / (target.hpp/100)
		missingHP = math.floor(est_max_hp - target.hp)
	end

	if missingHP ~= nil then
		if player.sub_job == 'DNC' then
			if missingHP < 40 and spell.target.name == player.name then
				add_to_chat(123,'Full HP!')
				cancel_spell()
				return
			elseif missingHP < 150 then
				newWaltz = 'Curing Waltz'
				waltzID = 190
			elseif missingHP < 300 then
				newWaltz = 'Curing Waltz II'
				waltzID = 191
			else
				newWaltz = 'Curing Waltz III'
				waltzID = 192
			end
		else
			return
		end
	end

	local waltzTPCost = {['Curing Waltz'] = 20, ['Curing Waltz II'] = 35, ['Curing Waltz III'] = 50, ['Curing Waltz IV'] = 65, ['Curing Waltz V'] = 80}
	local tpCost = waltzTPCost[newWaltz]

	local downgrade

	if player.tp < tpCost and not buffactive.trance then

		if player.tp < 20 then
			add_to_chat(123, 'Insufficient TP ['..tostring(player.tp)..']. Cancelling.')
			cancel_spell()
			return
		elseif player.tp < 35 then
			newWaltz = 'Curing Waltz'
		elseif player.tp < 50 then
			newWaltz = 'Curing Waltz II'
		elseif player.tp < 65 then
			newWaltz = 'Curing Waltz III'
		elseif player.tp < 80 then
			newWaltz = 'Curing Waltz IV'
		end

		downgrade = 'Insufficient TP ['..tostring(player.tp)..']. Downgrading to '..newWaltz..'.'
	end

	if newWaltz ~= spell.english then
		send_command('@input /ja "'..newWaltz..'" '..tostring(spell.target.raw))
		if downgrade then
			add_to_chat(158, downgrade)
		end
		cancel_spell()
		return
	end

	if missingHP > 0 then
		add_to_chat(158,'Trying to cure '..tostring(missingHP)..' HP using '..newWaltz..'.')
	end
end

function find_player_in_alliance(name)
	for i,v in ipairs(alliance) do
		for k,p in ipairs(v) do
			if p.name == name then
				return p
			end
		end
	end
end

function sub_job_change(newSubjob, oldSubjob)
	select_default_macro_book(10)
end

function set_macro_page(set,book)
	if not tonumber(set) then
		add_to_chat(123,'Error setting macro page: Set is not a valid number ('..tostring(set)..').')
		return
	end
	if set < 1 or set > 10 then
		add_to_chat(123,'Error setting macro page: Macro set ('..tostring(set)..') must be between 1 and 10.')
		return
	end

	if book then
		if not tonumber(book) then
			add_to_chat(123,'Error setting macro page: book is not a valid number ('..tostring(book)..').')
			return
		end
		if book < 1 or book > 20 then
			add_to_chat(123,'Error setting macro page: Macro book ('..tostring(book)..') must be between 1 and 20.')
			return
		end
		send_command('@input /macro book '..tostring(book)..';wait .1;input /macro set '..tostring(set))
	else
		send_command('@input /macro set '..tostring(set))
	end
end

function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(4, 10)
	elseif player.sub_job == 'DRK' then
		set_macro_page(4, 10)
	elseif player.sub_job == 'NIN' then
		set_macro_page(4, 10)
	elseif player.sub_job == 'BLU' then
		set_macro_page(4, 10)
	elseif player.sub_job == 'DNC' then
		set_macro_page(4, 10)
	elseif player.sub_job == 'RDM' then
		set_macro_page(4, 10)
	elseif player.sub_job == 'WHM' then
		set_macro_page(4, 10)
	else
		set_macro_page(4, 10)
	end
end