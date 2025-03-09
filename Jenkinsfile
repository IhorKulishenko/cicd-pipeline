pipeline {
    agent any

    stages {

        def IMAGE_NAME = ""
        def NAMESPACE = 'ihorkulishenko'
        def TAG = "v1.0"

        stage('init') {
            if (env.BRANCH_NAME == 'main') {                        
                IMAGE_NAME = "nodemain"
            } else if (env.BRANCH_NAME == 'dev') {
                IMAGE_NAME = "nodedev"
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
                script {
                    sh "docker build -t ${IMAGE_NAME}:${TAG} ."
                }
            }
        }

        /*stage('scan with trivy') {
            steps {
                script {
                    sh "trivy  image --no-progress --severity HIGH,CRITICAL --ignore-unfixed --format table ${IMAGE_NAME}:${TAG}"
                }
            }
        }*/

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
