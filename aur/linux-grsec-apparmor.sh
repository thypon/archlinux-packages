#!/bin/bash
NAME="linux-grsec-apparmor"
LOCATION="./$NAME"
BASEPKG="community/linux-grsec"

TMPABS=$(mktemp -d)

CONF='CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE=0
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_AUDIT=y
CONFIG_DEFAULT_SECURITY_APPARMOR=y
CONFIG_DEFAULT_SECURITY="apparmor"
# CONFIG_AUDITSYSCALL is not set
# CONFIG_SECURITY_SELINUX is not set
CONFIG_SECURITY_NETWORK=y
# CONFIG_SECURITY_NETWORK_XFRM is not set
# CONFIG_NETFILTER_XT_TARGET_AUDIT is not set
# CONFIG_INTEGRITY_AUDIT is not set'

ABSROOT="$TMPABS" abs $BASEPKG
mkdir -p $LOCATION
cp $TMPABS/$BASEPKG/* $LOCATION/
sed -i "s/^pkgbase=linux-grsec/pkgbase=$NAME/" $LOCATION/PKGBUILD
echo "$CONF" >> $LOCATION/config
echo "$CONF" >> $LOCATION/config.x86_64
updpkgsums $LOCATION/PKGBUILD
chmod 644 $LOCATION/*

