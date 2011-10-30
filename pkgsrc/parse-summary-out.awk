#!/usr/bin/awk -f

# exports PKG_SRC_PATH from command line via -v PKG_SRC_PATH=

BEGIN {
	CATEGORY_DIR="category"
	system("rm category/*")
}

$1 ~ /PKGPATH/ {
	PKGPATH=$2
	BR2_NAME=$2
	gsub( /[-\/\+]/, "_", BR2_NAME ) 
	#gsub( /-/, "_", BR2_NAME )
	split( $2, p, /\// )
	CATEGORY=p[1]
	BR2_NAME=sprintf("BR2_PKGSRC_PACKAGE_%s", toupper(BR2_NAME) )
}

$1 ~ /PKGNAME/ {
	PKGNAME=$2
}

$1 ~ /COMMENT/ {
	COMMENT=$2
	sub(/^ */, "", COMMENT)
}


$1 ~ /HOMEPAGE/ {
	HOMEPAGE=$2
	sub(/^ */, "", HOMEPAGE)
}

# finalize writing here
$1 ~ /^ *$/ {
	CATEGORY_IN=sprintf( "%s/%s.in", CATEGORY_DIR, CATEGORY ) 
	CMD=sprintf("sed 's/^[\t ]*/	  /g' <%s/%s/DESCR >>%s", PKG_SRC_PATH, PKGPATH, CATEGORY_IN )
	printf "\nconfig %s\n", BR2_NAME >>CATEGORY_IN
	printf "	bool \"%s\"\n", PKGNAME >>CATEGORY_IN
	printf "	help\n" >>CATEGORY_IN
	printf "	  %s\n\n", COMMENT >>CATEGORY_IN
	system(CMD)
	printf "\n	  %s\n\n", HOMEPAGE >>CATEGORY_IN
}

END {
#	print CATEGORY
}
