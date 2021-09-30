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
        
        stage('Push') {
            steps {
                
                sh '''
                     echo "Push the Docker image to artifactory"
                     curl -u ${ARTIFACTORY_CREDS_USR}:${ARTIFACTORY_CREDS_PSW} -T my-docker-image:${TAG} http://192.168.99.101:8082/artifactory/test-generic-local/my-docker-image:${TAG}
                   ''' 
            }
        }        
    }
}
