pipeline {
    agent {
        dockerfile {
            label 'docker'
            args  '-v /home/vagrant/docker-projects/tmp:/tmp --name=my-ubuntu'
        }
    }
    stages {
        stage("Build") {
            steps {
               sh 'echo "Today is $(date)" > /tmp/day.txt'
               sh 'uptime > /tmp/uptime.txt'
            }

        }
        stage("Test") {
            steps {
               sh 'ls -l /tmp'    
               sh 'cat /tmp/day.txt'
            }

        }
        stage("Deply") {
            steps {
               sh '''
                    cd /tmp
                    hostname
                    uname -a
                    cat /etc/os-release
                    df -h
                    mv /tmp/day.txt /tmp/day-time-${BUILD_NUMBER}.txt
                    mv /tmp/uptime.txt /tmp/uptime-host-${BUILD_NUMBER}.txt
                    cat /tmp/uptime-host-${BUILD_NUMBER}.txt
                    cat /tmp/day-time-${BUILD_NUMBER}.txt
                    ls -lrt
                  '''
            }

        }      
    }

}
