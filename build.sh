#!/bin/bash

isroot=0
iszsh=0  	 # zsh
istmux=0   # tmux
isVundle=0 # Plugin for vim

if [ $EUID -ne 0 ]; then
	echo -e "The shell isn't run as\033[0;31;40m root(sudo) \033[0m"
	echo -e "Install\033[0;31;40m without\033[0m root"
	while true; do
		read -p "Do you want to change as root(That will ask your sudo password below)?(y/n) " ans
		case $ans in
			[Yy]* ) isroot=1; break;;
			[Nn]* ) break;;
		*) echo "Please answer yes or no.";;
		esac
	done
else
	echo "The shell is run as root(sudo)"
	isroot=1
fi
echo ""
# Check if install zsh
while true; do
	echo -en "Do you want to install \033[0;31;40mzsh(default:bash)\033[0m?(y/n) "
	read ans
	case $ans in
		[Yy]* ) iszsh=1; break;;
		[Nn]* ) break;;
		*) echo "Please answer yes or no.";;
	esac
done
echo -e "\033[0;34;40m----------\033[0m"
# Check if install tmux
while true; do
	echo -en "Do you want to install \033[0;31;40mtmux\033[0m?(y/n) "
	read ans
	case $ans in
		[Yy]* ) istmux=1; break;;
		[Nn]* ) break;;
		*) echo "Please answer yes or no.";;
	esac
done
echo -e "\033[0;34;40m----------\033[0m"
# Check if install vim with Vundle
while true; do
	echo -en "Do you want to install \033[0;31;40mvim with Vundle\033[0m?(y/n) "
	read ans
	case $ans in
		[Yy]* ) isVundle=1; break;;
		[Nn]* ) break;;
		*) echo "Please answer yes or no.";;
	esac
done
echo -e "\n\n"
# Install tmux
if [ $istmux == "1" ]; then
	if ! type "tmux" > /dev/null; then
		if [ $isroot == "1" ]; then
			if [ `uname -s` == "Linux" ]; then
				sudo apt-get install -y tmux
			else
				brew install tmux
			fi
		else
			exec ./install_tmux.sh >> /dev/null
		fi

	else
		echo -e "\033[0;32;40m`type "tmux"` \033[0m"
	fi
	echo "Finish installation of tmux"
	echo ""
else
	echo -e "\033[0;31;40mNo install tmux\033[0m"
	echo ""
fi
# Install zsh
if [ $iszsh == "1" ]; then
	if ! type "zsh" > /dev/null; then
		if [ $isroot == "1" ]; then
			if [ `uname -s` == "Linux" ]; then
				sudo apt-get install -y zsh
			else
				brew install zsh zsh-completions
			fi
		else
			git clone git://git.code.sf.net/p/zsh/code zsh
			if [ -d "$HOME/local/bin" ]; then
				mkdir -p $HOME/local/bin/
			fi
			cd ./zsh 
			if [ ! -f ./configure ]; then
				./Util/preconfig
			fi
			./configure --prefix=$HOME/local/bin/ CFLAGS="-I$HOME/local/include -I$HOME/local/include/ncurses" LDFLAGS="-L$HOME/local/include/ncurses -L$HOME/local/include" CPPFLAGS="-I$HOME/local/include -I$HOME/local/include/ncurses" LDFLAGS="-static -L$HOME/local/include -L$HOME/local/include/ncurses -L$HOME/local/lib"
			make && make install
			cd ..
		fi
	else
		echo -e "zsh has been install in\033[0;32;40m `whereis zsh` \033[0m"

	fi
	# config
	echo -e "\033[0;34;40m-----configure zsh-----\033[0m"
	echo "exec $HOME/local/bin/zsh -l" >> $HOME/.profile
	if [ ! -d "$HOME/.oh-my-zsh" ]; then
		git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
	else
		echo -e "\033[0;31;40m.oh-my-zsh exits, no replace\033[0m"
	fi
	if [ -f $HOME/.zshrc ]; then
		while true; do
			read -p "Do you want to replace .zshrc?(y/n)" ans
			case $ans in
				[Yy]* ) cp zshrc $HOME/.zshrc; break;;
				[Nn]* ) break;;
				*) echo "Please answer yes or no.";;
			esac
		done
	else
		cp ./zshrc $HOME/.zshrc
	fi
	echo "Finish installation of zsh"
	echo ""
else
	echo -e "Use\033[0;31;40m bash shell\033[0m"
	if [ -f $HOME/.bashrc ]; then
		while true; do
			read -p "Do you want to replace .bashrc?(y/n)" ans
			case $ans in
				[Yy]* ) cp bashrc $HOME/.bashrc; break;;
				[Nn]* ) break;;
				*) echo "Please answer yes or no.";;
			esac
		done
	else
		cp ./bashrc $HOME/.bashrc
		echo ""
	fi
fi


# Install vim with Vundle
if [ $isVundle == "1" ]; then
	if [ -d $HOME/.vim/bundle/Vundle.vim ]; then
		echo -e "\033[0;32;40mVundle has been installed\033[0m"
	else
		git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
	fi
	if [ -f $HOME/.vimrc ]; then
		while true; do
			read -p "Do you want to replace .vimrc?(y/n)" ans
			case $ans in
				[Yy]* ) cp vimrc $HOME/.vimrc; break;;
				[Nn]* ) break;;
				*) echo "Please answer yes or no.";;
			esac
		done
	else
		cp ./vimrc $HOME/.vimrc
	fi
	echo -e "Now you can run\033[0:34:30m PluginInstall\033[0m when opening vim first to install plugins"
	echo ""
else
	if [ -f $HOME/.vimrc ]; then
		while true; do
			read -p "Do you want to replace .vimrc?(y/n)" ans
			case $ans in
				[Yy]* ) cp vimrc_basic $HOME/.vimrc; break;;
				[Nn]* ) break;;
				*) echo "Please answer yes or no.";;
			esac
		done
	else
		cp ./vimrc_basic $HOME/.vimrc
	fi
fi
echo -e "\033[0;32;40mFinish installation\033[0m"
