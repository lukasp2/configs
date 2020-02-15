export CCFLAGS="-Wall -Wextra -pedantic -Weffc++ -Wsuggest-attribute=const -fconcepts"

alias g++="\g++ -std=c++17 \${CCFLAGS}"
alias e++="\g++ -std=c++17 \${CCFLAGS} -Werror"

alias xclip='xclip -selection clipboard'
