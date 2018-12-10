------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal', 'ACC')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')

	send_command('bind !p gs c auto_action')
	send_command('bind ![ gs c auto_trust')
	send_command('bind !o gs c cure')
	send_command('bind @home gs c cycle AutoWS')
	
    gear.default.obi_waist = "Sekhmet Corset"
 
	select_default_macro_book()
	send_command('wait 7; input /lockstyleset 18;wait 5;input /displayhead on')
end

function file_unload()
    if binds_on_unload then
        binds_on_unload()
    end

	send_command('unbind !p')
	send_command('unbind ![')
	send_command('unbind !o')
	send_command('unbind @home')
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
		cprring="Capacity Ring",
		}
	
	
	sets.precast.FC = { --caps at 80% // @FC 43%, QC 10%
		head="Haruspex hat",				--	 8%
		ammo="Impatiens",					-- 			2%
		neck="Voltsurge Torque",			--	 4%
		lear="Etiolation earring",			--	 1%
		rear="Loquacious Earring",			--	 2%
		lring="Veneficium Ring",			--			1%
		rring="Kishar Ring",				--	 4%
		body="Zendik Robe",					--	13%
		hands={ name="Fanatic Gloves", augments={'MP+5','"Fast Cast"+7',}},	--	 7%
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
		body="Piety Briault +3",--Potency +36%
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
		lear="Nourishing earring +1", 				--Time - 4%
		rear="Mendicant's earring",					--Time - 5%
		head="Piety Cap +1",						--time -13%
		--legs="Chironic hose",--time -8% // Kaykaus got FC6% + Time -5%
		feet="Hygieia Clogs",						--time -17%
		back="Pahtli cape"							--time - 8%
		})

	sets.precast.FC.CureSolace = sets.precast.FC.Cure
		
	sets.precast.FC.Curaga = sets.precast.FC.Cure
	
	-- Precast sets to enhance JAs
	sets.precast.JA.Benediction = {body="Piety Briault +3"}
	
	
	---------------------------------------
	--- 		Midcast Sets			---
	---------------------------------------
	sets.midcast.FastRecast = set_combine(sets.precast.FC,{
		--waist="Ninurta's sash"
		})
	
	-- Cure sets
	sets.midcast.CureSolace = { --when afflatus solace is on --I 61%, II 7%
		main="Chatoyant Staff",						-- 			I 10%	Skill +15
		--sub="Sors Shield",	
		head="Ebers Cap +1",						--			I 16%
		--neck="Incanter's torque",					--					Skill +10
		lear="Nourishing earring +1",				--			I  6%
		rear="Glorious Earring",					-- II 2%
		body="Ebers Bliaud +1",						-- II 3%	I  5%
		hands="Telchine gloves",					--			I 10%
		lring="Ephedra Ring",						--					Skill + 7
		rring="Ephedra Ring",						--					Skill + 7
		legs="Ebers Pantaloons +1",													--6% Cure Amount returned to MP
		--feet="Vanya Clogs",		--			I  5%	Skill +40
		waist="Fucho-no-Obi",
		feet="Piety duckbills +1",
		back="Alaunus's cape",														--Solace+10
		--body="Ebers Bliaud +1",--solace 14
		--feet="Hygieia clogs",--Conserve MP
		--back="Moonbeam Cape",--7%
		}

	sets.midcast.Cure = set_combine(sets.midcast.CureSolace,{}) --{body="Kaykaus Bliaut",})
	sets.midcast.Curaga = set_combine(sets.midcast.CureSolace,{}) --{body="Kaykaus Bliaut",}) --removed for the moment as I don't use curaga enough

	sets.midcast.CureMelee = set_combine(sets.midcast.CureSolace,{--currently 51% + 5% II
		--head="Vanya Hood",--17%
		head="Ebers Cap +1",
		--neck="Incanter's torque",--skill+10
		lear="Glorious Earring",
		rear="Nourishing earring +1",--II 2%, I 6%
		--body="Ebers Bliaud +1",--solace 14
		body="Kaykaus Bliaut",--II 3%
		hands="Telchine gloves",--10%
		lring="Ephedra Ring",
		rring="Ephedra Ring",--lolSkill
		back="Moonbeam Cape",--7%
		legs="Ebers Pantaloons +1",--6% Cure Amount returned to MP
		--feet="Vanya Clogs",--5%
		feet="Piety duckbills +1",
		})
	
	sets.midcast.Cursna = { --this should be cursna and healing magic skill, skill 576
		--main="Yagrush",
		sub="Culminus",
		head="Ebers Cap +1",--divine veil+22%,skill+24
		--neck="Incanter's torque",--skill+10
		body="Ebers Bliaud +1",--skill+24
		hands={ name="Fanatic Gloves", augments={'MP+35','Healing magic skill +10',}},--Cursna+15
		lring="Ephedra Ring",
		rring="Ephedra Ring",--Cursna +10% ea.
		--back="Mending Cape",--Cursna +15%
		back="Alaunus's Cape",--Cursna +25
		legs="Theophany Pantaloons +1",-- Cursna +15
		--feet="Vanya clogs"--Skill +40
		}

	sets.midcast.StatusRemoval = {
		--main="Yagrush",
		--neck="Incanter's torque",
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
		--neck="Incanter's Torque", -- skill 10 / mp deplete
		body="Telchine chasuble", --skill 12
		--hands="Dynasty Mitts", --skill 18 / duration 5
		hands="Telchine gloves",
		--back="Mending Cape", --skill 1
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
		--neck="Incanter's Torque", 
		})

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
		--hands="Dynasty Mitts",
		waist="Siegel Sash",})

	sets.midcast.Auspice = set_combine(sets.midcast.EnhDuration,{
		feet="Ebers Duckbills +1"})

	sets.midcast.Haste = set_combine(sets.midcast.EnhDuration,{
		--waist="Ninurta's sash",
		})
	
	sets.midcast.refresh = set_combine(sets.midcast.EnhDuration,{--should I ever be /RDM
		waist="Gishdubar sash",
		--feet="Inspirited boots",
		})

	sets.midcast.Regen = set_combine(sets.midcast.EnhDuration,{--Regen effect + conserver MP. I prefer duration over effect though.
		main="Bolelabunga",sub="Culminus",--Regen Potency +10%
		head="Inyanga Tiara +2",--Potency 12%
		body="Piety Briault +3",--Potency +52%
		hands="Ebers Mitts +1",--Duration +22 (beats anything)
		legs="Theophany Pantaloons +1",--18 seconds extra.
		--feet="Telchine Pigaches",--potency +2
		})

	sets.midcast.Protectra = set_combine(sets.midcast.EnhDuration,{lring="Sheltered Ring",feet="Piety duckbills +1"})
	sets.midcast.Shellra = set_combine(sets.midcast.EnhDuration,{lring="Sheltered Ring",legs="Piety Pantaloons +1"})
	
	
	---------------------------------------
	--			MATT / ENFEEB			---
	---------------------------------------
	-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	sets.buff['Divine Caress'] = {
		hands="Ebers Mitts +1",
		--back="Mending Cape"
		}
	
	sets.midcast.MAB = { --ugh. Do we need it? @219 MAB
		main="Gada",
		sub="Culminus",
		ammo="Pemphredo tathlum",
		head="Befouled Crown",
		--body={ name="Chironic Doublet", augments={'Mag. Acc.+16 "Mag.Atk.Bns."+16','"Cure" potency +1%','CHR+4','Mag. Acc.+15','"Mag.Atk.Bns."+1',}},
		--hands={ name="Chironic Gloves", augments={'Mag. Acc.+27','Sklchn.dmg.+1%','Accuracy+20 Attack+20','Mag. Acc.+7 "Mag.Atk.Bns."+7',}},
		--legs={ name="Chironic Hose", augments={'Mag. Acc.+25','"Cure" spellcasting time -8%','CHR+6','"Mag.Atk.Bns."+2',}},
		--feet={ name="Chironic Slippers", augments={'"Mag.Atk.Bns."+23','"Store TP"+2','"Refresh"+1',}},
		neck="Saevus Pendant +1",
		--waist="Refoccilation Stone",
		lear="Friomisi Earring",
		rear="Hecate's Earring",
		lring="Strendu Ring",
		--rring="Adoulin Ring",
		--back="Izdubar Mantle",
		}
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast.MAB,{})

	sets.midcast['Dark Magic'] = set_combine(sets.midcast.MAB,{
		head="Pixie hairpin +1",
		--lring="Archon Ring",
		})
	
	sets.midcast.MACC = { --Since I don't want to enfeeble in MAB gear
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		rear="Digni. Earring",
		lring="Perception Ring",
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
		lear="Etiolation earring",rear="Infused Earring",--Regen/DT
		body="Piety Briault +3",--Refresh
		hands="Serpentes Cuffs",--{ name="Chironic Gloves", augments={'Spell interruption rate down -1%','Pet: Mag. Acc.+22','"Refresh"+2',}},--Refresh
		lring="Defending Ring",rring="Vocane Ring",--PDT/MDT/DT
		back="Moonbeam Cape",--Annuls DT
		--waist="Ninurta's sash",--interruption rate down. PDT/MDT would be better
		legs="Assiduity Pants +1",--refresh 1-2
		--feet={ name="Chironic Slippers", augments={'"Mag.Atk.Bns."+23','"Store TP"+2','"Refresh"+1',}},--refresh +1
		}

	sets.idle.PDT = set_combine(sets.idle,{ --34% DT, 25% PDT, 17% MDT --- 50% PDT, 50% MDT ++ 30%MDT ShellV
		main="Mafic Cudgel",
		sub="Genmei Shield",
		head="Inyanga Tiara +2",
		body="Inyanga Jubbah +2",
		hands="Inyan. Dastanas +2",
		--legs="Aya. Cosciales +1",
		feet="Aya. Gambieras +2",
		neck="Loricate Torque +1",
		--waist="Ninurta's Sash",
		lear="Etiolation Earring",
		--rear="Genmei Earring",
		lring="Defending Ring",
		rring="Vocane Ring",
		back="Moonbeam Cape",})
	
	sets.idle.Weak = set_combine(sets.idle.PDT,{})
	sets.latent_refresh = {waist="Fucho-no-obi"}
	
	-- Resting sets
	sets.resting = set_combine(sets.idle,{}) --haven't rested as WHM in a long long time, let's use the refresh set
	
	-- Defense sets
	sets.defense.PDT = set_combine(sets.idle.PDT,{
		main="Mafic Cudgel",
		sub="Genmei Shield",
		ammo="Homiliary",
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2",
		neck="Loricate Torque +1",
		--waist="Ninurta's Sash",
		lear="Etiolation Earring",
		--rear="Genmei Earring",
		lring="Defending Ring",
		rring="Vocane Ring",
		back="Moonbeam Cape",})
	sets.defense.MDT = set_combine(sets.defense.PDT,{
		head="Inyanga Tiara +2",
		body="Inyanga Jubbah +2",
		hands="Inyan. Dastanas +2",
		lear="Etiolation Earring",})
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
		ammo="Amar Cluster",
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2",
		neck="Sanctity Necklace",
		waist="Windbuffet Belt +1",
		lear="Digni. Earring",
		rear="Brutal Earring",
		lring="Hetairoi Ring",
		rring="Petrov Ring",
		--back="Kayapa Cape",	
		}
	
	sets.engaged.ACC = set_combine(sets.engaged,{ --ca 1050 acc
		ammo="Amar Cluster",
		head="Aya. Zucchetto +2",
		--body="Ayanmo Corazza +1",
		hands="Aya. Manopolas +2",
		--legs="Aya. Cosciales +1",
		feet="Aya. Gambieras +2",
		neck="Sanctity Necklace",
		waist="Windbuffet Belt +1",
		lear="Digni. Earring",
		rear="Brutal Earring",
		--lring="Chirich Ring",
		--rring="Chirich Ring",
		--back="Kayapa Cape",
		})
	
	-- Weaponskill sets

	-- Default set for any weaponskill that isn't any more specifically defined
	gear.default.weaponskill_neck = "Fotia Gorget"
	gear.default.weaponskill_waist = "Fotia Belt"
	sets.precast.WS = set_combine(sets.engaged.ACC,{
		neck="Fotia Gorget",
		lring="Petrov Ring",
		rring="Apate Ring",
		waist="Fotia Belt",
		})
	
	sets.precast.WS['Flash Nova'] = set_combine(sets.midcast.MAB,{}) --that way I only have to manage one set
end