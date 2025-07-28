pipeline {
    agent any

    environment {
        TF_DIR = 'terraform'
        INVENTORY_FILE = 'ansibel/inventory.ini'
        PRIVATE_KEY = '~/.ssh/liam-ansible-key'
    }

    stages {
        stage('Terraform Init & Destroy') {
            steps {
                dir("${TF_DIR}") {
                    withCredentials([
                        string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'),
                        string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY')
                    ]) {
                        sh '''
                            export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
                            export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
                            terraform init
                            terraform destroy -auto-approve
                        '''
                    }
                }
            }
        }
    }
}
