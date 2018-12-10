-- Feary's Global Statuses 
-- Created: 6/30/2014
-- Last Updated:
-- To Do:
--
--

-- Gain buffs
	if buff == 'Defense Down' and g_or_l == true then
		windower.send_command('input /p Defense Down')
	end
	if buff == 'Accuracy Down' and g_or_l == true then
		windower.send_command('input /p Accuracy Down')
	end
	if buff == 'gradual petrification' and g_or_l == true then
		windower.send_command('input /p gradual petrification will need Stona in 15;wait 10;input /p Stona in 5;wait 5;input /p Petrified Stona Please')
	end
	if buff == 'bind' and g_or_l == true then
		windower.send_command('input /p Bound')
	end
	if buff == 'doom' and g_or_l == true then
		windower.send_command('input /p Doomed')
	end
	if buff == 'slow' and g_or_l == true then
		windower.send_command('input /p Slowed')
	end
	if buff == 'charm' and g_or_l == true then
		windower.send_command('input /p Charmed, Sleep me')
	end
	if buff == 'weight' and g_or_l == true then
		windower.send_command('input /p Gravity')
	end
-- Lose Buffs
	if S{MNK,SAM,THF,DRK,WAR,COR,DRG,PUP,PLD}:contains(player.main_job) then
		if buff == 'haste' and g_or_l == false then
			windower.send_command('input /p Haste Please')
		end
	end
	if buff == 'encumbrance' and g_or_l == false then
		previous_set()
	end
	if buff == 'doom' and g_or_l == false then
		windower.send_command('input /p Doom off Woot -.-')
	end
	if buff == 'charm' and g_or_l == true then
		windower.send_command('input /p Uncharmed')
	end