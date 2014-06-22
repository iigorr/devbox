#!/bin/bash


if [ -d ~/dev/automation ]; then
  cd ~/dev/automation && git pull --ff-only;
else
  git clone git@bitbucket.org:iigorr/automation.git ~/dev/automation;
fi