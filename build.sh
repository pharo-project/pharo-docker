#!/bin/bash
repos="vm image"
allversion="40 50 60 61 70"

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

versions="$@"
if [ "$versions" = "" ]; then
        versions="$allversion"
fi

for repo in $repos; do
	for version in $versions; do
		default="slim64"
		if [ $version -le 50 ]; then
			variants="slim"
			default="slim"
		else
			variants="slim slim64"
		fi
		for variant in $variants; do
			dir="$repo/$version/$variant"
			tag="$repo:$version-$variant"
			echo "BUILDING $tag";
			
			(cd $dir && docker build -t "pharo/$tag" .)
			docker push "pharo/$tag"
			if [ "$variant" = "$default" ]; then
				docker tag "pharo/$tag" "pharo/$repo:$version"
				docker push "pharo/$repo:$version"
			fi
		done
	done
done

