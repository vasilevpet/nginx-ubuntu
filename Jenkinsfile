// def name
// def gender

pipeline {
    agent any
    parameters {
        string(name: 'NAME', description: 'Please tell me your name', defaultValue: 'Vasilev')
        choice(name: 'GENDER', choices: ['Male', 'Female'], description: 'Choose Gender')
    }
    
    environment {
        name = "${NAME}"
        gender = "${GENDER}"
        ll = sh (returnStdout: true, script: "ls -ltra").trim()
        hostname = sh (returnStdout: true, script: "hostname").trim()
    }      
    
    stages {
        stage('Printing name') {
            steps {
                script {
                    //name = "${params.NAME}"
                    //gender = "${params.GENDER}"
                    if(gender == "Male") {
                        echo "Mr. ${name}"
                        echo "${ll}"
                    } else {
                        echo "Mrs. ${name}"
                        echo "${ll}"
                    }
                }
            }
        }
        stage('Printing name again') {
            steps {
                echo "Hello ${name} welcome to our ${gender} club"
                echo "${ll}"
                echo "The hostname is ${hostname}"
            }
        }
   }
}
