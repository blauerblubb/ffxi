-- Define sets and vars used by this job file.
function init_gear_sets()
	--bpmagicstaff={ name="Espiritus", augments={'Enmity-6','Pet: "Mag.Atk.Bns."+30','Pet: Damage taken -4%',}}
        --bpmagicaccstaff = { name="Espiritus", augments={'MP+50','Pet: "Mag.Atk.Bns."+20','Pet: Mag. Acc.+20',}}
	bpmagicstaff= "Grioavolr" --{ name="Grioavolr", augments={'Blood Pact Dmg.+4','Pet: INT+10','Pet: Mag. Acc.+15','Pet: "Mag.Atk.Bns."+22',}}
	bpmagicaccstaff= "Grioavolr" --{ name="Grioavolr", augments={'Blood Pact Dmg.+4','Pet: INT+10','Pet: Mag. Acc.+15','Pet: "Mag.Atk.Bns."+22',}}
	smnskillstaff = "Espiritus" --{ name="Espiritus", augments={'Summoning magic skill +15','Pet: Mag. Acc.+30','System: 2 ID: 153 Val: 3',}}
	avatarattackstaff = "Espiritus" --{ name="Espiritus", augments={'System: 2 ID: 136 Val: 14','Pet: Attack+25','System: 2 ID: 152 Val: 3',}}
	conveyance =  "Campestres's Cape" --{ name="Conveyance Cape", augments={'Summoning magic skill +4','Blood Pact Dmg.+4','Blood Pact ab. del. II -3',}}
	--if you don't have 3 staff you can set them all to the same one, until you do get more.  Nirvana is the best avatarattackstaff, espiritus techinically best for the other 2 with right augs
	--if you're confused for any sets with augs or just wanna save time, just equip the gear and type //gs export lua and it will be in your data/export folder

	organizer_items = {
    echos="Echo Drops",
    food1="Tavnazian Taco",
	food2="Sublime Sushi",
    orb="Macrocosmic Orb"}
	
	sets.petmab = { -- this will be used as a base for all magical bp rage, slots can be overridden for types later on
	    head="Apogee Crown",
	    --hands="Apogee Mitts",
	    --hands={ name="Merlinic Dastanas", augments={'Pet: Mag. Acc.+24 Pet: "Mag.Atk.Bns."+24','Pet: "Mag.Atk.Bns."+15',}},
	    hands="Merlinic Dastanas", --augments={'Pet: Mag. Acc.+16 Pet: "Mag.Atk.Bns."+16','Blood Pact Dmg.+9','System: 1 ID: 1792 Val: 8','Pet: Mag. Acc.+7','Pet: "Mag.Atk.Bns."+9',}},
	    body="Apogee Dalmatica",
	    legs="Apogee Slacks",
	    feet="Apogee Pumps",
	    main=bpmagicstaff,
	    sub="Vox Grip",
	    ammo="Sancus Sachet",
	    neck="Deino Collar",
	    waist="Kobo Obi",
	    left_ear="Gelos Earring",
	    --right_ear="Andoaa earring",
	    right_ear="Esper earring",
	    left_ring="Speaker's Ring",
	    right_ring="Evoker's ring",
	    --back="Scintillating Cape"
	    back=conveyance
	    --ring2="Globidonta Ring",
	    --back="Argochampsa mantle",

	    --head={ name="Helios Band", augments={'Pet: "Mag.Atk.Bns."+29','Pet: Crit.hit rate +4','Blood Pact Dmg.+4',}}, 
	    --body={ name="Helios Jacket", augments={'Pet: "Mag.Atk.Bns."+28','Pet: Crit.hit rate +4','Blood Pact Dmg.+4',}},
	    --hands={ name="Helios Gloves", augments={'Pet: "Mag.Atk.Bns."+28','Pet: Crit.hit rate +4','Blood Pact Dmg.+4',}},
	    --legs={ name="Helios Spats", augments={'Pet: "Mag.Atk.Bns."+29','Pet: Crit.hit rate +4','Blood Pact Dmg.+5',}},
	    --feet={ name="Helios Boots", augments={'Pet: "Mag.Atk.Bns."+28','Pet: Crit.hit rate +3','Blood Pact Dmg.+6',}},
	}

	-- Magic Accuracy setting, overrides gear above
	sets.bp_magic_acc = {
	    main=bpmagicaccstaff,
	    hands="Apogee Mitts",
	    back=conveyance
	}
	-- Physical Accuracy setting, overrides physical pact
	sets.bp_phys_acc = {
	    hands="Apogee Mitts",
	    back=conveyance
	}
	-- Hybrid Accuracy setting, overrides hybrid pact
	sets.bp_hybrid_acc = {
	    main=bpmagicaccstaff,
	    hands="Apogee Mitts",
	    back=conveyance
	}


	--this will be used for many types of wards, max your summoning skill for longer ward duration and more magic acc
	--wards can be empowered by empy bonus your call on to use it or not
	sets.smnskill = { 
	    main=smnskillstaff,
	    sub="Vox Grip",
	    ammo="Sancus Sachet",
	    --head="Convoker's Horn +1",
	    head="Beckoner's Horn",
	    body="Beckoner's Doublet +1",
	    --hands="Glyphic Bracers +1",
	    hands="Lamassu Mitts +1",
	    legs="Beckoner's spats +1",
	    feet="Apogee Pumps",
	    --neck="Caller's Pendant",
	    neck="Melic Torque",
	    waist="Lucidity sash",
	    --waist="Kobo Obi",
	    --left_ear="Caller's Earring",
	    left_ear="Summoning earring",
	    right_ear="Andoaa earring",
		left_ring="Globidonta Ring",
	    right_ring="Evoker's ring",
	    back=conveyance
	}

	--Helios Notes
	--MAX: crit 20% mab 150 bpdmg 35
	--AT: crit 19% mab 142 bpdmg 23
	--MISSING: crit 1% mab 8 bpdmg 12

	sets.cpmode = {back="Mecisto. Mantle"}

	--for when you wanna melee for self skill chains, or procing voidwatch, or just wanna crack some skulls the old fashioned way
	sets.tplock = { 
		main=bpmagicstaff
	}
	sets.inwkr = {
		neck="Arciela's Grace +1"
	}

	--Feet is your biggest -perp slot, especially with apogee+1 being a massive -9.  Evans earring can help counter this, I keep moonshade on my left ear.  Lucidity helps too but my perp set uses it already
	sets.movement = { 
		right_ear="Evans earring",
		--waist="Lucidity sash",
		feet="Herald's Gaiters"
	}
	
	--When you zone into mog gardens, what you wear
	sets.farmer = { 
		}

	--For more movement in Adoulin
	sets.adoulinmovement = { 
		body="Councilor's Garb"
	}

	--if you use organizer and want to keep some things in inventory, weird I know but it works
	sets.keep = {
		left_ring="Warp Ring",
		right_ring="Capacity Ring",
	}
	sets.keep2 = {
		left_ring="Echad Ring",
		right_ring="Trizek Ring",
	}
	sets.keep3= {
		--left_ring="Holy Water",
		--main="Remedy",
		--sub="Echo Drops",
		--head="Grape Daifuku +1",
		--body="Grape Daifuku",
		--legs="Akamochi",
		--feet="Akamochi +1",
		--back="Rolanberry Daifuku",
		--ammo="Rolanberry Daifuku +1",
	}


		
    --------------------------------------
    -- Precast Sets
    --------------------------------------
   
    -- Precast sets to enhance JAs
	sets.precast = {}
	sets.precast.JA = {}
    sets.precast.JA['Astral Flow'] = {head="Glyphic Horn +1"}

    sets.precast.JA['Mana Cede'] = {hands="Beckoner's bracers +1"}
    sets.precast.JA['Elemental Siphon'] = {
	    main=smnskillstaff,
	    sub="Vox Grip",
	    ammo="Esper Stone +1",
	    head={ name="Telchine Cap", augments={'"Elemental Siphon"+30','Enh. Mag. eff. dur. +8',}},
		body={ name="Telchine Chas.", augments={'"Elemental Siphon"+25','INT+6 MND+6',}},
		hands={ name="Telchine Gloves", augments={'"Elemental Siphon"+35','Enh. Mag. eff. dur. +10',}},
		legs={ name="Telchine Braconi", augments={'"Elemental Siphon"+30',}},
	    feet="Beck. Pigaches +1",
	    neck="Melic Torque",
	    waist="Kobo Obi",
	    --left_ear="",
	    right_ear="Andoaa earring",
	    left_ring="Zodiac Ring",--technically shouldn't use on light or darks day, going to add logic for it later
	    right_ring="Evoker's Ring",
	    back=conveyance
    }

	sets.precast.BloodPactWard = set_combine(sets.smnskill, { --I just stack it all because when I do salvage or a gear slot is locked by a NM it's nice
		main=smnskillstaff, --II -2
		ammo="Sancus Sachet",-- II -5
		head="Beckoner's Horn",
		--body="Beck. Doublet +1", -- -6
		body="Shomonjijoe +1", -- -8
		hands="Glyphic Bracers +1",-- 6
		ear2="Evans Earring", -- 2
		back="Conveyance cape" --II -3
		--gift -5
			
		-- delay 1: -15 cap (-16 equipped)
		-- delay II: -10
		-- gift: -5
	    })
	
    sets.precast.BloodPactRage = sets.precast.BloodPactWard


    sets.burstmode = {}
    sets.burstmode.Burst = {
	    hands="Glyphic Bracers +1"
    }

    -- Fast cast sets for spells
    sets.precast.FC = {
	    main="Malevolence", --5
	    sub="Chanter's Shield",--3 
	    -- head="Vanya hood", --10
	    head={ name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic burst dmg.+11%',}}, --8
	    neck="Voltsurge Torque",--4
	    right_ear="Loquacious earring",--2
	    ear1="Enchntr. Earring +1",--2
	    -- hands={ name="Telchine Gloves", augments={'Mag. Acc.+12','"Fast Cast"+5','"Regen" potency+1',}}, --5
	    -- body="Marduk's jubbah +1",-- +6
	    body="Inyanga Jubbah +1", --10
	    -- ring1="Weatherspoon ring",--5
	    left_ring="Prolix ring", -- 2
	    back="Swith cape +1", --4
	    waist="Witful belt", --3
	    legs="Lengo Pants", --5
	    feet="Merlinic Crackows" --11
    }
    --rahab --+2
    --marduk --+6
    --zendik --+2
    --ammo --+2
    --max obtainable 81, 83 with ammo
    --at 71 and 86 with rdm sub
    
    sets.precast.FC['Stoneskin'] = {
		head="Umuthi hat",
		hands="Carapacho cuffs",
    --waist="Siegel Sash", --8
    }
    sets.precast.FC.Resistant = sets.precast.FC 
		--this is still in the works for me, I want it to work that it makes compromises between casting speed, keeping you alive, spell interuption gear, and skill gear for that type of spell to reduce interuption rate
	    --main="Earth Staff", -- -20 PDT
	    --sub="Vox Strap",
	    --head="Vanya hood", --10
	    --body="Vrikodara Jupon", --5 -3 PDT
	    --hands={ name="Telchine Gloves", augments={'Mag. Acc.+12','"Fast Cast"+5','"Regen" potency+1',}}, --5
	    --legs="Lengo pants", --5 -1 PDT
	    --feet="Regal Pumps", --7
	    --left_ring="Defending ring", -- -10 DT
	    --right_ring="Prolix ring", -- 2
	    --neck="Wiglen Gorget", -- -6 PDT
	    --back="Swith cape +1", --3
    
    --39
    --    sets.precast.FC['Cure'] = set_combine(sets.precast.FC, {
    --	    main="Tamaxchi",
    --	    sub="Genmei shield",
    --	    body="Heka's kalasiris",
    --	    back="pahtli cape",
    --	    feet="Chelona boots"
    --    })
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}
 
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Myrkr'] = {}
    sets.precast.WS['Shattersoul'] = { --stack INT and MAB, it's a magical WS, this isn't a very good set for it ;p
	    head="Apogee Crown",
	    body="Witching Robe",
	    hands="Apogee Mitts",
	    waist="Eschan Stone",
	    --legs="Helios Spats",
	    --feet="Helios Boots",
	    left_ear="Hecate's Earring",
	    right_ear="Friomisi Earring",
	    neck="Sanctity necklace",
	    back="Seshaw Cape",
    }
 
   
    --------------------------------------
    -- Midcast sets
    --------------------------------------
 
    --sets.midcast.FastRecast = {
    --	    main="Marin Staff",
    --	    sub="Vivid Strap",
    --	    ammo="Sancus Sachet",
    --	    head="Haruspex hat",
    --	    neck="Jeweled collar",
    --	    ear2="Loquacious earring",
    --	    hands="Regimen mittens",
    --	    body="Vanir cotehardie",
    --	    ring1="Weatherspoon ring",
    --	    ring2="Prolix ring",
    --	    back="Swith cape",
    --	    waist="Witful belt",
    --	    legs="Lengo pants",
    --	    feet="Glyph pigaches +1"
    --}
	sets.midcast = {}
    sets.midcast.Cure = {
	    --main="Serenity",
	    main="Arka IV", -- 24
		--head="Vanya hood",
	    body="Facio bliaut", --12
	    hands="Telchine Gloves", --10
	    --legs="Vanya slops",
	    --feet="Vanya clogs",
	    left_ear="Mendicant's earring", --5
	    -- right_ear="Roundel Earring",
	    -- right_ring="Sirona's Ring",
	    -- left_ring="Ephedra Ring",
	    -- neck="Nodens Gorget",
	    waist="Witful Belt",
	    --back="Thaumaturge's Cape"
    }
    --Notes, but outdated
    --power:787.25
    --cure potency: 50+19 
    --haste:8+3+3+5+3+3 = 25
    --conserve mp: 18
    --enmity:-10 + -5
    sets.midcast.Cure.Self = {
	    neck="Phalaina locket",
	    waist="Gishdubar Sash",
    }
    sets.midcast.Weather = {
	    back="Twilight Cape"
    }
    sets.midcast.Refresh = {}
    sets.midcast.Refresh.Self = {
	    waist="Gishdubar Sash",
    }

    sets.midcast.Cursna = {
	    --right_ring="Sirona's Ring",
	    --left_ring="Ephedra Ring",
	    --head="Vanya hood",
	    --feet="Vanya clogs",
    }          
    sets.midcast.Cursna.Self = {
	    waist="Gishdubar Sash",
    }
    sets.midcast['Enhancing Magic'] = {
	    neck="Melic Torque", --+10
	    body="Telchine Chasuble", --+12
	    right_ear="andoaa earring", --+5
	    feet="Regal Pumps", --+10
    }
    sets.midcast.Stoneskin = {
	    neck="Nodens Gorget", --+30
	    --left_ear="Earthcry Earring", +10
	    --legs="Shedier Seraweels",--+35
	    --waist="Siegel Sash",--+20
    }
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'],sets.midcast.Stoneskin)

    sets.midcast['Elemental Magic'] = {
	    main="Malevolence",
	    sub="Culminus", 
	    head="Helios band",
		--head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+30','"Fast Cast"+6','MND+6','Mag. Acc.+4',}}, 
	    --head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Mag. Acc.+7',}},
	    --neck="Satlada Necklace",
	    neck="Sanctity Necklace",
	    ear1="Friomisi Earring",
	    ear2="Hecate's Earring",
	    left_ring="Strendu Ring",
	    right_ring="Acumen Ring",
		--left_ring="Fenrir Ring",
	    --waist="Aswang Sash",
	    waist="Eschan Stone",
	    back="Seshaw Cape",
		body="Amalric doublet",
	    --body="Witching Robe",
	    --hands="Psycloth Manillas",
	    --hands={ name="Merlinic Dastanas", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','MND+3','Mag. Acc.+11',}},
	    hands="Helios gloves",
		legs="Hagondes pants +1",
		--legs="Gyve trousers",
	    --feet="Tutyr Sabots"
	    --feet="Merlinic Crackows"
		feet="Helios boots"
    }
    
    sets.midcast['Enfeebling Magic'] = {
	    --body="Cohort Cloak",
	    --legs="Vanya Slops",
	    --neck="Imbodla Necklace",
	    --left_earring="Lifestorm earring",
	    --right_earring="Psystorm earring",
	    --ammo="Kalboron stone"
    }
    --
    --    sets.midcast['Dark Magic'] = {
    --    }
 
    sets.meleehybrid = {
	    neck="Empath Necklace",
	    left_ear="Bladeborn Earring",
	    right_ear="Steelflash Earring",
	    waist="Olseni Belt",
    }
 
    -- Avatar pact sets.  All pacts are Ability type.
   
    -- Max out Summoning Magic Skill
	sets.midcast.Pet = {}
    sets.midcast.Pet.BloodPactWard = { --override your smnskill set with anything here
    }
    sets.midcast.Pet.BloodPactWard = set_combine(sets.smnskill,sets.midcast.Pet.BloodPactWard)

    --you want to put tp bonus and + to hp here for stronger cures, smn skill won't matter
    sets.midcast.Pet.TPBloodPactWard = set_combine(sets.smnskill,{
	    head="Apogee Crown",
	    hands="Apogee Mitts",
	    body="Apogee Dalmatica",
	    legs="Enticer's Pants",
	    feet="Apogee Pumps"
    })

    sets.midcast.Pet.DebuffBloodPactWard = { --override your smnskill set here
    }
    sets.midcast.Pet.DebuffBloodPactWard = set_combine(sets.smnskill,sets.midcast.Pet.DebuffBloodPactWard)
       
    sets.midcast.Pet.DebuffBloodPactWard.Acc = set_combine(sets.midcast.Pet.DebuffBloodPactWard,pet.petmabacc)
   
    sets.midcast.Pet.PhysicalBloodPactRage = {
	    main=avatarattackstaff,
	    sub="Vox Grip",
	    ammo="Sancus Sachet",
	    head="Apogee Crown",
	    body="Apogee Dalmatica",
	    --hands="Apogee Mitts",
	    hands="Merlinic Dastanas", --augments={'Pet: Mag. Acc.+16 Pet: "Mag.Atk.Bns."+16','Blood Pact Dmg.+9','System: 1 ID: 1792 Val: 8','Pet: Mag. Acc.+7','Pet: "Mag.Atk.Bns."+9',}},
	    legs="Apogee Slacks",
	    feet="Apogee Pumps",
	    neck="Empath necklace",
	    waist="Incarnation Sash",
	    left_ear="Gelos Earring",
	    right_ear="Esper earring",
	    left_ring="Globidonta Ring",
	    right_ring="Evoker's ring",
	    back="Penetrating Cape",
	    --back="Scintillating Cape",
	    feet="Apogee Pumps",
    }
    sets.midcast.Pet.PhysicalBloodPactRage.Acc = set_combine(sets.midcast.Pet.PhysicalBloodPactRage,{
	    hands="Apogee Mitts"
    })
    sets.midcast.Pet.HybridBloodPactRage = {
	    main=bpmagicstaff,
	    sub="Vox Grip",
	    ammo="Sancus Sachet",
	    head="Apogee Crown",
	    --hands="Apogee Mitts",
	    --hands={ name="Merlinic Dastanas", augments={'Pet: Mag. Acc.+24 Pet: "Mag.Atk.Bns."+24','Pet: "Mag.Atk.Bns."+15',}},
	    hands="Merlinic Dastanas", --augments={'Pet: Mag. Acc.+16 Pet: "Mag.Atk.Bns."+16','Blood Pact Dmg.+9','System: 1 ID: 1792 Val: 8','Pet: Mag. Acc.+7','Pet: "Mag.Atk.Bns."+9',}},
	    body="Apogee Dalmatica",
	    legs="Apogee Slacks",
	    feet="Apogee Pumps",
	    neck="Deino Collar",
	    waist="Incarnation Sash",
	    left_ear="Gelos Earring",
	    right_ear="Esper earring",
	    left_ring="Speaker's Ring",
	    right_ring="Globidonta Ring",
	    back="Scintillating Cape"
	    --back={ name="Conveyance Cape", augments={'Summoning magic skill +4','Blood Pact Dmg.+4','Blood Pact ab. del. II -3',}},
	    --back="Penetrating Cape",
	    --back="Argochampsa mantle",
    }
    sets.midcast.Pet.HybridBloodPactRage.Acc = set_combine(sets.midcast.Pet.HybridBloodPactRage,{
	    main=bpmagicaccstaff,
	    hands="Apogee Mitts"
    })
    sets.midcast.interruption = {
	    main=smnskillstaff,
	    sub="Vox Grip",
	    ammo="Sancus Sachet",
	    head="Convoker's Horn +1",
	    hands="Lamassu Mitts +1",
	    neck="Melic Torque",
	    waist="Lucidity sash",
	    left_ear="Evans Earring",
	    right_ear="Andoaa earring",
	    left_ring="Globidonta Ring",
	    right_ring="Evoker's ring",
	    back=conveyance
    }
    --sets.midcast.interruption = set_combine(sets.petmab,sets.midcast.interruption)
 
    sets.midcast.Pet.MagicalBloodPactRage = {
    }
 
    sets.midcast.Pet.MagicalBloodPactRage = set_combine(sets.petmab,sets.midcast.Pet.MagicalBloodPactRage)
    sets.midcast.Pet.MagicalBloodPactRage.Acc = set_combine(sets.midcast.Pet.MagicalBloodPactRage,pet.petmabacc)
    sets.midcast.Pet.TPMagicalBloodPactRage = set_combine(sets.petmab,{legs="Enticer's Pants"})
    sets.midcast.Pet.TPMagicalBloodPactRage.Acc = set_combine(sets.midcast.Pet.TPMagicalBloodPactRage,pet.petmabacc)
    sets.midcast.Pet.IfritMagicalBloodPactRage = set_combine(sets.petmab,{left_ring="Speaker's Ring",right_ring="Globidonta Ring"})
    sets.midcast.Pet.IfritMagicalBloodPactRage.Acc = set_combine(sets.midcast.Pet.IfritMagicalBloodPactRage,sets.petmabacc)
 
    -- Spirits cast magic spells, which can be identified in standard ways.
   
    --    sets.midcast.Pet.WhiteMagic = {
    --	    ammo="Sancus Sachet",
    --	    main="Tumafyrig",
    --	    head="Convoker's Horn +1 +1",
    --	    neck="Caller's Pendant",
    --	    ear1="Andoaa earring",
    --	    ear2="Summoning earring",
    --	    body="Anhur Robe",
    --	    hands="Glyphic Bracers +1 +1",
    --	    ring1="Evoker's Ring",
    --	    ring2="Globidonta Ring",
    --	    back="Conveyance cape",
    --	    waist="Lucidity sash",
    --	    legs="Marduk's Shalwar +1",
    --	    sub="Vox grip",
    --	    feet="Marduk's crackows +1"
    --    }

    --    sets.midcast.Pet['Elemental Magic'] = set_combine(sets.midcast.Pet.BloodPactRage, {legs="Helios spats"})
    -- 
    --    sets.midcast.Pet['Elemental Magic'].Resistant = {}
   
 
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
   
    -- Resting sets
    sets.resting = {}
   
    -- Idle sets
    sets.idle = {
	    main=bpmagicstaff,
	    sub="Vox Grip",
	    ammo="Sancus Sachet",
	    head="Convoker's Horn +1",
	    body="Shomonjijoe +1",
	    hands="Asteria Mitts +1",
	    legs="Assid. pants +1",
	    feet="Apogee Pumps",
	    --neck="Wiglen Gorget",
	    neck="Sanctity Necklace",
	    waist="Fucho-no-obi",
	    left_ear="Moonshade Earring",
	    right_ear="Gelos Earring",
	    --left_ring="Gelatinous Ring +1",
	    --left_ring="Thurandaut ring",
	    left_ring="Defending Ring",
	    right_ring="Evoker's ring",
	    back=conveyance
    }
      sets.damagetaken = {}
      sets.damagetaken.None = {
      }
      sets.damagetaken.DT = {
	      --body="Onca Suit",--10
	      hands="",
	      legs="",
	      feet="",
		  right_ring="Vocane Ring", --7
	      left_ring="Defending Ring", --10
	      neck="Loricate Torque +1", --5
	      --back="Solemnity Cape", --4
      }
      sets.damagetaken.PDT = { --
	      main="Earth Staff", --20
	      --main="Mafic Cudgel", --10
	      --sub="Genmei Shield", --10
	      left_ring="Defending Ring",--10
	      right_ring="Vocane Ring",--7
	      --neck="Wiglen Gorget",--6
	      neck="Loricate Torque +1",--6
	      --body="Onca Suit", --10
	      hands="",
	      legs="",
	      feet="",
	      back="Archon Cape"--4
	      --back="Repulse Mantle"--4
	      --back="Umbra Cape"--6, 12 at night
      }
      sets.damagetaken.MDT = {--Shell V is around 24%
	      left_ring="Defending Ring",--10
	      body="Inyanga Jubbah",--10
	      --back="Solemnity Cape",--4
	      neck="Loricate Torque +1",--6
	      right_ring="Vocane Ring",--7
      }
      sets.pullmode = {
	      main="Earth Staff", --20
	      --main="Mafic Cudgel", --10
	      --sub="Genmei Shield", --10
	      left_ring="Defending Ring",--10
	      right_ring="Vocane Ring",--7
	      --neck="Wiglen Gorget",--6
	      neck="Loricate Torque +1",--6
	      --body="Onca Suit", --10
	      hands="",
	      legs="",
	      feet="Hippomenes Socks",
	      back="Archon Cape"
	      --back="Repulse Mantle"--4
	      --back="Umbra Cape"--6, 12 at night
	      

      }
      --sets.damagetaken.MagicEvasion = {
	      --left_ring="Vengeful Ring",--9
	      --right_ring="Purity Ring",--10
	      --back="Felicitas Cape +1",--10
	      --body="Onca Suit" -- 252
	      --body 91, hands 48, legs 118, feet 118
	      --left_ear="Eabani Earrng", --8
	      --right_ear="Flashward Earrng", --8
	      --head 86
	      --
      --}
      sets.petdamagetaken = {}
      sets.petdamagetaken.DT = {
	    main=bpmagicstaff,
	    neck="Empath Necklace", 
	    left_ear="Handler's Earring +1", -- 4 PDT
	    right_ear="Handler's Earring", -- 3 PDT
	    legs="Enticer's Pants", --5 DT
      }
 
    sets.precast.FC.PDT = set_combine(sets.precast.FC, sets.damagetaken.PDT)
    sets.idle.PDT = {--mixes refresh with pdt
	    --main="Earth staff", --20
	    --sub="Oneiros Grip",
	    --main="Bolelabunga",
	    --sub="Sors shield",
	    
	    ammo="Sancus Sachet",
	    head="Convoker's Horn +1",
	    body="Shomonjijoe +1",
	    hands="Asteria Mitts +1",
	    legs="Assid. pants +1",
	    feet="Convoker's Pigaches +1",
	    --neck="Wiglen Gorget", --6
	    waist="Fucho-no-obi",
	    left_ear="Moonshade Earring",
	    right_ear="Andoaa earring",
	    right_ring="Gelatinous Ring +1", --6
	    --left_ring="Thurandaut ring",
	    left_ring="Defending Ring", --10
	    --back="Repulse Mantle" --4
	    back="Solemnity Mantle"--4
    }

    -- perp costs:
    -- spirits: 7
    -- carby: 11 (5 with mitts)
    -- fenrir: 13
    -- others: 15
    -- avatar's favor: free, if you minimized perp cost already, -4 a tick with no -perp gear.  Weird I know but it's true, test it yourself
   
    -- Max useful -perp gear is 1 less than the perp cost (can't be reduced below 1)
    -- Aim for -14 perp, and refresh in other slots.
    --
   
    -- -perp gear:
    -- Grivardor: -5
    -- Glyphic Horn: -4
    -- Caller's Doublet +2/Glyphic Doublet: -4
    -- Evoker's Ring: -1
    -- Convoker's Pigaches: -4
    -- total: -18
   
    -- Can make due without either the head or the body, and use +refresh items in those slots.
    sets.keep = {
	    left_ring="Warp Ring",
    }
    sets.keep2 = {
	    left_ring="Echad Ring",
	    right_ring="Trizek Ring",
    }
   

    sets.idle.PDT = {}
    --maximize summoning skill and reduce perp and use glyphic legs, tho it doesn't seem smn skill doing much for these anymore
    sets.idle.Spirit = set_combine(sets.midcast.Pet.BloodPactWard, {main="Gridarvor",left_ear="Moonshade Earring",legs="Glyphic Spats +1"})
    -- 
    --    sets.idle.Town = {
    --                main="Terra's staff",
    --                sub="Oneiros grip",
    --                head="Convoker's horn +1",
    --                neck="Twilight torque",
    --                ear1="Moonshade earring",
    --                ear2="Gifted earring",
    --                body="Hagondes coat +1",
    --                hands="Serpentes cuffs",
    --                ring1="Dark ring",
    --                ring2="Dark ring",
    --                back="umbra cape",
    --                waist="Fucho-no-obi",
    --                legs="Assid. pants +1",
    --                feet="Serpentes sabots"
    --    }
 
    -- Favor uses Caller's Horn instead of Convoker's Horn +1 for refresh
    --sets.idle.Avatar.Favor = {head="Caller's Horn +1"}
    
    sets.favor= {}
    sets.favor.mpsaver={ -- don't sacrifice refresh gear for smn skill gear
	    main="Gridarvor",
	    sub="Vox Grip",
	    ammo="Sancus Sachet",
	    head="Beckoner's Horn",
	    body="Shomonjijoe +1",
	    --body="Beckoner's Doublet +1",
	    --hands={ name="Telchine Gloves", augments={'"Avatar perpetuation cost" -4',}},
	    hands="Asteria Mitts +1",
	    --legs="Beckoner's Spats",
	    legs="Assid. pants +1",
	    --feet="Convoker's Pigaches +1",
	    --feet="Beck. Pigaches +1",
	    feet="Apogee pumps",
	    neck="Caller's Pendant",
	    waist="Lucidity sash",
	    --left_ear="Caller's Earring",
	    left_ear="Moonshade Earring",
	    right_ear="Andoaa earring",
	    --right_ear="Evans earring",
	    --left_ring="Thurandaut ring",
	    left_ring="Globidonta Ring",
	    right_ring="Evoker's ring",
	    back=conveyance
    }
    sets.favor.allout={ -- equip all the favor and smn skill you can while not losing MP
	    --main="Gridarvor",
	    main=smnskillstaff,
	    sub="Vox Grip",
	    ammo="Sancus Sachet",
	    head="Beckoner's Horn",
	    --body="Shomonjijoe +1",
	    body="Beckoner's Doublet +1",
	    --hands={ name="Telchine Gloves", augments={'"Avatar perpetuation cost" -4',}},
	    --hands="Glyphic Bracers +1",
	    hands="Lamassu Mitts +1",
	    --legs="Beckoner's Spats",
	    legs="Beckoner's spats +1",
	    --feet="Convoker's Pigaches +1",
	    --feet="Beck. Pigaches +1",
	    feet="Apogee Pumps",
	    --neck="Caller's Pendant",
	    neck="Melic Torque",
	    waist="Lucidity sash",
	    --left_ear="Caller's Earring",
	    left_ear="Moonshade Earring",
	    right_ear="Andoaa earring",
	    left_ring="Globidonta Ring",
	    right_ring="Evoker's ring",
	    back=conveyance
    }
       
    sets.idle.Avatar = { 
	    --ear2="Loquacious Earring",
	    --body="Hagondes coat +1",
	    --hands="Regimen mittens",
	    --ring2="Globidonta Ring",
	    --waist="Isa belt",
	    main="Gridarvor",
	    sub="Vox Grip",
	    head="Beckoner's Horn",
	    body="Shomonjijoe +1",
	    --hands={ name="Telchine Gloves", augments={'"Avatar perpetuation cost" -4',}},
	    hands="Asteria Mitts +1",
	    legs="Assid. pants +1",
	    --feet="Beck. Pigaches +1",
	    feet="Apogee pumps",
	    neck="Caller's Pendant",
	    ammo="Sancus Sachet",
	    waist="Lucidity sash",
	    --waist="Fucho-no-obi",
	    --left_ear="Caller's Earring",
	    --left_ear="Caller's Earring",
	    left_ear="Moonshade Earring",
	    --right_ear="Andoaa earring",
	    --right_ear="Evans earring",
	    right_ear="Andoaa earring",
	    --left_ring="Paguroidea Ring",
	    --left_ring="Thurandaut ring",
	    left_ring="Globidonta Ring",
	    right_ring="Evoker's ring",
	    back=conveyance
    }
    sets.Avatar = {}
    sets.Avatar.Haste = {
	    main=avatarattackstaff,
	    sub="Vox Grip",
	    head="Beckoner's Horn",
	    body="Shomonjijoe +1",
	    --hands={ name="Telchine Gloves", augments={'"Avatar perpetuation cost" -4',}},
	    hands="Asteria Mitts +1",
	    legs="Assid. pants +1",
	    --feet="Beck. Pigaches +1",
	    feet="Apogee pumps",
	    --feet="Psycloth boots",
	    --neck="Caller's Pendant",
	    neck="Empath necklace",
	    ammo="Sancus Sachet",
	    --waist="Incarnation Sash",
	    waist="Moepapa Stone",
	    --waist="Fucho-no-obi",
	    --left_ear="Caller's Earring",
	    left_ear="Moonshade Earring",
	    --right_ear="Handler's Earring +1",
	    right_ear="Rimeice earring",
	    --right_ear="Evans earring",
	    --left_ring="Paguroidea Ring",
	    --left_ring="Thurandaut ring",
	    left_ring="Globidonta Ring",
	    right_ring="Evoker's ring",
	    --back={ name="Conveyance Cape", augments={'Summoning magic skill +4','Blood Pact Dmg.+4','Blood Pact ab. del. II -3',}},
	    back="Penetrating Cape"

    }
    sets.idle.Spirit = set_combine(sets.midcast.Pet.BloodPactWard, {main="Gridarvor",left_ear="Moonshade Earring",legs="Glyphic Spats +1"})
    sets.perp = sets.idle.Avatar
    
    -- -5 staff
    --    head +2
    --    body +3
    -- -3 pants +2
    --    hands +2
    --    earring +1
    -- -1 ring
    -- -2 waist
    -- -8 feet
    -- -2 earring
    -- Caller's Bracer's halve the perp cost after other costs are accounted for.
    -- Using -10 (Gridavor, ring, Conv.feet), standard avatars would then cost 5, halved to 2.
    -- We can then use Hagondes Coat and end up with the same net MP cost, but significantly better defense.
    -- Weather is the same, but we can also use the latent on the pendant to negate the last point lost.
    --sets.perp.Day = {body="Hagondes Coat +1"}
    --sets.perp.Weather = {neck="Caller's Pendant",body="Hagondes Coat +1"}
    sets.perp.Weather = {neck="Caller's Pendant"}
    -- Carby: Mitts+Conv.feet = 1/tick perp.  Everything else should be +refresh
    --    sets.perp.Carbuncle = {
    --	    hands="Carbuncle Mitts"
    --    }
    sets.perp.Carbuncle = set_combine(sets.perp, {hands="Asteria Mitts +1"})
    sets.perp['Cait Sith'] = set_combine(sets.perp, {hands="Lamassu Mitts +1"})
    sets.perp.LightSpirit = set_combine(sets.midcast.Pet.BloodPactWard, {main="Gridarvor",left_ear="Moonshade Earring",legs="Glyphic Spats +1"})
    sets.perp.AirSpirit = set_combine(sets.midcast.Pet.BloodPactWard, {legs="Glyphic Spats +1"})
    sets.perp.FireSpirit = set_combine(sets.midcast.Pet.BloodPactWard, {legs="Glyphic Spats +1"})
    --can add other spirits too 
	    
--    sets.perp.staff_and_grip = {main=gear.perp_staff}
   
    sets.Kiting = {}
   
    sets.latent_refresh = {sub="Oneiros grip",waist="Fucho-no-obi"}
   
 
    --------------------------------------
    -- Engaged sets
    --------------------------------------
   
    sets.engaged = sets.perp 
    sets.engaged.Perp = sets.perp
    sets.engaged.Melee = {
	    head="Telchine Cap",
	    --body="Beckoner's Doublet +1",
	    --body={ name="Telchine Chasuble", augments={'"Elemental Siphon"+15',}},
	    --hands={ name="Telchine Gloves", augments={'Pet: Regen+3'}},
	    --legs={ name="Telchine Braconi", augments={'"Elemental Siphon"+15',}},
	    --feet="Beck. Pigaches +1",
	    body="Onca Suit",
	    neck="Sanctity Necklace",
	    --right_ring="Thurandaut ring",
	    right_ring="Evoker's Ring",
	    left_ring="Apate ring",
	    left_ear="Bladeborn earring",
	    right_ear="Steelflash earring",
	    waist="Olseni Belt",
    }
    --    sets.engaged.Acc = {
    --	    main="Ungeri Staff",
    --	    neck="Subtlety spectacles"
    --    }
end