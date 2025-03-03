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
                script {
                    if (env.BRANCH_NAME == 'main') {
                        echo 'Running main branch steps'
                        sh 'docker stop nodemain && docker rm nodemain'
                        sh 'docker run --name nodemain -d -p 3000:3000 nodemain:v1.0'
                    } else if (env.BRANCH_NAME == 'dev') {
                        echo 'Running dev branch steps'
                        sh 'docker stop nodedev && docker rm nodedev'
                        sh 'docker run --name nodedev -d -p 3001:3000 nodedev:v1.0'
                    }
                }
            }
        }
    }
}
