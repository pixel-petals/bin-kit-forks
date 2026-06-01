#!/usr/bin/env bash

function git.branch.fromRemote () {

	local origin
	local repo
	local branch

	origin="$1"
	branch="${2:-HEAD}"

	repo=$(basename "$origin")
	repo_name="${repo%.*}"

	git checkout --orphan "remote/$repo_name"
	git rm -rf .
	git commit --allow-empty -m "init"
	git pull "$origin" "$branch"
	git push -u origin

}
