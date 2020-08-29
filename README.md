# About

This utility generates certificates who want to test their local sites using `https` (very useful for web development where browsers disable various features under `http`).

# Disclaimer

# Instructions

## 1. Generate a Certificate Authority and certificate

To get started, run `generate-ca`.  You will be prompted for the name of your organisation.  The script will create a folder in your home directory named `.self-signed-ca/<organisation_name>`.  You will then be prompted for the name of your certificate, and what domain names/ip addresses it will be valid for.

## 2. Install the Root Certificate

In order to get your machine/device to trust certificates created by this tool, you need to install the generated root certificate in your browser/device.

### Chrome & Safari (MacOS)

* Double-click on the `.self-signed-ca/<organisation_name>/ca.crt` file in Finder
* Enter your password
* Double-click on the newly installed certificate (it will have a red cross next to it), open the `Trust` section and set *When using this certificate* to `Always trust`
* Close the window and enter your password again

### Firefox (MacOS)

* `Preferences > Privacy & Security > View Certificates...`
* Click `Import...`
* Select the `Authorities` tab
* Open `.self-signed-ca/<organisation_name>/ca.crt`

### Chrome (Android)

* Run the `.self-signed-ca/<organisation_name>/server_ca.sh` script, and then on your Android device navigate to `http://<computer_ip>:3000`.  Chrome will download and install the CA.

## Firefox (Android)

This is currently impossible on modern versions of Firefox (https://github.com/mozilla-mobile/fenix/issues/2286).  On older versions the installation procedure is the same as Chrome (Android).

## 3. Create more certificates (optional)

You can create new certificates or update existing ones at any time by running the script at `.self-signed-ca/<organisation_name>/generate_certificate.sh`.


# Thanks

Shout out to https://deliciousbrains.com/ssl-certificate-authority-for-local-https-development for the excellent article that put me on the right track.