#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export EDITOR=vim

export PATH="$HOME/.local/bin:$PATH"
# Add .NET Core SDK tools
export PATH="$PATH:/home/bradleyreynolds/.dotnet/tools"
# Added by Toolbox App
export PATH="$PATH:/home/bradleyreynolds/.local/share/JetBrains/Toolbox/scripts"

. "$HOME/.cargo/env"
