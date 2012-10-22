#!/bin/csh

#１週間分世代管理します
#postgresユーザのホームディレクトリに「.pgpass」を作成してパスワード省略出きるようにしてください。

set DIR=/backup
set FILE=$DIR/ss_kanri`date '+%w'`.tar
rm -f $FILE

su - postgres -c "/usr/bin/pg_dump -Ft -b ss_kanri > $FILE"


