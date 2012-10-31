#!/bin/csh

#１週間分世代管理します
#postgresユーザのホームディレクトリに「.pgpass」を作成してパスワード省略出きるようにしてください。

set DIR=/var/rails/ss_kanri/backup
set FILE=$DIR/ss_kanri`date '+%w'`.tar
rm -f $FILE

su - postgres -c "/opt/pgsql/bin/pg_dump -Ft -b ss_kanri > $FILE"


