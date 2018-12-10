 
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
	
	send_command('//lua load debuffed')
	
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
	send_command('//lua unload debuffed')
end
 
-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
 
    -- Precast Sets
    -- Precast sets to enhance JAs
	sets.precast = {}
	sets.precast.JA = {}
    sets.precast.JA['Chainspell'] = {body="Viti. Tabard +3"}
 
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
 
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
 
    -- Fast cast sets for spells
 
    -- 81%/80% Fast Cast (including trait) for all spells, plus 10% quick cast in separate set, triggered for non-elemental spells
    -- No other FC sets necessary.
    sets.precast.FC = { 																													--30 from trait
		head="Atrophy Chapeau +3",															 												--16
		neck="Voltsurge Torque", 																											--04
		lear="Estoqueur's Earring", 																										--02
		rear="Loquac. Earring", 																											--02
		body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}}, 														--13
		hands="Leyline Gloves", 																											--06
		lring="Prolix Ring", 																												--02
		legs={ name="Lengo Pants", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Refresh"+1',}}, 									--05
		feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+12','Crit.hit rate+1','"Refresh"+1','Mag. Acc.+6 "Mag.Atk.Bns."+6',}},} 	--05
	
	sets.precast.FC.quickcast = set_combine(sets.precast.FC, {
		ammo="Impatiens",				--2
		back="Perimede cape",			--4
		waist="Witful belt",			--3
		rring="Veneficium Ring",		--1
	})
    
	sets.precast.FC.Impact = set_combine(sets.precast.FC.quickcast, {head=empty,body="Twilight Cloak"})
 
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
	
	sets.precast.WS = {
    ammo="Vanir Battery",
    head="Viti. Chapeau +2",
    body="Jhakri Robe +2",
    hands="Atrophy Gloves +3",
    legs="Jhakri Slops +2",
    feet="Jhakri Pigaches +2",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Brutal Earring",
    right_ear="Ishvara Earring",
    left_ring="Apate Ring",
    right_ring="Petrov Ring",
    back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},
}
	
    sets.precast.WS.physical = set_combine(sets.precast.WS, {})
 
	sets.precast.WS.magical = set_combine(sets.precast.WS, {
		ammo="Pemphredo Tathlum",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic burst dmg.+11%',}},
		neck="Sanctity Necklace",
		lear="Friomisi Earring",
		rear="Hecate's Earring",
		body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+21','Mag. Acc.+21','Haste+3','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		lring="Acumen Ring",
		rring="Strendu Ring",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
		waist="Eschan Stone",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2"})
 
 
    sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS.magical, {})
	
	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS.magical, {})
 
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS.physical, {})     
 
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS.physical, {})
 
    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS.physical, {})
 
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS.physical, {})
         
    sets.precast.WS['Death Blossom'] = set_combine(sets.precast.WS, {})
	
	sets.precast.WS['Knights of Round'] = set_combine(sets.precast.WS.physical, {
	})
 
    -- Midcast Sets
	sets.midcast = {}
    sets.midcast.Cure = {
		main="Tamaxchi", 				--22
		--sub="Sors shield",			
		ammo="Regal Gem",
        head="Gendewitha Caubeen",		--10
		--neck="Colossus's Torque",
		lear="Mendi. Earring",			--05
		--rear="Digni. Earring",
        body="Kaykaus Bliaut",			--05 03II
		hands="Telchine Gloves",		--10
		lring="Ephedra ring",						--skill 7
		rring="Ephedra ring",						--skill 7
        back="Vates cape +1",						--skill 7
		--waist="Rumination Sash",
		legs="Atrophy Tights +2",		--10
		feet="Vitiation Boots +3"}
 
    sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.CureSelf = set_combine(sets.midcast.Cure, {rring="Vocane Ring"})
 
    sets.midcast['Enhancing Magic'] = {
        head="Befouled Crown",					-- 16
		neck="Incanter's Torque",					-- 10
		lear="Andoaa earring",					-- 05
		-- rear="Augmenting earring", 3 skill
        body="Viti. Tabard +3",
		hands="Atrophy gloves +3",
		--lring="Perception ring",
        back="Sucellos's cape",
		--waist="Olympus Sash",
		legs="Atrophy Tights +2",
		feet="Lethargy Houseaux +1"}
 
    sets.midcast.EnhancingDuration = set_combine(sets.midcast['Enhancing Magic'], {
		main={ name="Colada", augments={'Enh. Mag. eff. dur. +4','MND+8','"Mag.Atk.Bns."+12',}}, 
		sub="Ammurapi Shield",
		head="Telchine Cap",
		body="Vitiation Tabard +3",
		hands="Atrophy gloves +3",
		legs="Telchine Braconi",
		back="Sucellos's cape",
		feet="Leth. Houseaux +1"})
		
	sets.midcast['Enhancing Magic'].EnSpells = set_combine(sets.midcast.EnhancingDuration,{
	--rear="Hollow Earring",
	hands="Viti. Gloves +2"})
 
    sets.midcast['Enhancing Magic'].GainSpells = set_combine(sets.midcast.EnhancingDuration,{
		hands="Viti. Gloves +2"})
		
	sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration,{--Regen effect + conserver MP. I prefer duration over effect though.
		main="Bolelabunga",
		sub="Culminus",
		--Regen Potency +10%
		
		})
		
	sets.midcast['Refresh III'] = set_combine(sets.midcast.EnhancingDuration,{
		body="Atrophy Tabard +3",		-- Refresh potency +1
		waist="Gishdubar Sash", --self duration buff
		})

	sets.midcast['Temper II'] = set_combine(sets.midcast['Enhancing Magic'],{
				
		})
	
	
	
	sets.buff = {}
    sets.buff.ComposureOther = {
		head="Leth. Chappel +1",
		body="Lethargy Sayon +1",
		hands="Leth. Gantherots +1",
		legs="Lethargy Fuseau +1",
		feet="Lethargy Houseaux +1"}
 
    sets.midcast.Protect = {rring="Sheltered Ring"}
    sets.midcast.Shell = sets.midcast.Protect
 
    sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'],{})--main="Egeking"})
 
    sets.midcast.Cursna = {
		--neck="Malison medallion",
		--back="Oretania's cape +1",
		lring="Ephedra ring",
		rring="Ephedra ring",
		--feet="Vanya clogs"
		}
 
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'],{
		--neck="Stone gorget",
		--rear="Earthcry earring",
		--hands="Stone mufflers",
		waist="Siegel Sash",
		--legs="Haven hose"
		})
 
    sets.midcast['Enfeebling Magic'] = {
		main={ name="Colada", augments={'MND+2','Mag. Acc.+25','"Mag.Atk.Bns."+23','DMG:+13',}},
		sub="Ammurapi Shield",
		ammo="Regal Gem",
		head={ name="Viti. Chapeau +2", augments={'Enhances "Dia III" effect','Enhances "Slow II" effect',}},
		neck="Incanter's Torque",
		left_ear="Digni. Earring",
		right_ear="Regal Earring",
		body="Atrophy Tabard +3",
		hands="Leth. Gantherots +1",
		left_ring="Kishar Ring",
		right_ring="Sangoma Ring",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
		waist="Luminary Sash",
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic burst dmg.+8%','AGI+1','Mag. Acc.+7',}},
		feet={ name="Vitiation Boots +3", augments={'Enhances "Paralyze II" effect',}},
		}
		--388 macc +15 set bonus
 
    sets.midcast.Distract = set_combine(sets.midcast['Enfeebling Magic'], {})
 
    sets.midcast.Frazzle = set_combine(sets.midcast['Enfeebling Magic'], {})
 
    sets.midcast['Dia III'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Viti. Chapeau +2"})
 
    sets.midcast['Slow II'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Viti. Chapeau +2"})
 
    sets.midcast['Elemental Magic'] = {
		main={ name="Colada", augments={'MND+2','Mag. Acc.+25','"Mag.Atk.Bns."+23','DMG:+13',}},
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +1",
		neck="Sanctity Necklace",
		lear="Friomisi Earring",
		rear="Hecate's Earring",
		body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+21','Mag. Acc.+21','Haste+3','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
		hands="Jhakri cuffs +2",
		lring="Acumen Ring",
		rring="Strendu Ring",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
		waist="Eschan Stone",
		legs="Jhakri Slops +2",
		feet="Vitiation Boots +3"}

 
    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})
	
	sets.midcast.Burst = set_combine(sets.midcast['Elemental Magic'], {
		head="Atrophy Chapeau +3",			--10
		neck="Mizu. Kubikazari",			--10
		hands="Amalric Gages",				--05II
		lring="Mujin band",					--05II
		rring="Locus Ring",					--05
		back="Seshaw Cape",					--05
		feet="Jhakri Pigaches +2",})		--07
 
    sets.midcast.Drain = {
		waist="Fucho-no-Obi",
		feet="Merlinic Crackows"}
 
    sets.midcast.Aspir = sets.midcast.Drain
 
    sets.midcast['Stun'] = {
		main={ name="Colada", augments={'MND+2','Mag. Acc.+25','"Mag.Atk.Bns."+23','DMG:+13',}},									-- 41
		sub="Ammurapi Shield",		
		ammo="Pemphredo Tathlum", 																									-- 08 
        head="Carmine mask", 																										-- 38
		neck="Sanctity necklace",																									-- 10
		lear="Dignitary's Earring",																									-- 10
		rear="Estoqueur's Earring",																									-- 03
        body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+21','Mag. Acc.+21','Haste+3','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},	-- 55
		hands="Lethargy gantherots +1", 																							-- 24
		lring="Strendu Ring",																										-- 02
		rring="Sangoma Ring", 																										-- 08
        back="Sucellos's Cape",																										-- 20
		waist="Eschan Stone",																										-- 07
		legs="Lethargy fuseau +1",																									-- 22
		feet="Vitiation Boots +3"}																									-- 15
																																	--263
    -- Sets to return to when not performing an action.
 
    -- Resting sets
    sets.resting = {}
 
    -- Idle sets
	sets.idle = {
		main="Bolelabunga",
		sub="Genmei Shield",
		ammo="Homiliary",
		head="Viti. Chapeau +2",
		body="Jhakri Robe +2",
		hands="Serpentes Cuffs",
		legs={ name="Lengo Pants", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Refresh"+1',}},
		feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+12','Crit.hit rate+1','"Refresh"+1','Mag. Acc.+6 "Mag.Atk.Bns."+6',}},
		neck="Sanctity Necklace",
		waist="Flume Belt",
		lear="Etiolation Earring",
		rear="Infused Earring",
		lring="Sheltered Ring",
		rring="Defending Ring",
		back="Archon Cape",
	}
 
    sets.idle.Town = sets.idle
 
    sets.idle.Weak = sets.idle
 
    -- Defense sets
	sets.defense = {}
    sets.defense.PDT = set_combine(sets.idle, {
		ammo="Staunch Tathlum",			--  2 DT
		head="Aya. Zucchetto +2",		--  3 DT
		body="Ayanmo Corazza +2",		--  6 DT
		hands="Aya. Manopolas +2",		--  3 DT
		legs="Aya. Cosciales +2",		--  5 DT
		feet="Aya. Gambieras +2",		--  3 DT
		neck="Loricate Torque +1",		--  6 DT
		waist="Flume Belt",				--			2 PDT	2 convert MP
		left_ear="Infused Earring",		--	Evasion?
		right_ear="Ethereal Earring",	--					3 convert MP
		left_ring="Vocane Ring",		--  7 DT
		right_ring="Defending Ring",	-- 10 DT
		back="Moonbeam Cape",})			--  5 DT
											--------
											-- 50 DT
    sets.defense.MDT = set_combine(sets.defense.PDT, {
		main="Demers. Degen +1",
		--sub="Beatific shield",			--		25
		neck="Warder's Charm +1",		
		lear="Etiolation earring",		--		03		

        back="Engulfer cape +1",		--		04				
		})
 
    sets.Kiting = {legs="Carmine Cuisses +1"}
 
    sets.latent_refresh = {waist="Fucho-no-obi"}
 
    -- Engaged sets
 
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
 
    -- Normal melee group
    sets.engaged = {
		ammo="Ginsen",
        head="Aya. Zucchetto +2",
		neck="Anu Torque",
		lear="Suppanomimi",
		rear="Eabani Earring",
        body="Ayanmo Corazza +2",
		hands="Atrophy gloves +3",
		lring="Petrov Ring",
		rring="Hetairoi Ring",
        back="Bleating Mantle",
		waist="Windbuffet belt +1",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2"}
 
    -- Sets for special buff conditions on spells.
	sets.buff = {}
    sets.buff.Saboteur = {hands="Lethargy Gantherots +1"}
end