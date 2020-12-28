def dockerRunCommand = 'tbd'
pipeline {
    
    agent any

    tools{
    	maven "3.6.3"
    }

    stages {
        stage('Compile') {
            steps {
                sh 'mvn compile'
            }
        }
        stage('Code_Review') {
            steps {
                sh 'mvn -P metrics pmd:pmd'
            }
        }
        stage('Metric_Check') {
            steps {
                sh 'mvn cobertura:cobertura -D cobertura.report.format=xml'
            }
        }
        stage('Package') {
            steps {
                sh 'mvn package'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t 25123103/sampleapp:1.0.0 .'
            }
        }
        stage('Push Docker Image') {
            steps {
                withCredentials([string(credentialsId: 'dockerhubpwd', variable: 'dockerhubpwd')]) {
                    sh 'docker login -u 25123103 -p ${dockerhubpwd}'
                }
                sh 'docker push 25123103/sampleapp:1.0.0'
            }
        }
        stage('Deploy On Docker Server') {
            steps {
            	script {
            		dockerRunCommand = 'sudo su; docker rm -f sample-app; docker run -d -p 80:8080 --name sample-app 25123103/sampleapp:1.0.0'
            	}
            	sshagent(['docker_server']) {
            		sh "ssh -o StrictHostKeyChecking=no ubuntu@ec2-52-66-239-25.ap-south-1.compute.amazonaws.com ${dockerRunCommand}"
            	}
            }
        }
    }
}
