function inttobinary --description "integer to binary"
        echo "obase=2;$argv[1]" | bc
end
