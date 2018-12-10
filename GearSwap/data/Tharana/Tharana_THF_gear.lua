
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Mod')
    state.HybridMode:options('Normal', 'Evasion', 'PDT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.PhysicalDefenseMode:options('Evasion', 'PDT')
	state.AutoWS = M{['description']='Auto WS', "Rudra's Storm", 'Aeolian Edge', 'Shark Bite'}

    gear.default.weaponskill_neck = "Asperity Necklace"
    gear.default.weaponskill_waist = "Fotia Belt"

    -- Additional local binds
    send_command('bind ^` input /ja "Flee" <me>')
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind !- gs c cycle targetmode')
	send_command('bind @home gs c cycle AutoWS')
	send_command('bind !p gs c auto_action')
	send_command('bind ![ gs c auto_trust')

    --select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Special sets (required by rules)
    --------------------------------------

    sets.TreasureHunter = {
		hands="Plunderer's Armlets", 
		feet="Skulker's poulaines"}
    sets.ExtraRegen = {ear2="Unfused earring"}
    sets.Kiting = {feet="Jute boots"}
	
    sets.buff['Sneak Attack'] = {
		ammo="Yetshila",
        head="Plunderer's Bonnet +1",
		neck="Asperity Necklace",
		ear1="Eabani Earring",ear2="Suppanomimi",
        body="Plunderer's Vest +1",
		hands="Plunderer's Armlets +1",
		ring1="Petrov Ring",ring2="Epona's Ring",
        back="Canny cape",
		waist="Windbuffet belt +1",
		legs="Plunderer's Culottes +1",
		feet="Plunderer's Poulaines +1"}

    sets.buff['Trick Attack'] = {
		ammo="Yetshila",
        head="Plunderer's Bonnet +1",
		neck="Asperity Necklace",
		ear1="Eabani Earring",ear2="Suppanomimi",
        body="Plunderer's Vest +1",
		hands="Plunderer's Armlets +1",
		ring1="Petrov Ring",ring2="Epona's Ring",
        back="Canny cape",
		waist="Windbuffet belt +1",
		legs="Plunderer's Culottes +1",
		feet="Plunderer's Poulaines +1"}

    -- Actions we want to use to tag TH.
    sets.precast.Step = sets.TreasureHunter
    sets.precast.Flourish1 = sets.TreasureHunter
    sets.precast.JA.Provoke = sets.TreasureHunter


    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Collaborator'] = {head="Skulker's Bonnet +1"}
    sets.precast.JA['Accomplice'] = {head="Skulker's Bonnet +1"}
    sets.precast.JA['Flee'] = {feet="Plunderer's Poulaines +1"}
    sets.precast.JA['Hide'] = {body="Plunderer's Vest +1"}
    sets.precast.JA['Conspirator'] = {} -- {body="Skulker's Vest +1"}
    sets.precast.JA['Steal'] = {
		head="Plunderer's Bonnet",
		hands="Plunderer's Armlets +1",
		legs="Plunderer's Culottes +1",
		feet="Plunderer's Poulaines +1"}
    sets.precast.JA['Despoil'] = {
		legs="Skulker's Culottes +1",
		feet="Skulker's Poulaines +1"}
    sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +1"}
    sets.precast.JA['Feint'] = {} -- {legs="Assassin's Culottes +1"}

    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']


    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = set_combine(sets.precast.Waltz,{})


    -- Fast cast sets for spells
    sets.precast.FC = {
		head="Haruspex Hat",
		ear2="Loquacious Earring",
		ring1="Prolix Ring"}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})


    -- Ranged snapshot gear
    sets.precast.RA = {}


    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Ginsen",
		head={ name="Adhemar Bonnet", augments={'STR+10','DEX+10','Attack+15',}},
		body="Abnoba Kaftan",
		hands={ name="Adhemar Wristbands", augments={'STR+10','DEX+10','Attack+15',}},
		legs={ name="Herculean Trousers", augments={'Accuracy+18 Attack+18','"Store TP"+5','STR+3','Accuracy+13','Attack+5',}},
		feet={ name="Herculean Boots", augments={'Accuracy+10 Attack+10','"Triple Atk."+3','Accuracy+12','Attack+1',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal Earring",
		right_ear="Suppanomimi",
		left_ring="Rufescent Ring",
		right_ring="Apate Ring",
		back="Bleating Mantle",}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {ammo="Hasty pinion +1"})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {ring1="Stormsoul Ring",legs="Nahtirah Trousers"})
    sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {ammo="Hasty pinion +1"})
    sets.precast.WS['Exenterator'].Mod = set_combine(sets.precast.WS['Exenterator'], {})
    sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS['Exenterator'].Mod, {ammo="Yetshila"})
    sets.precast.WS['Exenterator'].TA = set_combine(sets.precast.WS['Exenterator'].Mod, {ammo="Yetshila"})
    sets.precast.WS['Exenterator'].SATA = set_combine(sets.precast.WS['Exenterator'].Mod, {ammo="Yetshila"})

    sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Dancing Edge'].Acc = set_combine(sets.precast.WS['Dancing Edge'], {ammo="Hasty pinion +1"})
    sets.precast.WS['Dancing Edge'].Mod = set_combine(sets.precast.WS['Dancing Edge'], {})
    sets.precast.WS['Dancing Edge'].SA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {ammo="Yetshila"})
    sets.precast.WS['Dancing Edge'].TA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {ammo="Yetshila"})
    sets.precast.WS['Dancing Edge'].SATA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {ammo="Yetshila"})

    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {ammo="Yetshila",
        head="Lilitu headpiece",
		neck="Rancor Collar",
		ear1="Brutal Earring",ear2="Moonshade Earring"})
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {ammo="Hasty pinion +1"})
    sets.precast.WS['Evisceration'].Mod = set_combine(sets.precast.WS['Evisceration'], {})
    sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'].Mod, {})
    sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'].Mod, {})
    sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'].Mod, {})

    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
		head="Plunderer's Bonnet +1",
		ear1="Brutal Earring",ear2="Moonshade Earring"})
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {ammo="Hasty pinion +1"})
    sets.precast.WS["Rudra's Storm"].Mod = set_combine(sets.precast.WS["Rudra's Storm"], {})
    sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {
		ammo="Yetshila",
        body="Plunderer's Vest +1",
		legs="Plunderer's Culottes +1"})
    sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {
		ammo="Yetshila",
        body="Plunderer's Vest +1",
		legs="Plunderer's Culottes +1"})
    sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {
		ammo="Yetshila",
        body="Plunderer's Vest +1",
		legs="Plunderer's Culottes +1"})

    sets.precast.WS['Aeolian Edge'] = {
		ammo="Jukukik Feather",
        head="Wayfarer Circlet",
		neck="Stoicheion Medal",
		ear1="Friomisi Earring",ear2="Moonshade Earring",
        body="Wayfarer Robe",
		hands="Plunderer's Armlets +1",
		ring1="Acumen Ring",ring2="Demon's Ring",
        back="Toro Cape",
		waist="Anguinus Belt",
		legs="Shneddick Tights +1",
		feet="Wayfarer Clogs"}

    sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)


    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {}

    -- Specific spells
    sets.midcast.Utsusemi = {}

    -- Ranged gear
    sets.midcast.RA = {}

    sets.midcast.RA.Acc = {}


    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------

    -- Resting sets
    sets.resting = {}


    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle = {
		--sub={ name="Sandung", augments={'Accuracy+50','Crit. hit rate+5%','"Triple Atk."+3',}},
		ammo="Amar Cluster",
		head="Pillager's Bonnet",
		body="Emet Harness",
		hands="Floral Gauntlets",
		legs="Ta'lab Trousers",
		neck="Twilight Torque",
		waist="Sarissapho. Belt",
		left_ear="Eabani Earring",
		right_ear="Suppanomimi",
		left_ring="Persis Ring",
		right_ring="Defending Ring",
		back="Solemnity Cape",
		feet="Jute boots"}

    sets.idle.Town = set_combine(sets.idle,{feet="Jute boots"})

    sets.idle.Weak = set_combine(sets.idle,{feet="Jute boots"})


    -- Defense sets

    sets.defense.Evasion = {
        head="Plunderer's Bonnet +1",
		neck="Twilight torque",
        body="Emet harness",
		hands="Plunderer's Armlets +1",
		ring1="Defending Ring",ring2="Vocane Ring",
        back="Canny Cape",
		waist="Flume Belt",
		legs="Kaabnax Trousers",
		feet="Iuitl Gaiters +1"}

    sets.defense.PDT = {
		ammo="Iron Gobbet",
        head="Plunderer's Bonnet +1",
		neck="Twilight Torque",
        body="Emet harness",
		hands="Plunderer's Armlets +1",
		ring1="Defending Ring",ring2="Vocane Ring",
        back="Iximulew Cape",
		waist="Flume Belt",
		legs="Plunderer's Culottes +1",
		feet="Iuitl Gaiters +1"}

    sets.defense.MDT = {
		ammo="Demonry Stone",
        head="Plunderer's Bonnet +1",
		neck="Twilight Torque",
        body="Plunderer's Vest +1",
		hands="Plunderer's Armlets +1",
		ring1="Defending Ring",ring2="Vocane Ring",
        back="Engulfer Cape",
		waist="Flume Belt",
		legs="Plunderer's Culottes +1",
		feet="Iuitl Gaiters +1"}


    --------------------------------------
    -- Melee sets
    --------------------------------------

    -- Normal melee group
    sets.engaged = { 
	    ammo="Focal Orb",
		head="Pillager's Bonnet",
		body="Samnuha Coat",
		hands="Plunderer's Armlets",
		legs="Samnuha Tights",
		feet="Jute Boots",
		neck="Anu Torque",
		waist="Windbuffet Belt",
		left_ear="Brutal Earring",
		right_ear="Suppanomimi",
		left_ring="Apate Ring",
		right_ring="Rajas Ring",
		back="Canny Cape",
	}
	sets.engaged.Acc = set_combine(sets.engaged,{
		neck="Sanctity Necklace",
		back="Ground. Mantle +1",
		waist="Eschan Stone",
		
		})
        
    -- Mod set for trivial mobs (Skadi+1)
    sets.engaged.Mod = set_combine(sets.engaged,{})
    -- Mod set for trivial mobs (Thaumas)
    sets.engaged.Mod2 = set_combine(sets.engaged,{})
    sets.engaged.Evasion = set_combine(sets.engaged,{})
    sets.engaged.Acc.Evasion = set_combine(sets.engaged,{})
    sets.engaged.PDT = set_combine(sets.engaged,{})
    sets.engaged.Acc.PDT = set_combine(sets.engaged,{})

end
