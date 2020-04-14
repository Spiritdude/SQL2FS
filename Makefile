NAME=SQL2FS
VERSION=0.0.4

all::
	@echo "make install deinstall edit backup git change push pull"

requirements::
	sudo apt -y install libfuse-dev libpq-dev libdbd-mysql-perl libdbd-sqlite3-perl
	sudo cpan Fuse JSON DBI DBD::Pg

install::
	cp sql2fs ~/bin/

deinstall::
	rm -f sql2fs ~/bin/

backup::
	cd ..; tar cfvz ~/Backup/${NAME}-${VERSION}.tar.gz ${NAME}; scp ~/Backup/${NAME}-${VERSION}.tar.gz backup:Backup;

edit::
	dee4 sql2fs Makefile README.md LICENSE

git::
	git remote add origin git@git:${NAME}
	#git remote add origin git@github.com:Spiritdude/${NAME}.git
	#git remote set-url origin git@github.com:Spiritdude/${NAME}.git
        
change::
	git commit -am "..."

push::
	git push -u origin master

pull::
	git pull
