pipeline {

    agent {
        label 'docker'
    }
       
    options {
        buildDiscarder(logRotator(numToKeepStr: '8'))
    }
    
    environment {
        TAG = "${params.TAGn}"
    }
    
    stages {
        stage('Build') {
            input {
                message "Please provide a Release TAG?"
                ok "Put a TAG"
                submitter "Jenkins"
                parameters {
                    string(name: 'TAGn', defaultValue: 'R10', description: 'Release TAG for Builds')
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
                sh '''
                    docker run --rm --name=my-con my-docker-image:${TAG} bash -c 'echo "Testing from $(hostname)"'
                   '''
            }
        }     
    }
}
