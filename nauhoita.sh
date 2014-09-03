#!/bin/bash

#
# GNU General Public License v3
#


_channel=""
_time=""
_duration=""
_file=""

_all_ok=0

function _print_help() {
    echo "

Skripti telkkariohjelmien nauhoituksiin.

(c) Juho Vähäkangas

Käyttö:
=======

-c help 
    kertoo mitä kanavavaihtoehtoja on, mikä kanava nauhoitetaan
-t vuosi-kuukausi-päivä tunnit:minuutit
    milloin nauhtoitus aloitetaan (atd pitää olla käynnissä)
-d tunnit.minuutit
    nauhoituksen kesto (0:30 = 30min, 1:30 = 1h 30min)
-f tiedostonimi.ts
    kerrotaan ohjelmalle mihin nauhoitetaan

Esimerkiksi
   $0 -c tv1 -t '2014-12-24 12:00' -d 0:30 -f julistus.ts
"
}

# function _iso_to_at() {
function parse_to_at() {
    x="$1 $2"
    read Y M D h m <<< ${x//[-: ]/ }
    _time="${h}:${m} ${M}/${D}/${Y}"
}

function calculate_time() {
    read hours minutes <<< ${1//[:]/ }
    _duration=$((${hours}*60*60+${minutes}*60))
}

function channel() {
    case $1 in
	tv1) _channel="udp://@239.16.116.1:5555" ;;
	tv2) _channel="udp://@239.16.116.2:5555" ;;
	mtv3) _channel="udp://@239.16.116.3:5555" ;;
	nelonen) _channel="udp://@239.16.116.4:5555" ;;
	fst5) _channel="udp://@239.16.116.5:5555" ;;
	sub) _channel="udp://@239.16.116.6:5555" ;;
	urheilu) _channel="udp://@239.16.116.7:5555" ;;
	liv) _channel="udp://@239.16.116.8:5555" ;;
	kutonen) _channel="udp://@239.16.116.10:5555" ;;
	taivas) _channel="udp://@239.16.116.11:5555" ;;
	fox) _channel="udp://@239.16.116.12:5555" ;;
	tv5) _channel="udp://@239.16.116.13:5555" ;;
	jim) _channel="udp://@239.16.116.14:5555" ;;

	help|*) 
	    _channel="";
	    echo "
Kanavavaihtoehdot ovat:
=======================
 tv1
 tv2
 mtv3
 nelonen
 fst5
 sub
 urheilu
 jim
 kutonen
 taivas
 fox
 viisi
 
";;
	esac
}

function check_variables() {
    _x=0
    [[ -z $_channel ]] && echo "Virhe: kanava ei voi olla " $_channel "." && _x=1
    [[ -z $_time ]] && echo "Virhe: aika ei voi olla " $_time "." && _x=1
    [[ -z $_duration ]] && echo "Virhe: kesto ei voi olla " $_duration "." && _x=1
    [[ -z $_file ]] && echo "Virhe: tiedosto ei voi olla " $_file "." && _x=1
    if [ _x == 1 ];
    then
	_all_ok=0
	echo "Asetuksissa jotain häikkää."
	exit
    else
	_all_ok=1
	echo "Asetukset oikein."
    fi
}

function write_to_file() {
    cvlc -q $_channel --run-time=$_duration --intf=dummy --sout file/ts:${1} --sout-all vlc://quit | at $_time 2>&1 >/dev/null &
#    ffmpeg -loglevel quiet -i ${_kanava} -acodec copy -t ${_kesto} -vcodec copy -y ${1} | at $_aika &  # 2>&1 >/dev/null
}

while getopts ":c:t:d:f:h" opt; do
    case $opt in
	c)
	    channel $OPTARG;; 
	t)
	    parse_to_at $OPTARG;;
	d) 
	    calculate_time $OPTARG;;
	f)     
	#    _file=$OPTARG
	#    check_variables
	    write_to_file $OPTARG;;
	h) _print_help ;;
    esac
done

# Tulostetaan help mikäli parametrejä ei ole annettu
[[ -z $1 ]] && _print_help
