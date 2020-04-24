#!/bin/sh

echo 'Adding to local repo'
git add .

echo 'Message for commit?'
read commitMessage

echo 'Commiting'
git commit -m '$commitMessage'

echo 'Pushing to github'
git push -u origin master
