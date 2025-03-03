pipeline {
    agent any
    environment {
        CI = 'true'
    }
    stages {

        stage('build') {
            steps {
                sh 'npm install'
            }
        }

        stage('test') {
            steps {
                sh 'npm test'
            }
        }

        stage('build docker image') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'main') {
                        echo 'Running main branch steps'
                        sh 'docker build -t nodemain:v1.0 .'
                    } else if (env.BRANCH_NAME == 'dev') {
                        echo 'Running dev branch steps'
                        sh 'docker build -t nodedev:v1.0 .'
                    }
                }
            }
        }

        stage('deploy') {
            steps {
                sh 'echo "deploy stage"'
            }
        }
    }
}
