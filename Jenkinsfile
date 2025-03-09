pipeline {
    agent any

    environment {
        IMAGE_NAME = ""
        NAMESPACE = 'ihorkulishenko'
        TAG = "v1.0"
    }
    
    stages {
        stage('init') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'main') {
                        IMAGE_NAME = "nodemain"
                    } else if (env.BRANCH_NAME == 'dev') {
                        IMAGE_NAME = "nodedev"
                    }
                }
            }
        }

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
                sh "docker build -t ${IMAGE_NAME}:${TAG} ."
            }
        }

        stage('scan with trivy') {
            steps {
                sh "trivy  image --no-progress --severity HIGH,CRITICAL --ignore-unfixed --format table ${IMAGE_NAME}:${TAG}"
            }
        }

        stage ('publish on GHCR') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'ghcr_token', variable: 'GHCR_TOKEN')]) {

                        sh 'echo $GHCR_TOKEN | docker login ghcr.io -u IhorKulishenko --password-stdin'

                        sh "docker tag ${IMAGE_NAME}:${TAG} ghcr.io/${NAMESPACE}/${IMAGE_NAME}:${TAG}"

                        sh "docker push ghcr.io/${NAMESPACE}/${IMAGE_NAME}:${TAG}"
                    }
                }
            }
        }
    }
}
