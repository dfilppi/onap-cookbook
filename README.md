## ONAP + Cloudify Setup Instructions

This project describes the steps needed to use Cloudify in ONAP.  It uses the OOM Kubernetes approach from the Beijing release.  These instructions were tested on a Cloudify 4.4 manager running on Openstack.

### Step 1: Install A Cloudify Manager (4.3.2 )

Use the instructions [here](https://docs.cloudify.co/4.3.0/install_maintain/installation/). 
Once the manager is running, assign a public IP and ssh to it.  The manager host itself can be used as home base for the rest of the instructions.
Update the `/etc/cloudify/config.yaml` file, change the public_ip and private_ip to appropriate values.  Set the `networks` key to { ‘default’: <private_ip> }.
Run `cfy_manager configure --clean-db`
Run `cfy plugins bundle-upload`

### Step 2: Install Kubernetes
You will need the ability to start 5 16GB VMs.  8 GB will not work.  You might get away with 12 GB, but that wasn’t tried.
Ssh to the cloudify manager
Run `sudo yum update`
Run `sudo yum install -y git`
Run `git clone https://github.com/dfilppi/oom`.  This contains a patched version of the Beijing release oom.
Cd to the `oom/TOSCA/kubernetes-cluster-TOSCA` directory
Run `cfy bl up openstack-blueprint.yaml -b onap-k8s`
To create the deployment, you’ll need to gather some info:
* A Centos 7 image ID
* A flavor ID for a 16GB instance
* Keystone credentials:
  * Username
  * Password
  * Tenant name
  * Region
  * Keystone URL
  * A keypair for the instances (public and private key files).
Run `cfy secrets create -f <private key file> agent_key_private`
Run `cfy secrets create -f <public key file> agent_key_public`
Fill out the included “inputs.yaml” file.
Run `cfy dep cre onap-k8s -b onap-k8s -i inputs.yaml`
Run `cfy exe start install -d onap-k8s`

This step will take awhile.  Errors will scroll up, but a normal as the system waits for Openstack to create resources.  
If an error not related to resource creation is happening you can cancel by:
* Run `cfy exe list`
* Use the id of the last execution listed, and run `cfy exe cancel <execution id>`
* Then run `cfy exec start uninstall -d onap-k8s -p ignore_failure=true`
When complete, you can delete the deployment (`cfy dep delete onap-k8s`, change your inputs as needed, and reinstall per above).
__CHECKPOINT__: Make sure the Kubernetes Install worked:
Run `cfy dep outputs onap-k8s`
Use the `kubernetes_cluster_master_ip` output to ssh to the Kubernetes master node.
Run `kubectl get nodes`.  You should see the master and nodes all with status 'Ready’.
Run `kubectl get pods -n kube-system`.  You should see many lines come back, all with status ‘Running’.

### Step 3: Install ONAP Beijing
* Stay, or get back on, the Kubernetes master host.
* Run `sudo yum update -y`
* Cd to the `oom/kubernetes/so/resources/config/mso` directory.
* Edit the `cloud_config` file for your needs.  For the Cloudify integration demo, the `cloudify_managers` section is most important.  There is an example manager configuration there.  Change the IP address to point at your Cloudify manager.  The credentials are `admin/admin`.  The password is a secure hash of the plain text password.
* Follow these instructions: http://onap.readthedocs.io/en/latest/submodules/oom.git/docs/oom_user_guide.html#user-guide-label  with the following errata:
  * start at the line with ‘helm init’ on it. (helm is already installed)
  * Run `helm repo remove ‘stable’`.  No need to create a local repo, it’s already there.
  * You can skip: > helm install local/onap --name development -f onap-development.yaml
  * Stop at the line: > kubectl get pods --all-namespaces -o=wide

The startup process can take quite awhile ( many minutes).  You can poll it by running ‘kubectl get pods’ and watching the status progress.  Since containers for services other than the SO are pulled from ONAP Nexus, it can’t be guaranteed that they will all complete.  For the purposes of this cookbook, the only pods that matter are the “so-” pods.

Once started, the cluster is ready for demonstrating a simple Cloudify blueprint installation and/or deployment on the configured manager.  You can use ‘curl’ to activate the Vnf Adapter as follows:  

* `curl -H 'content-type: application/json' -X POST -i http://<so ip>:8080/vnfs/rest/v2/vnfs/111/vf-modules?mode=CLOUDIFY --data-binary "@_createvdu_body"`
* The _createvdu_body file contents are: 
```json
{ "createVfModuleRequest":
                 {"cloudSiteId": "Cloudify",
                 "tenantId": "8e27d987536441e3a8762cdb4285aec6",
                 "vnfId": "111",
                 "vfModuleId": "somemodid",
                 "vfModuleName": "CloudifyTest",
                 "modelCustomizationUuid": "17424b51-742e-40f5-b9c8-83918849a787",
                 "vnfType": "ApacheVnf",
                 "vfModuleParams":
                    {"key_pair_name": "dfilppi-rs"
                    },
                 "failIfExists": true,
                 "messageId": "ra.1",
                 "skipAAI": true,
                 "msoRequest": {
                 "requestId": "ra1",
                 "serviceInstanceId": "sa1"
                 }}
}
```

Note that in the body, you will have to edit the `key_pair_name` to be an existing key pair.  The `vfModuleName` represents the deployment name.


## Alternative instructions for already running ONAP on K8S

The preceding instructions take care of a purpose built container and Helm chart to ease database and SO configuration.  If you’ve already got a running ONAP, use the following instructions.

### Step 1: Install Test Data in SO Database
Run a shell in the MariaDb container in the development-so-db POD.  Create a file from [src/sql/update_catalogdb.sql]().  Then update the database using `mysql -p mso_catalog update_catalogdb.sql`.


### Step 2: Configure cloud_config.json

Edit the ‘/etc/mso/config.d/cloud_config.json’ file to include a cloudify_managers section, e.g.:

```json
    "cloudify_managers":
    {
        "Cloudify":
        {
          "cloudify_url": "http://10.239.0.186",
          "username": "admin",
          "password": "0FC48BD43A6E041CA3041DC8F9EF62CB",
          "version": "17.6.30"
        }
    }
```

Note that the example password is the hash (AES) hex string of the plaintext password “admin”.  To use a different password, the new password will need be similarly hashed.

### Step 3: Install Patched MsoVnfAdapter war.

The patched version of the MsoVnfAdapter war is available here:  https://www.dropbox.com/s/syyikqd15dr8p8a/mso-vnf-adapter-1.2.0-SNAPSHOT.war?dl=0.  This file needs to replace the mso-vnf-adapter war in the /opt/jboss/standalone/deployments directory.  It may need to be renamed first so that it overwrites the existing war, depending on the details of your existing deployment.

Step 4: Run the example Cloudify VDU blueprint

These instructions are a duplicate of the “from scratch”  instructions:

Once started, the cluster is ready for demonstrating a simple Cloudify blueprint installation and/or deployment on the configured manager.  You can use ‘curl’ to activate the Vnf Adapter as follows:  
curl -H 'content-type: application/json' -X POST -i http://<so ip>:8080/vnfs/rest/v2/vnfs/111/vf-modules?mode=CLOUDIFY --data-binary "@_createvdu_body"
The _createvdu_body file contents are: 

```json
{ "createVfModuleRequest":
                 {"cloudSiteId": "Cloudify",
                 "tenantId": "8e27d987536441e3a8762cdb4285aec6",
                 "vnfId": "111",
                 "vfModuleId": "somemodid",
                 "vfModuleName": "CloudifyTest",
                 "modelCustomizationUuid": "17424b51-742e-40f5-b9c8-83918849a787",
                 "vnfType": "ApacheVnf",
                 "vfModuleParams":
                    {"key_pair_name": "dfilppi-rs"
                    },
                 "failIfExists": true,
                 "messageId": "ra.1",
                 "skipAAI": true,
                 "msoRequest": {
                 "requestId": "ra1",
                 "serviceInstanceId": "sa1"
                 }}
}
```

Note that in the body, you will have to edit the `key_pair_name` to be an existing key pair.  The `vfModuleName` represents the deployment name.




