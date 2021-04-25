#!/bin/bash

set ue



export array=(
addtags
api
batch
contact
develop
dm
follow
footer
layout
mail
master
notification
ranking
rspec
rubocop
users
)

for v in "${array[@]}"
do
echo $v
git push --delete origin $v
done
