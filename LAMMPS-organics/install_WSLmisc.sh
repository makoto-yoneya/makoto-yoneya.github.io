#! /bin/sh

if [ ! -d $HOME/bin ]; then
	mkdir $HOME/bin
fi

#if [ -x $HOME/bin/packmol ]; then
#	echo "OK! packmol was found"
#else
#	echo "* moving to $HOME/bin dir."
#	cd  $HOME/bin
#	echo "** installing packmol"
#	wget --no-check-certificate -q http://staff.aist.go.jp/makoto-yoneya/MDonWINPC/bin/packmol
#	chmod ugo+x packmol
#fi
#
#if [ -x $HOME/bin/atomsk ]; then
#	echo "OK! atomsk was found"
#else
#	echo "* moving to $HOME/bin dir."
#	cd  $HOME/bin
#	echo "** installing atomsk"
#	wget --no-check-certificate -q http://staff.aist.go.jp/makoto-yoneya/MDonWINPC/bin/atomsk
#	chmod ugo+x atomsk
#fi

if [ -x $HOME/bin/mol22lt.pl ]; then
	echo "OK! mol22lt.pl was found"
else
	echo "* moving to $HOME/bin dir."
	cd  $HOME/bin
	echo "** installing mol22lt.pl"
	wget -q https://github.com/makoto-yoneya/mol22lt/raw/master/mol22lt.pl
	chmod ugo+x mol22lt.pl
fi

if [ ! -d $HOME/opt ]; then
	mkdir $HOME/opt
fi

if [ -x $HOME/opt/amber20 ]; then
	echo "OK! antechamber was found"
else
	echo "* moving to $HOME/opt dir."
	cd  $HOME/opt
	echo "** installing antechamber"

	wget -q https://github.com/makoto-yoneya/antechamber-at20/releases/download/1.27.20/antechamber-at20.tar.gz
	tar zxvf antechamber-at20.tar.gz
	rm -rf antechamber-at20.tar.gz
fi

if [ ! -e  $HOME/.bash_aliases ]; then
	echo "# created by install_ac.sh" > .bash_aliases
fi	

grep MDonWSL $HOME/.bash_aliases > /dev/null
if [ $? -eq 1 ]; then
	echo "* updating .bash_aliases"
	echo "# MDonWSL" >> .bash_aliases
	echo "set -o notify" >> .bash_aliases
	if [ -d $HOME/bin ]; then
		echo "export PATH=\$HOME/bin:\$PATH" >> .bash_aliases
	fi
	if [ -x $HOME/opt/amber20 ]; then
		echo "export AMBERHOME=\$HOME/opt/amber20" >> .bash_aliases
		echo "export PATH=\$AMBERHOME/bin:\$PATH" >> .bash_aliases
	fi
	if [ -x $HOME/opt/moltemplate ]; then
		echo "export MTHOME=\$HOME/opt/moltemplate/moltemplate" >> .bash_aliases
		echo "export PATH=\$MTHOME/scripts:\$PATH" >> .bash_aliases
	fi
	VMDDIR="/mnt/c/Program Files/VMD"
	if [ -x "$VMDDIR" ]; then
		echo "export VMDDIR=\"/mnt/c/Program Files/VMD\"" >> .bash_aliases
		echo "export PATH=\$VMDDIR:\$PATH" >> .bash_aliases
	fi
fi
