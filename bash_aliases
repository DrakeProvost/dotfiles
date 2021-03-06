#This file contains a list of aliases accessible by .bashrc

#Note: when creating aliases, follow this template exactly (space-sensitive):
#alias aliasname='commands'

# ssh aliases
alias hopper='ssh z1872355@hopper.cs.niu.edu'
alias turing='ssh z1872355@turing.cs.niu.edu'
alias shatterdome='ssh drakeprovost@10.156.210.33'
alias locard='ssh pi@locard.local'	#requires mDNS (on Windows, download iTunes to resolve lack of native mDNS support)

# others
alias docker-start='sudo service docker start'
alias attach='~/Dockerfiles/ros2_foxy/attach.sh'
