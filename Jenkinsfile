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
                sh 'docker build -t 25123103/sampleapp:1.0.0 .'
            }
        }
        stage('Push Docker Image') {
            steps {
                withCredentials([string(credentialsId: 'dockerhubpwd', passwordVariable: 'dockerhubpwd')]) {
                    sh 'docker login -u 25123103 -p ${dockerhubpwd}'
                }
                sh 'docker push 25123103/sampleapp:1.0.0'
            }
        }
    }

}

