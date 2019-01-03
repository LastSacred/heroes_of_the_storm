# Personal HotS Coach

Personal HotS Coach is a tool that allows the user to upload historical match data. It then uses this data to make hero selection recommendations during a draft based on the user's performance on the map, and with and against the heroes that have been selected so far.

## What is HotS

Heroes of the Storm wiki: https://en.wikipedia.org/wiki/Heroes_of_the_Storm

## Notes

The first release of this project will only accommodate one user, the database will be constructed from only that user's battles.

## Import

 I have not yet devised a way to parse replays myself. For now, the import process works by uploading all replays in the indicated directory to http://hotsapi.net storing a match record for each with only a replay id. It then gets the full data for every match by searching for each replay id.
