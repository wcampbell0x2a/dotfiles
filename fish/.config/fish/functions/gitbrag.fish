# Defined in - @ line 0
function gitbrag --description alias\ gitbrag\ git\ ls-tree\ -r\ -z\ --name-only\ HEAD\ \|\ xargs\ -0\ -n1\ git\ blame\ --line-porcelain\ HEAD\ \|grep\ \ \'\^author\ \'\|sort\|uniq\ -c\|sort\ -nr\ 
	git ls-tree -r -z --name-only HEAD | xargs -0 -n1 git blame --line-porcelain HEAD |grep  '^author '|sort|uniq -c|sort -nr  $argv;
end
