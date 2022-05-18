pipeline{
    agent any 
    tools {
        "org.jenkinsci.plugins.terraform.TerraformInstallation" "terraform"
    }
    environment {
        TF_HOME = tool('terraform')
        TF_IN_AUTOMATION = "true"
        PATH = "$TF_HOME:$PATH"
        ARM_SUBSCRIPTION_ID='0fd4cead-96dd-4544-af2b-c27c3bf1b7e9'
        ARM_CLIENT_ID='67bae972-9160-4eea-869f-f2eae65d3446'
        ARM_CLIENT_SECRET='Sog8Q~VfHTNRhBmrZJ3JezHDxKJQ_21xKegiTc-J'
        ARM_TENANT_ID='89dc1d2c-a8dd-4803-b8ef-1c8963b09b20'
        ARM_ACCESS_KEY='sp=racwdl&st=2022-05-18T21:17:52Z&se=2023-05-19T05:17:52Z&sv=2020-08-04&sr=c&sig=aaZUdWyrO1Vg39RN8yQRQhKiLMrpvHo5gGwBlO4vqjM%3D'
    }
    stages {
    
        stage('Terraform Init'){
            
            steps {
                    ansiColor('xterm') {
                    withCredentials([azureServicePrincipal(
                    credentialsId: 'Azure-credentials',
                    subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID',
                    clientIdVariable: 'ARM_CLIENT_ID',
                    clientSecretVariable: 'ARM_CLIENT_SECRET',
                    tenantIdVariable: 'ARM_TENANT_ID'
                ), string(credentialsId: 'access-key', variable: 'ARM_ACCESS_KEY')]) {
                        
                        sh """
                                
                        echo "Initialising Terraform"
                        terraform init -backend-config="access-key=$ARM_ACCESS_KEY"
                        """
                           }
                    }
             }
        }

        stage('Terraform Validate'){
            
            steps {
                    ansiColor('xterm') {
                    withCredentials([azureServicePrincipal(
                    credentialsId: 'Azure-credentials',
                    subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID',
                    clientIdVariable: 'ARM_CLIENT_ID',
                    clientSecretVariable: 'ARM_CLIENT_SECRET',
                    tenantIdVariable: 'ARM_TENANT_ID'
                ), string(credentialsId: 'access-key', variable: 'ARM_ACCESS_KEY')]) {
                        
                        sh """
                                
                        terraform validate
                        """
                           }
                    }
             }
        }

        stage('Terraform Plan'){
            steps {

                    ansiColor('xterm') {
                    withCredentials([azureServicePrincipal(
                    credentialsId: 'Azure-credentials',
                    subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID',
                    clientIdVariable: 'ARM_CLIENT_ID',
                    clientSecretVariable: 'ARM_CLIENT_SECRET',
                    tenantIdVariable: 'ARM_TENANT_ID'
                ), string(credentialsId: 'access-key', variable: 'ARM_ACCESS_KEY')]) {
                        
                        sh """
                        
                        echo "Creating Terraform Plan"
                        terraform plan -var "client_id=$ARM_CLIENT_ID" -var "client_secret=$ARM_CLIENT_SECRET" -var "subscription_id=$ARM_SUBSCRIPTION_ID" -var "tenant_id=$ARM_TENANT_ID"
                        """
                        }
                }
            }
        }

        stage('Waiting for Approval'){
            steps {
                timeout(time: 10, unit: 'MINUTES') {
                    input (message: "Deploy the infrastructure?")
                }
            }
        
        }
    

        stage('Terraform Apply'){
            steps {
                    ansiColor('xterm') {
                    withCredentials([azureServicePrincipal(
                    credentialsId: 'Azure-credentials',
                    subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID',
                    clientIdVariable: 'ARM_CLIENT_ID',
                    clientSecretVariable: 'ARM_CLIENT_SECRET',
                    tenantIdVariable: 'ARM_TENANT_ID'
                ), string(credentialsId: 'access-key', variable: 'ARM_ACCESS_KEY')]) {

                        sh """
                        echo "Applying the plan"
                        terraform apply -auto-approve -var "client_id=$ARM_CLIENT_ID" -var "client_secret=$ARM_CLIENT_SECRET" -var "subscription_id=$ARM_SUBSCRIPTION_ID" -var "tenant_id=$ARM_TENANT_ID"
                        """
                                }
                }
            }
        }

    }
}
