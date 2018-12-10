-------------------------------------------------------------------------------------------------------------------
-- (Original: Motenten / Modified: Arislan)
-------------------------------------------------------------------------------------------------------------------

--[[	Custom Features:

		Rune Selector		Cycle through available runes and trigger with a single macro [Ctl-`]
		Knockback Mode		Equips knockback prevention gear (Ctl-[)
		Death Mode			Equips death prevention gear (Ctl-])
		Auto. Doom			Automatically equips na received gear on doom status
		Capacity Pts. Mode	Capacity Points Mode Toggle [WinKey-C]
		Reive Detection		Automatically equips Reive bonus gear
		Auto. Lockstyle		Automatically locks specified equipset on file load
--]]


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

-- Setup vars that are user-independent.
function job_setup()
	-- /BLU Spell Maps
	blue_magic_maps = {}

	blue_magic_maps.Enmity = S{'Blank Gaze', 'Geist Wall', 'Jettatura', 'Soporific',
		'Poison Breath', 'Blitzstrahl', 'Sheep Song', 'Chaotic Eye'}
	blue_magic_maps.Cure = S{'Wild Carrot'}
	blue_magic_maps.Buffs = S{'Cocoon', 'Refueling'}

	rayke_duration = 47
	gambit_duration = 92

	info = {}
	info.aftermath = {}

	state.Buff = {}
	state.Buff.Aftermath = buffactive['Aftermath: Lv.1'] or buffactive['Aftermath: Lv.2'] or buffactive['Aftermath: Lv.3'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
	Auto_Hasso = 'ON'
	runeHelper = 'OFF'
	state.OffenseMode:options('STP', 'Normal', 'LowAcc', 'MidAcc', 'HighAcc', 'Mixed')
	state.WeaponskillMode:options('Normal', 'Acc')
	state.CastingMode:options('Normal', 'Resistant')
	state.IdleMode:options('Normal', 'DT', 'MDT', 'Regain')
	state.PhysicalDefenseMode:options('PDT', 'HP', 'Critical', 'DT')
	state.MagicalDefenseMode:options('MDT', 'Status')

	state.WeaponLock = M(false, 'Weapon Lock')
	state.Knockback = M(false, 'Knockback')
	state.Death = M(false, "Death Resistance")
	state.CP = M(false, "Capacity Points Mode")

	state.Runes = M{['description']='Runes', "Ignis", "Gelus", "Flabra", "Tellus", "Sulpor", "Unda", "Lux", "Tenebrae"}

	--[[ ! = ALT. ^ = STRG, @ = WIN Key ]]--
	send_command('bind ^` input //gs c rune')
	send_command('bind !` input /ja "Vivacious Pulse" <me>')
	send_command('bind @` gs c autohasso')
	send_command('bind ^- gs c cycleback Runes')
	send_command('bind ^= gs c cycle Runes')
	send_command('bind ^f11 gs c cycle MagicalDefenseMode')
	send_command('bind ^[ gs c toggle Knockback')
	send_command('bind ^] gs c toggle Death')
	send_command('bind ^\ gs c toggle Charm')
	send_command('bind !q input /ma "Temper" <me>')

	if player.sub_job == 'BLU' then
		send_command('bind !w input /ma "Cocoon" <me>')
	elseif player.sub_job == 'WAR' then
		send_command('bind !w input /ja "Defender" <me>')
	elseif player.sub_job == 'DRK' then
		send_command('bind !w input /ja "Last Resort" <me>')
	elseif player.sub_job == 'SAM' then
		send_command('bind !w input /ja "Hasso" <me>')
	end

	send_command('bind !o input /ma "Regen IV" <stpc>')
	send_command('bind !p input /ma "Shock Spikes" <me>')

	if player.sub_job == 'DNC' then
		send_command('bind ^, input /ja "Spectral Jig" <me>')
		send_command('unbind ^.')
	else
		send_command('bind ^, input /item "Silent Oil" <me>')
		send_command('bind ^. input /item "Prism Powder" <me>')
	end

	send_command('bind @w gs c toggle WeaponLock')
	send_command('bind @c gs c toggle CP')

	select_default_macro_book()
	set_lockstyle()
end

function user_unload()
	send_command('unbind ^`')
	send_command('unbind !`')
	send_command('unbind ^-')
	send_command('unbind ^=')
	send_command('unbind ^f11')
	send_command('unbind ^[')
	send_command('unbind !]')
	send_command('unbind !q')
	send_command('unbind !w')
	send_command('unbind !o')
	send_command('unbind !p')
	send_command('unbind ^,')
	send_command('unbind @w')
	send_command('unbind @c')

	send_command('unbind ^t')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

	--------------------------------------
	-- Herculean
	--------------------------------------
	-- MAB -- used by COR
	gear.Herc_MAB_head = {"Herculean Helm",}
	gear.Herc_MAB_body = {name="Herculean Vest", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','Crit.hit rate+1','Mag. Acc.+15','"Mag.Atk.Bns."+15',}}
	gear.Herc_MAB_hands = {"Herculean Gloves",}
	gear.Herc_MAB_legs = {"Herculean Trousers",}
	gear.Herc_MAB_feet = {"Herculean Boots",}

	-- TA/QA
	gear.Herc_TA_head = {"Herculean Helm"}
	gear.Herc_TA_body = {"Herculean Vest",}
	gear.Herc_TA_hands = {name="Herculean Gloves", augments={'Accuracy+19 Attack+19','"Triple Atk."+3','INT+12','Accuracy+14',}}
	gear.Herc_TA_legs = {name="Herculean Trousers", augments={'Accuracy+19','"Triple Atk."+4','DEX+9','Attack+2',}}
	gear.Herc_TA_feet = {name="Herculean Boots", augments={'Accuracy+25 Attack+25','"Triple Atk."+3','AGI+9','Attack+1',}}

	-- WSD
	gear.Herc_WS_head = {"Herculean Helm",}
	--gear.Herc_WS_head = { name="Herculean Helm", augments={'Attack+15','Weapon skill damage +5%','Accuracy+8',}}
	gear.Herc_WS_hands = {"Herculean Gloves",}
	gear.Herc_WS_body = { name="Herculean Vest", augments={'INT+7','"Resist Silence"+3','Weapon skill damage +7%','Accuracy+15 Attack+15',}}
	gear.Herc_WS_legs = {name="Herculean Trousers",augments={'Accuracy+25','Weapon skill damage +4%','DEX+4','Attack+14',}}
	gear.Herc_WS_feet = {name="Herculean Boots", augments={'Accuracy+16 Attack+16','Weapon skill damage +4%','Accuracy+8','Attack+5',}}

	-- DT
	gear.Herc_DT_head = {name="Herculean Helm", augments={'Damage taken-4%','DEX+6',}}
	gear.Herc_DT_body = {"Herculean Vest"}
	gear.Herc_DT_hands = {name="Herculean Gloves", augments={'Damage taken-3%','STR+4',}}
	gear.Herc_DT_legs = {name="Herculean Trousers", augments={'Accuracy+30','Damage taken-2%','STR+3','Attack+5',}}
	gear.Herc_DT_feet = {"Herculean Boots",}

	-- ACC
	gear.Herc_Acc_head = {name="Herculean Helm", augments={'Accuracy+30','Crit.hit rate+3','DEX+7','Attack+8',}}
	gear.Herc_Acc_body = {"Herculean Vest",}
	gear.Herc_Acc_hands = {"Herculean Gloves",}
	gear.Herc_Acc_legs = {name="Herculean Trousers", augments={'Accuracy+24 Attack+24','Crit.hit rate+2','Accuracy+8','Attack+15',}}
	gear.Herc_Acc_feet = gear.Herc_TA_feet

	-- FC
	gear.Herc_FC_head = {name="Herculean Helm", augments={'"Fast Cast"+6','STR+6','Mag. Acc.+12','"Mag.Atk.Bns."+5',}}

	-- Other
	gear.Herc_TH_legs = { name="Herculean Trousers", augments={'Mag. Acc.+30','"Cure" potency +3%','"Treasure Hunter"+1','Accuracy+17 Attack+17',}}
	gear.Herc_Refresh_legs = { name="Herculean Trousers", augments={'AGI+7','STR+10','"Refresh"+2','Accuracy+2 Attack+2','Mag. Acc.+14 "Mag.Atk.Bns."+14',}}

	-- Phalanx
	gear.Phalanx_head = {"Futhark Bandeau +1",}
	gear.Phalanx_body = {name="Taeon Tabard", augments={'Phalanx +3',}}
	gear.Phalanx_hands = {name="Taeon Gloves", augments={'Phalanx +3',}}
	gear.Phalanx_legs = {name="Taeon Tights", augments={'Phalanx +3',}}
	gear.Phalanx_feet = {name="Taeon Boots", augments={'Phalanx +3',}}

	--------------------------------------
	-- Capes
	--------------------------------------
	-- RUN Capes
	gear.RUN_WSD_Cape = {name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}
	gear.RUN_DA_Cape = {name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}}
	gear.RUN_HP_Cape = {name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10',}}
	gear.RUN_TP_Cape = {name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+4','"Store TP"+10',}}

	--------------------------------------
	-- Organizer
	--------------------------------------
	sets.Org = {
		ammo="Miso Ramen +1",
		head="Miso Ramen",
		body="Holy Water",
		hands="Remedy",
	}

	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Enmity set
	sets.Enmity = { 				--74+28
		main="Epeolatry", 			--23
		--sub="Alber Strap", 		--5
		ammo="Sapience orb", 		--2
		--head="Halitus Helm", 		--8
		head="Rabid Visor", 		--6
		body="Emet Harness +1", 	--10
		hands="Kurys Gloves", 		--9
		legs="Eri. Leg Guards +1", 	--7
		feet="Erilaz Greaves +1",	--6
		neck="Unmoving Collar +1", 	--10
		ear1="Cryptic Earring", 	--4
		ear2="Friomisi Earring", 	--2
		ring1="Supershear Ring", 	--5
		ring2="Petrov Ring", 		--4
		back="Reiki Cloak", 		--6
		waist="Sulla Belt",			--3
		}

	-- Precast sets to enhance JAs
	sets.precast.JA['Vallation'] = set_combine(sets.Enmity, {
		body="Runeist Coat +3",
		legs="Futhark Trousers +1",
		back="Ogma's Cape"})
	sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
	sets.precast.JA['Pflug'] = set_combine(sets.Enmity, {feet="Runeist boots +3"})
	sets.precast.JA['Battuta'] = set_combine(sets.Enmity, {head="Fu. Bandeau +1"})
	sets.precast.JA['Liement'] = set_combine(sets.Enmity, {body="Futhark Coat +1"})

	sets.precast.JA['Lunge'] = {
		ammo="Seeth. Bomblet +1",
		head=gear.Herc_MAB_head,
		body="Samnuha Coat",
		hands="Carmine finger gauntlets",
		--legs="Limbo Trousers",
		feet=gear.Herc_MAB_feet,
		neck="Eddy Necklace",
		ear1="Hecate's Earring",
		ear2="Friomisi Earring",
		ring1="Acumen Ring",
		back="Argocham. Mantle",
		waist="Eschan Stone",
		}

	sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']
	sets.precast.JA['Gambit'] = {hands="Runeist Mitons +3"}
	sets.precast.JA['Rayke'] = {feet="Futhark Boots +1"}
	sets.precast.JA['Elemental Sforzo'] = set_combine(sets.Enmity, {body="Futhark Coat +1"})
	sets.precast.JA['Swordplay'] = set_combine(sets.Enmity, {hands="Futhark Mitons +1"})
	sets.precast.JA['Embolden'] = set_combine(sets.Enmity, {back="Evasionist's Cape"})
	sets.precast.JA['Vivacious Pulse'] = set_combine(sets.Enmity, {
		head="Erilaz Galea +1",
		neck="Incanter's Torque",
		legs="Rune. Trousers +3",
		back="Altruistic Cape",})
	sets.precast.JA['One For All'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Provoke'] = sets.Enmity

	sets.precast.Waltz = {}

	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	sets.precast.FC = { 				--65 with cape --> 85 with 2 merits
		ammo="Sapience Orb", 			--2
		head="Runeist Bandeau +3", 		--14
		--body=gear.Taeon_FC_body, 		--8
		body="Adhemar Jacket +1",			--7
		hands="Leyline Gloves", 		--6
		legs="Aya. Cosciales +2", 		--5
		feet="Carmine Greaves +1",		--8
		neck="Voltsurge Torque", 		--4
		ear1="Etiolation Earring", 		--1
		ear2="Loquacious Earring", 		--2
		ring1="Kishar Ring", 			--4
		ring2="Prolix Ring", 			--2
		back=gear.RUN_HP_Cape, 			--10
		waist="Ninurta's Sash",
		}

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
		legs="Futhark Trousers +1",
		waist="Siegel Sash",
		})

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		ammo="Impatiens",
		--ear2="Mendi. Earring",
		--legs="Doyen Pants",
		})

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
		ammo="Impatiens",
		--neck="Magoraga Beads",
		ring2="Lebeche Ring",
		waist="Ninurta's Sash",
		})

	-- Weaponskill sets
	sets.precast.WS = {
		ammo="Seeth. Bomblet +1",
		head="Lilitu Headpiece",
		body="Adhemar Jacket +1",
		hands="Meg. Gloves +2",
		legs=gear.Herc_WS_legs,
		feet=gear.Herc_TA_feet,
		neck="Fotia Gorget",
		ear1="Moonshade Earring",
		ear2="Sherida Earring",
		ring1="Niqmaddu Ring",
		ring2="Epona's Ring",
		back="Bleating Mantle",
		waist="Fotia Belt",
		}

	sets.precast.WS.Acc = set_combine(sets.precast.WS, {
		legs="Meg. Chausses +2",
		ear2="Telos Earring",
		})

	sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		--head=gear.Herc_Acc_head,
		head="Adhemar bonnet +1",
		--hands=gear.Herc_TA_hands,
		ring2="Regal Ring",
		legs=gear.Herc_TA_legs,
		feet=gear.Herc_TA_feet,
		back=gear.RUN_DA_Cape,
		})

	sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'], {
		head="Dampening Tam",
		legs="Meg. Chausses +2",
		ear2="Telos Earring",
		ring1="Rufescent Ring",
		})

	sets.precast.WS['Dimidiation'] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head="Adhemar bonnet +1",
		--legs=gear.Herc_WS_legs,
		legs="Lustratio subligar +1",
		feet=gear.Herc_WS_feet,
		ring1="Ilabrat Ring",
		back=gear.RUN_WSD_Cape,
		})

	sets.precast.WS['Dimidiation'].Acc = set_combine(sets.precast.WS['Dimidiation'], {
		--feet=gear.Herc_Acc_feet,
		ear2="Telos Earring",
		ammo="Seething Bomblet +1",
		--feet="Lustratio Leggings",
		ring1="Rufescent Ring"
		})

	sets.precast.WS['Herculean Slash'] = sets.precast.JA['Lunge']

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",
		feet=gear.Herc_TA_feet,
		--neck="Caro Necklace",
		--ring1="Ifrit Ring +1",
		ring2="Shukuyu Ring",
		--waist="Prosilio Belt +1",
		back=gear.RUN_WS1_Cape,
		})

	sets.precast.WS['Sanguine Blade'] = {
		ammo="Seeth. Bomblet +1",
		head="Pixie Hairpin +1",
		body="Samnuha Coat",
		hands="Carmine Fin. Ga.",
		legs=gear.Herc_WS_legs,
		feet=gear.Herc_MAB_feet,
		neck="Baetyl Pendant",
		ear1="Moonshade Earring",
		ear2="Friomisi Earring",
		ring1="Archon Ring",
		--ring2="Levia. Ring +1",
		ring2="Acumen Ring",
		back="Argocham. Mantle",
		waist="Eschan Stone",
		}

	sets.precast.WS['True Strike']= sets.precast.WS['Resolution']

	sets.precast.WS['True Strike']= sets.precast.WS['Savage Blade']
	sets.precast.WS['Judgment'] = sets.precast.WS['Savage Blade']
	sets.precast.WS['Black Halo'] = sets.precast.WS['Savage Blade']

	sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS['Sanguine Blade'])

	--------------------------------------
	-- Midcast Sets
	--------------------------------------

	sets.midcast.FastRecast = sets.precast.FC

	sets.midcast.SpellInterrupt = {
		ammo="Impatiens", 				--10
		legs="Carmine Cuisses +1", 		--20
		--ear1="Halasz Earring", 		--5 // bartimeus
		ring1="Evanescence Ring", 		--5
		--waist="Rumination Sash", 		--10
		}

	sets.midcast.Cure = {
		ammo="Staunch Tathlum",
		head=gear.Herc_DT_head,
		--body="Vrikodara Jupon", 		-- 13  fenrir htbcnm
		--hands="Buremte Gloves", 		--(13)
		legs="Eri. Leg Guards +1",
		feet="Erilaz Greaves +1",
		--neck="Phalaina Locket", 		-- 4(4)
		--ear1="Roundel Earring", 		-- 5
		--ear2="Mendi. Earring", 		-- 5
		ring1="Vocane Ring", 			-- R 5
		ring2="Lebeche Ring",			-- 3
		back="Solemnity Cape",			-- 7
		waist="Flume Belt +1",
		}

	sets.midcast['Enhancing Magic'] = { --500 // 534 atm (23% Temper)
		head="Carmine Mask",				--10
		body="Manasa Chasuble", 			--12
		hands="Runeist Mitons +3", 		--19
		legs="Carmine Cuisses +1", 			--18
		neck="Incanter's Torque", 			--10
		ear2="Andoaa Earring",				--5
		ring1="Stikini Ring", 				--5
		ring2="Stikini Ring", 				--5
		waist="Olympus Sash",				--5
		back="Merciful Cape", 				--5
		}

	sets.midcast.EnhancingDuration = {
		head="Erilaz Galea +1",
		legs="Futhark Trousers +1",
		}

	sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], { -- Phalanx +17 , 475 skill
		head=gear.Phalanx_head,		--5
		body=gear.Phalanx_body,		--3
		hands=gear.Phalanx_hands,	--3
		legs=gear.Phalanx_legs,		--3
		feet=gear.Phalanx_feet,		--3
		})

	sets.midcast['Regen'] = set_combine(sets.midcast.EnhancingDuration, {
		head="Runeist Bandeau +3",
		})

	sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
		waist="Gishdubar Sash",
		})

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		waist="Siegel Sash",
		})

	sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {
		ring2="Sheltered Ring",
		})

	sets.midcast.Shell = sets.midcast.Protect

	sets.midcast['Divine Magic'] = {
		legs="Runeist Trousers +3",
		neck="Incanter's Torque",		--10
		ring1="Stikini Ring",			--5
		ring2="Stikini Ring",			--5
		--waist="Bishop's Sash",
		back="Altruistic Cape",			--5
		}

	sets.midcast.Flash = sets.Enmity
	sets.midcast.Foil = sets.Enmity
	sets.midcast.Diaga = sets.Enmity
	sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

	sets.midcast['Blue Magic'] = {}
	sets.midcast['Blue Magic'].Enmity = sets.Enmity
	sets.midcast['Blue Magic'].Cure = sets.midcast.Cure
	sets.midcast['Blue Magic'].Buff = sets.midcast['Enhancing Magic']

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	sets.idle = {--Refresh+5/Regen+1/	--46/26
		main="Epeolatry",				--(25)/0
		sub="Utu Grip",
		ammo="Homiliary",
		head=gear.Herc_DT_head, 		--4/4
		body="Runeist Coat +3",
		hands=gear.Herc_DT_hands, 		--5/3
		legs=gear.Herc_Refresh_legs, --2/0
		--legs="Rawhide Trousers",
		feet="Erilaz Greaves +1",		--5/0
		neck="Loricate Torque +1",		--6/6
		waist="Flume Belt +1",			--4/0
		ear1="Genmei Earring",			--2/0
		ear2="Infused Earring",
		ring1="Sheltered Ring",
		ring2="Defending Ring",			--10/10
		back="Evasionist's Cape",		--6/3
		}

	sets.idle.DT = set_combine(sets.idle,{					--50/32    --need 3 more
		main="Epeolatry",
		sub="Refined Grip +1", 			--3/3
		ammo="Staunch Tathlum", 		--2/2
		head="Erilaz Galea +1",
		body="Erilaz Surcoat +1",
		legs="Eri. Leg Guards +1",		--7/0
		feet="Erilaz Greaves +1", 		--5/0
		neck="Loricate Torque +1",		--6/6
		ear1="Genmei Earring", 			--2/0
		ear2="Etiolation Earring", 		--0/3
		ring1="Vocane Ring", 			--7/7
		ring2="Defending Ring", 		--10/10
		back="Evasionist's Cape", 		--6/3
		waist="Flume Belt +1", 			--4/0
		})

	sets.idle.MDT = set_combine(sets.idle,{
		main="Epeolatry", 				--(25)/0
		sub="Refined Grip +1", 			--3/3
		ammo="Staunch Tathlum", 		--2/2
		head="Erilaz Galea +1",
		body="Futhark Coat +1", 		--7/7
		hands="Erilaz Gauntlets +1",
		legs="Eri. Leg Guards +1", 		--7/0
		feet="Erilaz Greaves +1",		--5/0
		neck="Warder's Charm +1",
		ear1="Etiolation Earring", 		--0/3
		ear2="Genmei Earring", 			--2/0
		ring1="Vocane Ring", 			--7/7
		ring2="Defending Ring", 		--10/10
		back="Evasionist's Cape", 		--7/4
		waist="Flume Belt +1", 			--4/0
		})

	sets.idle.Regain = set_combine(sets.idle,{
		neck="Opo-Opo Necklace",
		head="Turms cap",
		ring1="Nesanica Ring",
		ring2="Roller's ring",
		})

	sets.idle.Weak = sets.idle.DT

	sets.Kiting = {legs="Carmine Cuisses +1"}


	--------------------------------------
	-- Defense sets
	--------------------------------------

	sets.defense.Knockback = {
		ring1="Vocane Ring",
		back="Repulse Mantle",
		}

	sets.defense.Death = {
		body="Samnuha Coat",
		--ring1="Warden's Ring",		--on BSE
		--ring2="Eihwaz Ring",
		}

	sets.defense.PDT = {				--50/25
		main="Epeolatry", 				--(25)/0
		sub="Utu Grip",
		ammo="Staunch Tathlum", 		--2/2
		head=gear.Herc_DT_head, 		--4/4
		body="Futhark Coat +1",			--7/7
		--hands=gear.Herc_DT_hands, 		--5/3
		hands="Turms mittens",			--HP When Parry
		legs="Eri. Leg Guards +1", 		--7/0
		feet="Turms Leggings",	 		--0/0
		neck="Loricate Torque +1", 		--6/6
		ear1="Genmei Earring", 			--2/0
		ear2="Etiolation Earring", 		--0/3
		--ear2="Impreg. Earring",
		ring1="Vocane Ring", 			--7/7
		ring2="Defending Ring", 		--10/10
		back=gear.RUN_HP_Cape,
		waist="Flume Belt +1", 			--4/0
		}

	sets.defense.MDT = {
		main="Epeolatry", 				--(25)/0
		sub="Refined Grip +1", 			--3/3
		ammo="Staunch Tathlum", 		--2/2
		head="Erilaz Galea +1",
		body="Futhark Coat +1", 		--7/7
		hands="Erilaz Gauntlets +1",
		legs="Eri. Leg Guards +1", 		--7/0
		feet="Erilaz Greaves +1",		--5/0
		neck="Warder's Charm +1",
		ear1="Etiolation Earring", 		--0/3
		ear2="Genmei Earring", 			--2/0
		ring1="Vocane Ring", 			--7/7
		ring2="Defending Ring", 		--10/10
		back="Evasionist's Cape", 		--7/4
		waist="Flume Belt +1", 			--4/0
		}

	sets.defense.DT = { 				--50/25
		main="Epeolatry", 				--(25)/0
		sub="Utu Grip",
		ammo="Staunch Tathlum", 		--2/2
		head=gear.Herc_DT_head, 		--4/4
		body="Erilaz Surcoat +1",
		hands=gear.Herc_DT_hands, 		--5/3
		--hands="Turms mittens",		--HP When Parry
		legs="Eri. Leg Guards +1", 		--7/0
		feet="Erilaz Greaves +1", 		--5/0
		neck="Loricate Torque +1", 		--6/6
		ear1="Genmei Earring", 			--2/0
		ear2="Etiolation Earring", 		--0/3
		--ear2="Impreg. Earring",
		ring1="Vocane Ring", 			--7/7
		ring2="Defending Ring", 		--10/10
		back=gear.RUN_HP_Cape,
		waist="Flume Belt +1", 			--4/0
		}

	sets.defense.Status = set_combine(sets.defense.DT,{
		main="Epeolatry", 				--(25)/0
		sub="Refined Grip +1", 			--3/3
		ammo="Staunch Tathlum", 		--2/2
		head=gear.Herc_DT_head, 		--3/3
		body="Erilaz Surcoat +1",
		hands="Erilaz Gauntlets +1",
		legs="Runeist Trousers +3", 	--4/0
		feet="Erilaz Greaves +1", 		--5/0
		neck="Loricate Torque +1", 		--6/6
		--ear1="Hearty Earring",
		--ear2="Impreg. Earring",
		ring1="Vocane Ring", 			--7/7
		ring2="Defending Ring", 		--10/10
		back="Evasionist's Cape", 		--7/4
		waist="Flume Belt +1", 			--4/0
		})

	sets.defense.HP = { --44 w/o / 47 PDT with grip
		main="Epeolatry", 				--(25)/0
		sub="Refined Grip +1", 			--3/3
		ammo="Staunch Tathlum", 		--2/2
		head="Erilaz Galea +1",
		body="Erilaz Surcoat +1",
		hands="Runeist Mitons +3", 	--2/0
		legs="Eri. Leg Guards +1", 		--7/0
		feet="Carmine greaves +1", 		--4/0
		neck="Loricate Torque +1", 		--6/6
		ear1="Odnowa Earring", 			--0/1
		ear2="Odnowa Earring +1", 		--0/2
		ring1="Moonbeam Ring",			--4/4
		ring2="Defending Ring", 		--10/10
		back="Moonbeam cape",			--4/4
		waist="Flume Belt +1", 			--4/0
		}

	sets.defense.Critical = {
		main="Epeolatry", 				--(25)/0
		sub="Refined Grip +1", 			--3/3
		ammo="Staunch Tathlum", 		--(2)
		head="Fu. Bandeau +1", 			-- 4/0
		body="Futhark Coat +1", 		--7/7
		hands="Runeist Mitons +3",	--2/0
		legs="Eri. Leg Guards +1", 		--7/0
		feet="Erilaz Greaves +1", 		--5/0
		neck="Loricate Torque +1",	 	--6/6
		ear1="Genmei Earring", 			--2/0
		--ear2="Impreg. Earring",
		ear2="Etiolation Earring", 		--0/3
		ring1="Vocane Ring", 			--0/5(7)
		ring2="Defending Ring", 		--10/10
		back=gear.RUN_HP_Cape,
		waist="Flume Belt +1", 			--4/0
		}

	--------------------------------------
	-- Engaged sets
	--------------------------------------

	sets.engaged = {
		main="Lionheart",
		sub="Utu Grip",
		ammo="Yamarang",
		head="Adhemar bonnet +1",
		body="Adhemar Jacket +1",
		hands="Adhemar Wristbands +1",
		legs="Samnuha Tights",
		feet=gear.Herc_TA_feet,
		neck="Anu Torque",
		ear1="Brutal Earring",
		ear2="Sherida earring",
		ring1="Niqmaddu Ring",
		ring2="Epona's Ring",
		back=gear.RUN_DA_Cape,
		waist="Windbuffet Belt +1",
		}

	sets.engaged.LowAcc = set_combine(sets.engaged, {
		ammo="Yamarang",
		--neck="Combatant's Torque",
		})

	sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
		ear1="Digni. Earring",
		ear2="Telos Earring",
		ring2="Chirich Ring",
		})

	sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
		head=gear.Herc_Acc_head,
		legs="Carmine Cuisses +1",
		feet=gear.Herc_Acc_feet,
		neck="Sanctity Necklace",
		ear1="Mache Earring",
		waist="Kentarch Belt +1",
		})

	sets.engaged.Mixed = { --Mixed Set 17%DT, 9% PDT, 0% MDT // 60% PDT with Epeo ~~1200ACC
		ammo="Yamarang",
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		--hands={name="Herculean Gloves", augments={'Accuracy+19 Attack+19','"Triple Atk."+3','INT+12','Accuracy+14',}},
		hands="Turms mittens",
		legs="Meg. Chausses +2",
		feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}},
		neck="Loricate Torque +1",
		waist="Kentarch Belt +1",
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Moonbeam Ring",
		back=gear.RUN_TP_Cape,
		}

	sets.engaged.STP = set_combine(sets.engaged, { --4hit when /SAM
		-- TESTING SET
		ammo="Ginsen",
		head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
		body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}},
		neck="Anu Torque",
		waist="Windbuffet Belt +1",
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		left_ring="Petrov Ring",
		right_ring="Chirich Ring",
		back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+4','"Store TP"+10',}},
		})



	-- Custom buff sets
	sets.buff.Doom = {
		ring1="Saida Ring",
		ring2="Saida Ring",
		waist="Gishdubar Sash",
		}
	sets.buff.BattutaLock = {hands="Turms mittens",}

	sets.CP = {back="Mecisto. Mantle",}
	sets.EffectReceived = {
		ring1="Saida Ring",
		ring2="Saida Ring",
		waist="Gishdubar Sash",
		}

end

-- Call from job_precast() to setup aftermath information for custom timers.
function custom_aftermath_timers_precast()
	info.aftermath.duration = 0
	info.aftermath.level = math.floor(player.tp / 1000)
	if info.aftermath.level == 0 then
		info.aftermath.level = 1
	end
	-- nothing can overwrite lvl 3
	if buffactive['Aftermath: Lv.3'] then
		return
	end
	-- only lvl 3 can overwrite lvl 2
	if info.aftermath.level ~= 3 and buffactive['Aftermath: Lv.2'] then
		return
	end

	if info.aftermath.level == 1 then
		info.aftermath.duration = 270
	elseif info.aftermath.level == 2 then
		info.aftermath.duration = 120
	else
		info.aftermath.duration = 180
	end
end

-- Call from job_aftercast() to create the custom aftermath timer.
function custom_aftermath_timers_aftercast()
	if info.aftermath.duration > 0 then
		local aftermath_name = 'Aftermath: Lv.'..tostring(info.aftermath.level)
		send_command('timers d "Aftermath: Lv.1"')
		send_command('timers d "Aftermath: Lv.2"')
		send_command('timers d "Aftermath: Lv.3"')
		send_command('timers c "'..aftermath_name..'" '..tostring(info.aftermath.duration)..' down abilities/00027.png')

		state.Buff.Aftermath = true
		info.aftermath = {}
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

 

function job_precast(spell, action, spellMap, eventArgs)
	if player.equipment.main == "empty" then
		equip({main="Epeolatry",sub="Utu Grip"})
	end
	--[[
	if spell.english == 'Dimidiation' and player.equipment.main == 'Epeolatry' then
		custom_aftermath_timers_precast()
	end
	]]--
	if spell.english == 'Lunge' then
		local abil_recasts = windower.ffxi.get_ability_recasts()
		if abil_recasts[spell.recast_id] > 0 then
			send_command('input /jobability "Swipe" <t>')
--			add_to_chat(122, '***Lunge Aborted: Timer on Cooldown -- Downgrading to Swipe.***')
			eventArgs.cancel = true
			return
		end
	end
	if spell.english == 'Valiance' then
		local abil_recasts = windower.ffxi.get_ability_recasts()
		if abil_recasts[spell.recast_id] > 0 then
			send_command('input /jobability "Vallation" <me>')
			eventArgs.cancel = true
			return
		end
	end
	if spellMap == 'Utsusemi' then
		if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
			cancel_spell()
			add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
			eventArgs.handled = true
			return
		elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
			send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
		end
	end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.english == 'Lunge' or spell.english == 'Swipe' then
		local obi = get_obi(get_rune_obi_element())
		if obi then
			equip({waist=obi})
		end
	end
	if spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) then
		equip(sets.midcast.EnhancingDuration)
	end
	-- If DefenseMode is active, apply that gear over midcast
	-- choices.  Precast is allowed through for fast cast on
	-- spells, but we want to return to def gear before there's
	-- time for anything to hit us.
	-- Exclude Job Abilities from this restriction, as we probably want
	-- the enhanced effect of whatever item of gear applies to them,
	-- and only one item should be swapped out.
	if state.DefenseMode.value ~= 'None' and spell.type ~= 'JobAbility' then
		handle_equipping_gear(player.status)
		eventArgs.handled = true
	end
end

function job_aftercast(spell, action, spellMap, eventArgs)
	if spell.name == 'Rayke' and not spell.interrupted then
		send_command('input /p *** Rayke: ON ***;')
		--send_command('@timers c "Rayke ['..spell.target.name..']" '..rayke_duration..' down spells/00136.png')
		send_command('wait '..rayke_duration..';input /p *** Rayke: OFF ***;')
	elseif spell.name == 'Gambit' and not spell.interrupted then
		send_command('input /p *** Gambit: ON ***;')
		--send_command('@timers c "Gambit ['..spell.target.name..']" '..gambit_duration..' down spells/00136.png')
		send_command('wait '..gambit_duration..';input /p *** Gambit: OFF ***;')
	elseif spell.name == 'Odyllic Subterfuge' and not spell.interrupted then
		send_command('input /p *** Odyllic Subterfuge: ON ***;')
		send_command('wait 30;input /p *** Odyllic Subterfuge: OFF ***;')
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
	classes.CustomDefenseGroups:clear()
	classes.CustomDefenseGroups:append(state.Knockback.current)
	classes.CustomDefenseGroups:append(state.Death.current)

	classes.CustomMeleeGroups:clear()
	classes.CustomMeleeGroups:append(state.Knockback.current)
	classes.CustomMeleeGroups:append(state.Death.current)
end

function job_buff_change(buff,gain)
	-- If we gain or lose any haste buffs, adjust which gear set we target.
	if buff == "Hasso" and Auto_Hasso == 'ON' and player.sub_job == 'SAM' then
        if not gain then
        	send_command('Hasso')
    	end
	end
	if buff == "doom" then
		if gain then
			equip(sets.buff.Doom)
			send_command('@input /p Doomed.')
			disable('ring1','ring2','waist')
		else
			enable('ring1','ring2','waist')
			handle_equipping_gear(player.status)
		end
	elseif buff == 'embolden' then
		if gain then
			disable('back')
			equip({back="Evasionist's Cape"})
			add_to_chat(060,'[Embolden] ON -- Back Locked')
		elseif not gain then
			enable('back')
			add_to_chat(060,'[Embolden] OFF -- Back Unlocked')
			handle_equipping_gear(player.status)
		end
	elseif buff == 'Battuta' then
		if gain then
			equip(sets.buff.BattutaLock)
			disable('hands')
		elseif not gain then
			enable('hands')
			handle_equipping_gear(player.status)
		end
	end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
	if state.WeaponLock.value == true then
		disable('main','sub')
	else
		enable('main','sub')
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	if player.mpp < 51 then
		idleSet = set_combine(idleSet, sets.latent_refresh)
		end
	if state.Knockback.value == true then
		idleSet = set_combine(idleSet, sets.defense.Knockback)
		end
	if state.Death.value == true then
		idleSet = set_combine(idleSet, sets.defense.Death)
		end
	if state.CP.current == 'on' then
		equip(sets.CP)
		disable('back')
	else
		enable('back')
	end

	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	if state.Knockback.value == true then
		meleeSet = set_combine(meleeSet, sets.defense.Knockback)
		end
	if state.Death.value == true then
		meleeSet = set_combine(meleeSet, sets.defense.Death)
		end

	return meleeSet
end

function customize_defense_set(defenseSet)
	if state.Knockback.value == true then
		defenseSet = set_combine(defenseSet, sets.defense.Knockback)
		end
	if state.Death.value == true then
		defenseSet = set_combine(defenseSet, sets.defense.Death)
		end

	return defenseSet
end

-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
	local msg = '[ Melee'

	if state.CombatForm.has_value then
		msg = msg .. ' (' .. state.CombatForm.value .. ')'
	end

	msg = msg .. ': '

	msg = msg .. state.OffenseMode.value
	if state.HybridMode.value ~= 'Normal' then
		msg = msg .. '/' .. state.HybridMode.value
	end
	msg = msg .. ' ][ WS: ' .. state.WeaponskillMode.value .. ' ]'

	if state.DefenseMode.value ~= 'None' then
		msg = msg .. '[ Defense: ' .. state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ' ]'
	end

	if state.Knockback.value == true then
		msg = msg .. '[ Knockback: ON ]'
	end

	if state.Death.value == true then
		msg = msg .. '[ Death: ON ]'
	end

	if state.Kiting.value then
		msg = msg .. '[ Kiting Mode: ON ]'
	end

	msg = msg .. '[ *Rune: '..state.Runes.current .. '* ]'

	add_to_chat(060, msg)

	eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------
function job_get_spell_map(spell, default_spell_map)
	if spell.skill == 'Blue Magic' then
		for category,spell_list in pairs(blue_magic_maps) do
			if spell_list:contains(spell.english) then
				return category
			end
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------
function job_self_command(cmdParams, eventArgs)
	--ui_self_command(cmdParams, eventArgs)
	if cmdParams[1]:lower() == 'rune' then
		send_command('@input /ja '..state.Runes.value..' <me>')
	end
end

function NotDead()
    local player = windower.ffxi.get_player()
    if player.status ~= 2 and player.status ~= 3 then
       return true
    end
    return false
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function get_rune_obi_element()
	weather_rune = buffactive[elements.rune_of[world.weather_element] or '']
	day_rune = buffactive[elements.rune_of[world.day_element] or '']

	local found_rune_element

	if weather_rune and day_rune then
		if weather_rune > day_rune then
			found_rune_element = world.weather_element
		else
			found_rune_element = world.day_element
		end
	elseif weather_rune then
		found_rune_element = world.weather_element
	elseif day_rune then
		found_rune_element = world.day_element
	end

	return found_rune_element
end

function get_obi(element)
	if element and elements.obi_of[element] then
		return (player.inventory[elements.obi_of[element]] or player.wardrobe[elements.obi_of[element]]) and elements.obi_of[element]
	end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book: (set, book)
--	if player.sub_job == 'BLU' then
--		set_macro_page(2, 12)
--	else
		--set_macro_page(1, 12)
--	end
end

function set_lockstyle()
	send_command('wait 2; input /lockstyleset 25')
end
