pipeline {

    agent {
        label 'docker'
    }
       
    options {
        buildDiscarder(logRotator(numToKeepStr: '5'))
    }
    
  
    stages {
        stage('Build') {
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
                sh 'docker build -t my-docker-image:${TAGn} .'
                sh '''
                    docker run --rm --name=my-con my-docker-image:${TAGn} bash -c 'echo "Testing from $(hostname)"'
                   ''' 
            }   
        }

    }
}
