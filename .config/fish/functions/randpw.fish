#random password generator
function randpw --description "Generate random password"
    dd if=/dev/urandom bs=1 count=16 2>/dev/null | base64 | rev | cut -b 2- | rev
end
