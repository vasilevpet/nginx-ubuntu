def branchName
def test = "John" 
def myLabel = "jenkins-k8s-agent-build-${UUID.randomUUID().toString()}"

pipeline {
    agent {
       kubernetes {
           cloud 'kubernetes'
           label "${myLabel}"
           containerTemplate {
                name 'shell'
                image 'ubuntu'
                command 'sleep'
                args 'infinity'
           }
           //defaultContainer 'shell'
       }
    }
    stages {
        stage('Main') {
            steps {
                sh 'hostname && date'
                sh 'cat /etc/os-release'
                echo "Hello ${test}"
                script {
                    def branchName = env.GIT_BRANCH.replace('origin/', '')
                    echo "Branch name is ${branchName}"
                }
            }
        }
        stage('Second') {
            steps {
                container('shell') {
                    sh 'id && groups'
                    sh 'hostname && date'
                    sh 'cat /etc/os-release'
                    script {
                        def branchName = env.GIT_BRANCH.replace('origin/', '')
                        echo "Branch name is ${branchName}"
                    }
                }
        }
    }    
    post {
        always {
            echo 'I will always say something!'
        }
        success {
            echo 'I will say something only on SUCCESS!'
            
        }
        failure {
            echo 'I will say something only on FAILURE!'
        }
    }    
}
