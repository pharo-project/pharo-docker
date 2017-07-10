#!/bin/bash

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"
versions=( "$@" )
if [ ${#versions[@]} -eq 0 ]; then
	versions=( */ )
fi
versions=( "${versions[@]%/}" )

generated_warning() {
	cat <<-EOH
		#
		# NOTE: THIS DOCKERFILE IS GENERATED VIA "update.sh"
		#
		# PLEASE DO NOT EDIT IT DIRECTLY.
		#
	EOH
}

for version in "${versions[@]}"; do
	if [ $version -le 50 ]; then
		variants="slim"
	else
		variants="slim slim64"
	fi
	for variant in $variants; do
		dir="$version/$variant"
		echo $dir
		template="Dockerfile-$variant.template"
		mkdir -p "$dir"
		sedStr="
			s!%%VERSION%%!$version!g;
		"
		{ generated_warning; cat "$template"; } > "$dir/Dockerfile"
		sed -r "$sedStr" -i "$dir/Dockerfile"
	done
done

