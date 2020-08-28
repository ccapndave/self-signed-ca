#!/usr/bin/env bash

PASSWORD=test

read -p "Enter a name for your certificate authority [development]: " ORGANISATION
ORGANISATION=${ORGANISATION:-development}

if [ -z "$ORGANISATION" ]
then
  echo ""
  echo "You need to enter a name to continue."
  exit 1
fi

ORGANISATION=${ORGANISATION// /_}
TARGET_DIR=$HOME/.self-signed-ca/$ORGANISATION

mkdir -p $TARGET_DIR

# Create a key and a CA for our organisation and put them in a folder
mkdir $TARGET_DIR
# openssl genrsa -passout pass:$PASSWORD -des3 -out ${TARGET_DIR}/ca.key 2048
# openssl req -passin pass:$PASSWORD -x509 -new -nodes -key ${TARGET_DIR}/ca.key -sha256 -days 825 -subj "/CN=${ORGANISATION} DEV CA/O=${ORGANISATION}/C=CH" -out ${TARGET_DIR}/ca.pem
openssl req -config openssl.cnf -x509 -new -days 825 -subj "/CN=${ORGANISATION} DEV CA/O=${ORGANISATION}/C=CH" -out ca.crt

# Create a bash script for generating certificates
SCRIPT=${TARGET_DIR}/generate_certificate.sh
cat /dev/null > $SCRIPT

echo "#!/usr/bin/env bash" >> $SCRIPT
echo "" >> $SCRIPT
echo "ORGANISATION=$ORGANISATION" >> $SCRIPT
echo "PASSWORD=test" >> $SCRIPT
echo "" >> $SCRIPT
echo "read -p \"Enter the filename for this certificate [server]: \" CERTIFICATE_NAME" >> $SCRIPT
echo "CERTIFICATE_NAME=\${CERTIFICATE_NAME:-server}" >> $SCRIPT
echo "" >> $SCRIPT
echo "read -p \"Enter the allowed servers [DNS:localhost,IP:192.168.43.158,IP:192.168.8.19]: \" SERVERS" >> $SCRIPT
echo "SERVERS=\${SERVERS:-DNS:localhost,IP:192.168.43.158,IP:192.168.8.19}" >> $SCRIPT
echo "" >> $SCRIPT
echo "openssl genrsa -passout pass:$PASSWORD -out \$CERTIFICATE_NAME.key 2048" >> $SCRIPT
echo "openssl req -passin pass:$PASSWORD -new -key \$CERTIFICATE_NAME.key -subj \"/C=CH\" -out \$CERTIFICATE_NAME.csr" >> $SCRIPT
echo "openssl x509 -req -passin pass:$PASSWORD -in \$CERTIFICATE_NAME.csr -CA ca.pem -CAkey ca.key -CAcreateserial -out \$CERTIFICATE_NAME.crt -days 825 -sha256 -extfile <(printf \"subjectAltName=\$SERVERS\")" >> $SCRIPT

chmod +x ${TARGET_DIR}/generate_certificate.sh

# Run the certificate generation script at once.
cd $TARGET_DIR && $SCRIPT