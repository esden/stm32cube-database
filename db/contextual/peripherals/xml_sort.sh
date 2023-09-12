#!/bin/bash
# This script will sort all entries in XML file, in alphabetic order
# Script prerequisites
#  - msxsl must be installed on the machine
#
# example:
#   ls -1 *.xml | xargs -I {} msxsl {} xml_tri.xsl -o {}

##########################################
## Needed command for this script       ##
##########################################
_needed_commands="ls msxsl dos2unix" ;
 
########################################################
## Chekc the availability of all scripts ans commands ##
########################################################
checkrequirements () {
        command -v command >/dev/null 2>&1 || {
                echo "WARNING> \"command\" not found. Check requirements skipped !"
                return 1 ;
        }
        for requirement in ${_needed_commands} ; do
                echo -n "checking for \"$requirement\" ... " ;
                command -v ${requirement} > /dev/null && {
                        echo "ok" ;
                        continue ;
                } || {
                        echo "
						This command is required but not found !
						Please install it, or update your path, first
						" ;
                        _return=1 ;
                }
                done
        [ -z "${_return}" ] || { 
                echo "ERR > Requirement missing." >&2 ; 
                exit 1 ;
        }
}

########################################################
## Usage message                                      ##
########################################################
usage() {
cat << EOF
	This script is used to sort all ref entries, in all xml files, in alphabetic order.
	it uses the xml_tri.xsl file to do so.
	For more details on how it works please refer to various free courses under internet.
	following could be a good atrting point:
	http://magali.contensin.online.fr/html/XML/index.php?section=xsl&page=introduction
EOF
	exit 1
}

##########################################
##########################################
## =====          MAIN             ==== ##
##########################################
##########################################
#
# first make sure to be at the top of the GIT tree
#
while getopts :h opt
do
  case $opt in
    h)
      usage
      ;;
    \?)
	  echo "---------------------------------------------"
	  echo "ERROR : -$OPTARG is an unsupported command line option"
	  echo "---------------------------------------------"
      usage
      ;;
    :)
	  echo "---------------------------------------------"
	  echo "ERROR : Option -$OPTARG requires an argument"
	  echo "---------------------------------------------"
	  usage
      ;;
    *)
	  echo "---------------------------------------------"
	  echo "ERROR : -$OPTARG is an unsupported command line option"
	  echo "---------------------------------------------"
	  usage
      ;;
  esac
done

checkrequirements

#find . -name "*.xml" -exec echo "---------------------------------------------" \; -exec echo 'msxsl "{}" xml_tri.xsl -t -o "{}"' \; -exec msxsl "{}" xml_tri.xsl -t -o "{}" \; -exec dos2unix "{}" \; -exec sed -i 's/UTF-16/UTF-8/' {} \;
find . -name "*.xml" -exec echo "---------------------------------------------" \; -exec echo 'msxsl "{}" xml_tri.xsl -t -o "{}"' \; -exec msxsl "{}" xml_tri.xsl -t -o "{}" \;


