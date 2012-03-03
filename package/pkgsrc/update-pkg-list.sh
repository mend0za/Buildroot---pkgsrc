#!/bin/sh

# Copyleft by Vlad 'mend0za' Shakhov, 2011-2012

KCONFIG_OUT=pkgsrc-categories.in
PKG_SRC_PATH=/home/works/buildroot/pkgsrc-2011Q4
CATEGORY_DIR=category
export PATH="$PATH:/home/works/buildroot/pkg/bin"

export LC_ALL=C

# Read package list only once
PKG_LIST=`mktemp`
pkg_list_all_pkgs|sort >$PKG_LIST

PKG_PREFIX=BR2_PKGSRC_PACKAGE

test -f "$KCONFIG_OUT" && rm "$KCONFIG_OUT"
test -d "$CATEGORY_DIR" || mkdir "$CATEGORY_DIR"

echo "# Autogenerated file, please don't edit" >>$KCONFIG_OUT
echo >>$KCONFIG_OUT

for CATEGORY in `cut -d/ -f1 $PKG_LIST | uniq | sort`
do
	COMMENT=`awk -F'=' '/COMMENT/{print $2}' $PKG_SRC_PATH/$CATEGORY/Makefile|sed 's/^\t\+//g'`
	IN_FILE="$CATEGORY_DIR/$CATEGORY.in"
	echo "menu \"$COMMENT\"" >>$KCONFIG_OUT
	echo "source package/pkgsrc/$IN_FILE" >>$KCONFIG_OUT
	echo "endmenu" >>$KCONFIG_OUT
	echo >>$KCONFIG_OUT

	touch "$IN_FILE"
done

# turn on paexec to speedup
export PSS_SLAVES=+4

pkg_micro_src_summary -f PKGPATH,PKGNAME,COMMENT,HOMEPAGE <$PKG_LIST | \
	awk -v PKG_SRC_PATH="$PKG_SRC_PATH" -F= -f parse-summary-out.awk

for i in category/*.in 
do 
	./sort-category.awk <$i >$i.new
	mv $i.new $i
done

rm -f "$PKG_LIST"
