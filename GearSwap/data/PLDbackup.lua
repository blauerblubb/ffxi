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
	DefenseArray = {"None","DT","PDT","MDT"}
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
			head="Crimson Mask", -- Head Wind II - Baghere Salade
			neck="Sanctity Necklace", --
			ear1="Infused Earring", -- 
			ear2="Ethereal Earring", --
			body="Ares' Cuirass +1", -- 
			hands="Ogier's Gauntlets", --
			ring1="Paguroidea Ring", --
			ring2="Sheltered Ring", --
			back="Archon Cape", --
			waist="Fucho-no-Obi", --
			legs="Carmine Cuisses", --
			feet="Ogier's Leggings"} -- 
			
	sets.Idle.Regen.Ochain = set_combine(sets.Idle.Regen,{
			main="Burtgang",
			sub="Ochain"})
	sets.Idle.Regen.Aegis = set_combine(sets.Idle.Regen,{
			main="Burtgang",
			sub="Aegis"})
	sets.Idle.Regen.Priwen = set_combine(sets.Idle.Regen,{
			main="Burtgang",
			sub="Priwen"})
	sets.Idle.Movement = set_combine(sets.Idle.Regen,{legs="Carmine Cuisses"})
	sets.Idle.Movement.Ochain = set_combine(sets.Idle.Movement,{
			main="Burtgang",
			sub="Ochain"})
	sets.Idle.Movement.Aegis = set_combine(sets.Idle.Movement,{
			main="Burtgang",
			sub="Aegis"})
	sets.Idle.Movement.Priwen = set_combine(sets.Idle.Movement,{
			main="Burtgang",
			sub="Priwen"})
	sets.Idle.Refresh = set_combine(sets.Idle.Regen,{
			head="Baghere Salade",
			body="Ares' Cuirass +1",
			hands="Ogier's Gauntlets",
			feet="Ogier's Leggings"})
	sets.Idle.Refresh.Ochain = set_combine(sets.Idle.Refresh,{
			main="Burtgang",
			sub="Ochain"})
	sets.Idle.Refresh.Aegis = set_combine(sets.Idle.Refresh,{
			main="Burtgang",
			sub="Aegis"})
	sets.Idle.Refresh.Priwen = set_combine(sets.Idle.Refresh,{
			main="Burtgang",
			sub="Priwen"})
	sets.Idle.Hybrid = set_combine(sets.Idle.Regen,{
			--neck="Coatl Gorget +1",
			ring2="Sheltered Ring",
			--back="Shadow Mantle",
			legs="Carmine Cuisses"})
	sets.Town = set_combine(sets.Idle.Hybrid,{
			head="Souveran Schaller",
			body="Souveran cuirass",
			hands="Souveran Handschuhs",
			ring2="Defending Ring",
			ring1="Vocane Ring",
			feet="Souveran Schuhs"})

	sets.Resting = set_combine(sets.Idle.Regen)

	sets.Twilight = {head="Twilight Helm",body="Twilight Mail"}
	
	
			
	-- TP Base Set --
	sets.TP = {}

	sets.TP.Base = {
			ammo="Vanir Battery",
			head="Otomi Helm",
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
	
	sets.DT = {}
	sets.DT.Base = {
			ammo="Vanir Battery",
			head="Chev. Armet +1",						--  6 PDT --
			neck="Loricate Torque +1",		--  6 DT --
			ear1="Thureous Earring",
			ear2="Ethereal Earring",
			body="Souveran Cuirass",		--  9 DT --
			hands="Sulev. Gauntlets +1",	--  4 DT --
			ring1="Vocane Ring", 			--  7 DT --
			ring2="Defending Ring", 		-- 10 DT --
			back="Rudianos's Mantle",					
			waist="Nierenschutz",			--  3 DT --
			legs="Souveran Diechlings +1",	--  4 DT --
			feet="Reverence Leggings +3"}		 		
											-----------
											-- 48 DT --
	
	
	sets.MDT = {}
	sets.MDT.Base = set_combine(sets.DT.Base,{
			head="Founder's corona", 		-- 2 MDB --					-- 4 MDT --
			neck="Warder's charm +1",  
			ear1="Etiolation Earring", 									-- 3 MDT --
			hands="Souveran Handschuhs", 	-- 1 MDB -- 				-- 4 MDT --
			back="Engulfer cape +1", 									-- 4 MDT --
			waist="Windbuffet belt +1", 							
			})
			
								-- Total -37% DT + -15% MDT = -52%/50% Reduction / +16 MDB --
								-- Primary ACC 961
	
	
	sets.PDT = {}
	sets.PDT.Base = set_combine(sets.TP.Base,{
			head="Chev. Armet +1",										-- conv 6%
			hands="Founder's Gauntlets",				-- 5 PDT --
			waist="Flume Belt",							-- 4 PDT --		-- conv 2%
			back="Rudianos's Mantle",									-- conv 5%
			
			})
									-- Total -39% DT/-12% PDT  = -51%/50% Reduction --
									-- Primary ACC 954 / Defense 1105 / 24% Haste-- 
	
	sets.BaseDT = {
			ammo="Vanir Battery",
			head="Chev. Armet +1",											--  6 convert phys --  MDB 2 -- M.eva 53
			neck="Loricate Torque +1",		--  6 DT --
			ear1="Thureous Earring",										--  successful block +2 --
			ear2="Ethereal Earring",										--  3 convert damage --
			body="Souveran Cuirass",		--  9 DT --						-- MDB 4 -- M.eva 69
			hands="Sulev. Gauntlets +1",	--  4 DT --						-- M.eva 
			ring1="Vocane Ring", 			--  7 DT --
			ring2="Defending Ring", 		-- 10 DT --
			back="Rudianos's Mantle",										-- 5 convert phys, successful block +3 --
			waist="Flume Belt",								-- 4 PDT --		-- 2 convert damage
			legs="Souveran Diechlings +1",	--  4 DT --
			feet="Reverence Leggings +3"}									-- 10 convert dt --	 		
											-----------
			-- 40 DT --	-- 4 PDT -- -- 15% DT to MP -- -- 11% PDT to MP -- -- 5 Successful Block --
	
	sets.MDT.Ochain =  set_combine(sets.MDT.Base,{sub="Ochain"})
	sets.MDT.Aegis = set_combine(sets.MDT.Base,{sub="Aegis"})								
	sets.MDT.Priwen = set_combine(sets.MDT.Base,{sub="Priwen"})
	sets.PDT.Ochain = set_combine(sets.PDT.Base,{sub="Ochain"})
	sets.PDT.Aegis = set_combine(sets.PDT.Base,{sub="Aegis"})
	sets.PDT.Priwen = set_combine(sets.PDT.Base,{sub="Priwen"})
	sets.DT.Ochain =  set_combine(sets.DT.Base,{sub="Ochain"})
	sets.DT.Aegis = set_combine(sets.DT.Base,{sub="Aegis"})								
	sets.DT.Priwen = set_combine(sets.DT.Base,{sub="Priwen"})

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
			ring2="Rajas ring",
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
			neck="Warder's Charm +1", -- +1~8 --
			-- ear1="Trux Earring",
			ear2="Cryptic Earring", -- 4 --
			body="Souveran Cuirass", -- 14 --
			hands="Macabre Gaunt. +1", -- 7 --
			ring1="Apeile Ring", -- 5~9 --
			ring2="Apeile Ring +1", -- 5~9 --
			back="Rudianos's Mantle", -- 10 --
			waist="Creed Baudrier", -- 5 --
			legs="Odyssean Cuisses", -- 5 --
			feet="Chev. Sabatons +1"} -- 11 --
									-- Total Enmity+ = 94~114 --

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
			ammo="Impatiens", -- 2% q
			head="Carmine Mask", -- 12% fc
			neck="Voltsurge Torque", -- 4% fc
			ear1="Etiolation Earring", -- 1% fc
			ear2="Loquac. Earring", -- 2% fc
			body="Odyssean Chestplate", -- 8% fc
			hands="Leyline Gloves", -- 7% fc
			ring1="Prolix Ring", -- 2% fc
			ring2="Veneficium Ring", -- 1% q
			-- back="Repulse Mantle",
			waist="Rumination sash",
			-- legs="Enif Cosciales",
			feet="Odyssean Greaves"} -- 5% fc
			-- 41% fc / 3% q
			
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
			neck="Jokushu Chain", 			-- 10 Skill 
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
			legs="Souveran Diechlings",})	-- 17

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
			head="Souveran Schaller", -- 125+80
			neck="Bloodbead Gorget", -- 60
			ear1="Odnowa Earring +1", -- 100
			ear2="Etiolation Earring", -- 50
			body="Rev. Surcoat +1", -- 163
			hands="Cab. Gauntlets +1", -- 104
			ring1="Praan Ring", -- 60
			ring2="Meridian Ring", -- 90
			back="Xucau Mantle", -- 100
			waist="Creed Baudrier", -- 40
			legs="Souveran Diechlings",-- 57+80
			feet="Souveran Schuhs"} -- 72+50
							-- +1231HP
			
	-- Organizer Items --
	organizer_items = {
		head={name="Yorium Barbuta",augments={"Phalanx+2"}},
		legs={name="Yorium Cuisses",augments={"Dbl. Atk.+2","Phalanx+2"}}}
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
	elseif Armor == 'DT' then
		equip(sets.DT[ShieldArray[ShieldIndex]])
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
		equipSet = sets.Idle
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
send_command('bind f11 gs c C18') --DT/PDT/MDT/None--
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