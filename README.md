# Self-signed-ca

## About

This utility generates certificates who want to test their local sites using `https` (very useful for web development where browsers disable various features under `http`).

## Disclaimer

## Instructions

### 1. Generate a Certificate Authority and certificate

To get started, run `generate-ca`.  You will be prompted for the name of your organisation.  The script will create a folder in your home directory named `.self-signed-ca/<organsation_name>`.  You will then be prompted for the name of your certificate, and what domain names/ip addresses it will be valid for.

### 2. Install the Root Certificate

In order to get your machine/device to trust certificates created by this tool, you need to install the root certificate at `.self-signed-ca/<organsation_name>/<organsation_name>CA.pem`.  You can either install the certificate at a system or browser level.  Check Google for details on how to install root certificates on various devices and browsers.

### 3. Create more certificates (optional)

You can create new certificates, or update existing ones at any time by running the script at `.self-signed-ca/<organsation_name>/generate_certificate.sh`.


# References

Shout out to https://deliciousbrains.com/ssl-certificate-authority-for-local-https-development for the excellent article!