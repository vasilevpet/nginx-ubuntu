pipeline {

    agent { label 'docker' }

    options {
        buildDiscarder(logRotator(numToKeepStr: '5'))
    }
    environment {
        ARTIFACTORY_CREDS = credentials('artifactory-creds')
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
                sh 'docker run -ti --rm --name=my-container my-docker-image:v1 echo "Testing from $(hostname)"'
            }
        }

        stage('Push') {
            steps {
                
                sh '''
                     echo "Push the Docker image to artifactory"
                     curl -u ${ARTIFACTORY_CREDS_USR}:${ARTIFACTORY_CREDS_PSW} -T my-docker-image:${TAG} http://192.168.99.101:8082/artifactory/test-docker-local/my-docker-image-${TAG}
                   ''' 
            }
        }        
    }
}
