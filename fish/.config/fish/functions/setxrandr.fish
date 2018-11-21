# Set xrandr for work and other
function setxrandr --description 'Preset xrandr configurations'
    function print_usage
        echo 'Use either work or laptop'
    end

    test (count $argv) = 9
    or [ $argv[1] = "-h" ]
    or [ $argv[1] = "--help" ]
    and print_usuage; and return 0

    switch (echo $argv)
        case 'laptop'
            echo "Setting xrandr to laptop configuration"
            xrandr --output VIRTUAL1 --off --output DP3 --off --output DP1 --off --output eDP1 --primary --mode 2880x1620 --pos 0x0 --rotate normal --output DP2 --off


        case 'work'
            echo "Setting xrandr to work configuration"
            xrandr --output VIRTUAL1 --off --output DP3 --mode 2560x1080 --pos 2880x448 --rotate normal --output DP1 --mode 1920x1080 --pos 5440x0 --rotate right --output eDP1 --primary --mode 2880x1620 --pos 0x888 --rotate normal --output DP2 --off
    end
end
