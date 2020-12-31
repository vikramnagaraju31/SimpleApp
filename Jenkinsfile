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
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv(credentialsId: 'sonar_jenkins_token', installationName: 'SonarQubeScanner') {
                    sh 'mvn sonar:sonar'
                }
            }
        }
    }
}
