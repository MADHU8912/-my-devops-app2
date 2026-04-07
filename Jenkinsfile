pipeline {
    agent any

    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t my-devops-app .'
            }
        }

        stage('Create Docker Network') {
            steps {
                bat '''
                docker network inspect my-devops-network >nul 2>&1
                if errorlevel 1 (
                    docker network create my-devops-network
                ) else (
                    echo Network already exists
                )
                '''
            }
        }

        stage('Remove Old Container') {
            steps {
                bat 'docker rm -f my-devops-container || exit /b 0'
            }
        }

        stage('Run Container in Network') {
            steps {
                bat 'docker run -d --name my-devops-container --network my-devops-network my-devops-app'
            }
        }

        stage('Check Running Containers') {
            steps {
                bat 'docker ps'
                bat 'docker logs my-devops-container'
            }
        }
    }

    post {
        always {
            echo 'Pipeline completed'
        }
    }
}
stage('Push to Docker Hub') {
    steps {
        bat 'docker tag my-devops-app nikhilabba12/my-devops-app:latest'
        bat 'docker push nikhilabba12/my-devops-app:latest'
    }
}