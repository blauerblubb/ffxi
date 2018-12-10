-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('organizer-lib')
	send_command('input ;wait 1;/localsettings hidearmor on')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
    state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false
	info.aftermath = {}
end


-- Define sets and vars used by this job file.
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
	
	
	sets.precast.FC = { --caps at 80% // @FC 47%, QC 10%
		--head="Haruspex hat",				--	 8%
		ammo="Impatiens",					-- 			2%
		neck="Voltsurge Torque",			--	 4%
		lear="Etiolation earring",			--	 1%
		rear="Loquacious Earring",			--	 2%
		lring="Veneficium Ring",				--			1%
		rring="Kishar Ring",				--	 4%
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
		lear="Nourishing earring +1",				--			I  6%
		rear="Glorious Earring",					-- II 2%
		body="Ebers Bliaut +1",						-- II 3%	I  5%
		hands="Telchine gloves",					--			I 10%
		lring="Ephedra Ring",						--					Skill + 7
		rring="Ephedra Ring",						--					Skill + 7
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
		lear="Glorious Earring",
		rear="Nourishing earring +1",--II 2%, I 6%
		--body="Ebers Bliaud +1",--solace 14
		body="Kaykaus Bliaut",--II 3%
		hands="Telchine gloves",--10%
		lring="Ephedra Ring",
		rring="Ephedra Ring",--lolSkill
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
		lring="Ephedra Ring",
		rring="Ephedra Ring",--Cursna +10% ea.
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

	sets.midcast.Protectra = set_combine(sets.midcast.EnhDuration,{lring="Sheltered Ring",feet="Piety duckbills +1"})
	sets.midcast.Shellra = set_combine(sets.midcast.EnhDuration,{lring="Sheltered Ring",legs="Piety Pantaloons +1"})
	
	
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
		lear="Friomisi Earring",
		rear="Hecate's Earring",
		lring="Strendu Ring",
		rring="Adoulin Ring",
		back="Izdubar Mantle",
		}
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast.MAB,{})

	sets.midcast['Dark Magic'] = set_combine(sets.midcast.MAB,{
		head="Pixie hairpin +1",
		lring="Archon Ring",
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
		body="Witching Robe",--Refresh
		hands={ name="Chironic Gloves", augments={'Spell interruption rate down -1%','Pet: Mag. Acc.+22','"Refresh"+2',}},--Refresh
		lring="Defending Ring",rring="Vocane Ring",--PDT/MDT/DT
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
		lear="Etiolation Earring",
		rear="Genmei Earring",
		lring="Defending Ring",
		rring="Vocane Ring",
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
		lear="Etiolation Earring",
		rear="Genmei Earring",
		lring="Defending Ring",
		rring="Vocane Ring",
		back="Solemnity Cape",})
	sets.defense.MDT = set_combine(sets.defense.PDT,{
		head="Inyanga Tiara +1",
		body="Inyanga Jubbah +1",
		hands="Inyan. Dastanas +1",
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
		head="Blistering Sallet",
		body="Ayanmo Corazza +1",
		hands="Aya. Manopolas +1",
		legs="Aya. Cosciales +1",
		feet="Aya. Gambieras +1",
		neck="Sanctity Necklace",
		waist="Windbuffet Belt +1",
		lear="Digni. Earring",
		rear="Brutal Earring",
		lring="Hetairoi Ring",
		rring="Petrov Ring",
		back="Kayapa Cape",	
		}
	
	sets.engaged.ACC = set_combine(sets.engaged,{ --ca 1050 acc
		ammo="Amar Cluster",
		head="Aya. Zucchetto +1",
		body="Ayanmo Corazza +1",
		hands="Aya. Manopolas +1",
		legs="Aya. Cosciales +1",
		feet="Aya. Gambieras +1",
		neck="Sanctity Necklace",
		waist="Windbuffet Belt +1",
		lear="Digni. Earring",
		rear="Brutal Earring",
		lring="Chirich Ring",
		rring="Chirich Ring",
		back="Kayapa Cape",
		})
	
	-- Weaponskill sets

	-- Default set for any weaponskill that isn't any more specifically defined
	gear.default.weaponskill_neck = "Fotia Gorget"
	gear.default.weaponskill_waist = "Fotia Belt"
	sets.precast.WS = set_combine(sets.engaged.ACC,{
		neck="Fotia Gorget",
		lring="Rajas Ring",rring="K\'ayres Ring",
		waist="Fotia Belt",
		})
	
	sets.precast.WS['Flash Nova'] = set_combine(sets.midcast.MAB,{}) --that way I only have to manage one set
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == "Paralyna" and buffactive.Paralyzed then
        -- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
        eventArgs.handled = true
    end
	if spell.type == 'WeaponSkill' then
		info.aftermath = {}
		info.aftermath.duration = 0
		
		info.aftermath.level = math.floor(player.tp / 1000)
        if info.aftermath.level == 0 then
            info.aftermath.level = 1
        end
		
		if spell.english == "Randgrith" then
			info.aftermath.weaponskill = spell.english
			
			info.aftermath.duration = math.floor(0.02 * player.tp)
			if info.aftermath.duration < 20 then
				info.aftermath.duration = 20
			end
		end
	end
end

waittime = 2.6
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pretarget(spell)
    if spell.action_type == 'Magic' then
        if aftercast_start and os.clock() - aftercast_start < waittime then
            rounded = tonumber(string.format("%." .. (2) .. "f", waittime - (os.clock() - aftercast_start)))
            windower.add_to_chat(8,"Precast too early! Adding Delay:"..rounded)
            cast_delay(waittime - (os.clock() - aftercast_start))
        end
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
    end
	if spell.english == 'Cure' and player.tp < 1000 then
		if info.aftermath.duration ~= nil and info.aftermath.duration > 15 then
			--equip({main="Dacnomania", head="Fallen's Burgeonet +1"})
		end
	end
end

function job_aftercast(spell, action, spellMap, eventArgs)
	if not spell.interrupted and spell.type == 'WeaponSkill' and info.aftermath and info.aftermath.weaponskill == spell.english and info.aftermath.duration > 0 then
		local aftermath_name = 'Aftermath: Lv.'..tostring(info.aftermath.level)
		send_command('timers d "Aftermath: Lv.1"')
		send_command('timers d "Aftermath: Lv.2"')
		send_command('timers d "Aftermath: Lv.3"')
		send_command('timers c "'..aftermath_name..'" '..tostring(info.aftermath.duration)..' down')

		info.aftermath = {}
	end
	aftercast_start = os.clock()
    if spell.action_type ~= 'Magic' then
      aftercast_start = nil
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
		    disable('main','sub','range')
		elseif newValue == "ACC" then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------



-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if (default_spell_map == 'Cure' or default_spell_map == 'Curaga') and player.status == 'Engaged' then
            return "CureMelee"
        elseif default_spell_map == 'Cure' and state.Buff['Afflatus Solace'] then
            return "CureSolace"
        elseif spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end


function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
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
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not areas.Cities:contains(world.area) then
        local needsArts = 
            player.sub_job:lower() == 'sch' and
            not buffactive['Light Arts'] and
            not buffactive['Addendum: White'] and
            not buffactive['Dark Arts'] and
            not buffactive['Addendum: Black']
            
        if not buffactive['Afflatus Solace'] and not buffactive['Afflatus Misery'] then
            if needsArts then
                send_command('@input /ja "Afflatus Solace" <me>;wait 1.2;input /ja "Light Arts" <me>;wait 1.2;input /ja "Addendum White" <me>')
            else
                send_command('@input /ja "Afflatus Solace" <me>')
            end
        end
    end
end

-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

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

function relaxed_play_mode_WS(cmdParams, eventArgs)
	if not midaction() then
		if not check_buffs('Sleep','petrification','Terror') then		
			if player.tp > 1249 and player.target.distance < 8 then
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
            
			elseif not buffactive['Afflatus Solace'] and not buffactive['Afflatus Misery'] then
				send_command('@input /ja "Afflatus Solace" <me>')			
				
			elseif not buffactive[39] 
					and check_recasts(s('Aquaveil')) then
				send_command('@input /ma "Aquaveil" <me>')

			elseif not buffactive[33] 
					and not check_buffs('Slow')
					and check_recasts(s('Haste')) then
				send_command('@input /ma "Haste" <me>')
			
			--elseif not buffactive[106]
			--		and check_recasts(s('Baramnesra')) then
			--	send_command('@input /ma "Baramnesra" <me>')
				
			--elseif not buffactive[100]
			--		and check_recasts(s('Baraera')) then
			--	send_command('@input /ma "Baraera" <me>')
				
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
				
				--	elseif not check_buffs('Klimaform')
				--			and check_recasts(s('Klimaform')) then
				--		send_command('@input /ma "Klimaform" <me>')
				
					elseif not check_buffs('Aurorastorm')
							and check_recasts(s('Aurorastorm')) then
						send_command('@input /ma "Aurorastorm" <me>')
						
					elseif not check_buffs(42)
						and check_recasts(s('Accession'))
						and check_recasts(s('Regen IV')) then
					send_command('@input /echo Regen in 3;input /echo Regen in 3;wait 1;input /echo Regen in 2;input /echo Regen in 2;wait 2;input /ja "Accession" <me>;wait 1.2;input /ja "Regen IV" <me>')
					
					end	
			end
		end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(4, 19)
end