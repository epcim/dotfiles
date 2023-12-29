#!/bin/sh

myping(){
  loops=6
# --
  gPL=0
  while ( $loop -le $loops ); do

    ping -c 600 seznam.cz > ~/tmp/ping600.log
    mPL=0;
    PL=`grep -n3 'ping statistics ---' ~/tmp/ping600.log | awk '{print $6}'|sed -e 's/%//'`;
    if [ $PL -gt 20 ] ; then
      if [ $PL -ge $mPL  ] && mPL=$PL || echo nic;
      gPL=$(( $gPL + 1 )) 
    fi;
    loop=$(( $loop + 1 ))

  ;done    
  
  echo "Max PL: $mPL"
  echo "PL fre: $gPL/$loops"
}


myping
