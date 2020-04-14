# SQL2FS

Mapping SQL (PostgreSQL & MySQL) to a filesystem . . . because it's possible, and because it's how it should work.
```
% sql2fs --backend=mysql my_database
% cd my_database/
% ls
table1/     table2/     table3/
% cd table1/
% ls
column1/    column2/  ...
% cd column1/
% ls
val1    val2    val3/   val4   val5    val6/ 
% more val1
{
   "column1": "val1",
   "column2": "some value",
   ...
}
% cd val3/
% ls
0   1   2   3 
% more 0
{
   "column1": "val3",
   "column2": "some other value",
   ...
}
% more 1
{
   "column1": "val3",
   "column2": "something else",
   ...
}
```

## Limitations
- highly experimental (highly unstable)
- barely any sanity checkings
- read only

## Todo / Ideas
- create new tables, e.g. `echo "a int, comment varchar" > new_table/.schema`
- insert data into tables, e.g. `echo 'a=2 comment="testing something"' >> new_table/.tail`
- remove data, e.g. `rm table/a/1` => deletes records `where a = 1`
- etc

## Download
```
% git clone https://github.com/Spiritdude/SQL2FS
% cd SQL2FS
```

## Install
```
% sudo make requirements
% make install
```
Note: it just installs `sql2fs` to your local `~/bin/`.

## Use 
```
% createdb test
% psql test
> create table table1 (a int, b int, c varchar);
> insert into table1 (a,b,c) values(1,2,"test");
> insert into table1 (a,b,c) values(2,13,"test2");
> insert into table1 (a,b,c) values(2,3,"test3");
> insert into table1 (a,b,c) values(3,4,"test4");
> \q

% ./sql2fs test

% cd test/

% ls
table1/

% cd table1/

% ls
a/     b/     c/

% cd a/

% ls
1      2/     3
// note: some are files and some are directories

% more 1
{
   "a": 1,
   "b": 2,
   "c": "test",
}

// note: once you reached record level, you can access the column with adding '#column' to the filename:
% more 1#b
2

% more 1#c
test

// note: some values might not be unique, therefore you can 'cd' into them, and see entries like 0 1 2 ...
% cd 2/

% ls 
0      1

% pwd
test/table1/a/2

% more 0
{ 
   "a": 2,
   "b": 13,
   "c": "test3"
}

% more 1
{ 
   "a": 2,
   "b": 3,
   "c": "test4"
}

% more 1#c
test4

```

## Exit & Unmount
```
% killall sql2fs
% sudo umount test/
```

## Extended Use

Add in `/etc/fuse.conf`:
```
user_allow_other
```

so other users, like a web-server (lighttpd/apache/nginx) can access those mounted database/directories as well.

