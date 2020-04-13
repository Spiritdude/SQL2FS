# SQL2FS

Mapping (Postgre)SQL to a filesystem . . . because it's possible.

## Download
```
% git clone https://github.com/Spiritdude/SQL2FS
% cd SQL2FS
```

## Install
```
% sudo make requirements
```

## Use 
```
% ./sql2fs --db=<database>
% cd <database>
% ls
table1/   table2/    table3/

% cd table1/

% ls
col1/     col2/      col3/    col4/ 

% cd col3/

% ls
val1      val2       val3     val4    ...
val16/    val17      val18/
...       ..
# -- note that some are files and some are directories

% more val1
{
   "a": 1,
   "b": 334,
   "c": "some text",
   "col3": "val1"
}

% more val1#a
1

% more val1#c
some text

# -- note: some values might not be unique, therefore you can 'cd' into them, and see entries like 0 1 2 ...
% cd val16/

% ls 
0    1    2    3    4

% pwd
.../table1/col3/val16

% more 0
{ 
   "a": 1,
   "b": 8375,
   "c": "something",
   "col3": "val16",
}

% more 1
{ 
   "a": 211,
   "b": 877266,
   "c": "another text",
   "col3": "val16",
}

```

## Exit & Unmount
```
% killall sql2fs
% sudo umount <database>/
```

## Extended Use

Add in `/etc/fuse.conf`:
```
user_allow_other
```

so other users, like a web-server (lighttpd/apache/nginx) can access those mounted database/directories as well.


