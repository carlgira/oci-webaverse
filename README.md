# Webaverse in OCI
Terraform script to start a development **webaverse** instance. 

It comes with webaverse and code-server to develop directly in the browser. 

[Webaverse](https://app.webaverse.com/) is an open-source and browser-based web3 metaverse engine, and anyone can build and host virtual world and gaming experiences on.

<img src="webaverse.jpg">

## Requirements
- Terraform
- ssh-keygen

## Configuration

1. Follow the instructions to add the authentication to your tenant https://medium.com/@carlgira/install-oci-cli-and-configure-a-default-profile-802cc61abd4f.

2. Clone this repository
```bash
    git clone https://github.com/carlgira/oci-webaverse.git
```

3. Set three variables in your path. 
- The tenancy OCID, 
- The comparment OCID where the instance will be created.
- The "Region Identifier" of region of your tenancy. 
> **Note**: [More info on the list of available regions here.](https://docs.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm)

```bash
    export TF_VAR_tenancy_ocid='<tenancy-ocid>'
    export TF_VAR_compartment_ocid='<comparment-ocid>'
    export TF_VAR_region='<home-region>'
```

4. Execute the next command to generate private key to access the instance
```bash
    ssh-keygen -t rsa -b 2048 -N "" -f server.key
```

## Build
To build simply execute the next commands. 
```bash
    terraform init
    terraform plan
    terraform apply
```
## Test
To test everything you need to create a ssh tunel to the ports 3000 and 8080 (webaverse and code-server respectively).

```bash
    ssh -i server.key -L 3000:localhost:3000 -L 8080:localhost:8080 ubuntu@<instance-public-ip>
```

### Webaverse
Use chrome to open the URL https://localhost:3000, and you will see the webaverse UI.

### Code server
Code server is a vscode in the browser, open the URL http://localhost:8080/?folder=/home/ubuntu/webaverse and youll be able to program directly on webaverse.

## Clean
To delete the instance execute.
```bash
    terraform destroy
```

## Troubleshooting
If you found some problem check if the services are down. You can check the logs and the state of each app, with the commands.

```bash
    systemctl status webaverse.service
    systemctl status code-server@ubuntu
```

## Acknowledgements

* **Author** - [Carlos Giraldo](https://www.linkedin.com/in/carlos-giraldo-a79b073b/), Oracle
* **Last Updated Date** - March 12th, 2023