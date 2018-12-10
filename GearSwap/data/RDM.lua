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
    state.Buff.Saboteur = buffactive.saboteur or false
end
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.HybridMode:options('Normal', 'PhysicalDef', 'MagicalDef')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'MDT')
	state.MagicBurst = M{['description']='MB', 'off', 'tmp', 'Perma'}
	state.EnSpells = M{['description']='EnSpells', "Enfire II", "Enblizzard II", "Enaero II", "Enstone II", "Enthunder II", "Enwater II"}
	state.AutoWS = M{['description']='Auto WS', 'Requiescat', 'Chant du Cygne', 'Savage Blade', 'Knights of Round'}
	
	send_command('bind !home gs c cycle MagicBurst')
	
	send_command('bind ^` input //gs c enspell')
	send_command('bind != gs c cycleback EnSpells')
	send_command('bind ^= gs c cycle EnSpells')
	
	send_command('bind !q input /ma "Temper II" <me>')
	send_command('bind !w input /ma "Phalanx" <me>')
	send_command('bind !p gs c auto_action')
	send_command('bind ![ gs c auto_trust')
	send_command('bind !o gs c cure')
	send_command('bind @home gs c cycle AutoWS')
	
    gear.default.obi_waist = "Sekhmet Corset"
 
    select_default_macro_book()
end

function file_unload()
    if binds_on_unload then
        binds_on_unload()
    end

	send_command('unbind !`')
	
	send_command('unbind ^`')
	send_command('unbind ^-')
	send_command('unbind ^=')
	send_command('unbind !q')
	send_command('unbind !w')
	send_command('unbind !o')
	send_command('unbind @home')
end
 
-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
 
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = {body="Vitivation Tabard +1"}
 
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
 
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
 
    -- Fast cast sets for spells
 
    -- 81%/80% Fast Cast (including trait) for all spells, plus 10% quick cast in separate set, triggered for non-elemental spells
    -- No other FC sets necessary.
    sets.precast.FC = {	--30 from trait
		head={ name="Amalric Coif", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},												--10
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+22','"Fast Cast"+4','INT+1',}},													--10
		hands={ name="Merlinic Dastanas", augments={'"Fast Cast"+6','CHR+2','Mag. Acc.+11','"Mag.Atk.Bns."+12',}},							-- 6
		legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},													-- 7
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+25','"Fast Cast"+5','"Mag.Atk.Bns."+9',}},									--10
		neck="Voltsurge Torque",																											-- 4
		left_ear="Loquac. Earring",																											-- 2
		left_ring="Prolix Ring",																											-- 2
		}
	
	sets.precast.FC.quickcast = set_combine(sets.precast.FC, {
		ammo="Impatiens",				--2
		back="Perimede cape",			--4
		waist="Witful belt",			--3
		right_ring="Lebeche Ring",		--2
	})
    
	sets.precast.FC.Impact = set_combine(sets.precast.FC.quickcast, {head=empty,body="Twilight Cloak"})
 
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
	
	sets.precast.WS = {
		ammo="Yetshila",
		head={ name="Carmine Mask", augments={'Accuracy+15','Mag. Acc.+10','"Fast Cast"+3',}},
		body="Ayanmo Corazza +1",
		hands="Jhakri Cuffs +1",
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet="Thereoid Greaves",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +25',}},
		right_ear="Sherida Earring",
		left_ring="Begrudging Ring",
		right_ring="Ilabrat Ring",
		back="Bleating Mantle",
		}
	
	sets.precast.WS.physical = set_combine(sets.precast.WS, {})
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		ammo="Yetshila",
		head="Despair Helm",
		body="Jhakri Robe +1",
		hands="Jhakri Cuffs +1",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +1",
		neck="Asperity Necklace",
		waist="Kentarch Belt +1",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +25',}},
		right_ear="Ishvara Earring",
		left_ring="Rufescent Ring",
		right_ring="Ilabrat Ring",
		back="Bleating Mantle",
	})
 
	sets.precast.WS.magical = set_combine(sets.precast.WS,{
		ammo="Pemphredo Tathlum",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic Damage +13','INT+6','Mag. Acc.+13','"Mag.Atk.Bns."+8',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic burst mdg.+8%','CHR+2','Mag. Acc.+7','"Mag.Atk.Bns."+9',}},
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Enmity-6','Mag. Acc.+15','"Mag.Atk.Bns."+5',}},
		--feet={ name="Merlinic Crackows", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+8%','INT+5','Mag. Acc.+8',}},
		feet="Jhakri pigaches +1",
		--neck="Saevus pendant +1",
		neck="Sanctity Necklace",
		waist="Refoccilation Stone",
		ear1="Hecate's Earring",
		ear2="Friomisi Earring",
		ring1="Adoulin Ring",
		ring2="Strendu Ring",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
	})
 
 
    sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS.magical, {})
	
	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS.magical, {})
 
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS.physical, {})     
 
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS.physical, {})
 
    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS.physical, {})
 
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS.physical, {})
         
    sets.precast.WS['Death Blossom'] = set_combine(sets.precast.WS, {})
 
    -- Midcast Sets
 
    sets.midcast.Cure = {
		main={ name="Grioavolr", augments={'Spell interruption rate down -2%','MP+94','Mag. Acc.+22','"Mag.Atk.Bns."+28','Magic Damage +3',}},
		sub="Clerisy Strap",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body={ name="Kaykaus Bliaut", augments={'MP+60','"Cure" potency +5%','"Conserve MP"+6',}},
		hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +8',}},
		legs={ name="Vanya Slops", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		neck="Incanter's Torque",
		waist="Gishdubar Sash",
		left_ring="Ephedra Ring",
		right_ring="Lebeche Ring",
		back="Moonbeam Cape",
		}
 
    sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.CureSelf = {}
 
    sets.midcast['Enhancing Magic'] = { --540
       sub="Ammurapi Shield",
		ammo="Staunch Tathlum",
		head="Befouled Crown",			-- 16
        body="Telchine Chas.",			-- 12
		--body="Vitivation tabard +1",	-- 19
		--hands="Viti. Gloves +1",		-- 20
		hands="Atrophy Gloves +3",
		legs="Atrophy Tights +1",		-- 17 // +21 as +3
		feet="Lethargy Houseaux +1",	-- 25
		neck="Incanter's Torque",		-- 10
		waist="Olympus Sash",			-- 05
		ear1="Andoaa earring",			-- 05 skill
		--ear2="Augmenting earring", 	-- 03 skill
		left_ring="Stikini Ring",		-- 05
		right_ring="Stikini Ring",		-- 05
		back="Ghostfyre cape",			-- 07
		}
 
    sets.midcast['Enhancing Magic'].EnSpells = set_combine(sets.midcast['Enhancing Magic'],{
		--ear2="Hollow Earring",
		hands="Vitivation Gloves +1",
		})
 
    sets.midcast['Enhancing Magic'].GainSpells = set_combine(sets.midcast['Enhancing Magic'],{
		hands="Vitivation Gloves +1",
		})
 
    sets.midcast.EnhancingDuration = set_combine(sets.midcast['Enhancing Magic'],{	-- 507 skil // 100% duration
		main={ name="Colada", augments={'Enh. Mag. eff. dur. +3','Mag. Acc.+5','"Mag.Atk.Bns."+19','DMG:+6',}},
		sub="Ammurapi shield",			--10%
		head="Telchine Cap", 			--10
		body="Telchine Chas.",			--10
		hands="Atrophy Gloves +3",		--16
		legs="Telchine Braconi",		--10
		feet="Lethargy Houseaux +1",	--30
		back="Ghostfyre cape",			--18
		})
		
	sets.midcast.Haste = set_combine(sets.midcast.EnhancingDuration,{})
	sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration,{})
 
    sets.buff.ComposureOther = {
		--head="Leth. Chappel +1",
		body="Lethargy Sayon +1",
		--hands="Leth. Gantherots +1",
		--legs="Lethargy Fuseau +1",
		feet="Lethargy Houseaux +1",
		}
 
    sets.midcast.Protect = {ring2="Sheltered Ring"}
    sets.midcast.Shell = sets.midcast.Protect 
    sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'],{})--main="Egeking"})
 
    sets.midcast.Cursna = {
		--neck="Malison medallion",
		--back="Oretania's cape +1",
		ring1="Ephedra ring",
		ring2="Ephedra ring",
		feet="Vanya clogs",
		}
 
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'],{
		--neck="Stone gorget",
		waist="Siegel Sash",
		})
 
    sets.midcast['Enfeebling Magic'] = {
		--head="Carmine Mask", 		-- enfeebling +10, macc +38
		--body="Atrophy Tabard +1", -- enfeebling +17
		--hands="Lethargy gantherots +1", -- enfeebling +19
		--waist="Rumination Sash",
		--legs="Lethargy fuseau +1",
		--feet="Vitivation boots +1",
		main={ name="Grioavolr", augments={'Spell interruption rate down -2%','MP+94','Mag. Acc.+22','"Mag.Atk.Bns."+28','Magic Damage +3',}},
		sub="Enki Strap",
		ammo="Regal Gem",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic Damage +13','INT+6','Mag. Acc.+13','"Mag.Atk.Bns."+8',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic burst dmg.+8%','CHR+2','Mag. Acc.+7','"Mag.Atk.Bns."+9',}},
		hands="Jhakri Cuffs +1",
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Enmity-6','Mag. Acc.+15','"Mag.Atk.Bns."+5',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+8%','INT+5','Mag. Acc.+8',}},
		neck="Incanter's Torque",
		waist="Eschan Stone",
		left_ear="Digni. Earring",
		right_ear="Regal Earring",
		left_ring="Stikini Ring",
		right_ring="Stikini Ring",
		back="Altruistic Cape",
		}
 
    sets.midcast.Distract = set_combine(sets.midcast['Enfeebling Magic'], {})
 
    sets.midcast.Frazzle = set_combine(sets.midcast['Enfeebling Magic'], {})
 
    sets.midcast['Dia III'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Vitivation Chapeau +2"})
 
    sets.midcast['Slow II'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Vitivation Chapeau +2"})
 
    sets.midcast['Elemental Magic'] = {
		main={ name="Grioavolr", augments={'Spell interruption rate down -2%','MP+94','Mag. Acc.+22','"Mag.Atk.Bns."+28','Magic Damage +3',}},
		sub="Niobid Strap",
		ammo="Pemphredo Tathlum",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic Damage +13','INT+6','Mag. Acc.+13','"Mag.Atk.Bns."+8',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic burst mdg.+8%','CHR+2','Mag. Acc.+7','"Mag.Atk.Bns."+9',}},
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Enmity-6','Mag. Acc.+15','"Mag.Atk.Bns."+5',}},
		--feet={ name="Merlinic Crackows", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+8%','INT+5','Mag. Acc.+8',}},
		feet="Jhakri pigaches +1",
		--neck="Saevus pendant +1",
		neck="Sanctity Necklace",
		waist="Refoccilation Stone",
		ear1="Hecate's Earring",
		ear2="Regal Earring",
		ring1="Shiva Ring +1",
		ring2="Shiva Ring +1",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
		}

 
    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})
	
	sets.midcast.Burst = set_combine(sets.midcast['Elemental Magic'], {
		head={ name="Merlinic Hood", augments={'Mag. Acc.+28','Magic burst mdg.+11%',}},--11%
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic burst mdg.+8%','CHR+2','Mag. Acc.+7','"Mag.Atk.Bns."+9',}},--8%
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},--5% II
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+8%','INT+5','Mag. Acc.+8',}},--8%
		neck="Mizu. Kubikazari",--10%
		--ear2="Static Earring",--5%
		--ring1="Locus Ring",--5%
		ring2="Mujin Band",--5% II
		back="Seshaw Cape",	--5%
		})
		
 
    sets.midcast.Drain = {
		head="Pixie Hairpin +1",
		ring1="Evanescence Ring",
		waist="Fucho-no-Obi",
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+8%','INT+5','Mag. Acc.+8',}},
		}
 
    sets.midcast.Aspir = sets.midcast.Drain
 
    sets.midcast['Stun'] = {
		main={ name="Grioavolr", augments={'Spell interruption rate down -2%','MP+94','Mag. Acc.+22','"Mag.Atk.Bns."+28','Magic Damage +3',}},
		sub="Clerisy Strap",
		ammo="Pemphredo Tathlum",
		head={ name="Amalric Coif", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		body="Anhur Robe",
		hands={ name="Merlinic Dastanas", augments={'"Fast Cast"+6','CHR+2','Mag. Acc.+11','"Mag.Atk.Bns."+12',}},
		legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+25','"Fast Cast"+5','"Mag.Atk.Bns."+9',}},
		neck="Voltsurge Torque",
		waist="Witful Belt",
		left_ear="Loquac. Earring",
		right_ear="Etiolation Earring",
		left_ring="Prolix Ring",
		right_ring="Lebeche Ring",
        back="Sucellos's Cape",																										-- 20
		}

    -- Sets to return to when not performing an action.
 
    -- Resting sets
    sets.resting = {}
 
    -- Idle sets
	sets.idle = {
		main="Bolelabunga",
		sub="Genmei Shield",
		ammo="Homiliary",
		head="Befouled Crown",
		--body="Jhakri Robe +1",
		body="Shamash Robe",
		hands={ name="Chironic Gloves", augments={'Spell interruption rate down -1%','Pet: Mag. Acc.+22','"Refresh"+2',}},
		legs={ name="Lengo Pants", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Refresh"+1',}},
		feet={ name="Chironic Slippers", augments={'"Mag.Atk.Bns."+23','"Store TP"+2','"Refresh"+1',}},
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Infused Earring",
		right_ear="Etiolation Earring",
		ring1="Vocane Ring",
		ring2="Defending Ring",
		back="Moonbeam Cape",
	}
 
    sets.idle.Town = set_combine(sets.idle, {
		main="Sequence",
		sub="Culminus",
		ammo="Staunch Tathlum",
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +1",
		hands="Aya. Manopolas +2",
		legs="Aya. Cosciales +1",
		feet="Aya. Gambieras +2",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Genmei Earring",
		right_ear="Etiolation Earring",
		left_ring="Vocane Ring",
		right_ring="Defending Ring",
		back="Moonbeam Cape",
	})
 
    sets.idle.Weak = sets.idle
	
    -- Defense sets
	sets.defense = {}
    sets.defense.PDT = set_combine(sets.idle, { --45% DT, 3% MDT, 6% PDT
		ammo="Staunch Tathlum",			--	02/02
		head="Aya. Zucchetto +2",		--	02/02
		body="Ayanmo Corazza +1",		--	05/05
		hands="Aya. Manopolas +2",		--	02/02
		legs="Aya. Cosciales +1",		--	04/04
		feet="Aya. Gambieras +2",		--	02/02
		neck="Loricate Torque +1",		--	06/06
		waist="Flume Belt +1",			--	00/04
		left_ear="Genmei Earring",		--	00/02
		right_ear="Etiolation Earring",	--	03/00
		left_ring="Vocane Ring",		--	07/07
		right_ring="Defending Ring",	--	10/10
		back="Moonbeam Cape",			--	05/05
		})
 
    sets.defense.MDT = set_combine(sets.defense.PDT, {})
 
    sets.Kiting = {legs="Carmine Cuisses +1"}
 
    sets.latent_refresh = {waist="Fucho-no-obi"}
 
    -- Engaged sets
 
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
 
    -- Normal melee group
    sets.engaged = {
		main="Sequence",
		sub="Thorfinn Shield +1",
		ammo="Ginsen",
		head={ name="Carmine Mask", augments={'Accuracy+15','Mag. Acc.+10','"Fast Cast"+3',}},
		body="Ayanmo Corazza +1",
		hands="Aya. Manopolas +2",
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet={ name="Carmine Greaves", augments={'Accuracy+10','DEX+10','MND+15',}},
		neck="Anu Torque",
		waist="Windbuffet Belt +1",
		left_ear="Suppanomimi",
		right_ear="Sherida Earring",
		left_ring="Hetairoi Ring",
		right_ring="Ilabrat Ring",
		back="Moonbeam Cape",
		}
 
    -- Sets for special buff conditions on spells.
 
    sets.buff.Saboteur = {hands="Lethargy Gantherots +1"}
end
  
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

	 

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_precast(spell, action, spellMap, eventArgs)
	if spell.skill ~= 'Elemental Magic' then
        equip(sets.precast.FC.quickcast)
    end
end


function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.skill == 'Elemental Magic' then		
		if state.MagicBurst.value == 'tmp' or state.MagicBurst.value == 'Perma' then
			equip(sets.midcast.Burst)
		else
			equip(sets.midcast['Elemental Magic'])
		end
	end
	if spell.skill == 'Enfeebling Magic' and state.Buff.Saboteur then
        equip(sets.buff.Saboteur)
    elseif spell.skill == 'Enhancing Magic' then
		if spell.english:startswith('Temper') then
			equip(sets.midcast['Enhancing Magic'])
		elseif spell.english:startswith('Refresh') then
			equip(sets.midcast.Refresh)
		else
			equip(sets.midcast.EnhancingDuration)
			if buffactive.composure and spell.target.type == 'PLAYER' then
				equip(sets.buff.ComposureOther)
			end
		end
    elseif spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureSelf)
	end
	if spell.element == world.day_element or spell.element == world.weather_element then
		equip({waist="Hachirin-No-Obi"})
	end
end
 
function job_aftercast(spell, action, spellMap, eventArgs)
	if spell.skill == 'Elemental Magic' and state.MagicBurst.value == 'tmp' then
		state.MagicBurst:reset()
	end
	if not spell.interrupted then
		if spell.english == 'Sleep' or spell.english == 'Sleepga' then
			send_command('@wait 50;input /echo ------- '..spell.english..' is wearing off in 10 seconds -------')
		elseif spell.english == 'Sleep II' or spell.english == 'Sleepga II' then
			send_command('@wait 80;input /echo ------- '..spell.english..' is wearing off in 10 seconds -------')
		elseif spell.english == 'Break' or spell.english == 'Breakga' then
			send_command('@wait 20;input /echo ------- '..spell.english..' is wearing off in 10 seconds -------')
		end
	end
	 
end	
 
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Enhancing Magic' then
            if spell.english:startswith('En') then
                return 'EnSpells'
            elseif spell.english:startswith('Gain') then
                return 'GainSpells'
            end
        elseif spellMap == 'Cure' and spell.target.type == 'SELF' then
            equip(sets.midcast.CureSelf)
        end
    end
end
  
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
  
-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'None' then
            enable('main','sub','range')
        else
            disable('main','sub','range')
        end
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

function job_self_command(cmdParams, eventArgs)
	if cmdParams[1]:lower() == 'enspell' then
		send_command('@input /ma '..state.EnSpells.value..' <me>')
	end
	
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
			if player.tp > 1001 and player.target.distance < 8 then --and player.target.hpp <80 then
				send_command('@input /ws "'..state.AutoWS.value..'" <t>')
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
			
			elseif not check_buffs('Composure')
					and not check_buffs('amnesia')
					and composureRecast < 1
					and check_recasts(s('Composure')) then
				send_command('@input /ja "Composure" <me>')
				
			elseif not check_buffs('Aquaveil')
					and check_recasts(s('Aquaveil')) then
				send_command('@input /ma "Aquaveil" <me>')

			elseif not buffactive[33] 
					and not check_buffs('Slow')
					and check_recasts(s('Haste II')) then
				send_command('@input /ma "Haste II" <me>')
				
			elseif not check_buffs('Refresh') 
					and check_recasts(s('Refresh III')) then
				send_command('@input /ma "Refresh III" <me>')
			
			elseif not check_buffs('Regen') 
					and check_recasts(s('Regen II')) then
				send_command('@input /ma "Regen II" <me>')
			
			elseif not check_buffs('Barsleep')
					and check_recasts(s('Barsleep')) then
				send_command('@input /ma "Barsleep" <me>')
			
			elseif not check_buffs('Phalanx') 
					and check_recasts(s('Phalanx')) then
				send_command('@input /ma "Phalanx" <me>')
			
			elseif not check_buffs('Shock Spikes') 
					and check_recasts(s('Shock Spikes')) then
				send_command('@input /ma "Shock Spikes" <me>')
			
			elseif player.sub_job == 'SCH' then
			
					if not check_buffs(358)
							and not check_buffs('amnesia')
							and not check_buffs(401)
							and check_recasts(s('Light Arts')) then
						send_command('@input /ja "Light Arts" <me>')
			
					elseif not check_buffs(401)
							and not check_buffs('amnesia')
							and check_buffs(358)
							and check_recasts(s('Addendum: White')) then
						send_command('@input /ja "Addendum: White" <me>')
						
					elseif not check_buffs('MND Boost')
							and check_buffs('Composure')
							and check_recasts(s('Gain-MND')) then
						send_command('@input /ma "Gain-MND" <me>')
				
					elseif not check_buffs('Klimaform')
							and check_recasts(s('Klimaform')) then
						send_command('@input /ma "Klimaform" <me>')
				
					elseif not check_buffs('Aurorastorm')
							and check_recasts(s('Aurorastorm')) then
						send_command('@input /ma "Aurorastorm" <me>')
					end
			
			--elseif player.sub_job == 'SCH' then
			--
			--		if not check_buffs(359)
			--				and not check_buffs('amnesia')
			--				and not check_buffs(402)
			--				and check_recasts(s('Dark Arts')) then
			--			send_command('@input /ja "Dark Arts" <me>')
			
			--		elseif not check_buffs(402)
			--				and not check_buffs('amnesia')
			--				and check_buffs(359)
			--				and check_recasts(s('Addendum: Black')) then
			--			send_command('@input /ja "Addendum: Black" <me>')
			--			
			--		elseif not check_buffs('INT Boost')
			--				and check_buffs('Composure')
			--				and check_recasts(s('Gain-INT')) then
			--			send_command('@input /ma "Gain-INT" <me>')
			--	
			--		elseif not check_buffs('Klimaform')
			--				and check_recasts(s('Klimaform')) then
			--			send_command('@input /ma "Klimaform" <me>')
			--	
			--		elseif not check_buffs('Voidstorm')
			--				and check_recasts(s('Voidstorm')) then
			--			send_command('@input /ma "Voidstorm" <me>')
			--		end
				
			elseif player.sub_job == 'WAR'
				or player.sub_job == 'NIN'
				or player.sub_job == 'SAM'
				or player.sub_job == 'DNC' then
					if not check_buffs('Protect')
							and check_recasts(s('Protect V')) then
						send_command('@input /ma "Protect V" <me>')
		--	
					elseif not check_buffs('Shell')
							and check_recasts(s('Shell V')) then
						send_command('@input /ma "Shell V" <me>')
			--		
					elseif not check_buffs('Multi Strikes')
							and check_recasts(s('Temper II')) then
						send_command('@input /ma "Temper II" <me>')
			
					elseif not check_buffs('Enfire')
							and check_recasts(s('Enfire')) then
						send_command('@input /ma "Enfire" <me>')
			
					elseif not check_buffs('DEX Boost')
							and check_buffs('Composure')
							and check_recasts(s('Gain-DEX')) then
						send_command('@input /ma "Gain-DEX" <me>')
						

					
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
			
			if  spell_recasts[955] == 0 and not have_trust("Apururu") then
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
    if player.sub_job == 'DNC' then
        set_macro_page(2, 4)
    elseif player.sub_job == 'NIN' then
        set_macro_page(3, 4)
    elseif player.sub_job == 'THF' then
        set_macro_page(4, 4)
    else
        set_macro_page(1, 4)
    end
end



