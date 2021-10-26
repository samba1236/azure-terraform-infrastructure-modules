@Library("com.optum.jenkins.pipeline.library@master") _
DEPLOYABLE_BRANCHES = ["elink"]
SERVICE_PRINCIPAL = [elink: "test-eas-service-principle"]
REMOTE_STATE_PARAMS = [elink: "remote-backend-stage.properties"]
TF_PARAMS = [elink: "terraform-stage.tfvars"]
pipeline {
  agent none
  environment {
    AZURE_CREDENTIALS_ID = getAzureCredentialId(env.BRANCH_NAME)
    DEPLOY_BRANCH = getDeployBranch(env.BRANCH_NAME)
    AZURECLI_VERSION = '2.11.1'
    TERRAFORM_VERSION = '0.14'
    TERRAFORM_VARS = getTfVars(env.BRANCH_NAME)
  }
  options {
    disableConcurrentBuilds()
  }
  stages {
    stage ('Prepare Terraform Environment') {
      //agent {
        //label 'docker-terraform-agent'
      //}
      agent any
      environment {
        //Set all these values for each environment
        tfvars = readProperties file: getRemoteFileName(env.BRANCH_NAME)
        VARIABLES_FILE = "${env.TERRAFORM_VARS}"
        TF_BACKEND_RG = "${tfvars.tf_backend_rg}"
        TF_BACKEND_ACCOUNT = "${tfvars.tf_backend_account}"
        TF_BACKEND_LOCATION = "${tfvars.tf_backend_location}"
        TF_BACKEND_CONTAINER = "${tfvars.tf_backend_container}"
        TF_BACKEND_KEY = "${tfvars.tf_backend_key}"
      } 
      stages {
        stage('Terraform Init') {
          steps {

            echo "AZURE_CREDENTIALS_ID: ${AZURE_CREDENTIALS_ID}";
            echo "TERRAFORM_VARS: ${env.TERRAFORM_VARS}";
            echo "env.branch: ${env.BRANCH_NAME}";
            echo "env.DEPLOY_BRANCH: ${env.DEPLOY_BRANCH}";
            echo "env.tf_backend_rg: ${env.TF_BACKEND_RG}";
            echo "env.tf_backend_location: ${env.TF_BACKEND_LOCATION}";
            echo "env.tf_backend_key: ${env.TF_BACKEND_KEY}";
            echo "env.tf_backend_account: ${env.TF_BACKEND_ACCOUNT}";
            echo "env.tf_backend_container: ${env.TF_BACKEND_CONTAINER}";  

            glAzureLogin(env.AZURE_CREDENTIALS_ID) {
              glTerraformInit(
                azureInit: true,
              )
            }
            stash name: 'tfenv', includes: ".terraform/**/*, .terraform.lock.hcl"
          }
        }
        stage('Terraform Plan') {
          steps {
            ansiColor('xterm') {
              unstash name: 'tfenv'
              glAzureLogin(env.AZURE_CREDENTIALS_ID) {
                sh "mkdir -p /home/jenkins/.kube/ && touch /home/jenkins/.kube/config"
                glTerraformPlan(
                  additionalFlags: [
                    ('var-file'): env.VARIABLES_FILE,
                    out: 'plan.tfplan'
                  ]
                )
              }
              stash name: 'tfenv', includes: ".terraform/**/*, plan.tfplan, .terraform.lock.hcl"
            }
          }
        }
      }
    }
    stage('Validate Terraform Plan') {
      agent none
      when {
        branch env.DEPLOY_BRANCH
      }
      steps {
        timeout(time: 30, unit: 'MINUTES') {
          input(message: 'Apply this terraform plan?')
        }
      }
    }
    stage('Apply Terraform Plan') {
     // agent {
        //label 'docker-terraform-agent'
      //}
      agent any
      when {
        branch env.DEPLOY_BRANCH
      }
      steps {
        glAzureLogin(env.AZURE_CREDENTIALS_ID) {
          ansiColor('xterm') {
            unstash name: 'tfenv'
            sh "mkdir -p /home/jenkins/.kube/ && touch /home/jenkins/.kube/config"
            glTerraformApply(
              planFile: 'plan.tfplan'
            )
          }
        }
      }
    }
  }
}
/* The method will get service principle by branch name*/
def getAzureCredentialId(branchName) {
  println "principle map : ${SERVICE_PRINCIPAL}"
    if(SERVICE_PRINCIPAL.containsKey(branchName)) {
        return SERVICE_PRINCIPAL[branchName];
      }
     else {
        throw new Exception("service principle is not configured for " + branchName)
    }
}

/* The method will get deployable branch name*/
def getDeployBranch(branchName){
  println "branch name : ${branchName}"
   if(DEPLOYABLE_BRANCHES.contains(branchName)) {
        return branchName;
    } else {
        throw new Exception("not a valid branch for deployment: " + branchName)
    }
}

/* The method will get the remote backend property file name*/
def getRemoteFileName(branchName) {
  
    if(REMOTE_STATE_PARAMS.containsKey(branchName)) {
      println "remote backend properties : ${REMOTE_STATE_PARAMS[branchName]}"
        return REMOTE_STATE_PARAMS[branchName];
      }
     else {
        throw new Exception("terraform vars file is not avilable for this environment" + branchName)
    }
}

/* The method will get the tf vars file name*/
def getTfVars(branchName) {
  
    if(TF_PARAMS.containsKey(branchName)) {
      println "tf vars file : ${TF_PARAMS[branchName]}"
        return TF_PARAMS[branchName];
      }
     else {
        throw new Exception("terraform vars file is not avilable for this environment" + branchName)
    }
}