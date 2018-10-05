# Defined in - @ line 0
function wifilist --description 'alias wifilist nmcli device wifi rescan; nmcli device wifi list'
	nmcli device wifi rescan; nmcli device wifi list $argv;
end
