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
    options {
       ansiColor('xterm')
       preserveStashes(buildCount: 5)
       timestamps()
    }
    stages {
        stage('Main') {
            steps {
                sh 'hostname && date'
                sh 'cat /etc/os-release'
                echo "Hello ${test}"
                script {
                    branchName = env.GIT_BRANCH.replace('origin/', '')
                    echo "${env.GIT_BRANCH}"
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
                        branchName = env.GIT_BRANCH.replace('origin/', '')
                        echo "${env.GIT_BRANCH}"
                        echo "Branch name is ${branchName}"
                        sh 'sleep 5'
                    }
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
