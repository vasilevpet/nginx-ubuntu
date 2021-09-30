pipeline {

    agent { label 'docker' }

    options {
        buildDiscarder(logRotator(numToKeepStr: '5'))
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
                sh 'docker run --rm --name=my-container my-docker-image:v1 echo "Testing from $(hostname)"'
            }
        }     
    }
}  
