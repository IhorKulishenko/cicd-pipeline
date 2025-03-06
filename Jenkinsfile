pipeline {
    agent any

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
                    def IMAGE_NAME = ""
                    
                    if (env.BRANCH_NAME == 'main') {                        
                        IMAGE_NAME = "nodemain"
                    } else if (env.BRANCH_NAME == 'dev') {
                        IMAGE_NAME = "nodedev"
                    }

                    sh "docker build -t ${IMAGE_NAME}:v1.0 ."
                }
            }
        }

        stage ('publish on GHCR') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'ghcr_token', variable: 'GHCR_TOKEN')]) {
                        def NAMESPACE = 'ihor-kulishenko'
                        def TAG = "v1.0"

                        sh 'echo $GHCR_TOKEN | docker login ghcr.io -u IhorKulishenko --password-stdin'

                        def REPOSITORY = ''
                        if (env.BRANCH_NAME == 'main') {
                            REPOSITORY = 'nodemain'
                        } else if (env.BRANCH_NAME == 'dev') {
                            REPOSITORY = 'nodedev'
                        }

                        sh "docker tag ${REPOSITORY}:${TAG} ghcr.io/${NAMESPACE}/${REPOSITORY}:${TAG}"

                        sh "docker push ghcr.io/${NAMESPACE}/${REPOSITORY}:${TAG}"
                    }
                }
            }
        }

        // stage('deploy') {
        //     steps {
        //         script {
        //             if (env.BRANCH_NAME == 'main') {
        //                 def container_name = "nodemain"
        //                 def image_name = "nodemain:v1.0"

        //                 echo 'Running main branch steps'

        //                 sh "./scripts/undeploy.sh ${container_name}"
        //                 sh "docker run -d --name ${container_name} -p 3000:3000 ${image_name}"

        //             } else if (env.BRANCH_NAME == 'dev') {
        //                 def container_name = "nodedev"
        //                 def image_name = "nodedev:v1.0"
                        
        //                 echo 'Running dev branch steps'
                        
        //                 sh "./scripts/undeploy.sh ${container_name}"
        //                 sh "docker run -d --name ${container_name} -p 3001:3000 ${image_name}"

        //             }
        //         }
        //     }
        // }
    }
}
