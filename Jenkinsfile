pipeline {
    agent any

    tools{
    	maven "3.6.3"
    }

    stages {
        stage('Build Project') {
            steps {
                sh 'mvn clean install'
            }
        }
        stage('Building Docker Image') {
            steps{
                script {
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }
    }

}

