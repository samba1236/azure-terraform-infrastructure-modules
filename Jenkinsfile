#!/usr/bin/env groovy
proceedToBuild = true

pipeline {
    agent {
        label 'docker-maven-slave'
    }
    parameters {
        string(name: 'REPO_NAME', defaultValue: 'osim-terraform', description: 'Terraform Repository Name')
        choice(choices: ['prod'], description: 'Terraform Environment for deployment', name: 'TERRAFORM_ENVIRONMENT')
        // gitParameter branchFilter: 'origin/(.*)', defaultValue: 'master', name: 'BRANCH', type: 'PT_BRANCH'
    }
    tools {
        terraform 'Terraform-14'
    }
    stages{

        // stage('Git Checkout')
        //         {
        //             steps{
        //                 git credentialsId: 'sneha-sp' , url: 'https://github.com/samba1236/azure-terraform-infrastructure-modules.git' ,  branch: "${params.BRANCH}"
        //             }

        //         }
        /* Terraform Init */
        stage('Terraform Init') {
            steps{
                terraformStep('init')
            }
        }
        /* Terraform Validate*/
        stage('Terraform Validate') {
            steps{
                //sh "terraform  validate"
                terraformStep('validate')
            }
        }
        /* Terraform Plan */
        stage('Terraform Plan') {
            steps{
                terraformStep('plan')
            }
        }

        /* Terraform Apply*/
        stage('Terraform Apply') {
            steps{
                terraformStep('apply')
                echo "Reached apply step"
            }
        }

    }
}

def terraformStep(tfStep)
{
    echo "Executing Terraform Step " + tfStep
    //credId = "AzureServicePrincipal${tfEnv}"
    credId = "sneha-sp"
    echo "Using Credential : " + credId
    stage("Terraform $tfStep"){
        // withCredentials([azureServicePrincipal(
        //         credentialsId: credId,
        //         subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID',
        //         clientIdVariable: 'ARM_CLIENT_ID',
        //         clientSecretVariable: 'ARM_CLIENT_SECRET',
        //         tenantIdVariable: 'ARM_TENANT_ID'
        // )])
        withCredentials([azureServicePrincipal('sneha-sp')])
        {
            //echo "client ID is $AZURE_CLIENT_ID"
            echo "client ID is $ARM_CLIENT_ID"
            sh "az login --service-principal -u ${ARM_CLIENT_ID} -p ${ARM_CLIENT_SECRET} -t ${ARM_TENANT_ID} --allow-no-subscriptions"
            switch (tfStep) {
                case "init":
                    echo "Executing Terraform init :"
                    sh "ls -la"
                    if (credId=="sneha-sp")
                    {
                    sh '''
                    terraform  init 
                    '''
                    }
                    else
                    //sh "terraform  init "
                    break
                case "validate":
                    echo "Executing Terraform Validate :"
                    sh """
                    terraform  validate 
                    """
                    break
                case "plan":
                    echo "Executing Terraform plan :"
                    sh '''
                    terraform  plan -out=./output 
                    '''
                    break
                case "apply":
                    echo "Executing Terraform apply :"
                    sh '''
                    terraform  apply  -input=false -auto-approve 
                    '''
                    break
                default:
                    proceedToBuild = false
            }

        }
    }
}