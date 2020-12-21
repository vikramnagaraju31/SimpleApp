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
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t sampleapp:latest .'
            }
        }
    }

}

