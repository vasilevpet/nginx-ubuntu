pipeline {
    agent { 
        label 'docker'
    }
    
    options {
        buildDiscarder(logRotator(numToKeepStr: '5'))
    }
    environment {
        CI = true
        ARTIFACTORY_ACCESS_TOKEN = credentials('artifactory-token')
    }
    
    stages {
        stage('Build') {
            steps {
                echo "Start building the artifact: generatedFile-${BUILD_NUMBER}.txt"
                sh 'echo "Current Build number is ${BUILD_NUMBER}" > generatedFile-${BUILD_NUMBER}.txt'
            }
        }

        stage('Archive-artefacts') {

            steps {
                archiveArtifacts artifacts: '*.txt', fingerprint: true
            }
        }
    
        stage('Upload to Artifactory') {
            agent {
                docker {
                image 'releases-docker.jfrog.io/jfrog/jfrog-cli-v2:2.2.0' 
                label 'docker'
                reuseNode true
            }
        }
            steps {
                sh 'jfrog rt upload --url http://192.168.99.101:8082/artifactory/ --access-token $ARTIFACTORY_ACCESS_TOKEN generatedFile-${BUILD_NUMBER}.txt example-repo-local/'
            }
        }
    }
}  
