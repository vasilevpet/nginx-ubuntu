pipeline {

    agent {
        label 'docker'
    }
    
    environment {
        TAG = 'R10'
    }
    
    options {
        buildDiscarder(logRotator(numToKeepStr: '7'))
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
