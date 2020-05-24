#! /bin/sh

if [ ! -d $HOME/opt ];
then
	mkdir $HOME/opt
fi

if [ -x $HOME/opt/moltemplate ];
then
	echo "OK! moltemplate was found"
else
	echo "* moving to $HOME/opt dir."
	cd  $HOME/opt
	echo "** installing moltemplate"
	git clone https://github.com/jewettaij/moltemplate moltemplate
	cd moltemplate
	pip install . --user
fi
