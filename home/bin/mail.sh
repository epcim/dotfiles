#!/bin/bash


function help () {
echo "Send a message using ssmtp by emulating the send-only behaviour of the mail command"
echo "which appeared in Version 6 AT&T UNIX. If you are not using mail in a pipe you"
echo "are expected to type in your message, followed by an \`control-D' at the beginning"
echo "of a line. The full name of the sender will be read from /etc/passwd but when \$MAIL_NAME"
echo "is set that name will be used instead."
echo
echo "Usage: mail [-iInv] [-s subject] [-c cc-addr] [-b bcc-addr] [-R reply-addr] to-addr ..."
echo "     -v    Verbose mode.  The details of delivery are displayed on the user's"
echo "           terminal."
echo "     -i    (ignored) Ignore tty interrupt signals.  This is particularly useful when"
echo "           using mail on noisy phone lines."
echo "     -I    (ignored) Forces mail to run in interactive mode even when input isn't a ter-"
echo "           minal.  In particular, the \`~' special character when sending mail"
echo "           is only active in interactive mode."
echo "     -n    (ignored) Inhibits reading /etc/mail.rc upon startup."
echo "     -s    Specify subject on command line (only the first argument after the"
echo "           -s flag is used as a subject; be careful to quote subjects contain�"
echo "           ing spaces.)"
echo "     -R    Specify reply-to adress on command line. Only the first argument"
echo "           after the -R flag is used as the address."
echo "     -c    (ignored) Send carbon copies to list of users."
echo "     -b    (ignored) Send blind carbon copies to list.  List should be a comma-separated"
echo "           list of names."
}

flags=""
subject=""
reply=""
bcc=""
cc=""
to=""

function hasNext () {
  [ -z "$1" ] && {
    help
    exit 1
  } || return 0
}

# start option processing
while test $# -gt 0 ; do
  case $1 in
    -i | -I | -n )
      # ignore
      shift ;;
    -v )
        flags="$flags -v" 
        shift ;;
    -s )
      hasNext $2 && {
        subject=$2
        shift 2
      } ;;
    -c )
      hasNext $2 && {
        cc=$2
        shift 2
      } ;;
    -b )
      hasNext $2 && {
        bcc=$2
        shift 2
      } ;;
    -R )
      hasNext $2 && {
        reply=$2
        shift 2
      } ;;
    --help | -h )
        help
        exit 0 ;;
    -* )
       echo "$0: invalid option $1" >&2
       help
       exit 1 ;;
    * )
       to="$to $1"
       shift ;;
  esac
done

function tmp-file-name () {
  local name
  seconds=$(date +%s) 
  count=0
  name=$seconds
  while [ -e /tmp/$name ] ; do 
    name=$seconds.$count
    count=$[$count + 1]
  done
  echo /tmp/$name
}

tmpfile=$(tmp-file-name)

[ ! -z "$subject" ] && echo "Subject: $subject" >> $tmpfile
[ ! -z "$to" ] && echo "To: $to" >> $tmpfile
[ ! -z "$cc" ] && echo "Cc: $cc" >> $tmpfile
[ ! -z "$bcc" ] && echo "Bcc: $bcc" >> $tmpfile
[ ! -z "$reply" ] && echo "Reply-to: $reply" >> $tmpfile
echo >> $tmpfile

[ ! -z "${MAIL_NAME}" ] && mailname="-F${MAIL_NAME}"
sed 's/\$\.\^/\$\.\^/g' >> $tmpfile

cat $tmpfile | /usr/sbin/ssmtp $flags "$mailname" $to
rm -f $tmpfile
