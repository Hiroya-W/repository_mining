#!/bin/bash
set -eu

function usage()
{
    echo "重複リストを基に不要なリポジトリを削除する"
    echo ""
    echo "$0 path/to/hash_list_dup.txt"
}


if [ $# -ne 1 ]; then
    usage
    exit 1
fi


HASH_LIST_DUP_FILE=$1

cat "$HASH_LIST_DUP_FILE" | while read -r line; do
    # ファイル名を取得
    FILE_NAME=$(echo $line | awk '{print $2}')
    # ファイル名からディレクトリ名を取得
    RM_DIR=$(echo $FILE_NAME | sed -r "s/ghq\/(.+\/github.com\/[^\/]+\/[^\/]+).*/\1/")
    # ディレクトリの存在を確認する
    if [ -d "ghq/$RM_DIR" ]; then
        echo "rm -r ghq/$RM_DIR"
        # リポジトリが削除されるが、ユーザディレクトリは残る
        rm -r "ghq/$RM_DIR"
    fi
done

exit 0
