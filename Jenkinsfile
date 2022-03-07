pipeline {

    agent {
        label 'docker'
    }
       
    options {
        buildDiscarder(logRotator(numToKeepStr: '5'))
    }
    
    environment {
        DOCKER_HUB_CREDS = credentials('docker-hub-token-jenkins')
    }
  
    stages {
        stage('login to Docker Hub') {
            steps {
                sh 'echo ${DOCKER_HUB_CREDS} | docker login -u dockeradmin01 --password-stdin'
            }
        }
        stage('Build and Push to Docker Hub') {
            input {
                id "Provide a Release TAG"
                message "Please provide a Release TAG?"
                ok "Put a TAG"
                submitter "Jenkins Admin"
                parameters {
                    string(name: 'TAGn', defaultValue: 'R10', description: 'Release TAG for Builds')
                }
             }   
            steps {
                echo "Start building the Docker image with ${TAGn}"
                sh 'docker build -t dockeradmin01/my-docker-image:${TAGn} .'
                sh '''
                    docker run --rm --name=my-con dockeradmin01/my-docker-image:${TAGn} bash -c 'echo "Testing from $(hostname)"'
                    docker push dockeradmin01/my-docker-image:${TAGn}
                   ''' 
            }   
        }    
        // stage('Push to Docker Hub') {
        //     steps {
        //         sh 'docker push dockeradmin01/my-docker-image:${TAGn}' 
        //     }
        // }
    }    
    post {
        always {
            sh 'docker images'
            sh 'docker logout'
        }
    }    
}
