# Overview

Due to Helm secret management anyone with access to tiller can run a `helm get values --tls` command and see secret information in plain text (https://github.com/helm/helm/issues/2196) - only administrators or cluster administrators should have access to tiller. The configuration for an integration server (detailed in the `Configuration` section below) is stored in a secret. In order to separate this secret from the Helm release it should be created using the `generateSecrets.sh` command prior to the Helm chart installation.

## Configuration
The following table lists and describes the configurable files supported by the `generateSecrets.sh` script.

| File                             | Description                                                                     |
| -------------------------------- | ------------------------------------------------------------------------------- |
| `agentc.json`                    | Multi-line value containing a agentc.json file                                  |
| `agentp.json`                    | Multi-line value containing a agentp.json file                                  |
| `agentx.json`                    | Multi-line value containing a agentx.json file                                  |
| `adminPassword.txt`              | An admin password to set for the MQ queue manager                               |
| `appPassword.txt `               | An app password to set for the MQ queue manager                                 |
| `ca.crt`                         | The ca certificate in PEM format (will be copied into /home/aceuser/aceserver/tls on startup)  |
| `credentials`                   | Multi-line value containing a file which has details of accounts used to connect to external endpoints  |
| `extensions.zip`                 | Multi-line value containing an extensions.zip file                              |
| `keystorePassword`               | A password to set for the Integration Server's keystore                         |
| `keystore-{keyname}.pass`        | The passphrase for the private key being imported, if there is one              |
| `keystore-{keyname}.key`         | The private key in PEM format                                                   |
| `keystore-{keyname}.crt`         | The certificate in PEM format                                                   |
| `mqsc.txt`                       | An mqsc file to run against the Queue Manager                                   |
| `odbc.ini`                       | An odbc.ini file for the Integration Server to define any ODBC data connections |
| `policy.xml`                     | Policies to apply                                                               |
| `policyDescriptor.xml`           | The policy descriptor file                                                      |
| `serverconf.yaml`                | The server.conf.yaml                                                            |
| `setdbparms.txt`                 | This supports 2 formats: Each line which starts mqsisetdbparms will be run as written, Alternatively each line should specify the <resource> <userId> <password>, separated by a single space |
| `switch.json`                    | Multi-line value containing a switch.json                                       |
| `truststorePassword.txt`         | A password to set for the Integration Server's truststore                       |
| `truststore-{certname}.crt`      | The trust certificate in PEM format                                             |
| `tls.key`                        | The tls key in PEM format (will be copied into /home/aceuser/aceserver/tls on startup) |
| `tls.crt`                        | The tls certificate in PEM format (will be copied into /home/aceuser/aceserver/tls on startup) |

> **NB**: Take care not to include additional new lines at the end of the files (such as keystorePassword.txt) - some editors add these automatically on save and can result in the containers not starting due to password mismatch.

## Running

To run the script:
- The kubectl command must be installed and available
- The kubectl environment must be configured to point to the intended target cluster
- The name of the secret to be created must be supplied as an argument on the command line

```
./generateSecrets.sh my-secret
```

The script will look for any files detailed in the `Configuration` section in the same directory and if found will add them into keys in the generated secret. The script will then use the kubectl command to generate a secret containing the specified configuration for the integration server.
