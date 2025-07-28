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
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve'
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
                sh 'ansible-playbook -i ansibel/inventory.ini ansibel/playbook.yml'
            }
        }
    }
}
