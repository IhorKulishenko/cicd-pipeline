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
                        def container_name = "nodemain"
                        def image_name = "nodemain:v1.0"

                        echo 'Running main branch steps'

                        sh "./scripts/undeploy.sh ${container_name}"
                        sh "docker run -d --expose 3000 -p 3000:3000 ${image_name}"

                    } else if (env.BRANCH_NAME == 'dev') {
                        def container_name = "nodedev"
                        def image_name = "nodedev:v1.0"
                        
                        echo 'Running dev branch steps'
                        
                        sh "./scripts/undeploy.sh ${container_name}"
                        sh "docker run -d --expose 3000 -p 3001:3000 ${image_name}"

                    }
                }
            }
        }
    }
}
