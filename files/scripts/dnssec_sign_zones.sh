#!/bin/sh

# File controlled by puppet - module dnssec.

###################################################
#ZONE_DIR="/var/named/chroot/var/named/master/zonas"
CHROOT_BASE="/var/named/chroot"
ZONE_BASE="${CHROOT_BASE}/var/named/master"
ZONE_DIR="${ZONE_BASE}/zones"
ZONE_KEYS="${ZONE_BASE}/zones/keys"
ZONE_DSSET="${ZONE_BASE}/dsset"
ZONE_SIGNED="${ZONE_BASE}/signed"
LOG_FILE="${CHROOT_BASE}/var/log/$(basename $0).log"

test -d "${ZONE_SIGNED}" || mkdir -p ${ZONE_SIGNED} >/dev/null 2>&1
test -d "${ZONE_DSSET}" || mkdir -p ${ZONE_DSSET} >/dev/null 2>&1


# data final de validade dos registros Formato: AAAAMMDDHHMMSS
END_DATE="20161231235959"


FUNCTION_SIGN_ALL() {

  OPWD="$PWD"
  cd $ZONE_DIR
  for ZONE_FNAME in $(ls ${ZONE_DIR}/db.*); do

    ZONE_NAME="$(basename $ZONE_FNAME |awk -F'db.' '{print$2}')";
    DOMAIN=$ZONE_NAME

    if [ "$ZONE_NAME"x == "x" ]; then
      echo "## Domain file db not found for domain [$DOMAIN]." |tee -a ${LOG_FILE}
    else  

      echo -n " # Signing zone [$DOMAIN]... " |tee -a ${LOG_FILE}
      dnssec-signzone -r /dev/random -e $END_DATE -o $ZONE_NAME -d ${ZONE_DSSET} -K ${ZONE_KEYS}/ -f ${ZONE_SIGNED}/${ZONE_NAME}.signed $ZONE_FNAME >/dev/null 2>&1
      #dnssec-signzone -r /dev/random -e $END_DATE -o $ZONE_NAME -d ${ZONE_DSSET} -K ${ZONE_KEYS}/ -f ${ZONE_SIGNED}/${ZONE_NAME}.signed $ZONE_FNAME 

      if [ $? -ne 0 ]; then
        echo -n " Errors found. " |tee -a ${LOG_FILE}
      fi
      if [ -f "${ZONE_SIGNED}/${ZONE_NAME}.signed" ]; then
        echo " SUCCESS [${ZONE_SIGNED}/${ZONE_NAME}.signed]" |tee -a ${LOG_FILE}
      else
        echo " ERROR. File [${ZONE_SIGNED}/${ZONE_NAME}.signed] not found" |tee -a ${LOG_FILE}
      fi
    fi
  done

  cd $OPWD
}
FUNCTION_SIGN_ALL;

