# Install Certificates to Trusted Root Stores

A quick batch file script to install a certificate in the same folder as the script to the Trusted Root Store on the Local Machine the script is run on.


## Usage/Examples

To use this batch script, you will first need a Root Certificate, ideally in a `.cer` format.

**N.B.** if the certificate is in a `.crt` format instead, you will need to modify the script accordingly.

To use the script, just type in the file name of the certificate at the prompt (without the extension). For example, if your Root Certificate existed in the folder as `myRootCA.cer`, you would type `myRootCA` at the prompt.

**IMPORTANT NOTE:**

This script must be run as an administrator account, as it places the certificates in the `Local Machine` store on the device.
## Authors

- [@Euan Fitzpatrick](https://www.github.com/euanfitzpatrick) from [@Future Evolved Group](https://github.com/future-evolved-group) 


## License

This code is licensed under the [GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.en.html).
