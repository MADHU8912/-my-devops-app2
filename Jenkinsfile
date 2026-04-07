pipeline {
    agent any

    stages {
        stage('Checkout SCM') {
            steps {
                echo 'Checking source code'
                bat 'dir'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t my-devops-app .'
            }
        }

        stage('Create Docker Network') {
            steps {
                bat 'docker network inspect my-devops-network >nul 2>&1 || docker network create my-devops-network'
            }
        }

        stage('Remove Old Container') {
            steps {
                bat 'docker rm -f my-devops-container >nul 2>&1 || exit /b 0'
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
                bat 'docker network inspect my-devops-network'
            }
        }
    }

    post {
        always {
            bat 'echo Build completed > build-log.txt'
            archiveArtifacts artifacts: 'build-log.txt', fingerprint: true
        }
    }
}