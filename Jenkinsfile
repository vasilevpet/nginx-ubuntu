pipeline {

    agent {
        label 'docker'
    }
       
    options {
        buildDiscarder(logRotator(numToKeepStr: '8'))
    }
    stages {
        stage('Build') {
            input {
                message "Please provide a Release TAG?"
                ok "Put a TAG"
                submitter "Jenkins"
                parameters {
                    string(name: 'TAG', defaultValue: 'R10', description: 'Release TAG for Builds')
                }
             }   
            steps {
                echo "Start building the Docker image"
                sh 'docker build -t my-docker-image:${TAG} .'
            }
        }

        stage('Test') {
            steps {
                echo "Start testing the Docker image into container"
                sh 'docker run --rm --name=my-container my-docker-image:${TAG} echo "Testing from $(hostname)"'
            }
        }     
    }
}
