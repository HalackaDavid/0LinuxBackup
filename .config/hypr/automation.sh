var="ly-session.log"
mkdir -p ~/.cache/ly
cat ~/$var >> ~/.cache/ly/$var
rm ~/$var
unset var
