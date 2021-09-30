pipeline {

    agent { label 'docker' }

    options {
        buildDiscarder(logRotator(numToKeepStr: '5'))
    }
    environment {
        ARTIFACTORY_ACCESS_TOKEN = credentials('artifactory-token')
    }

    stages {
        stage('Build') {
            steps {
                echo "Start building the Docker image"
                sh 'docker build -t my-docker-image:${TAG} .'
                sh 'docker images'
            }
        }
        
        stage('Push') {
            agent {
                docker {
                image 'releases-docker.jfrog.io/jfrog/jfrog-cli-v2:2.2.0' 
                label 'docker'
                reuseNode true
                }            
            }            
            steps {         
                sh '''
                     echo Push the Docker image to artifactory
                     jfrog rt upload --url http://192.168.99.101:8082/artifactory/ --access-token ${ARTIFACTORY_ACCESS_TOKEN} my-docker-image:${TAG} example-repo-local/
                   ''' 
            }    
        }
    }
}    
