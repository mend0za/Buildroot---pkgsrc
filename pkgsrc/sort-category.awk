#!/usr/bin/awk -f

BEGIN {
	RS="\nconfig "
	FS="\n	"
	n=0
}

{
	name=$2
	sub( /bool /, "", name )
	gsub( /"/, "", name )
	
	if ( name ~ /^[:space:]*$/ )
		next
	pkg_names[n] = name 
	n++
	pkg_hash[name] = $0 

}

END {
	# TODO sort here
	j=0
	for ( i=2; i<n; i++ )
	{
		hold = pkg_names[j = i]
		while ( pkg_names[j-1] > hold )
		{ 
			j--
			pkg_names[j+1] = pkg_names[j] 
		}
		pkg_names[j] = hold
	}



	for ( i=0; i<n; i++ )
	{
		name=pkg_names[i]
		printf "config %s\n", pkg_hash[name]
	}
}
