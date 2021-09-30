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
                sh 'docker image build -t my-docker-image:${TAG} .'
            }
        }

        stage('Test') {
            steps {
                sh 'docker run -d --name my-build my-docker-image-${TAG} bash echo /etc/os-release'
            }
        }
    }
    post {
        success {
            sh '''
                echo "******Uploading generated artifact: generatedFile-$BUILD_NUMBER.txt to artifactory!!!******"
                curl -u ${ARTIFACTORY_CREDS_USR}:${ARTIFACTORY_CREDS_PSW} -T my-docker-image-${TAG} http://192.168.99.101:8082/artifactory/test-generic-local/my-docker-image-${TAG}
               '''
        }
    }
}
