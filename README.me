What is this?
===

A torrent RSS-feed downloader. Based off of alekseyt's code.

leech works by downloading the torrents from a RSS-feed generated from a website.

To do this it uses sh, wget, xsltproc, grep and sed.

It works with torrent clients that support directory watching, such as:

* transmission
* rtorrent

Highlights
===

* leech does not implement long-running processes, ideal for low memory devices.
* Does not require additional language pakages, written is bash its extemely small.
* Still does the job.

Setup
===
To install:

`opkg install http://downloads.dkopec.ca/leech_*_all.ipk`

Add all of the RSS-Feeds in `/etc/leech/foods`
Add any Regular Expressions you want applied to the 'foods' in `/etc/leech/downloads`
(default is to download everything)

Use
===

To run the program manually:

`CONFIG_DIR="/etc/leech" DOWLOADS_DIR="/mnt/downloads/" leech`

DOWNLOADS_DIR can be omitted to download files to current directory.

To make it run every 30 minutes add this entry to crontabs using `crontab -e`:

`*/30 * * * * CONFIG_DIR="/etc/leech" DOWNLOADS_DIR="/mnt/downloads" leech`

You can use `leech-match-test` to test if expressions in config/downloads match filenames you need.

Known Issues
===

* You need normal wget to make it work. Default OpenWRT's wget rippoff won't do.

Troubleshooting
===

If you think something is wrong, or just want to make sure if everything is OK, you could always run leech in manual mode and observe its output.

Under the Hood
===

Script will create temporary file in $TMP (/tmp by default): `$TMP/leech.lunch`
* contains downloaded feed.

Files matched `config/downloads` rules goes directly to DOWNLOADS_DIR. In
case of incomplete file retrieval, wget will resume download.