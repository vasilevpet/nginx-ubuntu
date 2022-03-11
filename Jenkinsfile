def name
def gender

pipeline {
    agent any
    parameters {
        string(name: 'NAME', description: 'Please tell me your name')
        choice(name: 'GENDER', choices: ['Male', 'Female'], description: 'Choose Gender')
    }
    stages {
        stage('Printing name') {
            steps {
                script {
                    name = "${params.NAME}"
                    gender = "${params.GENDER}"
                    if(gender == "Male") {
                        echo "Mr. $name"    
                    } else {
                        echo "Mrs. $name"
                    }
                }
            }
        }
        stage('Printing name again') {
            steps {
                echo "Hello ${name} welcome to our ${gender} club"
            }
        }
   }
}
