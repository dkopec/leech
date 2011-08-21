
WHAT'S THIS
-----------

It will download torrent files for you if you give it RSS-feeds of your
favorite trackers.

How it works::

    RSS -> leech -> torrent files -> directory ------+
    downloaded files <- torrent client <- watchdog <-+

Torrent clients supporting watching over directory:

* transmission
* rtorrent
* probably some else i don't know about

leech is implemented in sh + wget + xsltproc + grep + sed + wget again. For
periodic checks you might want to use cron. E.g.::

    # crontab -l
    */30 * * * * CONFIG_DIR=/etc/leech DOWNLOADS_DIR=/mnt/usb/store/schedule leech

Will run leech every 30 minutes, checking feeds and downloading all matched
torrent files.


WHY IT'S GOOD
-------------

* No long-running processes - no long-running memory consumption on your NAS.
* No Python/Perl/PHP/Java/Whatever required.
* Still does the job.


USAGE
-----

    ``CONFIG_DIR="/etc/leech" DOWLOADS_DIR="/mnt/downloads/schedule" leech``

leech will download RSS-feeds specified in ``/etc/leech/foods``,
transform them with xsltproc to text, match against expressions in
``/etc/leech/downloads``, and will run wget to download matched files
to ``/mnt/downloads/schedule``.

DOWNLOADS_DIR might be omitted to download files to current directory.

You might also want to use ``sbin/leech-match-test`` to test if expressions in
config/downloads match filenames you need.


KNOWN ISSUES
------------

* You need normal wget to make it work. Default OpenWRT's wget rippoff
won't do.


WHAT'S INSIDE
-------------

* ``sbin/leech`` - main script
* ``config/default`` - main configuration file
* ``config/foods`` - feeds file
* ``config/downloads`` - rules for files downloading
* ``share/leech/leech.xsl`` - XSL transformation (preprocessing stuff)


INSTALL AS USER
---------------

It should work out of the box.

* edit ``config/foods`` and add RSS feeds
* edit ``config/downloads`` and add DL rules

Now you should be able to run ``CONFIG_DIR=config ./leech`` and see it
downloading feeds (to /tmp) and files (if any, to current directory).

* `crontab -e` and add cron job as described above, with correct paths
to CONFIG_DIR, DOWNLOADS_DIR and correct path to main script.


INSTALL AS SUPERUSER
--------------------

Check "Downloads" section, there should be package(s) you need. In case they're
not there, please email me about this problem (aleksey dot tulinov at gmail dot
com).

Install process does everything you need for normal use (except cron and
downloads configuration). If you want to check if it's running correctly:

* ``leech`` will show you error message and usage information
* ``CONFIG_DIR=/etc/leech leech`` will force leech to run

Configuration files are under /etc/leech.

* edit ``/etc/leech/foods`` and add RSS feeds
* edit ``/etc/leech/downloads`` and add DL rules
* add cron job as described above
* ``crontab -e`` and add cron job as described above.
* (optional) don't forget to enable cron (if it's not): ``/etc/init.d/cron enable`` for OpenWRT


MANUAL INSTALLATION
-------------------

Here is short description of installation process:

* install wget, grep, sed and xsltproc
* link ``sbin/leech`` -> ``/usr/sbin/leech``
* link ``share/leech/leech.xsl`` -> ``/usr/share/leech/leech.xsl``
* link ``config/`` -> ``/etc/leech/``
* ``crontab -e`` and add cron job as described above.
* (optional) don't forget to enable cron (if it's not)

After steps above, you should be able to run ``CONFIG_DIR=/etc/leech leech`` in
shell and see leech downloading feeds and files.


TROUBLESHOOTING
---------------

If you think something is wrong, or just want to make sure if everything is OK,
you could always run leech in manual mode and observe its output.

See above, in (yours type) installation process how to do so.


UNDER THE HOOD
--------------

Script will create temporary file in $TMP (/tmp by default): ``$TMP/leech.lunch``
- contains downloaded feed.

Files matched ``config/downloads`` rules goes directly to DOWNLOADS_DIR. In
case of incomplete file retrieval, wget will resume download.
