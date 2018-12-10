--[[
	BLU Gearswap
	- Uses the Kinematic/Motenten as core
	
	Cure - Macro to automatically cast cure based on the spells set and sub job
	'/con gs c cure'
	
	Skillchains:
	'/gs con DarkSC' 	DarkSC + MB (SC with SinkerDrill Set, + MB if Spectral Floe has been set)
	'/gs con LightSC'	LightSC + MB (SC with Cannonball Set, + MB if Anvil Lightning has been set)

	Keybind:
	CTRL + `	= Chain Affinity
	ALT + ` 	= Efflux
	Win + ` 	= Burst Affinity
	`			= Diffusion + Mighty Guard
	pageup		= Enable Party notification for Requiescat and CDC. 
	pagedown	= Change CombatWeapon type between magic, dd and off. default is DD. Off does not reequip weapons automatically.

	Other:
	- When mode is DamageTaken and Blink or Utsusemi is up, the gear used is engaged / engaged.midacc (this is still in testing)
	- When attacking Apex mobs and the CP back is not equipped - the gearswap will do this automatically
	- Gear will lock on CP Back, Warp Ring, CP Ring
	
	Spells are up-to-date: October 2015 (Vagary)
]]--


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
	count_msg_mecisto = 0
	-- Load and initialize the include file.
	include('Mote-Include.lua')
	include('organizer-lib')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
    state.Buff.Convergence = buffactive.Convergence or false
    state.Buff.Diffusion = buffactive.Diffusion or false
    state.Buff.Efflux = buffactive.Efflux or false
	
    state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false
	state.Buff.Blink = buffactive.Blink or false
	
    blue_magic_maps = {}

    -- Mappings for gear sets to use for various blue magic spells.
    -- While Str isn't listed for each, it's generally assumed as being at least
    -- moderately signficant, even for spells with other mods.

    -- Physical Spells --

    -- Physical spells with no particular (or known) stat mods
    blue_magic_maps.Physical = S{
        'Bilgestorm'
    }

    -- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
    blue_magic_maps.PhysicalAcc = S{
        'Heavy Strike','Sweeping Gouge'
    }

    -- Physical spells with Str stat mod
    blue_magic_maps.PhysicalStr = S{
        'Battle Dance','Bloodrake','Death Scissors','Dimensional Death',
        'Empty Thrash','Quadrastrike','Sinker Drill','Spinal Cleave',
        'Uppercut','Vertical Cleave','Smite of Rage'
    }

    -- Physical spells with Dex stat mod
    blue_magic_maps.PhysicalDex = S{
        'Amorphic Spikes','Asuran Claws','Barbed Crescent','Claw Cyclone','Disseverment',
        'Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad',
        'Seedspray','Sickle Slash','Terror Touch','Thrashing Assault','Vanity Dive'
    }

    -- Physical spells with Vit stat mod
    blue_magic_maps.PhysicalVit = S{
        'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
        'Power Attack','Quad. Continuum','Sprout Smack','Sub-zero Smash','Saurian Slide'
    }

    -- Physical spells with Agi stat mod
    blue_magic_maps.PhysicalAgi = S{
        'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream',
        'Pinecone Bomb','Spiral Spin','Wild Oats','Final Sting'
    }

    -- Physical spells with Int stat mod
    blue_magic_maps.PhysicalInt = S{
        'Mandibular Bite','Queasyshroom'
    }

    -- Physical spells with Mnd stat mod
    blue_magic_maps.PhysicalMnd = S{
        'Ram Charge','Screwdriver'
    }

    -- Physical spells with Chr stat mod
    blue_magic_maps.PhysicalChr = S{
        'Bludgeon'
    }

    -- Magical Spells --

    -- Magical spells with the typical Int mod
    blue_magic_maps.Magical = S{
        'Blastbomb','Blazing Bound','Bomb Toss','Cursed Sphere','Dark Orb','Death Ray','Diffusion Ray',
		'Droning Whirlwind','Embalming Earth','Firespit','Foul Waters','Ice Break','Leafstorm','Maelstrom',
		'Rail Cannon','Regurgitation','Rending Deluge','Retinal Glare','Subduction','Tem. Upheaval',
		'Water Bomb','Charged Whisker','Gates of Hades','Thermal Pulse','Anvil Lightning','Crashing Thunder',
		'Entomb','Molting Plumage','Nectarous Deluge','Scouring Spate','Searing Tempest','Silent Storm',
		'Spectral Floe','Thunderbolt','Uproot','Blinding Fulgor','Tearing Gust','Cesspool',
    }

    blue_magic_maps.MagicalDark =S{
        'Palling Salvo','Tenebral Crush','Atra. Libations'
    }

    -- Magical spells with a primary Mnd mod
    blue_magic_maps.MagicalMnd = S{
        'Acrid Stream','Evryone. Grudge','Magic Hammer','Mind Blast'
    }

    -- Magical spells with a primary Chr mod
    blue_magic_maps.MagicalChr = S{
        'Eyes On Me','Mysterious Light'
    }


    -- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
    -- Add Int for damage where available, though.
    blue_magic_maps.MagicAccuracy = S{
        '1000 Needles','Absolute Terror','Actinic Burst','Auroral Drape','Awful Eye',
        'Blank Gaze','Blistering Roar','Blood Drain','Blood Saber','Chaotic Eye',
        'Cimicine Discharge','Cold Wave','Corrosive Ooze','Demoralizing Roar','Digest',
        'Dream Flower','Enervation','Feather Tickle','Filamented Hold','Frightful Roar',
        'Geist Wall','Hecatomb Wave','Infrasonics','Jettatura','Light of Penance',
        'Lowing','Mind Blast','Mortal Ray','MP Drainkiss','Osmosis','Reaving Wind',
        'Sandspin','Sandspray','Sheep Song','Soporific','Sound Blast','Stinking Gas',
        'Venom Shell','Voracious Trunk','Yawn','Tourbillion','Polar Roar','Cruel Joke',
    }

    -- Breath-based spells
    blue_magic_maps.Breath = S{
        'Bad Breath','Flying Hip Press','Frost Breath','Heat Breath','Hecatomb Wave',
		'Magnetite Cloud','Poison Breath','Radiant Breath','Self-Destruct','Thunder Breath',
		'Vapor Spray','Wind Breath'
    }

    -- Stun spells
    blue_magic_maps.Stun = S{
        'Blitzstrahl','Frypan','Head Butt','Sudden Lunge','Tail slap','Temporal Shift',
        'Thunderbolt','Whirl of Rage'
    }

    -- Healing spells
    blue_magic_maps.Healing = S{
        'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','Restoral','White Wind',
        'Wild Carrot'
    }

    -- Buffs that depend on blue magic skill
    blue_magic_maps.SkillBasedBuff = S{
        'Barrier Tusk','Diamondhide','Magic Barrier','Metallic Body','Plasma Charge',
        'Pyric Bulwark','Reactor Cool',
    }

    -- Other general buffs
    blue_magic_maps.Buff = S{
        'Amplification','Animating Wail','Battery Charge','Carcharian Verve','Cocoon','Erratic Flutter',
		'Exuviation','Fantod','Feather Barrier','Harden Shell','Memento Mori','Nat. Meditation',
		'Occultation','Orcish Counterstance','Refueling','Regeneration','Saline Coat','Triumphant Roar',
		'Warm-Up','Winds of Promyvion','Zephyr Mantle','Mighty Guard'
    }


    -- Spells that require Unbridled Learning to cast.
    unbridled_spells = S{
        'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve','Crashing Thunder',
		'Droning Whirlwind','Gates of Hades','Harden Shell','Polar Roar','Pyric Bulwark','Thunderbolt',
		'Tourbillion','Uproot','Mighty Guard','Tearing Gust','Cesspool','Cruel Joke',
    }
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

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
	state.AutoWS = M{['description']='Auto WS', 'Requiescat', 'Chant du Cygne', 'Savage Blade', 'Sanguine Blade', 'Expiacion'}
	
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
        body="Adhemar Jacket +1",
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
        body="Adhemar Jacket +1",
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
          body="Adhemar Jacket +1",
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

    sets.Kiting = {legs="Carmine Cuisses +1",feet="Hippomenes socks"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- misc, currently only used to equip weapons
	sets.misc = {}
	sets.misc.weapon = {}
	sets.misc.weapon['Magic'] = {main="Vampirism",sub="Vampirism",}
	sets.misc.weapon['DD'] = {main="Sequence",sub={ name="Colada", augments={'Mag. Acc.+24','DEX+2','Accuracy+24','Attack+15','DMG:+13',}},}
	sets.misc.weapon['Off'] = {}
	
	
    -- Normal melee group
    sets.engaged = { --done
		ammo="Ginsen",
		head="Dampening Tam",
		neck="Defiant Collar",
		lear="Brutal Earring",
		rear="Suppanomimi",
		body="Adhemar Jacket +1",
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
		hands="Aya. Manopolas +2",
		lring="Mars's Ring"})

	sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc,{ -- done
		ammo="Honed Tathlum",
		head="Carmine mask",
		rear="Cessance Earring",
		rring="Apate ring",
		back="Grounded Mantle +1",
		waist="Eschan Stone",
		legs="Carmine Cuisses +1"})
	
	sets.engaged.Blink = {body="Emet Harness",}
    sets.engaged.Refresh = {}
	
	sets.engaged.DamageTaken = set_combine(sets.engaged,{ -- done
		head="Iuitl Headgear +1",
        neck="Loricate Torque +1",
        lear="Colossus's Earring", rear="Ethereal Earring",
        body="Emet Harness",
        hands="Herculean Gloves",
        lring="Vocane Ring", rring="Defending Ring",
        back="Moonbeam Cape",
        waist="Flume Belt",
        legs="Herculean trousers",
        feet="Herculean boots"})

    sets.engaged.Learning = set_combine(sets.engaged, sets.Learning)


    sets.self_healing = {lring="Kunaji Ring",rring="Asklepian Ring"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
--lock gear from swapping
function check_equip_lock() -- Lock Equipment Here --	
	--if player.target.name ~= nil and player.target.name:contains('Apex') then
	--	if player.equipment.back ~= "Mecisto. Mantle" then
	--		equip{back="Mecisto. Mantle"}
	--		disable('back')
	--	end
	--end
	if player.equipment.left_ring == "Warp Ring" or player.equipment.left_ring == "Capacity Ring" or player.equipment.right_ring == "Warp Ring" or player.equipment.right_ring == "Capacity Ring" then
		disable('ring1','ring2')
	elseif player.equipment.back == "Mecisto. Mantle" then
		disable('back')
        if count_msg_mecisto == 0 then
            windower.add_to_chat(8,'REMINDER:  '
                ..'Mecistopins mantle equiped on back')
        end
        count_msg_mecisto = (count_msg_mecisto + 1) % 30
	else
		if count_msg_mecisto > 0 then
			enable('ring1','ring2','back')
			count_msg_mecisto = 0
		else
			enable('ring1','ring2')
			count_msg_mecisto = 0
		end
	end
end

	 

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    check_equip_lock()
	equip_weapon()
	if state.NotifyWS.value then
		if spell.name == 'Chant du Cygne' or spell.name == 'Requiescat' then
			send_command('@input /p **** '..spell.name..' Incoming ! ****')
		end
	end
	if unbridled_spells:contains(spell.english) and not state.Buff['Unbridled Learning'] then
        eventArgs.cancel = true
        windower.send_command('@input /ja "Unbridled Learning" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
    end
    if spell.name == 'Spectral Jig' and buffactive.sneak then
        -- If sneak is active when using, cancel before completion
        send_command('cancel 71')
    end
    if string.find(spell.english, 'Utsusemi') then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4)'] then
            cancel_spell()
            eventArgs.cancel = true
            return
        end
    end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Add enhancement gear for Chain Affinity, etc.
    if spell.skill == 'Blue Magic' then
		for buff,active in pairs(state.Buff) do
            if active and sets.buff[buff] then
                equip(sets.buff[buff])
			end
        end
		if spellMap:contains('Magic') and spell.target.type == 'MONSTER' then
			if spell.element == world.day_element or spell.element == world.weather_element then
				equip(sets.magic_burst,{waist="Hachirin-No-Obi"})
			end
		end
		
        if spellMap == 'Healing' and spell.target.type == 'SELF' and sets.self_healing then
            equip(sets.self_healing)
        end
    end

    -- If in learning mode, keep on gear intended to help with that, regardless of action.
    if state.OffenseMode.value == 'Learning' then
        equip(sets.Learning)
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
   	if state.SCStage.value ~= 'None' then
		--windower.add_to_chat(8,'SC Stage: '..state.SCStage.value) --for debugging
		windower.send_command('@wait 1;gs c DarkSC '..state.SCStage.value)
	end
	if not spell.interrupted then
        -- TIMERS PLUGIN: Dream Flower
        if spell.name == 'Dream Flower' then
            windower.send_command('wait 80;input /echo [ WARNING! '..spell.name..' : Will wear off within 0:10 ]')
			windower.send_command('wait 85;input /echo [ WARNING! '..spell.name..' : Will wear off within 0:05 ]')
        end
    end
	 
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)
	check_equip_lock()
	equip_weapon()
	customize_melee_set()
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        state.Buff[buff] = gain
    end
	customize_melee_set()
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


-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	--print(state.Buff.Blink)
	if state.OffenseMode.value == 'DamageTaken' then
		if check_buffs('Blink') or buffactive['Copy Image'] then
			windower.add_to_chat(8,'Blink')
			if player.target.name ~= nil and player.target.name:contains('Apex') then
				meleeSet = set_combine(sets.engaged)
			else
				meleeSet = set_combine(sets.engaged.MidAcc)
			end
		end
	elseif buff == "terror" or buff == "petrification" or buff == "stun" or buff == "sleep" then
		if gain then
			equip(sets.engaged.DamageTaken)
		end
	end
	return meleeSet
end

-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end

function check_buffs(...)
    --[[ Function Author: Arcon
            Simple check before attempting to auto activate Job Abilities that
            check active buffs and debuffs ]]
    return table.any({...}, table.get+{buffactive})
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

function equip_weapon()
	-- Will inform you if no weapon is equiped and re-equip once able
    if player.equipment.main == 'empty' then
        equip(sets.misc.weapon[state.CombatWeapon.value])
        windower.add_to_chat(8,'No Weapon, trying to re-equip: '..state.CombatWeapon.value)
    end
end

function job_self_command(cmdParams, eventArgs)
	if cmdParams[1] == 'cure' then
		if check_set_spells('Magic Fruit') then
			if party.count > 1 then
				windower.send_command('input /ma "Magic Fruit" <stpc>')
			else
				windower.send_command('input /ma "Magic Fruit" <me>')
			end
		elseif check_set_spells('Plenilune Embrace') then
			if party.count > 1 then
				windower.send_command('input /ma "Plenilune Embrace" <stpc>')
			else
				windower.send_command('plenilune embrace')
			end
		elseif check_set_spells('Restoral') then
			windower.send_command('restoral')
		elseif check_set_spells('White Wind') then
			windower.send_command('white wind')
		else
			if player.sub_job == 'RDM' then
				 if party.count > 1 then
					windower.send_command('input /ma "Cure IV" <stpc>')
				else
					windower.send_command('input /ma "Cure IV" <me>')
				end
			else
				windower.add_to_chat(8,'WARNING: No Cure spell is'
					..' currently set!')
			end
		end
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
	
	if cmdParams[1] == 'DarkSC' then
		local allRecasts = windower.ffxi.get_ability_recasts()
		local chainRecast = allRecasts[181]
		local burstRecast = allRecasts[182]
		local floe = check_set_spells('Spectral Floe')
		local sinker = check_set_spells('Sinker Drill')
		
		-- Step 5: MB
		if cmdParams[2] == 'MB' then
			if player.status == 'Engaged' then
				if check_buffs('Burst Affinity') then
					state.SCStage.value = 'None'
					windower.send_command('input /ma "Spectral Floe" <t>;')
				else
					state.SCStage.value = 'None'
					windower.add_to_chat(8,'Burst Affinity did not activate, cancelled.')
				end
			else
				windower.add_to_chat(8,'You are not engaged, cancelled.')
			end
		
		-- Step 4: BurstAffinity
		elseif cmdParams[2] == 'BurstAffinity' then
			if player.status == 'Engaged' then
				if burstRecast == 0 or check_buffs('Burst Affinity')then
					state.SCStage.value = 'MB'
					windower.send_command('@wait 1.7;input /ja "Burst Affinity" <me>;')
				else
					state.SCStage.value = 'None'
					windower.add_to_chat(8,'Recast on Burst Affinity, cancelled.'..burstRecast)
				end
			else
				windower.add_to_chat(8,'You are not engaged, cancelled.')
			end
		
		-- Step 3: SC
		elseif cmdParams[2] == 'SC' then
			if player.status == 'Engaged' then
				if check_buffs('Chain Affinity') then
					windower.send_command('input /ma "Sinker Drill" <t>;')
					if floe == true then
						state.SCStage.value = 'BurstAffinity'
					else
						state.SCStage.value = 'None'
						windower.add_to_chat(8,'Spectral Floe has not been set, no MB')
					end
				else
					windower.add_to_chat(8,'Chain Affinity did not activate, cancelled.')
				end
			else
				windower.add_to_chat(8,'You are not engaged, cancelled.')
			end
		
		-- Step 2: ChainAffinity
		elseif cmdParams[2] == 'ChainAffinity' then
			if player.status == 'Engaged' then
				if chainRecast == 0 or check_buffs('Chain Affinity') then
					windower.send_command('@wait 2;input /ja "Chain Affinity" <me>;')
					state.SCStage.value = 'SC'
				else
					state.SCStage.value = 'None'
					windower.add_to_chat(8,'Recast on Chain Affinity, cancelled.'..chainRecast)
				end
			else
				windower.add_to_chat(8,'You are not engaged, cancelled.')
			end
		
		-- Step 1: WS + ChainAffinity
		elseif player.status == 'Engaged' then
			if player.tp > 1000 then
				if sinker == true then
					state.SCStage.value = 'ChainAffinity'
					windower.send_command('input /ws "Chant du Cygne" <t>;')
				else
					windower.add_to_chat(8,'Sinker Drill has not been set, cancelled')
				end
				
			else
				windower.add_to_chat(8,'Not enought TP, cancelled.')
			end
		else
			windower.add_to_chat(8,'You are not engaged, cancelled.')
		end
	end

	if cmdParams[1] == 'LightSC' then
		local allRecasts = windower.ffxi.get_ability_recasts()
		local chainRecast = allRecasts[181]
		local burstRecast = allRecasts[182]
		local anvil = check_set_spells('Anvil Lightning')
		local cannon = check_set_spells('Cannonball')
		
		-- Step 5: MB
		if cmdParams[2] == 'MB' then
			if player.status == 'Engaged' then
				if check_buffs('Burst Affinity') then
					state.SCStage.value = 'None'
					windower.send_command('input /ma "Anvil Lightning" <t>;')
				else
					state.SCStage.value = 'None'
					windower.add_to_chat(8,'Burst Affinity did not activate, cancelled.')
				end
			else
				windower.add_to_chat(8,'You are not engaged, cancelled.')
			end
		
		-- Step 4: BurstAffinity
		elseif cmdParams[2] == 'BurstAffinity' then
			if player.status == 'Engaged' then
				if burstRecast == 0 or check_buffs('Burst Affinity') then
					state.SCStage.value = 'MB'
					windower.send_command('@wait 1.7;input /ja "Burst Affinity" <me>;')
				else
					state.SCStage.value = 'None'
					windower.add_to_chat(8,'Recast on Burst Affinity, cancelled.'..burstRecast)
				end
			else
				windower.add_to_chat(8,'You are not engaged, cancelled.')
			end
		
		-- Step 3: SC
		elseif cmdParams[2] == 'SC' then
			if player.status == 'Engaged' then
				if check_buffs('Chain Affinity') then
					windower.send_command('input /ma "Cannonball" <t>;')
					if anvil == true then
						state.SCStage.value = 'BurstAffinity'
					else
						state.SCStage.value = 'None'
						windower.add_to_chat(8,'Anvil Lightning has not been set, no MB')
					end
				else
					windower.add_to_chat(8,'Chain Affinity did not activate, cancelled.')
				end
			else
				windower.add_to_chat(8,'You are not engaged, cancelled.')
			end
		
		-- Step 2: ChainAffinity
		elseif cmdParams[2] == 'ChainAffinity' then
			if player.status == 'Engaged' then
				if chainRecast == 0 or check_buffs('Chain Affinity') then
					windower.send_command('@wait 2;input /ja "Chain Affinity" <me>;')
					state.SCStage.value = 'SC'
				else
					state.SCStage.value = 'None'
					windower.add_to_chat(8,'Recast on Chain Affinity, cancelled.'..chainRecast)
				end
			else
				windower.add_to_chat(8,'You are not engaged, cancelled.')
			end
		
		-- Step 1: WS + ChainAffinity
		elseif player.status == 'Engaged' then
			if player.tp > 1000 then
				if cannon == true then
					state.SCStage.value = 'ChainAffinity'
					windower.send_command('input /ws "Requiescat" <t>;')
				else
					windower.add_to_chat(8,'Cannonball has not been set, cancelled.')
				end
			else
				windower.add_to_chat(8,'Not enought TP, cancelled.')
			end
		else
			windower.add_to_chat(8,'You are not engaged, cancelled.')
		end
	end
end

function check_set_spells(...)
    --[[ Function Author: Arcon
            Used to pull list of currently set spells, this is useful for
            determining traits such as Dual Wield IV
            Also used to determine the Cure spell set, when used with a
            self_command ]]
    set_spells = set_spells
        or gearswap.res.spells:type('BlueMagic'):rekey('name')
        return table.all({...}, function(name)
        return S(windower.ffxi.get_mjob_data().spells)
        :contains(set_spells[name].id)
    end)
end

function relaxed_play_mode_WS(cmdParams, eventArgs)
	if not midaction() then
		if not check_buffs('Sleep','petrification','Terror') then		
			if player.tp > 1249 and player.target.distance < 8 then
				--if  player.target.name:contains('Quetzalcoatl') then
				
				if not check_buffs(272) then
					if player.tp > 2999 then
						send_command('@input /ws "Expiacion" <t>')
					end
				else
				--if player.target.hpp < 80 then
					send_command('@input /ws "'..state.AutoWS.value..'" <t>')
				end
			end
		end
	end
end

function relaxed_play_mode(cmdParams, eventArgs)
    -- This can be used as a mini bot to automate actions
	if not midaction() then
		if not check_buffs('Sleep','petrification','Terror') then
			local allRecasts = windower.ffxi.get_ability_recasts()
			local composureRecast = allRecasts[50]
			
			if player.hpp < 50					
					and not check_buffs('silence', 'mute')
					and check_recasts(s('Magic Fruit')) then
				send_command('@input /ma "Magic Fruit" <me>')

			elseif not buffactive[33] 
					and not check_buffs('silence', 'mute', 'Slow')
					and check_recasts(s('Erratic Flutter')) then
				send_command('@input /ma "Erratic Flutter" <me>')
				
			elseif not check_buffs('Refresh') 
					and not check_buffs('silence', 'mute')
					and check_recasts(s('Battery Charge')) then
					if player.sub_job == 'RDM' then
						send_command('@input /ma "Refresh" <me>')
					else	
						send_command('@input /ma "Battery Charge" <me>')
					end
			
			elseif not check_buffs('Phalanx') 
					and not check_buffs('silence', 'mute')
					and check_recasts(s('Barrier Tusk')) then
				send_command('@input /ma "Barrier Tusk" <me>')
				
			elseif player.sub_job == 'BLM'
					and not check_buffs('Ice Spikes') 
					and not check_buffs('silence', 'mute')
					and check_recasts(s('Reactor Cool')) then
				send_command('@input /ma "Reactor Cool" <me>')
			
			--elseif not check_buffs('Attack Boost')
			--		and not check_buffs('silence', 'mute')
			--		and check_recasts(s('Nat. Meditation')) then
			--	send_command('@input /ma "Nat. Meditation" <me>')
			
			elseif player.sub_job == 'RDM'
					and not check_buffs('Memento Mori')
					and check_recasts(s('Memento Mori'))then
				send_command('@input /ma "Memento Mori" <me>')
			
			elseif player.sub_job == 'WAR'
					and not check_buffs('Berserk')
					and check_recasts(j('Berserk'))then
				send_command('@input /ja "Berserk" <me>')

				
			elseif player.sub_job == 'WAR'
					and not check_buffs('Aggressor')
					and check_recasts(j('Aggressor')) then
				send_command('@input /ja "Aggressor" <me>')
			
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
			elseif check_buffs(603) then
				if spell_recasts[1017] == 0 and not have_trust("Arciela") then
					windower.send_command('input /ma "Arciela II" <me>')
					tickdelay = 250
					return true
				elseif spell_recasts[898] == 0 and not have_trust("Kupipi") then
					windower.send_command('input /ma "Kupipi" <me>')
					tickdelay = 250
					return true
				elseif spell_recasts[979] == 0 and not have_trust("Selh'teus") then
					windower.send_command("input /ma Selh'teus <me>")
					tickdelay = 250
					return true
				elseif spell_recasts[944] == 0 and not have_trust("Ferreous Coffin") then
					windower.send_command('input /ma "Ferreous Coffin" <me>')
					tickdelay = 250
					return true
				else
					return false
				end
			elseif spell_recasts[967] == 0 and not have_trust("Qultada") then
					windower.send_command('input /ma "Qultada" <me>')
					tickdelay = 250
					return true
			elseif spell_recasts[911] == 0 and not have_trust("Joachim") then
					windower.send_command('input /ma "Joachim" <me>')
					tickdelay = 250
					return true
			elseif spell_recasts[914] == 0 and not have_trust("Ulmia") then
					windower.send_command('input /ma "Ulmia" <me>')
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
        set_macro_page(2, 20)
    else
        set_macro_page(1, 20)
    end
end