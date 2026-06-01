#!/usr/bin/env bash

function git.origin () {
	git remote get-url origin
}

function git.branch.fromRemote () {

	local origin
	local repo
	local branch

	origin="$1"
	branch="${2:-HEAD}"

	repo=$(basename "$origin")
	repo_name="${repo%.*}"

	local subtree
	subtree="remote/$repo_name"

	git checkout --orphan "$subtree"
	git rm -rf .
	git commit --allow-empty -m "init"
	git pull "$origin" "$branch"
	git push -u origin

	git checkout main
	git submodule add -b "$subtree" "$origin" "$subtree"

}

function git.submodule.self () {

	local origin
	local branch
	local path

	origin=$(git.origin)
	branch="$1"
	path="${2:-$1}"

	git submodule add -b "$branch" "$origin" "$path"

}
