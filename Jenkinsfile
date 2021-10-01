pipeline {

    agent {
        label 'docker'
    }
    
    parameters { 
        string(name: 'TAG', defaultValue: 'R10', description: 'Release Tag for Builds') 
    }
    
    options {
        buildDiscarder(logRotator(numToKeepStr: '6'))
    }
    stages {
        stage('Build') {
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
