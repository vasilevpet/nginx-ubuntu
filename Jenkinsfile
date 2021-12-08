pipeline {
    agent {
        label 'docker'
    }
    tools {
        maven '3.8.2'
    }
    environment {
        //JAVA_HOME = '/opt/java/openjdk/bin/java'
        //JAVA_HOME = '/opt/java/openjdk'
        CI = true
        ARTIFACTORY_ACCESS_TOKEN = credentials('artifactory-token')
    }
    options {
        buildDiscarder(logRotator(numToKeepStr: '5'))
    }
    stages {
        stage('Maven-check') {
            steps {
                sh 'mvn --version'
                sh 'java -version'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean install'
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
                sh 'jfrog rt upload --url http://192.168.99.101:8082/artifactory/ --access-token $ARTIFACTORY_ACCESS_TOKEN target/hello-world-1.0.0.jar java-web-app/'
            }
        }        
    }
}
