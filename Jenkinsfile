pipeline {
    agent any

    environment {
        IMAGE_NAME = ""
        FULL_IMAGE_NAME = ""
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

                    FULL_IMAGE_NAME = "ghcr.io/${NAMESPACE}/${IMAGE_NAME}:${TAG}"
                }
            }
        }

        stage('docker linter') {
            steps {
                sh 'hadolint Dockerfile'
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
                sh "docker build -t ${FULL_IMAGE_NAME} ."
            }
        }

        stage('scan with trivy') {
            steps {
                sh "trivy  image --no-progress --severity HIGH,CRITICAL --ignore-unfixed --format table ${FULL_IMAGE_NAME}"
            }
        }

        stage ('publish on GHCR') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'ghcr_token', variable: 'GHCR_TOKEN')]) {

                        sh 'echo $GHCR_TOKEN | docker login ghcr.io -u IhorKulishenko --password-stdin'

                        // sh "docker tag ${IMAGE_NAME}:${TAG} ghcr.io/${NAMESPACE}/${IMAGE_NAME}:${TAG}"

                        sh "docker push ${FULL_IMAGE_NAME}"
                    }
                }
            }
        }
    }
}
