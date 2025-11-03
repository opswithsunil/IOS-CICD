#!/usr/bin/env sh

PROFILE_FILE=${DISTRIBUTION_PROVISION_UUID}.mobileprovision

# Recreate the certificate from the secure environment variable
echo $DISTRIBUTION_PROVISION_KEY | base64 --decode > $PROFILE_FILE

mkdir -p "$HOME/Library/MobileDevice/Provisioning Profiles"

# copy where Xcode can find it
cp ${PROFILE_FILE} "$HOME/Library/MobileDevice/Provisioning Profiles/${DISTRIBUTION_PROVISION_UUID}.mobileprovision"

# clean
rm -fr *.mobileprovision
