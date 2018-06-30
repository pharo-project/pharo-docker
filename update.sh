#!/bin/bash

repos="vm image"
allversion="40 50 60 61 70"

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

versions="$@"
if [ "$versions" = "" ]; then
	versions="$allversion"
fi

generated_warning() {
	cat <<-EOH
		#
		# NOTE: THIS DOCKERFILE IS GENERATED VIA "update.sh"
		#
		# PLEASE DO NOT EDIT IT DIRECTLY.
		#
	EOH
}
for repo in $repos; do
	for version in $versions; do
		if [ $version -le 50 ]; then
			variants="slim"
		else
			variants="slim slim64"
		fi
		for variant in $variants; do
			dir="$repo/$version/$variant"
			echo $dir
			template="Dockerfile-$repo-$variant.template"
			mkdir -p "$dir"
			sedStr="
				s!%%VERSION%%!$version!g;
			"	
			{ generated_warning; cat "$template"; } > "$dir/Dockerfile"
			sed -r "$sedStr" -i "$dir/Dockerfile"
		done
	done
done
