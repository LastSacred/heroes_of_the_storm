# Personal HotS Coach

Personal HotS Coach is a tool that allows the user to upload historical match data. It then uses this data to make hero selection recommendations during a draft based on the user's performance on the map, and with and against the heroes that have been selected so far.

## What is HotS

Heroes of the Storm wiki: https://en.wikipedia.org/wiki/Heroes_of_the_Storm

## Notes

The first release of this project will only accommodate for one user, the database will be constructed from only that user's battles. It can later be adapted for multiple users by adding a Player model to the database, or storing a database for each player.

## Import

Currently, the import process uses APIs to search every match record on http://hotsapi.net. You must have uploaded your replays for this to work. Instructions are available on how to do this here: http://hotsapi.net/upload. This can be a very long and inefficient process. I will work on a way to parse the replays myself.

In the meantime you can speed up the process a little by manually setting the value under PROFILE.last_import. Go to http://hotsapi.net/swagger and do a manual search by id. Look at the date created for the search result to find an entry created shortly before you uploaded your first one. Once you find one, use its id number as the last import. Use the Replays Uploaded counter in the top right to help you estimate.

## still to do

1. TODO: build draft interface

2. TODO: build stats interface

3. TODO: build run file to chose between options: setup user, import, stats, draft
