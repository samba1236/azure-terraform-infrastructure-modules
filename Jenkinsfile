#!/usr/bin/env groovy
proceedToBuild = true

pipeline {
    agent any
    parameters {
        string(name: 'REPO_NAME', defaultValue: 'osim-terraform', description: 'Terraform Repository Name')
        choice(choices: ['prod'], description: 'Terraform Environment for deployment', name: 'TERRAFORM_ENVIRONMENT')
        // gitParameter branchFilter: 'origin/(.*)', defaultValue: 'master', name: 'BRANCH', type: 'PT_BRANCH'
    }
    // tools {
    //     terraform 'Terraform-14'
    // }
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
        // stage('Upload tfstate'){
        //     steps{
        //         terraformStep('statefile')
        //     container('terraform-az') {
        //         // Upload the state of the plan to Azure Blob Storage
        //         sh (script: "cd terraform-plans/create-vmss-from-image && tar -czvf ~/workspace/${env.JOB_NAME}/$deployment'.tar.gz' .")
        //         sh "pwd"
        //         azureUpload blobProperties: [cacheControl: '', contentEncoding: '', contentLanguage: '', contentType: '', detectContentType: true], containerName: '<container-name>', fileShareName: '', filesPath: '${deployment}.tar.gz', storageCredentialId: '<jenkins-storage-id>', storageType: 'blobstorage'
                
        //     }
        //  }
        // }

    }
}

def terraformStep(tfStep)
{
    echo "Executing Terraform Step " + tfStep
    //credId = "AzureServicePrincipal${tfEnv}"
    credId = "sneha-sp"
    // echo "Using Credential : " + credId
    stage("Terraform $tfStep"){
        // withCredentials([azureServicePrincipal(
        //         credentialsId: credId,
        //         subscriptionIdVariable: 'AZURE_SUBSCRIPTION_ID',
        //         clientIdVariable: 'AZURE_CLIENT_ID',
        //         clientSecretVariable: 'AZURE_CLIENT_SECRET',
        //         tenantIdVariable: 'AZURE_TENANT_ID'
        // )])
        withCredentials([azureServicePrincipal('sneha-sp')])
        {
            //echo "client ID is $AZURE_CLIENT_ID"
            echo "client ID is $AZURE_CLIENT_ID"
            sh "az login --service-principal -u ${AZURE_CLIENT_ID} -p ${AZURE_CLIENT_SECRET} -t ${AZURE_TENANT_ID} --allow-no-subscriptions"
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