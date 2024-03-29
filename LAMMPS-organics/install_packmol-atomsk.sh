#! /bin/sh

ver_packmol=20.010-1
#ver_atomsk=b0.10.6
ver_atomsk=b0.11.2

if [ -x /usr/bin/packmol ]; then
	echo "OK! packmol was found"
else
	echo "* downloading packmol package file"
	wget http://ftp.jp.debian.org/debian/pool/main/p/packmol/packmol_${ver_packmol}_amd64.deb
	echo "** installing packmol"
	sudo dpkg -i packmol_${ver_packmol}_amd64.deb
	if [ -x /usr/bin/packmol ]; then
		rm -f packmol_${ver_packmol}_amd64.deb
	fi
fi

#if [ -x /usr/bin/atomsk ]; then
#	echo "OK! atomsk was found"
#else
#	echo "* downloading packmol package file"
#	wget https://atomsk.univ-lille.fr/code/atomsk_${ver_atomsk}_amd64.deb
#	echo "** installing atomsk"
#	sudo dpkg -i atomsk_${ver_atomsk}_amd64.deb
#	if [ -x /usr/bin/atomsk ]; then
#		rm -f atomsk_${ver_atomsk}_amd64.deb
#	fi
#fi

if [ -x $HOME/bin/atomsk ]; then
	echo "OK! atomsk was found"
else
	echo "* moving to $HOME/bin dir."
	cd  $HOME/bin
	echo "** installing atomsk"
	wget -q https://github.com/makoto-yoneya/makoto-yoneya.github.io/releases/download/atomsk-0.10.6-test/atomsk-0.10.6.tar.gz
	tar zxvf atomsk-0.10.6.tar.gz
	chmod ugo+x atomsk
	rm -rf atomsk-0.10.6.tar.gz
fi
