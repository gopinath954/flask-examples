pipeline {
    agent any

    environment {
        IMAGE_NAME = "flask-app"
        DEPLOY_SERVER = "deploy@your-server-ip"       // remote server SSH user and IP
        SSH_CREDENTIALS = "ssh-server-key"           // Jenkins SSH credentials ID
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo "📦 Cloning Flask app from GitHub..."
                git branch: 'main', url: 'https://github.com/gopinath954/flask-examples.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "🐳 Building Docker image..."
                sh "docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} ."
            }
        }

        stage('Run Docker Container (Test)') {
            steps {
                echo "🚀 Running container for testing..."
                sh '''
                    docker stop ${IMAGE_NAME} || true
                    docker rm ${IMAGE_NAME} || true
                    docker run -d -p 5000:5000 --name ${IMAGE_NAME} ${IMAGE_NAME}:${BUILD_NUMBER}
                    sleep 5
                    echo "✅ Flask app is running in Docker container on port 5000"
                '''
            }
        }

        stage('Deploy to Server') {
            steps {
                echo "📡 Deploying Docker container to remote server..."
                sshagent([SSH_CREDENTIALS]) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ${DEPLOY_SERVER} '
                        docker stop ${IMAGE_NAME} || true
                        docker rm ${IMAGE_NAME} || true
                        docker pull ${IMAGE_NAME}:${BUILD_NUMBER} || true
                        docker run -d -p 5000:5000 --name ${IMAGE_NAME} ${IMAGE_NAME}:${BUILD_NUMBER}
                        echo "✅ Deployment completed on remote server"
                    '
                    """
                }
            }
        }
    }

    post {
        always {
            echo "🏁 Pipeline finished."
        }
        success {
            echo "✅ Build and deployment successful!"
        }
        failure {
            echo "❌ Pipeline failed. Please check logs."
        }
    }
}

