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
	    when {
		branch 'dev'
	    }
            steps {
                sh 'docker build -t nodedev:v1.0 .'
            }
        }

	stage('build docker image') {
	    when {
		branch 'main'
	    }
            steps {
                ssh 'docker build -t nodemain:v1.0 .'
            }
        }

        stage('deploy')
            steps {
                sh 'echo "deploy stage"'
            }
        }
    }
}

