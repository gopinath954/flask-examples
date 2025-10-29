pipeline {
    agent any

    environment {
        IMAGE_NAME = "flask-app"
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
                    echo "✅ Flask app is running on port 5000"
                '''
            }
        }

        stage('Deployment (Local Server)') {
            steps {
                echo "📡 Deploying Docker container locally..."
                sh '''
                    docker stop ${IMAGE_NAME} || true
                    docker rm ${IMAGE_NAME} || true
                    docker run -d -p 5000:5000 --name ${IMAGE_NAME} ${IMAGE_NAME}:${BUILD_NUMBER}
                    echo "✅ Deployment completed on Jenkins server"
                '''
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
            echo "❌ Pipeline failed. Check logs."
        }
    }
}
