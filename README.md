# Creating Three Tier Architecture

<img src= "https://github.com/ArchAndrew/Multi-tier/blob/main/ThreeTier.png" style="width:700px;">





## Prerequisites

- An AWS account with access keys assigned to corresponding user.
- Basic understanding of the [AWS console](https://aws.amazon.com/console/)
- Visual Studio Code [VSC](https://code.visualstudio.com/) (Windows)



## Step 1: Go to Route 53 

1. Enter Route 53 in search bar within AWS console.
2. Select registered domains.


<img src= "https://github.com/ArchAndrew/Multi-tier/blob/main/RTE53Domain.png" alt="image description" style="width:200px;">


3. Click on register domains.
   
<img src= "https://github.com/ArchAndrew/Multi-tier/blob/main/Register%20Domain.png" alt="image description" style="width:500px;">


4. Search for desired domain availability and purchase it.

<img src= "https://github.com/ArchAndrew/Multi-tier/blob/main/SearchDomain.png" alt="image description" style="width:500px;">




## Step 2: Go to AWS Certificate Manager


1. Click on request certificate.

<img src= "https://github.com/ArchAndrew/Multi-tier/blob/main/RequestCert.png" alt="image description" style="width:500px;">

2. Now enter your domain name from step 1.
3. And choose certificate validatation via. Email (Though DNS validation is recommended I choose the email option being that it is faster).

*Note: Validation can take up to an hour.*

<img src= "https://github.com/ArchAndrew/Multi-tier/blob/main/DomainName.png" style="width:500px;">


4. Go to "list certificates" to confirm validation.

<img src= "https://github.com/ArchAndrew/Multi-tier/blob/main/ListCert.png" style="width:500px;">



## Step 3 Open Visual Studio Code and import .tf files 0-11 from "Multi-Tier" repo


1. For now we need all .tf files except 12-RDSDB.tf. Once files are open in VSC modify them as necessary. (Instructions are included within code.)
2. Type EC2 in the search bar of the AWS console, and click launch instance.

    *Note: we are not actually launching an instance we just need some variables from the console to enter into our "launchtemplate.tf"*


<img src= "https://github.com/ArchAndrew/Multi-tier/blob/main/EC2Launch.png" style="width:400px;">


3. Copy the AMI i.d from AWS and paste this into line 3 of the "launchtemplate.tf" within VSC.

<img src= "https://github.com/ArchAndrew/Multi-tier/blob/main/AMI.png" style="width:500px;">


4. Go back to console and on the same instance set-up page scroll down and click "create new key pair" name it and download it to your local machine. This key will help us to connect to AWS through VSC, alongside the AWS access keys that are attached to your user which you should already have. More on access keys next.

<img src= "https://github.com/ArchAndrew/Multi-tier/blob/main/KeyPair.png" style="width:500px;">



## Step 4 Input your Access keys into VSC 

1. We will enter our keys into the VSC via the terminal
2. In terminal enter:
 ```bash
aws configure
```

3. You want to enter your AWS access keys and secrets access keys in the provided locations, as well as your desired region and output format which in this case is json. Now press enter one more time to take you back to the present working directory.

<img src= "https://github.com/ArchAndrew/Multi-tier/blob/main/awsconfigure.png" style="width:500px;">



## Step 5 Run Terraform script

1. Now that we have VSC configured to AWS its time to initialize terraform. Run command:
 ```bash
terraform init
```
*Notice our terraform init was successful*

<img src= "https://github.com/ArchAndrew/Multi-tier/blob/main/Tfinit.png" style="width:500px;">


2. Next we want to verify that our configuration is valid. Enter:
```bash
terraform validate
```
*Notice this is also successful*

<img src= "https://github.com/ArchAndrew/Multi-tier/blob/main/Tfvalidate.png" style="width:500px;">


3. Now, we will plan to deploy our resources in AWS with this command:
```bash
terraform plan
```
*Note: you may be prompted to enter your region of choice after entering this command otherwise you will get a count of the resources that you plan to deploy*


<img src= "https://github.com/ArchAndrew/Multi-tier/blob/main/Tfplan.png" style="width:500px;">

4. Next, we will apply our resources with this command:
```bash
terraform apply
```
*You will be asked to approve this action, so enter "yes". However if you want to skip this step, instead of entering the above command you can enter:*
```bash
terraform apply -auto-approve
```
<img src= "https://github.com/ArchAndrew/Multi-tier/blob/main/Tfapply.png" style="width:500px;">

*Once your deployment is complete you will get this message:*

<img src= "https://github.com/ArchAndrew/Multi-tier/blob/main/Tfapplygood.png" style="width:500px;">

5. Now, go to the AWS console to ensure that your resources have been populated. Enter EC2 in the search bar, and then enter VPC to check for resources

<img src= "https://github.com/ArchAndrew/Multi-tier/blob/main/ResourcesEC2.png" style="width:400px;">


<img src= "https://github.com/ArchAndrew/Multi-tier/blob/main/ResourcesVPC.png" style="width:400px;">



## Step 6 Add RDS DB

1. Remember we deployed modules 0-11, but not 12. We did this because in order to deploy the DB we will need the subnet i.d. (in this case we need three). The subnet ids. are provided in our terminal after the initial deployment. We only want private subnets to house our DB.


<img src= "https://github.com/ArchAndrew/Multi-tier/blob/main/Subnetids.png" style="width:500px;">

2.Import the 12-RDSDB.tf into VSC and save.
3.Then enter:
```bash
aws rds describe-db-engine-versions --engine mysql --query "DBEngineVersions[].EngineVersion"
```
*Note we need to ensure that our DB has one of the following versions in order to ensure we do not get any errors. If version is not current modify this section now. SEE line 7 of 12-RDSDB.tf module.

<img src= "https://github.com/ArchAndrew/Multi-tier/blob/main/RDSDBVersion.png" style="width:500px;">

4. Next, on line 35 paste your subnet ids. Then save.
5. Now, lets update our terraform. In our terminal we can enter:
```bash
terraform init -upgrade
```

*Note: You will see this message*

<img src= "https://github.com/ArchAndrew/Multi-tier/blob/main/Tfinitupgrade.png" style="width:500px;">

6. Then, enter
```bash
terraform plan
```

*Note: Resources to be added*

<img src= "https://github.com/ArchAndrew/Multi-tier/blob/main/TfplanDB.png" style="width:500px;">

7. Now, enter
```bash
terraform apply -auto-approve
```

*This will take awhile. I recommend a well deserved coffee break!* 

## Welcome Back! Your DB has been deployed

<img src= "https://github.com/ArchAndrew/Multi-tier/blob/main/DBcomplete.png" style="width:500px;">

1. Check your resources. Search EC2 in the AWS console and notice the DB instances.

<img src= "https://github.com/ArchAndrew/Multi-tier/blob/main/DBinstance.png" style="width:500px;">

2. Now search for RDS and click on database.

<img src= "https://github.com/ArchAndrew/Multi-tier/blob/main/RDSdblist.png" style="width:250px;">

*Notice your DB*

<img src= "https://github.com/ArchAndrew/Multi-tier/blob/main/RDSonAWS.png" style="width:500px;">

## Step 7 Tear down

1. Time to clean up. Lets run this command:
```bash
terraform destroy
```

*Note you can also run the following command as well in order to avoid terraform from questioning your action.*

```bash
terraform destroy -auto-approve
```

*Again, this will take awhile. Coffee, workout, study, or popcorn. Whatever floats your boat!*


## Uh-oh looks like we have an error :open_mouth:

<img src= "https://github.com/ArchAndrew/Multi-tier/blob/main/DBOptionError.png" style="width:500px;">

- No worries. The RDS option group is used by final DB snapshot. Terraform doesn't know about this. The option group can be removed only when final snapshot is removed.
- To do this we must go to the AWS console and delete the snapshot first.

## Step 8 Goodbye Option Group :wave:
1. Go to RDS. Click snapshots=>actions=>delete snapshot.

<img src= "https://github.com/ArchAndrew/Multi-tier/blob/main/DeleteSnapShot.png" style="width:500px;">

2. Now in the same RDS section click on option groups.

<img src= "https://github.com/ArchAndrew/Multi-tier/blob/main/Optmenu.png" style="width:400px;">

3. Select your option group and delete. [Do NOT touch the default] :warning:

<img src= "https://github.com/ArchAndrew/Multi-tier/blob/main/DeleteOptionGroup.png" style="width:500px;">

4. On the next screen click delete.

<img src= "https://github.com/ArchAndrew/Multi-tier/blob/main/DeleteOptionGroup2.png" style="width:500px;">

*You should see this message*

<img src= "https://github.com/ArchAndrew/Multi-tier/blob/main/DeleteSuccessful.png" style="width:500px;">

*Only the default option group should exist*

<img src= "https://github.com/ArchAndrew/Multi-tier/blob/main/DefaultOptOnly.png" style="width:500px;">

5. While we are in the console lets check if Terraform at least deleted our database. Yup its gone, this is good!

<img src= "https://github.com/ArchAndrew/Multi-tier/blob/main/DBDeleted.png" style="width:500px;">

6. Lastly lets go back to VSC and run this command one more time to verify that all resources have been terminated.
```bash
terraform destroy -auto-approve
```
<img src= "https://github.com/ArchAndrew/Multi-tier/blob/main/DestroyComplete.png" style="width:500px;">

## Congratulations! :sunglasses: Not a resource in site! :clap:



   

















