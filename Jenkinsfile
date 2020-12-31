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
            steps 
            {
                script
                {
                    withSonarQubeEnv(credentialsId: 'sonar_jenkins_token', installationName: 'SonarQubeScanner') 
                    {
                        sh 'mvn sonar:sonar'
                    }
                    timeout(time: 1, unit: 'HOURS' )
                    {
                        def qq = waitForQualityGate()
                        if (qq.status != 'OK')
                        {
                            error 'Pipeline aborted'
                        }
                    }
                }
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
        stage('Email Notification') {
            steps{
                emailext subject: "Email Rreport from '${env.JOB_NAME}'", body: readFile("target/surefire-reports/emailable-report.html"), to: 'vikramnagaraju31@gmail.com', mimeType: 'text/html'
            }

        }
    }
}
