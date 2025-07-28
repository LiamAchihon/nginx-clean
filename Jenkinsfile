pipeline {
    agent any

    environment {
        TF_DIR = 'terraform'
        INVENTORY_FILE = 'ansibel/inventory.ini'
        PRIVATE_KEY = '~/.ssh/liam-ansible-key'
    }

    stages {
        stage('Terraform Init & Apply') {
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
                            terraform apply -auto-approve
                        '''
                    }
                }
            }
        }

        stage('Extract EC2 IP and Update Inventory') {
            steps {
                script {
                    def ec2_ip = sh(script: "cd ${TF_DIR} && terraform output -raw ec2_eip", returnStdout: true).trim()
                    writeFile file: "${INVENTORY_FILE}", text: """
[web]
${ec2_ip} ansible_user=ec2-user ansible_ssh_private_key_file=${PRIVATE_KEY}
""".trim()
                }
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                sh '''
                    ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ansibel/inventory.ini ansibel/playbook.yml
                '''
            }
        }
    }
}
