#!/bin/bash

if [ "$POST_BUILD" == "true" ] && [ "$TRAVIS_PULL_REQUEST" == "false" ]; then

#Set git user
git config --global user.email "kuba.marchwicki@gmail.com"
git config --global user.name "Travis"

echo -e "Cloning blog master\n"
git clone -b master https://${GH_TOKEN}@github.com/kubamarchwicki/kubamarchwicki.github.io site

echo -e "Building Jekyll site\n"
jekyll build -d site

cd site

touch .nojekyll
rm build.sh
rm Gemfile
rm Gemfile.lock

echo -e "Committing site\n"
git add -f .
git commit -m "Travis build $TRAVIS_BUILD_NUMBER"
git push origin

cd ..
rm -rf site

fi
