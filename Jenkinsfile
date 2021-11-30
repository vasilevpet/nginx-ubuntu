pipeline {
    agent {
        label 'docker'
    }
    environment {
        DEPLOY_TO = 'production'
    }
    stages {
        stage('Example Build') {
            steps {
                echo 'Hello World'
            }
        }
        stage('Example Deploy') {
            when {
                branch 'test'
                anyOf {
                    environment name: 'DEPLOY_TO', value: 'production'
                    environment name: 'DEPLOY_TO', value: 'staging'
                }
            }
            steps {
                echo "Deploying to ${env.DEPLOY_TO}"
            }
        }
    }
}
