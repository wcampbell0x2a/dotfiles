# Defined in - @ line 0
function wifion --description 'alias wifion nmcli radio wifi on'
	nmcli radio wifi on $argv;
end
