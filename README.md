# Rubysplit

A work-in-progress split timer for speedrunners, built in the console using Ruby and CouchDB.

## Main tasks

* ~~Split class~~
* ~~Run class~~
* Renderer service functions for drawing Splits and Runs to the console
* Definition classes for storing run definitions in the database
* Add PBs to the definition classes
* Write script to set up local CouchDB instance with appropriate security, design docs, etc.
* Tying it all together into a console application with basic split capability
* In-app run/split creation, editing, etc.
* Finishing up the full suite of expected capabilities - skipping a split that was late, aborting a run in progress, etc.

## Possible future tasks

* Bundling as a gem with simple installation and initialization
* Adding graphs to visually display time savings, similar to some Livesplit configurations (text limits us somewhat but there are some options that might work)
* Ability to configure global CouchDB servers with multiple users, share runs or PBs with other users, and so forth
