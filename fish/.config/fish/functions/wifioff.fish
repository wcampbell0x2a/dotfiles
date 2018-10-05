# Defined in - @ line 0
function wifioff --description 'alias wifioff nmcli radio wifi off'
	nmcli radio wifi off $argv;
end
