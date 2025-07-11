pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // کد را از ریپازیتوری گیت‌هاب دریافت می‌کند
                git 'git@github.com:YOUR_USERNAME/python-flask-ci-cd-project.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                // یک نام برای ایمیج با استفاده از شماره بیلد جنکینز می‌سازد
                script {
                    def imageName = "python-flask-app:${env.BUILD_NUMBER}"
                    sh "docker build -t ${imageName} ."
                }
            }
        }
        stage('Deploy Application') {
            steps {
                // کانتینر قدیمی (اگر وجود داشته باشد) را متوقف و حذف می‌کند
                sh 'docker stop my-flask-container || true'
                sh 'docker rm my-flask-container || true'

                // کانتینر جدید را با ایمیج تازه بیلد شده اجرا می‌کند
                script {
                    def imageName = "python-flask-app:${env.BUILD_NUMBER}"
                    sh "docker run -d -p 5000:5000 --name my-flask-container ${imageName}"
                }
            }
        }
    }
    post {
        always {
            // ایمیج‌های قدیمی داکر را برای جلوگیری از پر شدن حافظه پاک می‌کند
            sh 'docker image prune -f'
        }
    }
}
