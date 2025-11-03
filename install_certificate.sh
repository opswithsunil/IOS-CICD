#!/usr/bin/env sh

CERTIFICATE_P12=certificate.p12

# Recreate the certificate from the secure environment variable
echo $APPLE_DISTRIBUTION_CERTIFICATE_KEY | base64 --decode > $CERTIFICATE_P12

# Create new keychain
security create-keychain -p $BUILD_KEY_CHAIN_PASSWORD $BUILD_KEY_CHAIN

# Import certificates to disk from Environment variable
security import $CERTIFICATE_P12 -A -P $APPLE_DISTRIBUTION_CERTIFICATE_PASSWORD -k $BUILD_KEY_CHAIN

# Set Correct Default Keychain
security default-keychain -s $BUILD_KEY_CHAIN

# Unlock the Keychain:
security unlock-keychain -p $BUILD_KEY_CHAIN_PASSWORD $BUILD_KEY_CHAIN

# Check the Partition List:
security set-key-partition-list -S apple-tool:,apple: -s -k $BUILD_KEY_CHAIN_PASSWORD $BUILD_KEY_CHAIN

# Check if the certificate exists in the keychain by listing the contents
security find-identity -p codesigning $BUILD_KEY_CHAIN

#Set a longer timeout 
security set-keychain-settings -t $KEYCHAIN_TIME $BUILD_KEY_CHAIN

#Verify the Keychain Access
security show-keychain-info $BUILD_KEY_CHAIN

# remove certs
rm -fr *.p12
