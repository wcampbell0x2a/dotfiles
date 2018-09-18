# Defined in - @ line 0
function wificonn --description 'Connect to wifi using nmcli >wificonn <name> <pass>'
    function print_usage
        echo 'Connect to wifi using nmcli'
        echo
        echo 'Usage: wificonn <SSID> <PASS>'
    end

    test (count $argv) = 0
    or [ $argv[1] = "-h" ]
    or [ $argv[1] = "--help" ]
    and print_usage; and return 0

	nmcli device wifi connect $argv[1] password $argv[2];
end
