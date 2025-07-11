pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'git@github.com:kasra-dr/python-flask-ci-cd-project.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    def imageName = "python-flask-app:${env.BUILD_NUMBER}"
                    sh "docker build -t ${imageName} ."
                }
            }
        }
        stage('Deploy Application') {
            steps {
                sh 'docker stop my-flask-container || true'
                sh 'docker rm my-flask-container || true'

                script {
                    def imageName = "python-flask-app:${env.BUILD_NUMBER}"
                    sh "docker run -d -p 5000:5000 --name my-flask-container ${imageName}"
                }
            }
        }
    }
    post {
        always {
            sh 'docker image prune -f'
        }
    }
}
